{
  Libreria para Texto para Turbo Pascal
  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 3.0
  Ultima actualizacion: Mayo 22 de 1997
  Este es codigo GNU/GPL
}


UNIT packsoft;

INTERFACE

USES CRT,DOS;
Const MaxOpc=20;
      MaxOpc1=12;
      MaxCmpo=20;
CONST MaxBoton=7;
      PASW=1;
      NORM=2;
TYPE Teclas= (TeclaNula,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,
              SaltoCarro,Tab,InvTab,Retroceso,Arriba,Abajo,
              Derecha,Izquierda,TeclaSupr,TeclaIns,TeclaInicio,
              Esc,AltX,TeclaFin,TeclaTexto,TeclaNumero,Espacio,
              RePag,AvPag);
Type CarLeid=RECORD
             CordX,CordY:INTEGER;
             Car:CHAR;
             END;
     Texto=STRING[80];
     Campos=STRING[30];
     PackReg= OBJECT
              ContarCmpo,Desplegar:INTEGER;
              NumOpcion:INTEGER;

              RespCmpo:ARRAY [1..MaxCmpo] OF STRING;
              NomCmpo:ARRAY [1..MaxCmpo] OF STRING;
              TipoCmpo:ARRAY [1..MaxCmpo] OF CHAR;
              AnchoCmpo:ARRAY [1..MaxCmpo] OF INTEGER;
              CorX:ARRAY [1..MaxCmpo] OF INTEGER;
              CorY:ARRAY [1..MaxCmpo] OF INTEGER;

              PROCEDURE IniRegistro;
              PROCEDURE AgregarCampo (VAR Resp:STRING;
                                     NomCamp:STRING;TipoCamp:CHAR;
                                     ANCHO,CordX,CordY:INTEGER);
              PROCEDURE DialogarCampos (ColorFondo1,ColorTexto2,ColorFondo,ColorTexto,Sombra:INTEGER);
              END;
     PackMenu= OBJECT
           CordX,CordY,ContarOpc,LargoMnu,Desplegar,NumOpcion,Y,
           NumOpcion2,Y2:INTEGER;
           Valor2,Valor3:SHORTINT;
           Titulo:ARRAY [1..MaxOpc] OF STRING;
                 PROCEDURE IniMnu (xx,yy:INTEGER);
                 PROCEDURE AgregarOp(Opcion:STRING);
                 PROCEDURE Valores(VAR x3,y3:SHORTINT);
                 PROCEDURE Dialogar(Estilo,Sombra,Lado,ColorFondo,ColorTexto,
                           FondIluminado,ColorIuminar:INTEGER;
                           Var OpcionEscogida:INTEGER);
                 END;
     PackMenu2= OBJECT
           CordX,CordY,ContarOpc,LargoMnu,Desplegar,NumOpcion,Y,
           NumOpcion2,Y2:INTEGER;
           Titulo:ARRAY [1..MaxOpc] OF STRING;
                 PROCEDURE IniMnu (xx,yy:INTEGER);
                 PROCEDURE AgregarOp(Opcion:STRING);
                 PROCEDURE Dialogar(Estilo,Sombra,Lado,ColorFondo,ColorTexto,
                           FondIluminado,ColorIuminar:INTEGER;
                           Var OpcionEscogida:INTEGER);
                 END;

     TYPE CADENABOT=STRING[15];

     Botones=OBJECT
             PRIVATE
                    PROCEDURE TSombra (CordX,CordY,CordX2,ColorFondo,ColorSombra:SHORTINT);
             PUBLIC

             Desplegar,ContarBot,
             LargoSom,NumOpcion,NumOpcion2:SHORTINT;

             TitBot:ARRAY [1..MaxBoton] OF CADENABOT;
             BotCordX:ARRAY [1..MaxBoton] OF SHORTINT;
             BotCordY:ARRAY [1..MaxBoton] OF SHORTINT;

                   PROCEDURE IniBotones;
                   PROCEDURE AgregarBot(TextoBoton:CadenaBot;CordX,CordY:INTEGER);
                   PROCEDURE PreguntaBot(TextNorm,FondNorm,TextIlum,FondIlum,Sombra,Fond:SHORTINT;
                                        VAR Resultado:SHORTINT);
             END;

VAR Tecla:Teclas;
    CadenaLeer:STRING;
PROCEDURE TeclaPulsada (Var TeclaFuncion:BOOLEAN;
                        Var c:CHAR;
                        CursorIni,CursorFin:CHAR);
PROCEDURE EntradaCadenaEdit (VAR S:STRING;
                             LongVentana,LongitudMax,
                             X,Y:INTEGER;
                             TC:CHAR;
                             CarFondo,ColorFond,ColorText:INTEGER);
PROCEDURE EntradaCadenaEdit2(VAR S:CAMPOS;
                             LongVentana,LongitudMax,
                             X,Y:INTEGER;
                             TC:CHAR;
                             CarFondo,ColorFond,ColorText:INTEGER);


VAR
    Cuadro:ARRAY [1..2000] OF CarLeid;
    ContC,ContC2:INTEGER;
    AuxTextMode:WORD;
    AuxTextAttr:BYTE;
    AuxWindMin:WORD;
    AuxWindMax:WORD;
    AuxWhereX:BYTE;
    AuxWhereY:BYTE;
    TeclaEspecial:BOOLEAN;
    TecN:CHAR;
PROCEDURE GuardarTexto(CorX,CorY,CorX2,CorY2:INTEGER);

PROCEDURE RestaurarTexto;

FUNCTION UpCadena (CADENA:STRING):STRING;

PROCEDURE EscribirXY (CordX,CordY:SHORTINT;Mensaje:TEXTO);

PROCEDURE CentrarTexto(Cadena:Texto;CordY,ctexto,cfondo:INTEGER);

FUNCTION SegVideo: Word;{ Regresa la ubicacion del la memoria de video }

PROCEDURE EscribirRapido(x,y:Byte;s:String; pp,f:Byte);

PROCEDURE Sonido (Frecuencia,Tiempo:INTEGER);

PROCEDURE ColorFondText (ColorFondo,ColorTexto:SHORTINT);

PROCEDURE
margen (colini,renini,colfin,renfin,estilo,text,fond:Byte);

PROCEDURE
linver (columna,renini,renfin,estilo:INTEGER);

PROCEDURE
linhor (colini,renglon,colfin,estilo:INTEGER);

PROCEDURE
linorm (colini,renglon,colfin,estilo:integer);

PROCEDURE
logo (colini,renini,fondo:INTEGER);

PROCEDURE
Menusom (colini,renini,colfin,renfin,estilo,fondo,sombra,lado:INTEGER; ColorText,ColorFond:Byte);

PROCEDURE
ventana(colini,renini,colfin,renfin,Tipo,CTexto,CFondo:BYTE);

PROCEDURE
cierraventana;

PROCEDURE
Efectosalida (tipo,tiempo:INTEGER);

PROCEDURE
BloquearControlBreak;

PROCEDURE Fecha(CordX,CordY:INTEGER);

PROCEDURE FechaNum (CordX,CordY:INTEGER);

FUNCTION ExisteArchivo (NombreArchivo:STRING) : Boolean;

FUNCTION TipoMonitor:CHAR;

PROCEDURE SinCursor;

PROCEDURE CursorNormal;

PROCEDURE CursorLargo;

PROCEDURE Pausa;

PROCEDURE PackReloj (CordX,CordY:INTEGER);

PROCEDURE AlargarCuadro (Veces,Tiempo,CordY,CordY2,Estilo,CFondo,CTexto:SHORTINT);

IMPLEMENTATION

