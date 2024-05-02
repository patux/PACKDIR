{
  Libreria para encryptacion de un archivo.

  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.0
  Ultima actualizacion: Mayo 22 de 1996

  Este es codigo GNU/GPL
}

UNIT Codecod;

INTERFACE

USES Packsoft;
CONST MaxBuf=30000;
TYPE Pass=STRING[8];
     Archivo=STRING[11];
VAR Semilla1,Semilla1x,Semilla2,Semilla2x:Byte;
    Clave:STRING[8];
    Fuente,Destino:FILE;
    Buffer:ARRAY [1..MaxBuf] OF BYTE;
    Bytesleidos:REAL;
    i,j:INTEGER;

TYPE Codificacion=OBJECT
                  PRIVATE
                  ArchCod:Archivo;
                  Pasword:Pass;
                  PROCEDURE ObtenerSemilla;
                  PROCEDURE AbrirArchCod;
                  PROCEDURE Codificar;
                  PROCEDURE CerrarArchCod;
                  PROCEDURE AbrirArchDeCod;
                  PROCEDURE DeCodificar;
                  PROCEDURE CerrarArchDeCod;
                  PUBLIC
                  PROCEDURE Codif(NombreArch:STRING;Password:Pass);
                  PROCEDURE Decod(NombreArch:STRING;Password:Pass);

                  END;

IMPLEMENTATION
PROCEDURE Codificacion.ObtenerSemilla;
          BEGIN
               Semilla1:=0;
               Semilla2:=0;
               Clave:=Pasword;
               j:=Length (Clave);
               FOR i:=1 TO Length (Clave) DO
                   BEGIN
                        Semilla1:=Semilla1 + (Ord (Clave[i]) * i);
                        Semilla2:=Semilla2 + (Ord (Clave[i]) * j);
                        j:=j-1;
                   END;{For}
          END;{ObtenerSemilla}

PROCEDURE Codificacion.AbrirArchCod;
CONST Pasw:ARRAY [1..8] OF CHAR = ('P','A','C','K','D','I','R','G');
          BEGIN
               Assign (Fuente,ArchCod);
               Reset (Fuente,1);
               BlockRead (Fuente,Buffer,8);
               IF ((Buffer[1] = Ord ('P')) AND
                   (Buffer[2] = Ord ('A')) AND
                   (Buffer[3] = Ord ('C')) AND
                   (Buffer[4] = Ord ('K')) AND
                   (Buffer[5] = Ord ('D')) AND
                   (Buffer[6] = Ord ('I')) AND
                   (Buffer[7] = Ord ('R')) AND
                   (Buffer[8] = Ord ('G'))) THEN
                   BEGIN
                        Codificacion.DeCod (ArchCod,Pasword);
                   END;
               Reset (Fuente,1);
               Assign (Destino,'$$$$$.$$');
               Rewrite (Destino,1);
               BlockWrite (Destino,Pasw,8);
               BlockWrite (Destino,Semilla1,1);
               BlockWrite (Destino,Semilla2,1);
          END;
PROCEDURE Codificacion.Codificar;
VAR i1,i2:Byte;
    rr:INTEGER;
          BEGIN
               i1:=Semilla1;
               i2:=Semilla2;
               Bytesleidos:=0;
               BlockRead(Fuente,Buffer,MaxBuf,rr);
               Bytesleidos:=Bytesleidos+rr;
               WHILE rr > 0 DO
                     BEGIN
                          FOR i:=1 TO rr DO
                              BEGIN
                                   i1:=i1-1;
                                   i2:=i2+1;
                                   IF odd(i) THEN Buffer[i]:=Buffer[i]-i1
                                   ELSE
                                       Buffer[i]:=Buffer[i]+i2;
                              END;{For}
                              BlockWrite (Destino,Buffer,rr);
                              BlockRead (Fuente,Buffer,MaxBuf,rr);
                              Bytesleidos:=Bytesleidos+rr;
                     END;{While}
          END;
