{
  Programa instalador de PACKDIR ocupa que el archivo compilado
  PACKDIR.EXE este renombrado a PACKDIR.VGA y que este en donde se
  encuentre este archivo compilado: INSTALPD.EXE

  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.2
  Ultima actualizacion: Mayo 22 de 1996
  Este es codigo GNU/GPL
}

{$S-}
{$B-}
{$R-}
USES Crt,Packsoft,Windows,Dos,Codecod,Graph,BGICHR;
VAR BotonContinuar:BotonGr;
    Opcion:SHORTINT;
    Fuente:STRING;
    Destino:STRING;
    Codificar:Codificacion;

PROCEDURE Continuar;
PROCEDURE Copiar (Origen,Destino:STRING);
VAR ArchOrigen:FILE OF BYTE;
    ArchDestino:FILE OF BYTE;
    CopyArch:LONGINT;
    Bite:Byte;
    CordX:INTEGER;
          BEGIN
               Assign (ArchOrigen,Origen);
               Assign (ArchDestino,Destino);
               Reset (ArchOrigen);
               Rewrite (ArchDestino);
               CordX:=115;
               GrafEscribir (110,400,'Leyendo...',2,0,5,4);
               FOR CopyArch:=1 TO Filesize (ArchOrigen) DO
                   BEGIN
                        IF CopyArch>=1820 THEN
                           IF CopyArch MOD 1820=0 THEN
                           BEGIN
                                Menugrafsom (105,395,220,415,7,1,7);
                                GrafEscribir (110,400,'Escribiendo...',2,0,5,4);
                                Borde (CordX,360,CordX+4,390,0,Bajo);
                                CordX:=CordX+4;
                           END;
                        IF CopyArch MOD (1820 * 2)=0 THEN
                                   BEGIN
                                        Menugrafsom (105,395,220,415,7,1,7);
                                        GrafEscribir (110,400,'Leyendo...',2,0,5,4);
                                   END;
                        Read (ArchOrigen,Bite);
                        Write (ArchDestino,Bite);
                   END;
               Close (ArchOrigen);
               Close (ArchDestino);
          END;

          BEGIN
               EscribirSombreado (120,349,'0%',0,0,1,0,Bajo);
               EscribirSombreado (310,349,'50%',0,0,1,0,Bajo);
               EscribirSombreado (490,349,'100%',0,0,1,0,Bajo);
               EscribirSombreado (280,400,'Instalando',0,0,1,7,Bajo);
               Borde (115,359,519,389,1,Alto);
               IF Length(Destino)>=4 THEN BEGIN
                                          {$I-}
                                          ChDir(Destino);
                                          IF IOResult<>0 THEN
                                             BEGIN
                                                  MkDir(Destino);
                                                  ChDir(Destino);
                                             END;
                                          {$I+}
                                          END;
               Copiar (Fuente+'\PACKDIR.VGA ',Destino+'\PACKDIR.EXE');
               Sonido (600,60);
               Borde (115,360,519,390,0,Bajo);
               Menugrafsom (105,395,440,415,7,1,7);
               EscribirSombreado (230,400,'Presione ENTER para salir ',0,0,1,0,Bajo);
               SettextJustify (1,2);
               GrafEscribir (succ (GetmaxX div 2),365,'Instalacion Terminada',2,0,6,15);
               SettextJustify (0,2);
               BotonAceptar (290,GetmaxY-40,7,4,'  Salir  ');
               Protector;
               Pausa;
          END;

