{
  Programa para crear un directorio personal
  ya se, ya hay muchos, la caracteristica de este es que es grafico
  probablemente ya haya algun otro. Pero aunque sea tarde aqui esta este
  programa, no me pregunten porque hasta ahora pero resulta que lo acabo
  de sacar de la tumba. Y en ese entonces no conocia el tipo de licencia
  GPL y tampoco conocia mucho de Internet.
  Asi que no me pregunten mucho sobre el ya que lo la ultima acualizacion
  en el codigo fue el 12/07/1996.
  Y como veran estaba algo influenciado en esas fechas por Mocosoft
  Decidi dejarlo tal cual, y no modificarle nada por respeto.
  y solo le agregue estas lineas.
  Por ultimo:
  Este programa ha sido compilado satisfactoriamente en Borland Pascal 7.0

  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 2.0
  Ultima actualizacion: Julio 12 de 1996
  Este es codigo GNU/GPL
}

{$S-}
{$B-}
{$R-}
USES Crt,Packsoft,Graph,Windows,Impresora,Codecod,Printer,BGICHR;
TYPE Cadena2=STRING;
      DatPersona=RECORD
                Nombre:Cadena2;
                Direccion:STRING;
                Colonia:STRING;
                Telefono:STRING;
                END;
    Fichero=FILE OF DatPersona;
CONST
     ColorTitulo=7;
     ColorFondo=8;
VAR Menu:GrafMenu;
    Existe:BOOLEAN;
    E,E2:DatPersona;
    OpcionMenu:INTEGER;
    Persona:DATPERSONA;{Variables de archivos}
    Archivo:Fichero;
    Codificar:Codificacion;
PROCEDURE CuadroImpresoraLista;
VAR ImpOk:SHORTINT;
    BotonImp:BotonGr;
          BEGIN
               REPEAT
                     IF ImpresoraLista<> TRUE THEN
                        BEGIN
                             Sonido (600,80);
                             Menugrafsom (130,180,510,290,14,1,4);
                             GrafEscribir (195,185,' La impresora no esta lista ! ',6,0,2,15);
                             GrafEscribir (134,215,
                             'Revise que su impresora este lista para imprimir y seleccione Ok '
                             ,2,0,4,15);
                             BotonImp.IniBotones (1);
                             BotonImp.AgregarBot ('  Ok!  ',190,250);
                             BotonImp.AgregarBot ('Cancelar',350,250);
                             BotonImp.PreguntaBot (0,1,0,7,0,0,ImpOk);
                        END;
               UNTIL (ImpresoraLista=TRUE) OR (ImpOk=2) OR (ImpOk=3);
          END;
PROCEDURE Presentacion;
VAR Drive,Modo:INTEGER;
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
          IF ExisteArchivo ('PACKDIR.PKS')=TRUE THEN
             BEGIN
                  Assign (Archivo,'PACKDIR.PKS');
                  Reset (Archivo);
                  IF FileSize (Archivo)<>0 THEN
                     BEGIN
                          Close (Archivo);
                          Codificar.DeCod ('PACKDIR.PKS','PackGom');
                     END
                  ELSE
                      Close (Archivo);
             END;
          Drive:=3;
          Modo:=2;
          EncuentranBGICHR;
          Initgraph (Drive,Modo,'');
	  Borde (100,80,GetmaxX-100,GetMaxY-120,9,ALTO);
          Borde (150,190,GetmaxX-150,GetMaxY-195,7,ALTO);
          Settextjustify (1,2);
          GrafEscribir(Succ (GetMaxX div 2),300,'Version 2.0',0,0,1,15);
          GrafEscribir(Succ (GetMaxX div 2),310,'Copyrigth (c), 1996  PackSoft S.A.',0,0,1,15);
          Setfillstyle (1,0);
          Fillellipse (425,125,6,6);
          GrafEscribir (425,119,'C',2,0,4,15);
          EscribirSombreado (Succ (GetMaxX div 2),125,' ACKSOFT',1,0,5,8,Alto);
          EscribirSombreado (Succ (GetMaxX div 2),200,' ACKDIR',8,0,7,8,Bajo);
          Settextjustify (0,2);
          EscribirSombreado (170,164,'P',8,0,9,8,Bajo);
          EscribirSombreado (220,115,'P',1,0,6,8,Alto);
          Protector;
          Pausa;
  END;
PROCEDURE Activar(VAR F:Fichero;Nombre:STRING);
          BEGIN
               Existe:=ExisteArchivo(Nombre);
               IF Existe=FALSE THEN
                               BEGIN
                               Rewrite (F);
                               Close (F);
                               END;
          END;{Activar}
FUNCTION Posicion (N:Cadena2;Var F:FICHERO):INTEGER;
Var Registro:DatPersona;
    Hallado:Boolean;
         BEGIN
              Hallado:=FALSE;
              Seek (F,0);
              WHILE NOT EOF (F) AND NOT Hallado DO
                    BEGIN
                         Read (F,Registro);
                         Hallado:=Upcadena(Registro.Nombre)=Upcadena (N);
                    END;
              IF Hallado=TRUE THEN Posicion:=FilePos(F)-1
              ELSE Posicion:=-1
         END;{Posicion}
PROCEDURE VisualizarRegistro(VAR Pers:DatPersona);
          BEGIN
               Borde (60,230,GetMaxX-50,360,7,Alto);
               Borde (180,240,GetMaxX-60,260,0,Bajo);
               Borde (180,270,GetMaxX-60,290,0,Bajo);
               Borde (180,300,440,320,0,Bajo);
               Borde (180,330,440,350,0,Bajo);
               WITH Pers DO
                    BEGIN
               GrafEscribir (70,240,'NOMBRE:',1,0,1,0);
               GrafEscribir (70,270,'DIRECCION:',1,0,1,0);
               GrafEscribir (70,300,'COLONIA:',1,0,1,0);
               GrafEscribir (70,330,'TELEFONO:',1,0,1,0);
               GrafEscribir(185,240,Nombre,2,0,6,14);
               GrafEscribir(185,270,Direccion,2,0,6,14);
               GrafEscribir(185,300,COLONIA,2,0,6,14);
               GrafEscribir(185,330,TELEFONO,2,0,6,14);
                    END;{WITH}
          END;