PROCEDURE TeclaPulsada (Var TeclaFuncion:BOOLEAN;
                        Var c:CHAR;
                        CursorIni,CursorFin:CHAR);
          BEGIN
               CASE CursorIni OF
                    'G':CursorLargo;
                    'P':CursorNormal;
                    'S':Sincursor;
               END;
               TeclaFuncion:=False;
               C:=Readkey;
               IF (c=#0) THEN
                  BEGIN
                       TeclaFuncion:=True;
                       c:=Readkey;
                  END;
               IF TeclaFuncion THEN
                  CASE Ord(c) OF
                       15:Tecla:=InvTab;   {Tab Cambiado}
                       45:Tecla:=AltX;
                       72:Tecla:=Arriba;   {Flecha arriba}
                       80:Tecla:=Abajo;    {Flecha abajo}
                       82:Tecla:=TeclaIns; {Tecla insertar}
                       75:Tecla:=Izquierda;
                       77:Tecla:=Derecha;
                       73:Tecla:=RePag;
                       81:Tecla:=AvPag;
                       71:Tecla:=TeclaInicio;
                       79:Tecla:=TeclaFin;
                       83:Tecla:=TeclaSupr;
                       82:Tecla:=TeclaIns;
                       59:Tecla:=F1;
                       60:Tecla:=F2;
                       61:Tecla:=F3;
                       62:Tecla:=F4;
                       63:Tecla:=F5;
                       64:Tecla:=F6;
                       65:Tecla:=F7;
                       66:Tecla:=F8;
                       67:Tecla:=F9;
                       68:Tecla:=F10;
                  END {Case}
               ELSE
                   Case Ord(c) OF
                        8:Tecla:=Retroceso;
                        9:Tecla:=Tab;
                        13:Tecla:=SaltoCarro;
                        27:Tecla:=Esc;
                        32:Tecla:=Espacio;
                        33..44,47,58..254:Tecla:=TeclaTexto;
                        45..46,48..57:Tecla:=TeclaNumero;
                   END;{Case}
                   CASE CursorFin OF
                        'G':CursorLargo;
                        'P':CursorNormal;
                        'S':SinCursor;
                   END;{Case}
          END;{TeclaPulsada}

PROCEDURE EntradaCadenaEdit (VAR S:STRING;
                             LongVentana,LongitudMax,
                             X,Y:INTEGER;
                             TC:CHAR;
                             CarFondo,ColorFond,ColorText:INTEGER);
VAR xx,i,j,p:INTEGER;
    C:Char;
    Insercion,TeclaEspecial:BOOLEAN;
    desp:INTEGER;
    CadTmp:STRING;

PROCEDURE XY (x,y:INTEGER);
VAR Xpeq:INTEGER;
    BEGIN
         REPEAT
                XPeq:=x-80;
                IF XPeq>0 THEN
                   BEGIN
                        y:=y+1;
                        x:=Xpeq;
                   END;
         UNTIL XPeq<=0;
         Gotoxy (x,y);
    END;

PROCEDURE EstCadena;
VAR i:INTEGER;
    BEGIN
         i:=Length (s);
         WHILE s[i] = Char(CarFondo) DO
               i:=i-1;
         s[0]:=Char(i);
         CursorNormal;
    END;
    BEGIN
         S:='';
         J:=Length (s)+1;
         FOR i:=j TO LongitudMax DO
             s[i]:=Char (CarFondo);
         s[0]:=Char (LongitudMax);
         CadTmp:=Copy (s,1,LongVentana);
         EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
         p:=1;
         desp:=1;
         Insercion:=TRUE;
         REPEAT
               xx:=x+(p-desp);
               IF (p-desp)=LongVentana THEN xx:=xx-1;
               xy (xx,y);
               IF Insercion THEN
                  TeclaPulsada(TeclaEspecial,c,'P','S')
               ELSE
                  TeclaPulsada(TeclaEspecial,c,'G','S');
               IF (TC='N') THEN
                  BEGIN
                       IF (Tecla=TeclaTexto) THEN
                          BEGIN
                               Sonido (600,150);
                               Tecla:=TeclaNula;
                          END
                       ELSE IF (c='-') AND ((p>1) OR (s[1]='-')) THEN
                            BEGIN
                                 Sonido (600,150);
                                 Tecla:=TeclaNula;
                            END
                       ELSE IF (c='.') THEN
                            BEGIN
                                 IF NOT ((Pos('.',s)=0) OR (Pos('.',s)=p)) THEN
                                    BEGIN
                                         Sonido (600,150);
                                         Tecla:=TeclaNula;
                                    END
                                 ELSE IF (Pos('.',s)=p) THEN
                                      Delete (s,p,1);
                            END;{if not pos}
                  END;{tc=n}
               CASE Tecla OF
                    TECLANUMERO,
                    TECLATEXTO,
                    ESPACIO:BEGIN
                            IF (Length(s) = LongitudMax) THEN
                               BEGIN
                                    IF p=LongitudMax THEN
                                       BEGIN
                                       Delete (s,LongitudMax,1);
                                       s:=s+c;
                                       IF p=LongVentana+desp THEN
                                          Desp:=Desp+1;
                                       CadTmp:=Copy (s,desp,LongVentana);
                                       EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                               END
                            ELSE
                                BEGIN
                                     IF Insercion THEN
                                        BEGIN
                                             Delete(s,LongitudMax,1);
                                             Insert(c,s,p);
                                             IF p=LongVentana+desp THEN
                                                desp:=desp+1;
                                             IF p<LongitudMax THEN
                                                p:=p+1;
                                             CadTmp:=Copy(s,desp,LongVentana);
                                             EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                        END
                                ELSE {Sobreescritura}
                                     BEGIN
                                          Delete (s,p,1);
                                          Insert (c,s,p);
                                          IF p=LongVentana+desp THEN
                                             desp:=desp+1;
                                          IF p< LongitudMax THEN
                                             p:=p+1;
                                          CadTmp:=Copy (s,desp,LongVentana);
                                          EscribirRapido (x,y,cadTmp,ColorText,ColorFond);
                                     END;
                                END;
                            END
                       ELSE
                           BEGIN
                                IF Insercion THEN
                                   BEGIN
                                        Insert(c,s,p);
                                   END
                                ELSE
                                    BEGIN
                                         Delete(s,p,1);
                                         Insert(c,s,p);
                                    END;
                           IF p=LongVentana+Desp THEN
                              desp:=Desp+1;
                           IF p<LongitudMax THEN
                              p:=p+1;
                           CadTmp:=Copy (s,desp,LongVentana);
                           EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                           END;
                       END;{CualquierTecla}
                    RETROCESO:BEGIN
                                   IF p>1 THEN
                                      BEGIN
                                           p:=p-1;
                                           Delete(s,p,1);
                                           s:=s+Char(CarFondo);
                                           IF desp>1 THEN
                                           desp:=desp-1;
                                           CadTmp:=Copy (s,desp,LongVentana);
                                           EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                           c:=' ';
                                      END
                                   ELSE
                                      BEGIN
                                           Sonido (600,150);
                                           c:=' ';
                                           p:=1;
                                      END;
                                   END;{Retroceso}
                    IZQUIERDA:BEGIN
                                   IF p>1 THEN
                                      BEGIN
                                           p:=p-1;
                                           IF  p<desp THEN
                                               BEGIN
                                                    desp:=desp-1;
                                                    CadTmp:=Copy (s,desp,LongVentana);
                                                    EscribirRapido (x,y,cadTmp,ColorText,ColorFond);
                                               END;
                                      END
                                   ELSE
                                      BEGIN
                                           EstCadena;
{                                           Exit}
                                      END;
                                   END;{IZQUIERDA}
                    DERECHA:BEGIN
                                 IF (s[p]<>Char(CarFondo)) AND (p<LongitudMax) THEN
                                    BEGIN
                                         p:=p+1;
                                         IF p=(LongVentana+desp) THEN
                                            BEGIN
                                                 desp:=desp+1;
                                                 CadTmp:=Copy (s,desp,LongVentana);
                                                 EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                            END;
                                    END
                                 ELSE
                                     BEGIN
                                          EstCadena;
{                                          Exit;}
                                     END;
                                 END;{Derecha}
                    TECLASUPR:BEGIN
                                   Delete(s,p,1);
                                   s:=s+Char(CarFondo);
                                   IF ((Length(s)+1)-desp)>=LongVentana THEN
                                      BEGIN
                                           CadTmp:=Copy (s,desp,LongVentana);
                                           EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                      END
                                   ELSE
                                       BEGIN
                                            CadTmp:=Copy(s,desp,LongVentana);
                                            EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                       END;
                                END;{TeclaSupr}
                    TECLAINS:BEGIN
                                  IF Insercion THEN
                                     Insercion:=FALSE
                                  ELSE
                                      Insercion:=TRUE
                              END;{TeclaIns}
                    ELSE IF NOT (Tecla In [SaltoCarro,Arriba,Abajo,RePag,
                                           AvPag,Esc,Tab,F1,F2,F3,F4,F5,F6,
                                           F7,F8,F9,F10]) THEN Sonido (600,150);
                    END;{Case}
               UNTIL (Tecla In [SaltoCarro,Arriba,Abajo,RePag,AvPag,Esc,Tab,
                                F1,F2,F3,F4,F5,F6,F7,F8,F9,F10]);
               EstCadena;
               END; {EntradaCadenaEdit}
PROCEDURE EntradaCadenaEdit2 (VAR S:CAMPOS;
                             LongVentana,LongitudMax,
                             X,Y:INTEGER;
                             TC:CHAR;
                             CarFondo,ColorFond,ColorText:INTEGER);
VAR xx,i,j,p:INTEGER;
    C:Char;
    Insercion,TeclaEspecial:BOOLEAN;
    desp:INTEGER;
    CadTmp:STRING;

PROCEDURE XY (x,y:INTEGER);
VAR Xpeq:INTEGER;
    BEGIN
         REPEAT
                XPeq:=x-80;
                IF XPeq>0 THEN
                   BEGIN
                        y:=y+1;
                        x:=Xpeq;
                   END;
         UNTIL XPeq<=0;
         Gotoxy (x,y);
    END;

PROCEDURE EstCadena;
VAR i:INTEGER;
    BEGIN
         i:=Length (s);
         WHILE s[i] = Char(CarFondo) DO
               i:=i-1;
         s[0]:=Char(i);
         CursorNormal;
    END;
    BEGIN
         S:='';
         J:=Length (s)+1;
         FOR i:=j TO LongitudMax DO
             s[i]:=Char (CarFondo);
         s[0]:=Char (LongitudMax);
         CadTmp:=Copy (s,1,LongVentana);
         EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
         p:=1;
         desp:=1;
         Insercion:=TRUE;
         REPEAT
               xx:=x+(p-desp);
               IF (p-desp)=LongVentana THEN xx:=xx-1;
               xy (xx,y);
               IF Insercion THEN
                  TeclaPulsada(TeclaEspecial,c,'P','S')
               ELSE
                  TeclaPulsada(TeclaEspecial,c,'G','S');
               IF (TC='N') THEN
                  BEGIN
                       IF (Tecla=TeclaTexto) THEN
                          BEGIN
                               Sonido (600,150);
                               Tecla:=TeclaNula;
                          END
                       ELSE IF (c='-') AND ((p>1) OR (s[1]='-')) THEN
                            BEGIN
                                 Sonido (600,150);
                                 Tecla:=TeclaNula;
                            END
                       ELSE IF (c='.') THEN
                            BEGIN
                                 IF NOT ((Pos('.',s)=0) OR (Pos('.',s)=p)) THEN
                                    BEGIN
                                         Sonido (600,150);
                                         Tecla:=TeclaNula;
                                    END
                                 ELSE IF (Pos('.',s)=p) THEN
                                      Delete (s,p,1);
                            END;{if not pos}
                  END;{tc=n}
               CASE Tecla OF
                    TECLANUMERO,
                    TECLATEXTO,
                    ESPACIO:BEGIN
                            IF (Length(s) = LongitudMax) THEN
                               BEGIN
                                    IF p=LongitudMax THEN
                                       BEGIN
                                       Delete (s,LongitudMax,1);
                                       s:=s+c;
                                       IF p=LongVentana+desp THEN
                                          Desp:=Desp+1;
                                       CadTmp:=Copy (s,desp,LongVentana);
                                       EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                               END
                            ELSE
                                BEGIN
                                     IF Insercion THEN
                                        BEGIN
                                             Delete(s,LongitudMax,1);
                                             Insert(c,s,p);
                                             IF p=LongVentana+desp THEN
                                                desp:=desp+1;
                                             IF p<LongitudMax THEN
                                                p:=p+1;
                                             CadTmp:=Copy(s,desp,LongVentana);
                                             EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                        END
                                ELSE {Sobreescritura}
                                     BEGIN
                                          Delete (s,p,1);
                                          Insert (c,s,p);
                                          IF p=LongVentana+desp THEN
                                             desp:=desp+1;
                                          IF p< LongitudMax THEN
                                             p:=p+1;
                                          CadTmp:=Copy (s,desp,LongVentana);
                                          EscribirRapido (x,y,cadTmp,ColorText,ColorFond);
                                     END;
                                END;
                            END
                       ELSE
                           BEGIN
                                IF Insercion THEN
                                   BEGIN
                                        Insert(c,s,p);
                                   END
                                ELSE
                                    BEGIN
                                         Delete(s,p,1);
                                         Insert(c,s,p);
                                    END;
                           IF p=LongVentana+Desp THEN
                              desp:=Desp+1;
                           IF p<LongitudMax THEN
                              p:=p+1;
                           CadTmp:=Copy (s,desp,LongVentana);
                           EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                           END;
                       END;{CualquierTecla}
                    RETROCESO:BEGIN
                                   IF p>1 THEN
                                      BEGIN
                                           p:=p-1;
                                           Delete(s,p,1);
                                           s:=s+Char(CarFondo);
                                           IF desp>1 THEN
                                           desp:=desp-1;
                                           CadTmp:=Copy (s,desp,LongVentana);
                                           EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                           c:=' ';
                                      END
                                   ELSE
                                      BEGIN
                                           Sonido (600,150);
                                           c:=' ';
                                           p:=1;
                                      END;
                                   END;{Retroceso}
                    IZQUIERDA:BEGIN
                                   IF p>1 THEN
                                      BEGIN
                                           p:=p-1;
                                           IF  p<desp THEN
                                               BEGIN
                                                    desp:=desp-1;
                                                    CadTmp:=Copy (s,desp,LongVentana);
                                                    EscribirRapido (x,y,cadTmp,ColorText,ColorFond);
                                               END;
                                      END
                                   ELSE
                                      BEGIN
                                           EstCadena;
{                                           Exit}
                                      END;
                                   END;{IZQUIERDA}
                    DERECHA:BEGIN
                                 IF (s[p]<>Char(CarFondo)) AND (p<LongitudMax) THEN
                                    BEGIN
                                         p:=p+1;
                                         IF p=(LongVentana+desp) THEN
                                            BEGIN
                                                 desp:=desp+1;
                                                 CadTmp:=Copy (s,desp,LongVentana);
                                                 EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                            END;
                                    END
                                 ELSE
                                     BEGIN
                                          EstCadena;
{                                          Exit;}
                                     END;
                                 END;{Derecha}
                    TECLASUPR:BEGIN
                                   Delete(s,p,1);
                                   s:=s+Char(CarFondo);
                                   IF ((Length(s)+1)-desp)>=LongVentana THEN
                                      BEGIN
                                           CadTmp:=Copy (s,desp,LongVentana);
                                           EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                      END
                                   ELSE
                                       BEGIN
                                            CadTmp:=Copy(s,desp,LongVentana);
                                            EscribirRapido (x,y,CadTmp,ColorText,ColorFond);
                                       END;
                                END;{TeclaSupr}
                    TECLAINS:BEGIN
                                  IF Insercion THEN
                                     Insercion:=FALSE
                                  ELSE
                                      Insercion:=TRUE
                              END;{TeclaIns}
                    ELSE IF NOT (Tecla In [SaltoCarro,Arriba,Abajo,RePag,
                                           AvPag,Esc,Tab,F1,F2,F3,F4,F5,F6,
                                           F7,F8,F9,F10]) THEN Sonido (600,150);
                    END;{Case}
               UNTIL (Tecla In [SaltoCarro,Arriba,Abajo,RePag,AvPag,Esc,Tab,
                                F1,F2,F3,F4,F5,F6,F7,F8,F9,F10]);
               EstCadena;
               END; {EntradaCadenaEdit}
PROCEDURE AlargarCuadro (Veces,Tiempo,CordY,CordY2,Estilo,CFondo,CTexto:SHORTINT);
VAR CordX,CordX2:SHORTINT;
          BEGIN
               IF Veces>40 THEN Veces:=40;
               CordX2:=41;
               FOR CordX:=40 DOWNTO Veces DO
                   BEGIN
                        Menusom (CordX,CordY,CordX2,CordY2,Estilo,0,0,0,CTexto,CFondo);
                        Delay (Tiempo);
                        CordX2:=CordX2+1;
                   END;
          END;
FUNCTION UpCadena (CADENA:STRING):STRING;
VAR
   Cadena2:STRING;
   Caracter:ARRAY[1..255] OF CHAR;
   Convertir:INTEGER;
     BEGIN
          Cadena2:='';
          FOR Convertir:=1 TO Length (Cadena) DO
              BEGIN
                   Cadena2:=Cadena2+Upcase (Cadena[Convertir]);
              END;
     Upcadena:=Cadena2
     END;

PROCEDURE GuardarTexto (CorX,CorY,CorX2,CorY2:INTEGER);
VAR Linea,Columna:INTEGER;
FUNCTION CarPant:CHAR;
VAR Regs:Registers;
   BEGIN
        FillChar(Regs,SizeOf(Regs),0);
        Regs.AH:=8;
        Regs.BH:=0; {Pagina de video}
        Intr ($10,Regs);
        CarPant:=Chr(Regs.AL);
   END;
       BEGIN
       ContC:=1;
       FOR Linea:=CorY TO CorY2 DO
       BEGIN
            FOR Columna:=CorX TO CorX2 DO
                BEGIN
                     Gotoxy (Columna,Linea);
                     AuxTextMode:=LastMode;
                     AuxTextAttr:=TextAttr;
                     AuxWindMin:=WindMin;
                     AuxWindMax:=WindMax;
                     AuxWhereX:=WhereX;
                     AuxWhereY:=WhereY;
                     Cuadro[ContC].CordX:=Columna;
                     Cuadro[ContC].CordY:=Linea;
                     Cuadro[ContC].Car:=Carpant;
                     ContC:=ContC+1;
                END;
       END;

          END;
PROCEDURE RestaurarTexto;
          BEGIN
          FOR ContC2:=1 TO ContC DO
                BEGIN
                     IF LastMode <> Auxtextmode THEN Textmode(AuxTextMode);
                     Window (Lo (AuxWindMin)+1,Hi(AuxWindMin)+1,
                             Lo (AuxWindMax)+1,Hi(AuxWindMax)+1);
                     TextAttr:=AuxTextAttr;
                     Gotoxy (Cuadro[ContC2].CordX,Cuadro[ContC2].CordY);
                     Write (Cuadro[ContC2].Car);
                END;
               Gotoxy (AuxWhereX,AuxWhereY);
          END;



PROCEDURE PackReloj(CordX,CordY:INTEGER);
VAR Horas,Minutos,Segundos,Centesimas:WORD;
    AMPM:STRING[2];
    FUNCTION AgregarCero (FragHora:WORD):STRING;
    VAR Numero:STRING;
              BEGIN
                   Str (FragHora:0,Numero);
                   IF Length (Numero)=1 THEN Numero:='0'+Numero;
                   AgregarCero:=Numero;
              END;
          BEGIN
               REPEAT
                     Gettime (Horas,Minutos,Segundos,Centesimas);
                     Gotoxy (CordX,CordY);
                     AgregarCero(Horas);
                     IF Horas>12 THEN BEGIN
                                     Horas:=Horas-12;
                                     AMPM:='PM';
                                     END
                     ELSE AMPM:='AM';
                     IF Horas=12 THEN AMPM:='PM';
                     Write (' ',Horas,':',AgregarCero(Minutos),'.',AgregarCero(Segundos),' ',AMPM,' ');
               UNTIL Keypressed;
          END;

PROCEDURE EscribirXY (CordX,CordY:SHORTINT;Mensaje:TEXTO);
          BEGIN
               Gotoxy (CordX,CordY);Write (Mensaje);
          END;

PROCEDURE ColorFondText (ColorFondo,ColorTexto:SHORTINT);
          BEGIN
               Textbackground (ColorFondo);
               Textcolor (ColorTexto);
          END;

{ *******************************************************************}
FUNCTION SegVideo: Word;{ Regresa la ubicacion del la memoria de video }
{ *******************************************************************}
BEGIN
	IF mem[$0000:$0449] = 7 THEN
	   SegVideo := $B000
	ELSE
	   SegVideo := $B800;

END;


{ *******************************************************************}
PROCEDURE EscribirRapido(x,y:Byte;s:String; pp,f:Byte);
{ *******************************************************************}
VAR
	w:Word;
	i,atrCol:Byte;
BEGIN
	atrcol := (f SHL 4 ) + pp; { Byte del atributo }
	w := ((y-1)*80 + (x-1))*2; { Dezplazamiento }

	FOR i:= 1 TO Length(s) DO
		BEGIN
			memW [ SEGVIdeo :w] := (atrCol SHL 8 ) + Ord(s[i]);
			Inc(w,2);
		END;

END;
{*********************************************************************}
PROCEDURE Sonido (Frecuencia,Tiempo:INTEGER);
{*********************************************************************}
   BEGIN
        Sound (Frecuencia);
        Delay (Tiempo);
        Nosound;
   END;

{*********************************************************************}
PROCEDURE CentrarTexto(Cadena:Texto;CordY,ctexto,cfondo:INTEGER);
{*********************************************************************}
     VAR NumCaracter,Cordenada:INTEGER;
               BEGIN
                    NumCaracter:=Length(Cadena);
                    IF Numcaracter mod 2 <> 0 THEN
                    Cadena:=Cadena+'.';
                    NumCaracter:=Length(Cadena);
                    Cordenada:=(80-NumCaracter)div 2;
                    EscribirRapido(Cordenada,CordY,Cadena,ctexto,cfondo);
               END;




{*********************************************************************}
PROCEDURE
margen (colini,renini,colfin,renfin,estilo,text,fond:Byte);
{*********************************************************************}
VAR columna,renglon:INTEGER;
   reng,col,esqsupizq,esqsupder,esqinfizq,esqinfder:CHAR;

BEGIN
     IF (estilo<1 ) OR (estilo >7) THEN estilo:=1;

     IF estilo=1 THEN
       BEGIN
        col:='ƒ';
        reng:='≥';
        esqsupizq:='⁄';
        esqsupder:='ø';
        esqinfizq:='¿';
        esqinfder:='Ÿ';
       END;

    IF estilo=2 THEN
       BEGIN
        col:='Õ';
        reng:='∫';
        esqsupizq:='…';
        esqsupder:='ª';
        esqinfizq:='»';
        esqinfder:='º';
       END;



    IF estilo=3 THEN
       BEGIN
        col:='∞';
        reng:='∞';
        esqsupizq:='∞';
        esqsupder:='∞';
        esqinfizq:='∞';
        esqinfder:='∞';
       END;

   IF estilo=4 THEN
       BEGIN
        col:='±';
        reng:='±';
        esqsupizq:='±';
        esqsupder:='±';
        esqinfizq:='±';
        esqinfder:='±';
       END;

   IF estilo=5 THEN
       BEGIN
        col:='≤';
        reng:='≤';
        esqsupizq:='≤';
        esqsupder:='≤';
        esqinfizq:='≤';
        esqinfder:='≤';
       END;

   IF estilo=6 THEN
       BEGIN
        col:='€';
        reng:='€';
        esqsupizq:='€';
        esqsupder:='€';
        esqinfizq:='€';
        esqinfder:='€';
       END;

   IF estilo=7 THEN
       BEGIN
        col:=' ';
        reng:=' ';
        esqsupizq:=' ';
        esqsupder:=' ';
        esqinfizq:=' ';
        esqinfder:=' ';
       END;
          {RENGLON INICIAL}
               FOR columna:=colini to colfin DO
                    BEGIN
                        EscribirRapido (columna,renini,col,text,fond);
                    END;

          {RENGLON FINAL}
               FOR  columna:=colini to colfin DO
                    BEGIN
                          EscribirRapido (columna,renfin,col,text,fond);
                    END;

          {COLUMNA INICIAL}
               FOR  renglon:=renini to renfin DO
                    BEGIN
                         EscribirRapido (colini,renglon,reng,text,fond);
                    END;

          {COLUMNA FINAL}
               FOR renglon:=renini to renfin DO
                   BEGIN
                        EscribirRapido (colfin,renglon,reng,text,fond);
                   END;

     {ESQUINAS}
     EscribirRapido (colini,renini,esqsupizq,text,fond);
     EscribirRapido (colfin,renini,esqsupder,text,fond);
     EscribirRapido (colini,renfin,esqinfizq,text,fond);
     EscribirRapido (colfin,renfin,esqinfder,text,fond);
END;

{*********************************************************************}
PROCEDURE
ventana (colini,renini,colfin,renfin,Tipo,Ctexto,Cfondo:BYTE);
{*********************************************************************}

VAR columna,renglon:INTEGER;
BEGIN
     {RENGLON INICIAL}
     Margen (colini-1,renini-1,colfin+1,renfin+1,Tipo,Ctexto,CFondo);
     Window(colini,renini,colfin,renfin);
     ColorFondText (CFondo,CTexto);
     Clrscr;
END;


{*********************************************************************}
PROCEDURE
cierraventana;
{*********************************************************************}

BEGIN
     ColorFondText (0,7);
     Window(1,1,80,25)
END;

{*********************************************************************}
PROCEDURE Menusom(colini,renini,colfin,renfin,estilo,fondo,sombra,lado:INTEGER; ColorText,ColorFond:Byte);
{*********************************************************************}
VAR sombras,columna,renglon,renglones,
    renesp,espacios,lados:INTEGER;
    somcol,somren:string[3];
    reng,col,esqsupizq,esqsupder,esqinfizq,esqinfder,fond:char;
BEGIN


{ESTILOS DE MARGEN}
IF (estilo<0 ) OR (estilo >6) THEN estilo:=1;

     IF estilo=0 THEN
       BEGIN
        reng:=' ';
        col:=' ';
        esqsupizq:=' ';
        esqsupder:=' ';
        esqinfizq:=' ';
        esqinfder:=' ';
       END;

     IF estilo=1 THEN
       BEGIN
        reng:='ƒ';
        col:='≥';
        esqsupizq:='⁄';
        esqsupder:='ø';
        esqinfizq:='¿';
        esqinfder:='Ÿ';
       END;

    IF estilo=2 THEN
       BEGIN
        reng:='Õ';
        col:='∫';
        esqsupizq:='…';
        esqsupder:='ª';
        esqinfizq:='»';
        esqinfder:='º';
       END;



    IF estilo=3 THEN
       BEGIN
        reng:='∞';
        col:='∞';
        esqsupizq:='∞';
        esqsupder:='∞';
        esqinfizq:='∞';
        esqinfder:='∞';
       END;

   IF estilo=4 THEN
       BEGIN
        reng:='±';
        col:='±';
        esqsupizq:='±';
        esqsupder:='±';
        esqinfizq:='±';
        esqinfder:='±';
       END;

   IF estilo=5 THEN
       BEGIN
        reng:='≤';
        col:='≤';
        esqsupizq:='≤';
        esqsupder:='≤';
        esqinfizq:='≤';
        esqinfder:='≤';
       END;

   IF estilo=6 THEN
       BEGIN
        reng:='€';
        col:='€';
        esqsupizq:='€';
        esqsupder:='€';
        esqinfizq:='€';
        esqinfder:='€';
       END;
{ESTILOS DE SOMBRA}
IF (sombra<0 ) OR (sombra >5) THEN sombra:=0;

     IF sombra=0 THEN
       BEGIN
          somcol:='';
          somren:='';
       END;

     IF sombra=1 THEN
       BEGIN
          somcol:='  ';
          somren:=' ';
       END;
     IF sombra=2 THEN
       BEGIN
          somcol:='∞∞';
          somren:='∞';
       END;
     IF sombra=3 THEN
       BEGIN
          somcol:='±±';
          somren:='±';
       END;
     IF sombra=4 THEN
       BEGIN
          somcol:='≤≤';
          somren:='≤';
       END;
     IF sombra=5 THEN
       BEGIN
          somcol:='€€';
          somren:='€';
       END;
{ESTILOS DE FONDO}
IF (fondo<1 ) OR (fondo >5) THEN fondo:=1;
IF fondo=1 THEN fond:=' ';
IF fondo=2 THEN fond:='∞';
IF fondo=3 THEN fond:='±';
IF fondo=4 THEN fond:='≤';
IF fondo=5 THEN fond:='€';

{RENGLON INICIAL}
               FOR columna:=colini to colfin DO
                    BEGIN
                         EscribirRapido (columna,renini,reng,ColorText,ColorFond);
                    END;
          EscribirRapido(colini,renini,esqsupizq,ColorText,ColorFond);
          EscribirRapido(colfin,renini,esqsupder,ColorText,ColorFond);

          {COLUMNA INICIAL y FINAL}
          FOR  renglon:=renini+1 to renfin DO
                    BEGIN
                         EscribirRapido(colini,renglon,col,ColorText,ColorFond);{COL. INICIAL}
                         EscribirRapido(colfin,renglon,col,ColorText,ColorFond);{COL. FINAL}
                    END;

          {RENGLON FINAL}
               FOR  columna:=colini to colfin DO
                    BEGIN
                          EscribirRapido(columna,renfin,reng,ColorText,ColorFond);
                    END;
     {ESQUINAS}
     EscribirRapido(colini,renfin,esqinfizq,ColorText,ColorFond);
     EscribirRapido(colfin,renfin,esqinfder,ColorText,ColorFond);
{SOMBRAS}
IF (lado<1) OR (lado>2) then lado:=1;
IF lado=1 then
   BEGIN
        FOR Sombras:=renini+1 TO renfin+1 DO
            BEGIN
                 EscribirRapido(colini-2,sombras,somcol,ColorText,ColorFond);
            END;

        FOR Sombras:=colini-2 TO colfin-2 DO
            BEGIN
                 EscribirRapido (sombras,renfin+1,somren,ColorText,ColorFond);
        END;
    END;{LADO 1}
IF lado=2 then
   BEGIN
        FOR Sombras:=Renini+1 TO renfin+1 DO
            BEGIN
                 EscribirRapido(Colfin+1,sombras,somcol,ColorText,ColorFond);
            END;
        For Sombras:=Colini+2 TO Colfin+2 DO
            BEGIN
                 EscribirRapido(sombras,Renfin+1,Somren,ColorText,ColorFond);
            END;
   END;{Lado 2}
    FOR RENESP:= RENINI+1 TO RENFIN-1 DO
        BEGIN
              FOR ESPACIOS:=colini+1 to colfin-1 do
                  BEGIN
                       EscribirRapido(Espacios,Renesp,fond,ColorText,ColorFond);
                  END;
        END;{Renesp}

END;{menuSOM}

{*********************************************************************}
PROCEDURE
logo (colini,renini,fondo:integer);
{*********************************************************************}

BEGIN
IF (FONDO<1) OR (FONDO>5) THEN FONDO:=1;

IF FONDO=1 THEN
BEGIN
     gotoxy (colini,renini);writeln   (' ‹‹‹‹‹                     ‹‹‹‹‹‹                      ');
     gotoxy (colini,renini+1);writeln (' €ﬂﬂﬂ€   ‹‹   ‹‹‹‹‹ ‹  ‹   €       ‹‹‹‹‹  ‹‹‹‹‹ ‹‹‹‹‹‹ ');
     gotoxy (colini,renini+2);writeln (' €   €  €  €  €     €  €   €‹‹‹‹‹  €   €  €       €    ');
     gotoxy (colini,renini+3);writeln (' €ﬂﬂﬂﬂ  €‹‹€  €     €‹ﬂ         €  €   €  €‹‹‹    €    ');
     gotoxy (colini,renini+4);writeln (' €      €  €  €     € ﬂ‹        €  €   €  €       €    ');
     gotoxy (colini,renini+5);writeln (' €      €  €  €‹‹‹‹ €  €   ‹‹‹‹‹€  €‹‹‹€  €       €    ');
END;


IF FONDO=2 THEN
BEGIN
     gotoxy (colini,renini);writeln   ('∞‹‹‹‹‹ ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞‹‹‹‹‹‹∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞');
     gotoxy (colini,renini+1);writeln ('∞€ﬂﬂﬂ€ ∞∞‹‹ ∞∞‹‹‹‹‹∞‹ ∞‹ ∞∞€ ∞∞∞∞∞∞‹‹‹‹‹ ∞‹‹‹‹‹∞‹‹‹‹‹‹∞');
     gotoxy (colini,renini+2);writeln ('∞€∞∞∞€ ∞€ ∞€ ∞€ ∞∞∞∞€ ∞€ ∞∞€‹‹‹‹‹ ∞€∞∞∞€ ∞€ ∞∞∞∞∞∞€ ∞∞∞');
     gotoxy (colini,renini+3);writeln ('∞€ﬂﬂﬂﬂ ∞€‹‹€ ∞€ ∞∞∞∞€‹ﬂ ∞∞∞∞∞∞∞∞€ ∞€∞∞∞€ ∞€‹‹‹∞∞∞∞€ ∞∞∞');
     gotoxy (colini,renini+4);writeln ('∞€ ∞∞∞∞∞€ ∞€ ∞€ ∞∞∞∞€ ﬂ‹ ∞∞∞∞∞∞∞€ ∞€∞∞∞€ ∞€ ∞∞∞∞∞∞€ ∞∞∞');
     gotoxy (colini,renini+5);writeln ('∞€ ∞∞∞∞∞€ ∞€ ∞€‹‹‹‹∞€ ∞€ ∞∞‹‹‹‹‹€ ∞€‹‹‹€ ∞€ ∞∞∞∞∞∞€ ∞∞∞');
END;

IF FONDO=3 THEN
BEGIN
     gotoxy (colini,renini);writeln   ('±‹‹‹‹‹ ±±±±±±±±±±±±±±±±±±±±‹‹‹‹‹‹±±±±±±±±±±±±±±±±±±±±±±');
     gotoxy (colini,renini+1);writeln ('±€ﬂﬂﬂ€ ±±‹‹ ±±‹‹‹‹‹±‹ ±‹ ±±€ ±±±±±±‹‹‹‹‹ ±‹‹‹‹‹±‹‹‹‹‹‹±');
     gotoxy (colini,renini+2);writeln ('±€±±±€ ±€ ±€ ±€ ±±±±€ ±€ ±±€‹‹‹‹‹ ±€±±±€ ±€ ±±±±±±€ ±±±');
     gotoxy (colini,renini+3);writeln ('±€ﬂﬂﬂﬂ ±€‹‹€ ±€ ±±±±€‹ﬂ ±±±±±±±±€ ±€±±±€ ±€‹‹‹±±±±€ ±±±');
     gotoxy (colini,renini+4);writeln ('±€ ±±±±±€ ±€ ±€ ±±±±€ ﬂ‹ ±±±±±±±€ ±€±±±€ ±€ ±±±±±±€ ±±±');
     gotoxy (colini,renini+5);writeln ('±€ ±±±±±€ ±€ ±€‹‹‹‹±€ ±€ ±±‹‹‹‹‹€ ±€‹‹‹€ ±€ ±±±±±±€ ±±±');
END;

IF FONDO=4 THEN
BEGIN
     gotoxy (colini,renini);writeln   ('≤‹‹‹‹‹ ≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤‹‹‹‹‹‹≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤');
     gotoxy (colini,renini+1);writeln ('≤€ﬂﬂﬂ€ ≤≤‹‹ ≤≤‹‹‹‹‹≤‹ ≤‹ ≤≤€ ≤≤≤≤≤≤‹‹‹‹‹ ≤‹‹‹‹‹≤‹‹‹‹‹‹≤');
     gotoxy (colini,renini+2);writeln ('≤€≤≤≤€ ≤€ ≤€ ≤€ ≤≤≤≤€ ≤€ ≤≤€‹‹‹‹‹ ≤€≤≤≤€ ≤€ ≤≤≤≤≤≤€ ≤≤≤');
     gotoxy (colini,renini+3);writeln ('≤€ﬂﬂﬂﬂ ≤€‹‹€ ≤€ ≤≤≤≤€‹ﬂ ≤≤≤≤≤≤≤≤€ ≤€≤≤≤€ ≤€‹‹‹≤≤≤≤€ ≤≤≤');
     gotoxy (colini,renini+4);writeln ('≤€ ≤≤≤≤≤€ ≤€ ≤€ ≤≤≤≤€ ﬂ‹ ≤≤≤≤≤≤≤€ ≤€≤≤≤€ ≤€ ≤≤≤≤≤≤€ ≤≤≤');
     gotoxy (colini,renini+5);writeln ('≤€ ≤≤≤≤≤€ ≤€ ≤€‹‹‹‹≤€ ≤€ ≤≤‹‹‹‹‹€ ≤€‹‹‹€ ≤€ ≤≤≤≤≤≤€ ≤≤≤');
END;

IF FONDO=5 THEN
BEGIN
     gotoxy (colini,renini);writeln   ('€‹‹‹‹‹ €€€€€€€€€€€€€€€€€€€€‹‹‹‹‹‹€€€€€€€€€€€€€€€€€€€€€€');
     gotoxy (colini,renini+1);writeln ('€€ﬂﬂﬂ€ €€‹‹ €€‹‹‹‹‹€‹ €‹ €€€ €€€€€€‹‹‹‹‹ €‹‹‹‹‹€‹‹‹‹‹‹€');
     gotoxy (colini,renini+2);writeln ('€€€€€€ €€ €€ €€ €€€€€ €€ €€€‹‹‹‹‹ €€€€€€ €€ €€€€€€€ €€€');
     gotoxy (colini,renini+3);writeln ('€€ﬂﬂﬂﬂ €€‹‹€ €€ €€€€€‹ﬂ €€€€€€€€€ €€€€€€ €€‹‹‹€€€€€ €€€');
     gotoxy (colini,renini+4);writeln ('€€ €€€€€€ €€ €€ €€€€€ ﬂ‹ €€€€€€€€ €€€€€€ €€ €€€€€€€ €€€');
     gotoxy (colini,renini+5);writeln ('€€ €€€€€€ €€ €€‹‹‹‹€€ €€ €€‹‹‹‹‹€ €€‹‹‹€ €€ €€€€€€€ €€€');
END;
END;{LOGO}
{*********************************************************************}
PROCEDURE
linver(columna,renini,renfin,estilo:integer);
{*********************************************************************}
VAR veses:INTEGER;
    caracterarr,caracterabj,raya:CHAR;
BEGIN

IF (estilo<0) or (estilo>6) then estilo:=1;

IF estilo=0 then
   BEGIN
        caracterarr:=' ';
        caracterabj:=' ';
        raya:=' ';
   END;

IF estilo=1 then
   BEGIN
        caracterarr:=#194;
        caracterabj:=#193;
        raya:=#179
   END;

IF estilo=2 then
   BEGIN
        caracterarr:=#203;
        caracterabj:=#202;
        raya:=#186;
   END;

IF estilo=3 then
   BEGIN
        caracterarr:=#176;
        caracterabj:=#176;
        raya:=#176;
   END;

IF estilo=4 then
   BEGIN
        caracterarr:=#177;
        caracterabj:=#177;
        raya:=#177;
   END;

IF estilo=5 then
   BEGIN
        caracterarr:=#178;
        caracterabj:=#178;
        raya:=#178;
   END;

IF estilo=6 then
   BEGIN
        caracterarr:=#219;
        caracterabj:=#219;
        raya:=#219;
   END;

     FOR veses:=renini to renfin do
         BEGIN
              gotoxy (columna,veses);write (raya);
         END;
     Gotoxy (columna,renini);write (caracterarr);
     Gotoxy (columna,renfin);write (caracterabj);
END;

{*********************************************************************}
PROCEDURE
linhor (colini,renglon,colfin,estilo:integer);
{*********************************************************************}
VAR veses:INTEGER;
    raya,caracterizq,caracterder:CHAR;
BEGIN

IF (estilo<0) or (estilo>6) THEN estilo:=1;

IF estilo=0 then
   BEGIN
        caracterizq:=' ';
        caracterder:=' ';
        raya:=' ';
   END;

IF estilo=1 then
   BEGIN
        caracterizq:=#195;
        caracterder:=#180;
        raya:=#196;
   END;

IF estilo=2 then
   BEGIN
        caracterizq:=#204;
        caracterder:=#185;
        raya:=#205;
   END;

IF estilo=3 then
   BEGIN
        caracterizq:=#176;
        caracterder:=#176;
        raya:=#176;
   END;

IF estilo=4 then
   BEGIN
        caracterizq:=#177;
        caracterder:=#177;
        raya:=#177;
   END;

IF estilo=5 then
   BEGIN
        caracterizq:=#178;
        caracterder:=#178;
        raya:=#178;
   END;

IF estilo=6 then
   BEGIN
        caracterizq:=#219;
        caracterder:=#219;
        raya:=#219;
   END;

     FOR veses:=colini to colfin do
         BEGIN
              gotoxy (veses,renglon);write (raya);
         END;
     Gotoxy (colini,renglon);write (caracterizq);
     Gotoxy (colfin,renglon);write (caracterder);
END;
{*********************************************************************}
PROCEDURE
linorm (colini,renglon,colfin,estilo:integer);
{*********************************************************************}
VAR veses:INTEGER;
    raya,caracterizq,caracterder:CHAR;
BEGIN

IF (estilo<0) or (estilo>6) THEN estilo:=1;

IF estilo=0 then raya:=' ';
IF estilo=1 then raya:=#196;
IF estilo=2 then raya:=#205;
IF estilo=3 then raya:=#176;
IF estilo=4 then raya:=#177;
IF estilo=5 then raya:=#178;
IF estilo=6 then raya:=#219;
     FOR veses:=colini to colfin do
         BEGIN
              gotoxy (veses,renglon);write (raya);
         END;
END;

{*****************************************************************}
PROCEDURE FECHA(CordX,CordY:INTEGER);
{*****************************************************************}
CONST Dias:ARRAY [0..6] OF STRING[9]=
                    ('Domingo','Lunes','Martes','Miercoles','Jueves',
                      'Viernes','Sabado');
      Meses:ARRAY [1..12] OF STRING[10]=
                  ('Enero','Febrero','Marzo','Abril','Mayo',
                   'Junio','Julio','Agosto','Septiembre','Octubre',
                   'Noviembre','Diciembre');
              VAR
                 Agno,Dia,Mes,DiaSemana:WORD;
         BEGIN
              GetDate (Agno,Mes,Dia,DiaSemana);
              Gotoxy  (CordX,CordY);Write (' ',Dias[Diasemana],' ',dia:0,' de ',Meses[Mes],' de ',agno:0,' ');
         END;

{*****************************************************************}
PROCEDURE FECHANUM(CordX,CordY:INTEGER);
{*****************************************************************}
Var  Agno,Dia,Mes,DiaSemana:WORD;
Function AgregarCero (variable:WORD):STRING;
Var cadena:STRING;
         BEGIN
              Str(variable:0,cadena);
              IF Length (Cadena) =1 THEN Cadena:='0'+Cadena;
              AgregarCero:=Cadena;
         END;
         BEGIN
              GetDate (Agno,Mes,Dia,DiaSemana);
              Gotoxy  (CordX,CordY);Write (AgregarCero(dia),'/',AgregarCero(Mes),'/',agno:0);
         END;

{*********************************************}
PROCEDURE
Efectosalida (tipo,tiempo:INTEGER);
{*********************************************}
Var Salir:INTEGER;
BEGIN
     IF (tipo<1) OR (tipo>2) then tipo:=1;
     IF tipo=1 then
        BEGIN
             FOR Salir:=1 TO 25 DO
                 BEGIN
                      Gotoxy (1,1);Insline;
                      Delay (tiempo);
                 END;
        END;{TIPO1}

     IF tipo=2 then
        BEGIN
             FOR Salir:=1 TO 25 DO
                 BEGIN
                      Gotoxy (1,1);Delline;
                      Delay (tiempo);
                 END;
        END;{TIPO2}
END;{Efectosalida}

{******************************************}
      PROCEDURE BloquearControlBreak;
{******************************************}
    BEGIN
         CheckBreak:=False;
    END;{BloquearControlBreak}

{*****************************************************************}
     FUNCTION ExisteArchivo (NombreArchivo:STRING) : Boolean;
{*****************************************************************}
Var Archivo:FILE;
    BEGIN
         {$I-}
         Assign (Archivo,NombreArchivo);
         FileMode:=0;
         Reset (Archivo);
         Close (Archivo);
         {$I+}
         IF IOResult=0 THEN ExisteArchivo:=TRUE
         ELSE ExisteArchivo:=False;
    END; {ExisteArchivo}

{********************************************************************}
PROCEDURE Pausa;
{********************************************************************}
Var Tecla:CHAR;
    BEGIN
         Tecla:=Readkey;
    END;{Pausa}

FUNCTION Tipomonitor:CHAR;
VAR Regs:Registers;
         BEGIN
              Regs.AH:=$0F;
              Intr ($10,Regs);
              IF Regs.AL=7 THEN Tipomonitor:='M'
              ELSE Tipomonitor:='C';
         END;

PROCEDURE SinCursor;
Var Regs:Registers;
          BEGIN
               WITH Regs DO
               BEGIN
                    AH:=$01;
                    CH:=$20;
                    CL:=$20;
               END;
          Intr ($10,Regs);
          END;

PROCEDURE CursorNormal;
Var Regs:Registers;
    Monitor:CHAR;
    BEGIN
         Monitor:=TipoMonitor;
         IF Monitor='M' THEN
            BEGIN
                 WITH Regs DO
                      BEGIN
                           AH:=$01;
                           CH:=12;
                           CL:=13;
                      END;{with}
          END{SI ES A MONOCROMATICO}
         ELSE
             BEGIN
                  WITH Regs DO
                      BEGIN
                           AH:=$01;
                           CH:=6;
                           CL:=7;
                      END;{with}
             END;{SI ES A COLOR}
          Intr ($10,Regs);
    END;

PROCEDURE CursorLargo;
Var Regs:Registers;
    Monitor:CHAR;
    BEGIN
         Monitor:=TipoMonitor;
         IF Monitor='M' THEN
            BEGIN
                 WITH Regs DO
                      BEGIN
                           AH:=$01;
                           CH:=0;
                           CL:=13;
                      END;{WITH}
            END{SI ES MONOCROMO}
         ELSE
             BEGIN
                  WITH Regs DO
                      BEGIN
                           AH:=$01;
                           CH:=0;
                           CL:=7;
                      END;{WITH}
             END;
         Intr ($10,Regs);
    END;


PROCEDURE PackMenu.IniMnu(xx,yy:INTEGER);
          BEGIN
               Cordx:=xx;
               Cordy:=yy;
               ContarOpc:=0;
               Desplegar:=0;
               Valor2:=0;
               Valor3:=0;
               
          END;
{***************************************************************************}
{Packmenu}

PROCEDURE PackMenu.AgregarOp (Opcion:STRING);
          BEGIN
               IF ContarOpc>=MaxOpc THEN Exit;
               ContarOpc:=ContarOpc+1;
               Titulo[ContarOpc]:=Opcion;
          END;
PROCEDURE PackMenu.Valores(VAR x3,y3:SHORTINT);
          BEGIN
               x3:=0;
               y3:=0;
               x3:=Valor2;
               y3:=Valor3;
          END;
PROCEDURE PackMenu.Dialogar(Estilo,Sombra,Lado,ColorFondo,ColorTexto,
                        FondIluminado,ColorIuminar:INTEGER;
                        Var OpcionEscogida:INTEGER);
          BEGIN
               GuardarTexto (CordX,CordY,CordX+(LargoMnu+1),CordY+
                            (ContarOpc+1));
               LargoMnu:=Length(Titulo[1]);
               ColorFondText (ColorFondo,ColorTexto);
               MenuSom(CordX,CordY,CordX+(LargoMnu+1),CordY+(ContarOpc+1),
                           Estilo,0,Sombra,Lado,ColorTexto,ColorFondo);
               Valor2:=CordX+(LargoMnu+1);
               Valor3:=CordY+(ContarOpc+1);
          {Desplegar Las Opciones}
          WHILE Desplegar <> ContarOpc DO
                BEGIN
                     Desplegar:=Desplegar+1;
                     Gotoxy (CordX+1,CordY+Desplegar);Write (Titulo[Desplegar]);
                END;
          NumOpcion:=1;
          NumOpcion2:=1;
          Y:=CordY+1;
          Y2:=CordY+1;
          REPEAT
                Textcolor (ColorTexto);TextBackground (ColorFondo);
                Gotoxy (CordX+1,Y2);Write (Titulo[NumOpcion2]);
                Textcolor (ColorIuminar);TextBackground (FondIluminado);
                Gotoxy (CordX+1,Y);Write (Titulo[NumOpcion]);
                TeclaPulsada (TeclaEspecial,TecN,'S','S');
                        IF (Tecla=ARRIBA) THEN
                           BEGIN
                                Y2:=Y;
                                Y:=Y-1;
                                NumOpcion2:=NumOpcion;
                                NumOpcion:=NumOpcion-1;
                                IF Y <CordY+1 THEN Y:=CordY+ContarOpc;
                                IF NumOpcion <1 THEN NumOpcion:=ContarOpc;
                           END;

                        IF Tecla=ABAJO THEN
                           BEGIN
                                Y2:=Y;
                                Y:=Y+1;
                                NumOpcion2:=NumOpcion;
                                NumOpcion:=NumOpcion+1;
                                IF Y >CordY+ContarOpc THEN Y:=CordY+1;
                                IF NumOpcion > ContarOpc THEN NumOpcion:=1;
                           END;
                        IF Tecla= F1 THEN
                           BEGIN
                                NumOpcion:=-1;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F2 THEN
                           BEGIN
                                NumOpcion:=-2;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F3 THEN
                           BEGIN
                                NumOpcion:=-3;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F4 THEN
                           BEGIN
                                NumOpcion:=-4;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F10 THEN
                           BEGIN
                                NumOpcion:=-10;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= ALTX THEN
                           BEGIN
                                NumOpcion:=-11;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla=ESC THEN
                           BEGIN
                                NumOpcion:=0;
                                Tecla:=SALTOCARRO;
                           END;
                      { IF Tecla=CURIZQ THEN
                           BEGIN
                                NumOpcion:=-1;
                                Tecla:=SALTOCARRO;
                           END;

                        IF Tecla=CURDER THEN
                           BEGIN
                                NumOpcion:=-2;
                                Tecla:=SALTOCARRO;
                           END;}

          UNTIL Tecla=SALTOCARRO;
          OpcionEscogida:=NumOpcion;
          ColorFondText (ColorFondo,ColorTexto);
          RestaurarTexto;
          END;{PackMenu}
{***************************************************************************}
{***************************************************************************}
{PackMenu2}
PROCEDURE PackMenu2.IniMnu(xx,yy:INTEGER);
          BEGIN
               Cordx:=xx;
               Cordy:=yy;
               ContarOpc:=0;
               Desplegar:=0;

          END;
PROCEDURE PackMenu2.AgregarOp (Opcion:STRING);
          BEGIN
               IF ContarOpc>=MaxOpc1 THEN Exit;
               ContarOpc:=ContarOpc+1;
               Titulo[ContarOpc]:=Opcion;
          END;
PROCEDURE PackMenu2.Dialogar(Estilo,Sombra,Lado,ColorFondo,ColorTexto,
                        FondIluminado,ColorIuminar:INTEGER;
                        Var OpcionEscogida:INTEGER);
VAR PonerLinea,PosicionY:INTEGER;
          BEGIN
               LargoMnu:=Length(Titulo[1]);
               ColorFondText(ColorFondo,ColorTexto);
               MenuSom(CordX,CordY,CordX+(LargoMnu+1),CordY+(ContarOpc*2),
                           Estilo,0,Sombra,Lado,ColorTexto,ColorFondo);

          {Desplegar Las Opciones}
          PosicionY:=CordY-1;
          WHILE Desplegar <> ContarOpc DO
                BEGIN
                     PosicionY:=PosicionY+2;
                     Desplegar:=Desplegar+1;
                     Gotoxy (CordX+1,PosicionY);Write (Titulo[Desplegar]);
                END;
          PosicionY:=CordY;
          FOR PonerLinea:=0 TO ContarOpc-2 DO
              BEGIN
                PosicionY:=PosicionY+2;
                Linhor (CordX,PosicionY,CordX+(LargoMnu+1),Estilo);
              END;

          NumOpcion:=1;
          NumOpcion2:=1;
          Y:=CordY+1;
          Y2:=CordY+1;
          REPEAT
                Textcolor (ColorTexto);TextBackground (ColorFondo);
                Gotoxy (CordX+1,Y2);Write (Titulo[NumOpcion2]);
                Textcolor (ColorIuminar);TextBackground (FondIluminado);
                Gotoxy (CordX+1,Y);Write (Titulo[NumOpcion]);
                TeclaPulsada (TeclaEspecial,TecN,'S','S');
                        IF Tecla=ARRIBA THEN
                           BEGIN
                                Y2:=Y;
                                Y:=Y-2;
                                NumOpcion2:=NumOpcion;
                                NumOpcion:=NumOpcion-1;
                                IF Y <CordY+1 THEN Y:=CordY+(ContarOpc*2)-1;
                                IF NumOpcion <1 THEN NumOpcion:=ContarOpc;
                           END;

                        IF Tecla=ABAJO THEN
                           BEGIN
                                Y2:=Y;
                                Y:=Y+2;
                                NumOpcion2:=NumOpcion;
                                NumOpcion:=NumOpcion+1;
                                IF Y >CordY+(ContarOpc*2)-1 THEN Y:=CordY+1;
                                IF NumOpcion > ContarOpc THEN NumOpcion:=1;
                           END;
                        IF Tecla= F1 THEN
                           BEGIN
                                NumOpcion:=-1;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F2 THEN
                           BEGIN
                                NumOpcion:=-2;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F3 THEN
                           BEGIN
                                NumOpcion:=-3;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F4 THEN
                           BEGIN
                                NumOpcion:=-4;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= F10 THEN
                           BEGIN
                                NumOpcion:=-10;
                                Tecla:=SALTOCARRO;
                           END;
                        IF Tecla= ALTX THEN
                           BEGIN
                                NumOpcion:=-11;
                                Tecla:=SALTOCARRO;
                           END;

                        IF Tecla=ESC THEN
                           BEGIN
                                NumOpcion:=0;
                                Tecla:=SALTOCARRO;
                           END;
                      { IF Tecla=CURIZQ THEN
                           BEGIN
                                NumOpcion:=-1;
                                Tecla:=SALTOCARRO;
                           END;

                        IF Tecla=CURDER THEN
                           BEGIN
                                NumOpcion:=-2;
                                Tecla:=SALTOCARRO;
                           END;}

          UNTIL Tecla=SALTOCARRO;
          OpcionEscogida:=NumOpcion;
          END;
{Menu2}
{***************************************************************************}

PROCEDURE Botones.TSombra (CordX,CordY,CordX2,ColorFondo,ColorSombra:SHORTINT);
          VAR Poner:SHORTINT;
              BEGIN
                   IF (ColorFondo <> -1) THEN
                      BEGIN
                           ColorFondText (ColorFondo,ColorSombra);
                           FOR Poner:=CordX TO CordX2 DO EscribirXY (Poner,CordY+1,'ﬂ');
                           EscribirXY (CordX2,CordY,'‹');
                      END;
              END;

PROCEDURE Botones.IniBotones;
          BEGIN
               ContarBot:=0;
               Desplegar:=0;
          END;

PROCEDURE Botones.AgregarBot(TextoBoton:CadenaBot;CordX,CordY:INTEGER);
          BEGIN
               IF ContarBot>=MaxBoton THEN Exit;
                  ContarBot:=ContarBot+1;
                  TitBot[ContarBot]:=TextoBoton;
                  BotCordX[ContarBot]:=CordX;
                  BotCordY[ContarBot]:=CordY;
          END;

PROCEDURE Botones.PreguntaBot(TextNorm,FondNorm,TextIlum,FondIlum,Sombra,Fond:SHORTINT;
          VAR Resultado:SHORTINT);
              BEGIN
                    {Desplegar las opciones}
                   WHILE Desplegar <> ContarBot DO
                         BEGIN
                              ColorFondText (FondNorm,Textnorm);
                              Desplegar:=Desplegar+1;
                              Gotoxy (BotcordX[Desplegar],BotcordY[Desplegar]);
                              Write ('['+TitBot[Desplegar]+']');
                              LargoSom:=Length('['+TitBot[Desplegar]+']');
                              IF Sombra>-1 THEN
                                 BEGIN
                                 TSombra(BotCordX[Desplegar]+1,BotCordY[Desplegar],BotCordX[Desplegar]+LargoSom,Fond,Sombra);
                                 END;
                         END;
              NumOpcion:=1;
              NumOpcion2:=1;
                  REPEAT
                        IF NumOpcion >ContarBot THEN NumOpcion:=1;
                        IF NumOpcion <1  THEN NumOpcion:=ContarBot;
                        ColorFondText (FondNorm,TextNorm);
                        Gotoxy (BotcordX[NumOpcion2],BotcordY[NumOpcion2]);
                        Write ('['+TitBot[NumOpcion2]+']');

                        ColorFondText (FondIlum,TextIlum);
                        Gotoxy (BotcordX[NumOpcion],BotcordY[NumOpcion]);
                        Write ('['+TitBot[Numopcion]+']');
                        TeclaPulsada (TeclaEspecial,TecN,'S','S');
                                IF (Tecla=ABAJO) OR (Tecla=DERECHA) THEN
                                    BEGIN
                                         NumOpcion2:=NumOpcion;
                                         NumOpcion:=NumOpcion+1;
                                    END;
                                  IF (Tecla=ARRIBA) OR (Tecla=IZQUIERDA) THEN
                                     BEGIN
                                          NumOpcion2:=NumOpcion;
                                          NumOpcion:=NumOpcion-1;
                                     END;
                                  IF Tecla= F1 THEN
                                     BEGIN
                                          NumOpcion:=-1;
                                          Tecla:=SALTOCARRO;
                                     END;
                                  IF Tecla= F2 THEN
                                     BEGIN
                                          NumOpcion:=-2;
                                          Tecla:=SALTOCARRO;
                                     END;
                                  IF Tecla= F3 THEN
                                     BEGIN
                                          NumOpcion:=-3;
                                          Tecla:=SALTOCARRO;
                                     END;
                                  IF Tecla= F4 THEN
                                     BEGIN
                                          NumOpcion:=-4;
                                          Tecla:=SALTOCARRO;
                                     END;
                                  IF Tecla= F10 THEN
                                     BEGIN
                                          NumOpcion:=-10;
                                          Tecla:=SALTOCARRO;
                                     END;

                           IF Tecla=TAB THEN
                              BEGIN
                                   NumOpcion2:=NumOpcion;
                                   NumOpcion:=NumOpcion+1;
                              END;
                           IF Tecla=ESC THEN
                              BEGIN
                                   Numopcion:=0;
                                   Tecla:=SALTOCARRO;
                              END;
                  UNTIL Tecla=SALTOCARRO;
              Resultado:=NumOpcion;
          END;{PreguntaBoton}
PROCEDURE PackReg.IniRegistro;
          BEGIN
               ContarCmpo:=0;
               Desplegar:=0;
          END;{IniRegistro}
PROCEDURE PackReg.AgregarCampo (VAR Resp:STRING;
                               NomCamp:STRING;TipoCamp:CHAR;
                               ANCHO,CordX,CordY:INTEGER);
          BEGIN
               IF Contarcmpo>=MaxCmpo THEN Exit;
               ContarCmpo:=ContarCmpo+1;
               NomCmpo[ContarCmpo]:=NomCamp;
               TipoCmpo[ContarCmpo]:=TipoCamp;
               AnchoCmpo[ContarCmpo]:=Ancho;
               CorX[ContarCmpo]:=CordX;
               CorY[ContarCmpo]:=CordY;

          END;{AgregarCampo}
PROCEDURE PackReg.DialogarCampos (ColorFondo1,ColorTexto2,ColorFondo,ColorTexto,Sombra:INTEGER);
          BEGIN
               {Desplegar Registro}
               WHILE Desplegar <> ContarCmpo DO
                     BEGIN
                          ColorFondText (ColorFondo1,ColorTexto2);
                          Desplegar:=Desplegar+1;
                          Gotoxy (CorX[Desplegar],CorY[Desplegar]);
                          Write (NomCmpo[Desplegar]);
                     END;
               NumOpcion:=1;
          END;{DialogarCampos}
END.{PackSoft}