PROCEDURE Personalizar;
VAR BotPer:BotonGr;
    OpcPer:SHORTINT;
    OldF,OldD:STRING;
          BEGIN
               OldF:=Fuente;
               OldD:=Destino;
               BotonContinuar.IniBotones (1);
               BotonContinuar.AgregarBot ('FUENTE ',265,340);
               BotonContinuar.AgregarBot ('DESTINO',265,370);
               BotonContinuar.AgregarBot (' TODO  ',265,400);
               BotonContinuar.AgregarBot ('CANCEL ',265,430);
               BotonContinuar.PreguntaBot (0,1,0,7,0,0,OpcPer);
               Menugrafsom (264,339,360,460,7,1,7);
               IF OpcPer=1 THEN LeerCadenaGrafica (255,200,500,2,6,15,0,Fuente);
               IF OpcPer=2 THEN LeerCadenaGrafica (255,240,500,2,6,15,0,Destino);
               IF OpcPer=3 THEN
                  BEGIN
                       LeerCadenaGrafica (255,200,500,2,6,15,0,Fuente);
                       LeerCadenaGrafica (255,240,500,2,6,15,0,Destino);
                  END;
               IF Length(Fuente)>=4 THEN
                  BEGIN
                       IF Fuente[Length(Fuente)]='\'
                       THEN Delete (Fuente,Length(Fuente),1);
                       IF Destino[Length(Destino)]='\'
                       THEN Delete (Destino,Length(Destino),1);
                       IF ExisteArchivo (Fuente+'\PACKDIR.VGA')=FALSE THEN Fuente:=OldF;
                  END
               ELSE
               IF ExisteArchivo (Fuente+'PACKDIR.VGA')=FALSE THEN Fuente:=OldF;
               IF Fuente[Length(Fuente)]='\'
               THEN Delete (Fuente,Length(Fuente),1);
               IF Destino[Length(Destino)]='\'
               THEN Delete (Destino,Length(Destino),1);
               IF ExisteArchivo (Fuente+'\PACKDIR.VGA')=FALSE THEN Fuente:=OldF;
               IF (Destino[1]='\') OR (Destino='') OR (Destino=' ') THEN Destino:=OldD;
          END;

PROCEDURE Instalacion;
VAR Modo,Drive:INTEGER;
    ArchCod:FILE OF BYTE;
    
     BEGIN
          IF TipoMonitor='M' THEN
             BEGIN
                  ColorFondText (0,7);
                  Clrscr;
                  Writeln ('PackSoft (c)., 1994-1996, Paquete de Directorios  Version 2.0');
                  Writeln ('Lo siento este programa solo funciona en un monitor a color');
                  Writeln ('Aentamente: Geronimo Orozco Martinez');
                  Writeln;
                  Writeln ('Sugerencia: Puede utilizar un simulador de graficos: ejem. SIMCGA.COM');
                  Writeln ('pero no le garantizo que funcione...');
                  Writeln ('A no ser que su computadora tenga una tarjeta de video VGA');
                  Writeln;
                  Halt;
             END
          ELSE
          IF ExisteArchivo ('PACKDIR.VGA')=FALSE THEN
             BEGIN
                  Sonido (600,60);
                  Writeln ('No se encuentra el archivo PACKDIR.VGA');
                  Writeln ('La instalacion de el Paquete de Directorio no ha sido instalado con exito');
                  Writeln ('Copyrigth (c), 1994-1996 PackSoft');
                  Halt;
             END;
          Drive:=3;
          Modo:=2;
          EncuentranBGICHR;
          Initgraph (Drive,Modo,'');
          Fuente:='A:';
          Destino:='C:\PACKDIR';
          Borde (1,1,GetmaxX-1,50,7,ALTO);
          SettextJustify (1,2);
          Borde (1,52,GetmaxX-1,GetmaxY-1,7,ALTO);
          Borde (100,150,GetmaxX-100,GetmaxY-150,7,ALTO);
          EscribirSombreado (Succ(GetmaxX div 2),5,'Instalacion de PackDir Ver. 2.0',1,0,3,0,ALTO);
          EscribirSombreado (Succ(GetmaxX div 2),30,'Copyrigth (c) 1994-1996 PackSoft(R)',2,0,5,7,ALTO);
          GrafEscribir (Succ(GetmaxX div 2),160,'La Instalacion se hara por defecto en C:\PACKDIR',2,0,5,0);
          SettextJustify (0,2);

          REPEAT
                Borde (250,200,500,222,0,Bajo);
                Borde (250,240,500,262,0,Bajo);
                GrafEscribir (255,200,Fuente,2,0,6,14);
                GrafEscribir (255,240,Destino,2,0,6,14);
                GrafEscribir (170,200,'Fuente:',2,0,6,1);
                GrafEscribir (170,240,'Destino:',2,0,6,1);
                BotonContinuar.IniBotones (1);
                BotonContinuar.AgregarBot (' CONTINUAR  ',115,290);
                BotonContinuar.AgregarBot ('PERSONALIZAR',250,290);
                BotonContinuar.AgregarBot ('   SALIR    ',390,290);
                BotonContinuar.PreguntaBot (0,1,0,7,0,0,Opcion);
                IF Opcion=2 THEN Personalizar;
          UNTIL (Opcion=1) OR (Opcion=3);
                IF Opcion=1 THEN Continuar;
     END;
BEGIN
     BloquearControlBreak;
     Instalacion;
     Randomize;
     EfectoSalidaGraf (Random (3),0);
     Writeln ('PackSoft (c)., Instalacion de PackDir Version 2.0');
     Writeln;
END.