PROCEDURE LeerRegistro(VAR Pers:DatPersona);
          BEGIN
               Borde (60,170,GetMaxX-50,310,7,ALTO);
               WITH Pers DO
                    BEGIN
               GrafEscribir (70,180,'NOMBRE:',1,0,1,0);
               GrafEscribir (70,210,'DIRECCION:',1,0,1,0);
               GrafEscribir (70,240,'COLONIA:',1,0,1,0);
               GrafEscribir (70,270,'TELEFONO:',1,0,1,0);
               LeerCadenaGrafica(180,180,GetMaxX-60,2,6,15,0,Nombre);
               LeerCadenaGrafica(180,210,GetMaxX-60,2,6,15,0,Direccion);
               LeerCadenaGrafica(180,240,440,2,6,15,0,Colonia);
               LeerCadenaGrafica(180,270,440,2,6,15,0,Telefono);
               IF Nombre[Length(Nombre)]=' ' THEN Delete (Nombre,Length(Nombre),1);
                    END;{WITH}
          END;
PROCEDURE LeerCampo(VAR Pers:DatPersona;Campo:CHAR);
          BEGIN
               WITH Pers DO
                    BEGIN
                         CASE Campo OF
                              'D':LeerCadenaGrafica(182,270,GetMaxX-60,2,6,15,0,Direccion);
                              'C':LeerCadenaGrafica(182,300,440,2,6,15,0,Colonia);
                              'T':LeerCadenaGrafica(182,330,440,2,6,15,0,Telefono);
                         END{Case}
                    END;{WITH}
          END;{LeerCampo}

PROCEDURE ImprimirReg (VAR F:Fichero; VAR Pers:DatPersona;NumReg,RegSN:INTEGER);
          BEGIN
               Seek (F,NumReg);
               WITH Pers DO
                    BEGIN
                         ImpresoraEnfatizado;
                         CuadroImpresoraLista;
                         IF RegSn=1 THEN Writeln (lst,'REGISTRO No. ',NumReg);
                         ImpresoraDoblePasada;
                         CuadroImpresoraLista;
                         Writeln(lst);
                         CuadroImpresoraLista;
                         Write (lst,'NOMBRE: ');
                         ImpresoraDesDoblePasada;
                         CuadroImpresoraLista;
                         Writeln (lst,Nombre);
                         ImpresoraDoblePasada;
                         CuadroImpresoraLista;
                         Write (lst,'DIRECCION: ');
                         ImpresoraDesDoblePasada;
                         CuadroImpresoraLista;
                         Writeln (lst,Direccion);
                         ImpresoraDoblepasada;
                         CuadroImpresoraLista;
                         Write (lst,'COLONIA: ');
                         ImpresoraDesDoblePasada;
                         CuadroImpresoraLista;
                         Writeln (lst,Colonia);
                         ImpresoraDoblepasada;
                         CuadroImpresoraLista;
                         Write (lst,'TELEFONO: ');
                         ImpresoraDesDoblePasada;
                         CuadroImpresoraLista;
                         Writeln (lst,Telefono);
                         ImpresoraDesDoblePasada;
                         CuadroImpresoraLista;
                         Writeln (lst);
                    END;{with}
          END;{LeerCampo}


PROCEDURE Ampliar (Var F:Fichero);
VAR
    Arch2:Fichero;
    Cont:CHAR;
    Opcion:SHORTINT;
    BotonesCS:BotonGr;
    I:INTEGER; {Posicion del registro en el archivo }
    BEGIN
         Borde (20,60,GetMaxX-20,100,7,Alto);
         EscribirSombreado (230,70,'AGREGAR REGISTROS',1,0,1,0,BAJO);
         Borde (20,100,GetMaxX-20,GetMaxY-20,7,Alto);
         REPEAT
              Menugrafsom (99,329,571,381,7,1,7);
              Menugrafsom (155,395,465,427,7,1,7);
              Activar(F,'PACKDIR.PKS');
              Reset (F);
              LeerRegistro (E);
              I:=Posicion (E.Nombre,F);
          IF E.Nombre='' THEN BEGIN
                              Sonido (800,60);
                              Borde (100,330,570,380,4,alto);
                              EscribirSombreado (120,345,'EL NOMBRE DEBE CONTENER AL MENOS 1 CARACTER',2,0,6,14,bajo);
                              Close (F);
                              I:=-2;
                              END;{I:=0;}
              IF I=-1 THEN
                 BEGIN
                  Assign (Arch2,'DIRCTORY.BAK');
                  Rewrite(Arch2);
                  Seek (F,0);
                  WHILE NOT EOF (F) DO
                     BEGIN
                       Read (F,E2);
                       Write (Arch2,E2);
                     END;
                  Write (Arch2,E);
                  Close (Arch2);
                  Close (F);
                  Erase (F);
                  Rename (Arch2,'PACKDIR.PKS');
              END; {Si no existe}
          IF I>-1 THEN {Si existe}
            BEGIN
             Sonido (800,60);
             Borde (200,330,450,380,4,alto);
             EscribirSombreado (220,345,'EL REGISTRO YA EXISTE !',2,0,6,14,bajo);
             Close (F);
            END;{Si existe}
            BotonesCS.IniBotones (1);
            BotonesCS.AgregarBot  (' CONTINUAR ',160,GetMaxY-80);
            BotonesCS.AgregarBot  ('   SALIR   ',340,GetMaxY-80);
            BotonesCS.PreguntaBot (0,1,0,7,0,0,Opcion);
         UNTIL (Opcion=2) OR (Opcion=0);
END;{Ampliar}
PROCEDURE Borrarlo (VAR F:Fichero;VAR Posicion:INTEGER);
VAR Arch2:Fichero;
    Registro2,Registro:DatPersona;
    Pos:INTEGER;
          BEGIN

               Assign (Arch2,'DIRCTORY.TEM');
               Rewrite (Arch2);
               Pos:=0;
               Seek (F,Pos);
               WHILE NOT EOF (F) DO
                     BEGIN
                          Read (F,Registro2);
                          IF Pos<>Posicion THEN
                             BEGIN
                                  Write(Arch2,Registro2);
                             END;{No es igual}
                          Pos:=Pos+1;
                     END;{While}
               CLOSE (F);
               CLOSE (Arch2);
               Erase (F);
               Rename (Arch2,'PACKDIR.PKS');
               Reset (F);
               Seek (F,Posicion-1);
          END;