PROCEDURE Codificacion.CerrarArchCod;
VAR i:INTEGER;
          BEGIN
               Rewrite (Fuente,1);
               FillChar (Buffer,MaxBuf,0);
               WHILE Bytesleidos > 0 DO
                     BEGIN
                          IF BytesLeidos > MaxBuf THEN
                             BlockWrite (Fuente,Buffer,MaxBuf)
                          ELSE
                              BEGIN
                                   I:=Trunc(Bytesleidos);
                                   BlockWrite (Fuente,Buffer,i);
                              END;
                          BytesLeidos:=Bytesleidos-MaxBuf;
                     END;{While}
               Close (Fuente);
               Close (Destino);
               Erase (Fuente);
               Rename (Destino,ArchCod);
          END;
PROCEDURE Codificacion.Codif(NombreArch:STRING;Password:Pass);
          BEGIN
               ArchCod:=NombreArch;
               Pasword:=Password;
               Codificacion.ObtenerSemilla;
               Codificacion.AbrirArchCod;
               Codificacion.Codificar;
               Codificacion.CerrarArchCod;
          END;
PROCEDURE Codificacion.AbrirArchDecod;
CONST Pasw:ARRAY [1..8] OF CHAR = ('P','A','C','K','D','I','R','G');
          BEGIN
               Assign (Fuente,ArchCod);
               Reset (Fuente,1);
               BlockRead (Fuente,Buffer,8);
               IF NOT ((Buffer[1] = Ord ('P')) AND
                      (Buffer[2] = Ord ('A')) AND
                      (Buffer[3] = Ord ('C')) AND
                      (Buffer[4] = Ord ('K')) AND
                      (Buffer[5] = Ord ('D')) AND
                      (Buffer[6] = Ord ('I')) AND
                      (Buffer[7] = Ord ('R')) AND
                      (Buffer[8] = Ord ('G'))) THEN
                   BEGIN
                        Codificacion.Codif (ArchCod,Pasword);
                        Reset (Fuente,1);
                        BlockRead (Fuente,Buffer,8);
                   END;

               BlockRead (Fuente,Semilla1x,1);
               BlockRead (Fuente,Semilla2x,1);

               IF ((Semilla1 <> Semilla1x) OR (Semilla2<> Semilla2x)) THEN
                  BEGIN
                       Writeln;
                       Sonido (600,200);
                       Writeln ('Password erroneo');
                       Writeln;
                       Halt;
                  END;
               Assign (Destino,'$$$$$.$$');
               Rewrite (Destino,1);
          END;{AbrirArchivos}

PROCEDURE Codificacion.Decodificar;
VAR i1,i2:Byte;
    rr:INTEGER;
          BEGIN
               i1:=Semilla1;
               i2:=Semilla2;
               Bytesleidos:=0;
               BlockRead (Fuente,Buffer,MaxBuf,rr);
               BytesLeidos:=BytesLeidos + rr;
               WHILE rr>0 DO
                     BEGIN
                          FOR i:=1 TO rr DO
                              BEGIN
                                   i1:=i1-1;
                                   i2:=i2+1;
                                   IF Odd(i) THEN Buffer[i]:=Buffer[i]+i1
                                   ELSE Buffer[i]:=Buffer[i]-i2;
                              END;{For}
                              BlockWrite (Destino,Buffer,rr);
                              BlockRead (Fuente,Buffer,MaxBuf,rr);
                              BytesLeidos:=Bytesleidos+rr;
                     END;{While}
          END;
PROCEDURE Codificacion.CerrarArchDecod;
VAR i:INTEGER;
          BEGIN
               Rewrite (Fuente,1);
               FillChar (Buffer,MaxBuf,0);
               WHILE BytesLeidos > 0 DO
                     BEGIN
                          IF BytesLeidos > MaxBuf THEN
                             BlockWrite (Fuente,Buffer,MaxBuf)
                          ELSE
                              BEGIN
                                   i:=Trunc(BytesLeidos);
                                   BlockWrite (Fuente,Buffer,i);
                              END;{En caso contrario}
                          BytesLeidos:=BytesLeidos-MaxBuf;
                     END;{While}
               Close (Fuente);
               Close (Destino);
               Erase (Fuente);
               Rename (Destino,ArchCod);
          END;
PROCEDURE Codificacion.Decod (NombreArch:STRING;Password:Pass);
          BEGIN
               ArchCod:=NombreArch;
               Pasword:=Password;
               Codificacion.ObtenerSemilla;
               Codificacion.AbrirArchDeCod;
               Codificacion.DeCodificar;
               Codificacion.CerrarArchDeCod;
          END;
END.