PROCEDURE Borrar (VAR F:Fichero);
VAR
    Arch2:Fichero;
    Registro2,Registro:DatPersona;
    Pos:INTEGER;
    BotonesCS:BotonGr;
    BotonesBNB:BotonGr;
    BorNobor,Opcion:SHORTINT;
    BEGIN
          Existe:=ExisteArchivo ('PACKDIR.PKS');
          IF Existe=TRUE THEN
             BEGIN
                  Borde (20,60,GetMaxX-20,100,7,Alto);
                  EscribirSombreado (170,70,' BORRAR REGISTRO DEL ARCHIVO ',1,0,1,0,BAJO);
                  Borde (20,100,GetMaxX-20,GetMaxY-20,7,Alto);
              REPEAT
                    Borde (60,140,GetMaxX-50,200,7,alto);
                    GrafEscribir (70,160,'NOMBRE ? ',1,0,1,0);
                    LeerCadenaGrafica(170,160,GetMaxX-70,2,6,15,0,Registro.Nombre);
                    IF Registro.Nombre[Length(Registro.Nombre)]=' ' THEN
                    Delete (Registro.Nombre,Length(Registro.Nombre),1);
                    Reset (F);
                    Pos:=Posicion(Registro.Nombre,F);
                    IF Pos=-1 THEN
                       BEGIN
                            Sonido (800,60);
                            Borde (195,220,460,300,4,Alto);
                            EscribirSombreado (220,250,'EL REGISTRO NO EXISTE ! ',2,0,6,14,bajo);
                            Close (f);
                       END{Pos =-1}
                    ELSE{1}
                        BEGIN
                             Seek (F,Pos);
                             Read (F,Registro);
                             VisualizarRegistro(Registro);
                             BotonesBNB.IniBotones (1);
                             BotonesBNB.AgregarBot  ('  BORRAR!  ',180,GetMaxY-90);
                             BotonesBNB.AgregarBot  (' CANCELAR ',340,GetMaxY-90);
                             BotonesBNB.PreguntaBot (0,1,0,7,0,0,BorNobor);
                             CASE BorNobor OF
                             1:BEGIN
                                    Assign (Arch2,'DIRCTORY.TEM');
                                    Rewrite (Arch2);
                                    Seek (F,0);
                                    WHILE NOT EOF (F) DO
                                          BEGIN
                                               Read (F,Registro2);
                                               IF Registro2.Nombre <> Registro.Nombre THEN
                                                  BEGIN
                                                       Write(Arch2,Registro2);
                                                  END;{No es igual}
                                          END;{While}
                                    CLOSE (F);
                                    CLOSE (Arch2);
                                    Erase (F);
                                    Rename (Arch2,'PACKDIR.PKS');
                                END;{En caso de que lo quiera borrar opcion 1}
                             END;{Else 1} {Borrado}
                             Menugrafsom (59,380,GetMaxX-49,GetMaxY-40,7,1,7); {Borra el cuadro de presentacion}
                             END;{Case}
                    BotonesCS.IniBotones (1);
                    BotonesCS.AgregarBot  (' CONTINUAR ',160,390);
                    BotonesCS.AgregarBot  ('   SALIR   ',340,390);
                    BotonesCS.PreguntaBot (0,1,0,7,0,0,Opcion);
                    Menugrafsom (59,219,GetMaxX-49,GetMaxY-40,7,1,7);
               UNTIL (Opcion=2) OR (Opcion=0);
             END{Si existe}
          ELSE{2}
              BEGIN
                   Sonido (800,60);
                   MenugrafSom (90,180,GetMaxX-80,240,15,1,4);
                   GrafEscribir (110,200,'NO EXISTE EL ARCHIVO ESCOJA "AGREGAR" !',1,0,2,14);
                   Protector;
                   Pausa;
              END;{{Else 2 Si no existe}
    END;{Borrar}
PROCEDURE ListadoTotal (Var F:Fichero);
VAR Reg:INTEGER;
    RegS:STRING;
    BotonesCS,BotonImp:BotonGr;
    Opcion,ImpOk:SHORTINT;
    BEGIN
         Existe:=ExisteArchivo ('PACKDIR.PKS');
         IF Existe= TRUE THEN
            BEGIN
                 Reset (F);
                 IF Filesize(F) <> 0 THEN
                    BEGIN
                     Borde (20,60,GetMaxX-20,100,7,Alto);
                     EscribirSombreado (200,70,'LISTADO TOTAL DE REGISTROS',1,0,1,0,BAJO);
                     Borde (20,100,GetMaxX-20,GetMaxY-20,7,Alto);
                     EscribirSombreado(65,170,'Registro No. ',1,0,1,0,Bajo);
                     Reg:=0;
                     WHILE NOT EOF(F) DO
                        BEGIN
                           Seek (F,Reg);
                           Str(Reg+1:0,RegS);
                           Menugrafsom (180,170,225,195,7,1,7);
                           EscribirSombreado (185,170,RegS,1,0,1,0,Bajo);
                           Read (F,E);
                           VisualizarRegistro(E);
                           BotonesCS.IniBotones (1);
                           BotonesCS.AgregarBot  ('ADELANTE',65,400);
                           BotonesCS.AgregarBot  (' ATRAS ',175,400);
                           BotonesCS.AgregarBot  ('IMPRIMIR',285,400);
                           BotonesCS.AgregarBot  ('BORRAR',400,400);
                           BotonesCS.AgregarBot  ('SALIR',500,400);
                           BotonesCS.PreguntaBot (0,1,0,7,0,0,Opcion);
                           IF Opcion=1 THEN IF Reg>=0 THEN Reg:=Reg+1;
                           IF Opcion=2 THEN IF Reg>0 THEN Reg:=Reg-1
                           ELSE BEGIN
                                Sonido (600,60);
                                END;
                           IF Opcion=3 THEN
                              BEGIN
                                   REPEAT
                                         IF ImpresoraLista<> TRUE THEN
                                            BEGIN
                                                 Sonido (600,80);
                                                 Menugrafsom (330,110,610,190,14,1,4);
                                                 GrafEscribir (360,107,' La impresora no esta lista ! ',6,0,1,15);
                                                 GrafEscribir (340,132,'Revise que su impresora este lista para ',2,0,4,15);
                                                 GrafEscribir (340,140,'imprimir y seleccione Ok ',2,0,4,15);
                                                 BotonImp.IniBotones (1);
                                                 BotonImp.AgregarBot ('  Ok!  ',350,160);
                                                 BotonImp.AgregarBot ('Cancelar',500,160);
                                                 BotonImp.PreguntaBot (0,1,0,7,0,0,ImpOk);
                                            END;
                                   UNTIL (ImpresoraLista=TRUE) OR (ImpOk=2) OR (ImpOk=0);
                                   IF ImpresoraLista=TRUE THEN
                                      BEGIN
                                           ImprimirReg (F,E,Reg+1,1);
                                           IF Reg>1 THEN Reg:=Reg-1
                                           ELSE Reg:=0;
                                      END;
                                   IF (ImpOk=2) OR (ImpOk=0) THEN
                                      BEGIN
                                           Menugrafsom (330,110,610,190,7,1,7);
                                           IF Reg>1 THEN Reg:=Reg-1
                                           ELSE Reg:=0;
                                      END;

                              END;
                              IF Opcion=4 THEN
                              BEGIN
                                   Borrarlo (Archivo,Reg);
                                   Seek (F,Reg);
                              END;
                           IF (Opcion=5) OR (Opcion=0) THEN
                              BEGIN
                                   Close (F);
                                   Exit;
                              END;
                     END;{While}
                Close (F);
              END{Si no esta vacio}
         ELSE
             BEGIN
                  Sonido (800,60);
                  MenugrafSom (160,180,GetMaxX-130,240,15,1,4);
                  GrafEscribir (210,200,'EL ARCHIVO ESTA VACIO !',1,0,2,14);
                  Close (F);
                  Protector;
                  Pausa;
             END;{Si esta vacio}
            END{Si existe}
         ELSE
         BEGIN
              Sonido (800,60);
              MenugrafSom (90,180,GetMaxX-80,240,15,1,4);
              GrafEscribir (110,200,'NO EXISTE EL ARCHIVO ESCOJA "AGREGAR" !',1,0,2,14);
              Protector;
              Pausa;
         END;
END;{ListadoTotal}
PROCEDURE Cambios(Var F:Fichero);
VAR
    Arch2:Fichero;
    Registro2,Registro:DatPersona;
    Pos:INTEGER;
    BotonesCS:BotonGr;
    BotonesMod:BotonGr;
    BotonesMCam:BotonGr;
    Modificar,Opcion,OpcionBMC:SHORTINT;
    CampoModif:CHAR;
PROCEDURE LeerParaModificar(E2,Ecorrec:DatPersona;PosRegistro:INTEGER);
VAR PosComp:INTEGER;
    Fich2:Fichero;
          BEGIN
          LeerRegistro (E2);
          Assign (Fich2,'PACKDIR.PKS');
          Reset (Fich2);
          Poscomp:=0;
          WHILE NOT EOF (Fich2) DO
                BEGIN
                     Read (Fich2,E);
                     IF (Upcadena(E.Nombre)=Upcadena (E2.Nombre))
                        AND (PosRegistro<>PosComp) THEN
                        BEGIN
                             Seek (Arch2,PosRegistro);
                             Write (Arch2,Ecorrec);
                             Sonido (800,60);
                             Borde (140,330,500,380,4,alto);
                             EscribirSombreado (180,345,'EL NOMBRE YA ESTA REGISTRADO !',2,0,6,14,bajo);
                             Exit;
                        END;
                     PosComp:=PosComp+1;
                END;
          Close (Fich2);
          IF E2.Nombre='' THEN
             BEGIN
                  Sonido (800,60);
                  Borde (100,330,570,380,4,alto);
                  EscribirSombreado (120,345,'EL NOMBRE DEBE CONTENER AL MENOS 1 CARACTER',2,0,6,14,bajo);
                  Seek (Arch2,PosRegistro);
                  Write (Arch2,Ecorrec);
             END;
          IF E2.Nombre<>'' THEN
             BEGIN
                  Seek (Arch2,PosRegistro);
                  Write (Arch2,E2);
             END;{Si la cadena del nombre es mayor a un caracter}

          END;{LeerParaModificar Registro}
PROCEDURE LeerParaCampo(E2,Ecorrec:DatPersona;Campo:CHAR;PosRegistro:INTEGER);
          BEGIN
              LeerCampo (E2,Campo);
              Write (Arch2,E2);
                        END;{LeerParaModificar Campo}

          BEGIN
            Existe:=ExisteArchivo ('PACKDIR.PKS');
            IF Existe=TRUE THEN
               BEGIN
                    Borde (20,60,GetMaxX-20,100,7,Alto);
                    EscribirSombreado (230,70,'MODIFICAR REGISTROS',1,0,1,0,BAJO);
                    Borde (20,100,GetMaxX-20,GetMaxY-20,7,Alto);
               REPEAT
                    Borde (60,140,GetMaxX-50,200,7,alto);
                    GrafEscribir (70,160,'NOMBRE ? ',1,0,1,0);
                    LeerCadenaGrafica(170,160,GetMaxX-70,2,6,15,0,Registro.Nombre);
                    IF Registro.Nombre[Length(Registro.Nombre)]=' ' THEN
                    Delete (Registro.Nombre,Length(Registro.Nombre),1);
                    Reset (F);
                    Pos:=Posicion(Registro.Nombre,F);
                    IF Pos=-1 THEN
                       BEGIN
                            Sonido (800,60);
                            Borde (195,220,460,300,4,Alto);
                            EscribirSombreado (220,250,'EL REGISTRO NO EXISTE ! ',2,0,6,14,bajo);
                            Close (f);
                       END{Pos =-1}
                    ELSE{Si existe el registro}
                        BEGIN
                             Seek (F,Pos);
                             Read (F,Registro);
                             VisualizarRegistro(Registro);
                             BotonesMOD.IniBotones (1);
                             BotonesMOD.AgregarBot  (' MODIFICAR REGISTRO ',75,GetMaxY-90);
                             BotonesMOD.AgregarBot  (' MODIFICAR CAMPO ',280,GetMaxY-90);
                             BotonesMOD.AgregarBot  (' CANCELAR ',465,GetMaxY-90);
                             BotonesMOD.PreguntaBot (0,1,0,7,0,0,Modificar);
                             CASE Modificar OF
                             1:BEGIN
                                    Assign (Arch2,'DIRCTORY.BAK');
                                    Rewrite(Arch2);
                                    Seek (F,0);
                                    Pos:=0;
                                    WHILE NOT EOF (F) DO
                                          BEGIN
                                               Read (F,Registro2);
                                               IF Registro2.Nombre <> Registro.Nombre THEN
                                                  BEGIN
                                                       Write(Arch2,Registro2);
                                                  END;{No es igual}
                                                IF Registro2.Nombre = Registro.Nombre THEN
                                                   BEGIN
                                                        Menugrafsom (59,119,GetMaxX-49,GetMaxY-40,7,1,7);
                                                        LeerParaModificar(Registro,Registro2,Pos);
                                                   END;
                                                Pos:=Pos+1;
                                          END;{While}
                                     Close (F);
                                     Close (Arch2);
                                     Erase (F);
                                     Rename (Arch2,'PACKDIR.PKS');
                                END;{En caso de que lo quiera modificar todo opcion 1}
                             2:BEGIN
                                    Menugrafsom (59,369,GetMaxX-49,GetMaxY-40,7,1,7); {Borra el cuadro de presentacion}

                                    BotonesMCAM.IniBotones(1);
                                    BotonesMCAM.AgregarBot  (' DIRECCION ',65,GetMaxY-90);
                                    BotonesMCAM.AgregarBot  ('  COLONIA  ',195,GetMaxY-90);
                                    BotonesMCAM.AgregarBot  ('  TELEFONO ',330,GetMaxY-90);
                                    BotonesMCAM.AgregarBot  (' CANCELAR ',470,GetMaxY-90);
                                    BotonesMCAM.PreguntaBot (2,5,0,7,0,0,OpcionBMC);
                                    Menugrafsom (59,369,GetMaxX-49,GetMaxY-40,7,1,7);{Borra los botones}
                                    IF (OpcionBMC>0) AND (OpcionBMC<4) THEN
                                       BEGIN
                                            CASE OpcionBMC OF
                                                 1:CampoModif:='D';
                                                 2:CampoModif:='C';
                                                 3:CampoModif:='T';
                                            END;{Case}
                                            Assign (Arch2,'DIRCTORY.BAK');
                                            Rewrite(Arch2);
                                            Reset (F);
                                            Seek (F,0);
                                            Pos:=0;
                                            WHILE NOT EOF (F) DO
                                                  BEGIN
                                                       Read (F,Registro2);
                                                       IF Registro2.Nombre <> Registro.Nombre THEN
                                                          BEGIN
                                                               Write(Arch2,Registro2);
                                                          END;{No es igual}
                                                       IF Registro2.Nombre = Registro.Nombre THEN
                                                       BEGIN
                                                            LeerParaCampo(Registro,Registro2,Campomodif,Pos);
                                                       END;
                                                  Pos:=Pos+1;
                                            END;{While}
                                       Close (F);
                                       Close (Arch2);
                                       Erase (F);
                                       Rename (Arch2,'PACKDIR.PKS');
                                    END;{Si la opcion esta entre 1 y 3}
                                    Menugrafsom (59,369,GetMaxX-49,GetMaxY-40,7,1,7);{Borra los botones}
                               END;{Opcion 2}
                             END;{Else Modificar si existe}
                             Menugrafsom (59,369,GetMaxX-49,GetMaxY-40,7,1,7); {Borra los botones}
                             END;{Case}
                    BotonesCS.IniBotones (1);
                    BotonesCS.AgregarBot  (' CONTINUAR ',160,400);
                    BotonesCS.AgregarBot  ('   SALIR   ',340,400);
                    BotonesCS.PreguntaBot (0,1,0,7,0,0,Opcion);
                    IF Opcion=1 THEN
                    Menugrafsom (59,189,GetMaxX-49,GetMaxY-40,7,1,7);
               UNTIL (Opcion=2) OR (Opcion=0);

               END{Si existe el archivo}
            ELSE
               BEGIN
                    Sonido (800,60);
                    MenugrafSom (90,180,GetMaxX-80,240,15,1,4);
                    GrafEscribir (110,200,'NO EXISTE EL ARCHIVO ESCOJA "AGREGAR" !',1,0,2,14);
                    Protector;
                    Pausa;
               END;{No existe el archivo}
          END;{Modificar}

PROCEDURE Imprimir(VAR F:Fichero);
VAR
    Arch2:Fichero;
    Registro2,Registro:DatPersona;
    Pos:INTEGER;
    BotonesCS:BotonGr;
    BotonesINI:BotonGr;
    ImpNoImp,Opcion,ImpOk:SHORTINT;
    BotonImp:BotonGr;
    BEGIN
          Existe:=ExisteArchivo ('PACKDIR.PKS');
          IF Existe=TRUE THEN
             BEGIN
                  Borde (20,60,GetMaxX-20,100,7,Alto);
                  EscribirSombreado (150,70,' IMPRIMIR REGISTROS DEL ARCHIVO ',1,0,1,0,BAJO);
                  Borde (20,100,GetMaxX-20,GetMaxY-20,7,Alto);
              REPEAT
                    Borde(150,150,GetmaXX-150,180,7,Alto);
                    Borde(150,182,GetmaXX-150,GetmaxY-150,7,Alto);
                    GrafEscribir (195,155,'Elija el modo de imprecion ',1,0,1,0);
                    BotonImp.IniBotones (1);
                    BotonImp.AgregarBot (' IMPRIMIR POR REGISTRO  ',210,205);
                    BotonImp.AgregarBot ('IMPRIMIR TODO EL ARCHIVO',210,245);
                    BotonImp.AgregarBot ('   CANCELAR IMPRESION   ',210,283);
                    BotonImp.PreguntaBot (0,1,0,7,0,0,Opcion);
                    IF (Opcion=0) OR (Opcion=3) THEN Exit;
                    IF Opcion=1 THEN
                       BEGIN
                            MenugrafSom (148,148,GetmaxX-148,GetmaxY-148,7,1,7);
                            Borde (60,140,GetMaxX-50,200,7,alto);
                            GrafEscribir (70,160,'NOMBRE ? ',1,0,1,0);
                            LeerCadenaGrafica(170,160,GetMaxX-70,2,6,15,0,Registro.Nombre);
                            IF Registro.Nombre[Length(Registro.Nombre)]=' ' THEN
                            Delete (Registro.Nombre,Length(Registro.Nombre),1);
                            Reset (F);
                            Pos:=Posicion(Registro.Nombre,F);
                            IF Pos=-1 THEN
                               BEGIN
                                    Sonido (800,60);
                                    Borde (195,220,460,300,4,Alto);
                                    EscribirSombreado (220,250,'EL REGISTRO NO EXISTE ! ',2,0,6,14,bajo);
                                    Close (f);
                               END{Pos =-1}
                            ELSE{1}
                                   BEGIN
                                        Seek (F,Pos);
                                        Read (F,Registro);
                                        VisualizarRegistro(Registro);
                                        BotonesINI.IniBotones (1);
                                        BotonesINI.AgregarBot  (' IMPRIMIR ',180,GetMaxY-90);
                                        BotonesINI.AgregarBot  (' CANCELAR ',340,GetMaxY-90);
                                        BotonesINI.PreguntaBot (0,1,0,7,0,0,ImpNoImp);
                                        CASE ImpNoImp OF
                                             1:BEGIN
                                                REPEAT
                                                 IF ImpresoraLista<> TRUE THEN
                                                    BEGIN
                                                         Sonido (600,80);
                                                         Menugrafsom (130,180,510,290,14,1,4);
                                                         GrafEscribir (195,185,' La impresora no esta lista ! ',6,0,2,15);
                                                         GrafEscribir (134,215,
                                                         'Revise que su impresora este lista para imprimir y seleccione Ok '
                                                         ,2,0,4,15);
                                                         BotonImp.IniBotones (1);
                                                         BotonImp.AgregarBot ('  Ok!  ',190,250);
                                                         BotonImp.AgregarBot ('Cancelar',350,250);
                                                         BotonImp.PreguntaBot (0,1,0,7,0,0,ImpOk);
                                                    END;
                                                 UNTIL (ImpresoraLista=TRUE) OR (ImpOk=2);
                                                       IF ImpresoraLista=TRUE THEN ImprimirReg (F,Registro,Pos-1,2);
                                               END;{1}
                                        END;{Case}
                                        Menugrafsom (59,380,GetMaxX-49,GetMaxY-40,7,1,7); {Borra el cuadro de presentacion}
                                   END;{Else}
                            END;{Si la opcion es imprimir por registro}
                       IF Opcion=2 THEN
                          BEGIN
                               Menugrafsom (130,180,510,290,14,1,4);
                               GrafEscribir (170,185,'Prepare la impresora para impresion ',6,0,2,15);
                               BotonImp.IniBotones (1);
                               BotonImp.AgregarBot (' Listo ',190,250);
                               BotonImp.AgregarBot ('Cancelar',350,250);
                               BotonImp.PreguntaBot (0,1,0,7,0,0,ImpOk);
                               IF ImpOk=1 THEN
                                  BEGIN
                                       REPEAT
                                             IF ImpresoraLista<> TRUE THEN
                                                BEGIN
                                                     Sonido (600,80);
                                                     Menugrafsom (130,180,510,290,14,1,4);
                                                     GrafEscribir (195,185,' La impresora no esta lista ! ',6,0,2,15);
                                                     GrafEscribir (134,215,
                                                     'Revise que su impresora este lista para imprimir y seleccione Ok '
                                                     ,2,0,4,15);
                                                     BotonImp.IniBotones (1);
                                                     BotonImp.AgregarBot ('  Ok!  ',190,250);
                                                     BotonImp.AgregarBot ('Cancelar',350,250);
                                                     BotonImp.PreguntaBot (0,1,0,7,0,0,ImpOk);
                                                 END;
                                       UNTIL (ImpresoraLista=TRUE) OR (ImpOk=2);
                                       IF ImpresoraLista=TRUE THEN
                                          BEGIN
                                               Reset (F);
                                               Pos:=0;
                                               ImpresoraExpandido;
                                               ImpresoraDoblePasada;
                                               Writeln (lst,'IMPRESION TOTAL DE REGISTROS');
                                               ImpresoraDesDoblePasada;
                                               Writeln (lst);
                                               Pos:=0;
                                               WHILE NOT EOF (F) DO
                                                     BEGIN
                                                      Seek (F,Pos);
                                                      Read (F,Registro);
                                                      ImprimirReg (F,Registro,Pos+1,1);
                                                      Pos:=Pos+1;
                                                     END;
                                          END;
                                  END;{Si quiere imprimir el archivo}
                         END;
                    BotonesCS.IniBotones (1);
                    BotonesCS.AgregarBot  (' CONTINUAR ',160,390);
                    BotonesCS.AgregarBot  ('   SALIR   ',340,390);
                    BotonesCS.PreguntaBot (0,1,0,7,0,0,Opcion);
                    Menugrafsom (59,129,GetMaxX-49,GetMaxY-40,7,1,7);
               UNTIL (Opcion=2) OR (Opcion=0);
             END{Si existe}
          ELSE{2}
              BEGIN
                   Sonido (800,60);
                   MenugrafSom (90,180,GetMaxX-80,240,15,1,4);
                   GrafEscribir (110,200,'NO EXISTE EL ARCHIVO ESCOJA "AGREGAR" !',1,0,2,14);
                   Protector;
                   Pausa;
              END;{{Else 2 Si no existe}
    END;{Borrar}
PROCEDURE Desplieges(VAR F:Fichero);
Var Registro:DatPersona;
    Pos:INTEGER;
    BotonesCS:BotonGR;
    Opcion:SHORTINT;
          BEGIN
          Existe:=ExisteArchivo('PACKDIR.PKS');
         IF Existe=TRUE THEN
          BEGIN
               Borde (20,60,GetMaxX-20,100,7,Alto);
               EscribirSombreado (170,70,' DESPLEGAR REGISTRO DEL ARCHIVO ',1,0,1,0,BAJO);
               Borde (20,100,GetMaxX-20,GetMaxY-20,7,Alto);
               Borde (60,140,GetMaxX-50,200,7,Alto);
           REPEAT
               GrafEscribir (70,160,'NOMBRE ? ',1,0,1,0);
               LeerCadenaGrafica(170,160,GetMaxX-60,2,6,15,0,Registro.Nombre);
               IF Registro.Nombre[Length(Registro.Nombre)]=' ' THEN
               Delete (Registro.Nombre,Length(Registro.Nombre),1);
               Reset (F);
               Pos:=Posicion(Registro.Nombre,F);
               IF Pos=-1 THEN
                         BEGIN
                         Sonido (800,60);
                         Borde (180,230,450,300,4,Alto);
                         EscribirSombreado (210,260,'EL REGISTRO NO EXISTE ! ',2,0,6,14,Bajo);
{                         Protector;
                         Pausa;}
                         END
               ELSE
                   BEGIN
                   Seek (F,Pos);
                   Read (F,Registro);
                   VisualizarRegistro(Registro);
                   END;
                   BotonesCS.IniBotones (1);
                   BotonesCS.AgregarBot  (' CONTINUAR ',160,GetMaxY-80);
                   BotonesCS.AgregarBot  ('   SALIR   ',340,GetMaxY-80);
                   BotonesCS.PreguntaBot (0,1,0,7,0,0,Opcion);
                   Menugrafsom (59,219,GetMaxX-49,GetMaxY-40,7,1,7);
           UNTIL (Opcion=2) OR (Opcion=0);
               Close (f);
         END{Si existe}
ELSE
    BEGIN
         Sonido (800,60);
         MenugrafSom (90,180,GetMaxX-80,240,15,1,4);
         GrafEscribir (110,200,'NO EXISTE EL ARCHIVO ESCOJA "AGREGAR" !',1,0,2,14);
         Protector;
         Pausa;
    END;{Si no existe}
END;{Desplegar}
PROCEDURE Ayuda;
Var Salir:CHAR;
          BEGIN
               Borde (20,60,GetMaxX-20,110,7,ALTO);
               EscribirSombreado (185,75,'Ayuda General PackDir 2.0',1,0,1,0,BAJO);
               Borde (20,112,GetMaxX-20,GetMaxY-30,7,ALTO);
               GrafEscribir (50,130,'Este programa esta dise¤ado para crear un directorio',2,0,6,0);
               GrafEscribir (50,142,'personalizado para el usuario., esta cuenta con las',2,0,6,0);
               GrafEscribir (50,154,'caracteristicas de un directorio personal.,',2,0,6,0);
               GrafEscribir (50,166,'Tambien cuenta con Reloj.',2,0,6,0);
               GrafEscribir (50,214,'La funcion de PackDir es muy facil,  utilice las teclas',2,0,6,0);
               GrafEscribir (50,226,'de flechas para seleccionar en el Menu de PackDir,',2,0,6,0);
               GrafEscribir (50,238,'y las teclas de funcion para los titulos anunciados',2,0,6,0);
               GrafEscribir (50,250,'en los botones a su izquierda...',2,0,6,0);
               GrafEscribir (50,300,'Se autoriza toda copia de este programa siempre y',2,0,6,0);
               GrafEscribir (50,315,'y cuando no se lo pasen a los maestros...',2,0,6,0);
               GrafEscribir (50,345,'ESPECIALMENTE DEL POLI...',2,0,7,0);
               BotonAceptar(270,400,7,0,' Aceptar ');
          REPEAT
                Protector;
                Salir:=Readkey;
          Until (Salir=#27) OR (Salir=#13);
          END;
PROCEDURE Autor;
Var Salir:CHAR;
          BEGIN

               Borde (90,92,GetMaxX-90,123,7,ALTO);
               EscribirSombreado (220,95,'PackDir Version 2.0',8,0,1,0,ALTO);
               Borde (90,125,GetMaxX-90,369,7,ALTO);
               EscribirSombreado (110,130,'PackDir Version 2.0, PackSoft (c), 1994-1996',2,0,6,0,BAJO);
               EscribirSombreado (180,280,'Universidad de Guadalajara',8,0,1,0,BAJO);
               Borde (170,165,465,265,7,BAJO);
               EscribirSombreado (165,300,'Escuela Politecnica los Belenes',8,0,1,0,BAJO);
               EscribirSombreado (200,175,'Geronimo Orozco Martinez',2,0,6,0,BAJO);
               EscribirSombreado (205,195,'Epigmenio Preciado #722',2,0,6,0,BAJO);
               EscribirSombreado (220,215,'Colonia Los Maestros',2,0,6,0,BAJO);
               EscribirSombreado (185,235,'633-66-98 Zapopan., Jalisco.',2,0,6,0,BAJO);
               BotonAceptar (270,340,7,0,' Aceptar ');
          REPEAT
                Protector;
                Salir:=Readkey;
          Until (Salir=#27) OR (Salir=#13);
               Setcolor (15);
          END;
PROCEDURE BorrarArchivo;
VAR Archivo:FILE;
    BotonBorrar:BotonGR;
    Borrar:SHORTINT;
          BEGIN
               Borde (100,100,GetMaxX-100,125,7,Alto);
               EscribirSombreado (250,100,'Borrar Archivo',1,0,1,0,Bajo);
               Borde (100,127,GetMaxX-100,280,7,ALTO);
               Borde (120,205,GetMaxX-120,265,4,BAJO);
               GrafEscribir (120,130,'¨ Esta seguro de borrar el archivo de DIRECTORIO ?',2,0,5,0);
               BotonBorrar.IniBotones (1);
               BotonBorrar.AgregarBot  ('  [ SI ]  ',160,220);
               BotonBorrar.AgregarBot  ('  [ NO ]  ',360,220);
               BotonBorrar.PreguntaBot (2,6,0,7,0,0,Borrar);
               IF Borrar=1 THEN
                  BEGIN
                       Existe:=ExisteArchivo('PACKDIR.PKS');
                       IF Existe= TRUE THEN
                          BEGIN
                               Assign (Archivo,'PACKDIR.PKS');
                               Erase(Archivo);
                               Sonido (550,100);
                               EscribirSombreado (180,160,'­ EL ARCHIVO HA SIDO BORRADO !',2,0,6,8,BAJO);
                          END {Si existe el archivo PACKDIR.PKS}
                       ELSE
                           BEGIN
                                Sonido (100,100);
                                EscribirSombreado (200,160,'­ EL ARCHIVO NO EXISTE !',2,0,6,8,Bajo);
                           END;{Si no existe el archivo PACKDIR.PKS}
                  Protector;
                  Pausa;
             END
          END;{BorrarArchivo}
PROCEDURE Reloj;
          BEGIN
               Borde (80,100,GetMaxX-30,130,7,Alto);
               EscribirSombreado (250,105,' R  E  L  O  J ',1,0,2,0,Bajo);
               Borde (80,132,GetMaxX-30,GetMaxY-80,7,Alto);
               Settextjustify (1,2);
               FechaGrafica (Succ((GetMaxX div 2)+30),280,8,0,3,0,Bajo);
               Settextjustify (0,2);
               BotonAceptar(300,342,7,0,' Aceptar ');
               HoraGrafica  (135,160,8,9,0,7,Alto);
          END;{Reloj}
PROCEDURE Fondo;
          BEGIN
               Borde (1,380,59,GetMaxY-1,7,Bajo);
               Setcolor (7);
               Line (0,1,0,GetmaxY-1);
               Borde (2,32,60,100,7,Alto);
               Borde (2,102,60,170,7,Alto);
               Borde (2,172,60,240,7,Alto);
               Borde (2,242,60,310,7,Alto);
               Borde (2,312,60,380,7,Alto);
               {F1}
               EscribirSombreado (20,35,'?',1,0,5,0,Bajo);
               GrafEscribir (7,85,'F1-Ayuda',2,0,4,0);
               {F2}
               Borde (10,117,52,147,4,Alto);
               GrafEscribir (7,155,'F2-Autor',2,0,4,0);
               GrafEscribir (14,125,'PackSoft (c)',2,0,1,15);
               GrafEscribir (14,135,'1994 - 1996',2,0,1,15);
               {F3}
               Menugrafsom (20,185,40,210,15,1,0);
               Line (29,180,29,185);
               Line (30,180,30,185);
               Line (31,180,31,185);
               Line (17,185,43,185);
               Setcolor (7);
               Line (25,186,25,209);
               Line (30,186,30,209);
               Line (35,186,35,209);
               GrafEscribir (4,215,'F3-Borrar',2,0,4,0);
               GrafEscribir (4,225,'  Archivo',2,0,4,0);
               {F4}
               Setfillstyle (1,8);
               Setcolor (15);
               Fillellipse (30,270,15,15);
               Line (15,270,20,270);
               Line (40,270,45,270);
               Line (30,255,30,260);
               Line (30,285,30,280);
               Line (30,270,37,262);
               Line (30,270,34,274);
               GrafEscribir(7,295,'F4-Reloj',2,0,4,0);
               {ALT-X}
               Menugrafsom (8,315,50,327,14,1,4);
               GrafEscribir (12,315,'Salida',2,0,4,14);
               Menugrafsom (20,330,40,360,0,1,0);
               Setcolor (15);
               Line (20,330,30,337);
               Line (30,337,30,365);
               Line (30,365,20,360);
               Line (20,330,20,360);
               Setfillstyle (1,1);
               Floodfill (22,335,15);
               Line (20,330,40,330);
               Line (40,330,40,360);
               Line (40,360,30,360);
               Setfillstyle (1,0);
               Fillellipse (27,350,2,2);
               GrafEscribir (2,367,'ALT-X.Salir',2,0,4,0);
               Borde (62,32,GetMaxX-2,GetMaxY-1,ColorFondo,Alto);
               Menugrafsom (260,160,455,335,0,4,0);
          END;
BEGIN
     BloquearControlBreak;
     Presentacion;
     Assign (Archivo,'PACKDIR.PKS');
     Borde (1,1,GetMaxX-2,30,7,Alto);
     EscribirSombreado (5,4,'Paquete de Directorios 1996',1,0,1,ColorTitulo,Bajo);
     Fondo;
     Autor;
     REPEAT
           Fondo;
           Menu.IniGrafMnu (240,100);
           Menu.AgrOpcGraf (' Agregar Registro   ');
           Menu.AgrOpcGraf (' Borrar  Registro   ');
           Menu.AgrOpcGraf (' Modificar Registro ');
           Menu.AgrOpcGraf (' Desplegar Registro ');
           Menu.AgrOpcGraf (' Listado Total      ');
           Menu.AgrOpcGraf (' Imprimir Datos     ');
           Menu.AgrOpcGraf (' Salir al  MS-DOS   ');
           Menu.DialogarGr (6,3,0,15,7,0,Alto,Bajo,OpcionMenu);
           IF OpcionMenu=-1 THEN Ayuda;
           IF OpcionMenu=-2 THEN Autor;
           IF OpcionMenu=-3 THEN BorrarArchivo;
           IF OpcionMenu=-4 THEN Reloj;
           IF OpcionMenu =1 THEN Ampliar(Archivo);
           IF OpcionMenu =2 THEN Borrar(Archivo);
           IF OpcionMenu =3 THEN Cambios(Archivo);
           IF OpcionMenu =4 THEN Desplieges(Archivo);
           IF OpcionMenu =5 THEN ListadoTotal(Archivo);
           IF OpcionMenu =6 THEN Imprimir(Archivo);
     UNTIL (OpcionMenu=7) OR (OpcionMenu=-11);
     IF ExisteArchivo ('PACKDIR.PKS')=TRUE THEN
        BEGIN
             Assign (Archivo,'PACKDIR.PKS');
             Reset (Archivo);
             IF FileSize (Archivo)<>0 THEN
                BEGIN
                     Close (Archivo);
                     Codificar.Codif ('PACKDIR.PKS','PackGom');
                END
             ELSE
                 Close (Archivo);
        END;
     Randomize;
     EfectoSalidaGraf (Random (3),0);
     Writeln ('PackSoft (c)., 1994-1996, Paquete de Directorios  Version 2.0');
END.
