{
  Libreria para Graficos para Turbo Pascal
  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 2.2
  Este es codigo GNU/GPL
}

UNIT Windows;
INTERFACE
USES Crt,Graph,Dos,PackSoft;
CONST
     ALTO=1;
     BAJO=2;
     ENTER=#13;
     ARRIBA=#72;
     ABAJO=#80;
     NULO=#0;
     TAB=#9;
     ESC=#27;
     SHIFTAB=#15;
     VERTICAL=1;
     HORIZONTAL=2;
     INVTAV=#15;   {Tab Cambiado}
     AltX=#45;
     TeclaIns=#82; {Tecla insertar}
     Izquierda=#75;
     Derecha=#77;
     RePag=#73;
     AvPag=#81;
     TeclaInicio=#71;
     TeclaFin=#79;
     TeclaSupr=#83;
     F1=#59;
     F2=#60;
     F3=#61;
     F4=#62;
     F5=#63;
     F6=#64;
     F7=#65;
     F8=#66;
     F9=#67;
     F10=#68;
CONST MaxbotGr=10;

Type DIRECTORIO=STRING[80];


TYPE CADENABOT=STRING[80];



     BotonGr=OBJECT
             TeclaPresionar:CHAR;

             Desplegar,ContarBot,
             Som,NumOpcion,NumOpcion2:SHORTINT;

             Verhor:INTEGER;


             TitBot:ARRAY [1..MaxBotGr] OF CADENABOT;
             BotCordX:ARRAY [1..MaxBotGr] OF INTEGER;
             BotCordY:ARRAY [1..MaxBotGr] OF INTEGER;

                   PROCEDURE IniBotones(Fonres:SHORTINT);
                   PROCEDURE AgregarBot(TextoBoton:CadenaBot;CordX,CordY:INTEGER);
                   PROCEDURE PreguntaBot(TipoLetra,Tamano,TextNorm,FondNorm,TextIlum,FondIlum:SHORTINT;
                                        VAR Resultado:SHORTINT);
             END;


     GrafMenu=OBJECT
              XIni,YIni,ContarOpc,Desplegar,CorY,CordenadaY,Cuad,Cuad2,Lin,
              OpcionIlumi,OpcionNormal,CordAnt,CordAct,
              LargoMnuGraf,AnchoMnuGraf:INTEGER;
              OpcDesplegar:ARRAY [1..20] OF STRING;

              TeclaPresionada:CHAR;
                    PROCEDURE IniGrafMnu (CordX,CordY:INTEGER);
                    PROCEDURE AgrOpcGraf (Opcion:STRING);
                    PROCEDURE DialogarGr (TipoLetra,TamanoLetra,
                                          ColorNorm,ColorResalt,
                                          FondNorm,FondResalt,Altbaj1,Altbaj2:INTEGER;
                                          Var OpcionEscogida:INTEGER);
              END;
VAR Tiempo:INTEGER;

PROCEDURE Protector;

PROCEDURE Efectosalidagraf (Tipo,Tiempo:INTEGER);

{****************************************}
   PROCEDURE Inicializargraficos(Ruta:DIRECTORIO);
{****************************************}
   PROCEDURE Borde (CordX,CordY,CordX1,CordY1,Color,AltBaj:INTEGER);
{****************************************}

  PROCEDURE EstadoTexto(Modo:INTEGER);

{----------------------------------------------------------------------}
PROCEDURE Relieve;
{----------------------------------------------------------------------}

PROCEDURE EscribirSombreado (CordX,CordY:INTEGER;
                               Mensaje:TEXTO;
                               EstiloLetra,VerHor,Tamagno,Color,AltBaj:SHORTINT);
{****************************************}
{****************************************}
   PROCEDURE Cerrargraficos;
{****************************************}
{****************************************}
   PROCEDURE
   Menugrafsom (cordx,cordy,cordx1,cordy1,Colrec,EstiloFon,Colorfon:INTEGER);
{****************************************}
{****************************************}
   PROCEDURE
   Menugrafsom3d (cordx,cordy,cordx1,cordy1,EstiloLin,EstiloFon,Colorfon,ancho:INTEGER);
{****************************************}
{****************************************}
       PROCEDURE
       Margengraf (cordx,cordy,cordx1,cordy1,EstiloLin:INTEGER);
{****************************************}
{****************************************}
       PROCEDURE
       RestauraGraficos;
{****************************************}
{*****************************************************************}
PROCEDURE GrafEscribir (CordX,CordY:INTEGER;
                        Mensaje:Texto;
                        EstiloLetra,VerHor,Tamagno,Color:INTEGER);
{*****************************************************************}
{*****************************************************************}
PROCEDURE LeerCadenaGrafica(CordX,CordY,Limite,EstiloLetra,Tamagno,ColorLetra,ColorFondo:INTEGER;
          Var CadenaResultante:STRING);
{*****************************************************************}

{*****************************************************************}
PROCEDURE LeerCaracterGrafico(CordX,CordY,EstiloLetra,Tamagno,Color:INTEGER;
          Var LeerCaracter:CHAR);
{*****************************************************************}

{*****************************************************************}
PROCEDURE FechaGrafica(CordX,CordY,TipoLetra,VerHor,Tamagno,ColorTexto,Altbaj:INTEGER);
{*****************************************************************}

{*****************************************************************}
PROCEDURE HoraGrafica (CordX,CordY,TipoLetra,Tamagno,ColorTexto,ColorFondo,Altbaj:INTEGER);
{*****************************************************************}

{*****************************************************************}
PROCEDURE BotonAceptar (CordX,CordY,EstiloFondo,Color:INTEGER;
                       Mensaje:STRING);
{*****************************************************************}

IMPLEMENTATION
PROCEDURE Protector;
PROCEDURE Gotas;
VAR ALBAJ:SHORTINT;
    sombra,color:INTEGER;
    Cordx,Cordy:INTEGER;
    Tamano,Letra:Shortint;
    Tiempos:STRING;
          BEGIN
          Randomize;
          Albaj:=Random (3);

          Setfillstyle (1,0);
          CASE Albaj OF
               1:BEGIN
                      Sombra:=0;
                      Color:=15;
                 END;{1}
               2:BEGIN
                      Sombra:=15;
                      Color:=0;
                 END{2}
               ELSE BEGIN
                         Sombra:=0;
                         Color:=15;
                    END;{Else}
          END;{Case}
          REPEAT
               CordX:=Random(GetmaxX);
               CordY:=Random(GetmaxY);
               Tamano:=Random(20);
               Setcolor (Sombra);
               circle (CORDX-1,CordY-1,Tamano);
               Setcolor (Color);
               circle (CORDX+1,CordY+1,Tamano);
               Setcolor (0);
               Fillellipse(CordX,CordY,Tamano,Tamano);
               Delay (850);
          UNTIL Keypressed;
          END;{Gotas}
PROCEDURE Signos;
VAR Tamano,Letra:Shortint;
    Cordx1,Cordy1:INTEGER;
    Tiempos:STRING;
    ALBAJ:SHORTINT;
          BEGIN
               Randomize;
               REPEAT
                     Albaj:=Random (3);
                     CordX1:=Random(GetmaxX);
                     CordY1:=Random(GetmaxY);
                     Tamano:=Random(6);
                     Letra:=Random (11);
                     EscribirSombreado (CordX1,CordY1,'?',Letra,0,Tamano,0,Albaj);
                     Delay (400);
               UNTIL Keypressed;
          END;{Signos}
VAR
   MaxX,MaxY:INTEGER;
   TipoProtector:SHORTINT;
   Mapa1,Mapa2,Mapa3,Mapa4:Pointer;
PROCEDURE Actuar;
          BEGIN
          Tiempo:=0;
          MaxX:=GetmaxX;
          MaxY:=GetmaxY;
           Getmem   (Mapa1,Imagesize (0,0,MaxX div 2, MaxY div 2));
          GetImage (0,0,MaxX div 2, MaxY div 2,Mapa1^);
          Getmem   (Mapa2,Imagesize (MaxX div 2, MaxY div 2,MaxX,MaxY));
          GetImage (MaxX div 2, MaxY div 2,MaxX,MaxY,Mapa2^);
          Getmem   (Mapa3,Imagesize (0,MaxY div 2,MaxX div 2,MaxY));
          GetImage (0,MaxY div 2,MaxX div 2, MaxY,Mapa3^);
          Getmem   (Mapa4,Imagesize (MaxX div 2,0,MaxX,MaxY div 2));
          GetImage (MaxX div 2,0,MaxX,MaxY div 2,Mapa4^);
          Randomize;
          TipoProtector:=Random (3);
          IF TipoProtector=2 THEN Gotas
             ELSE Signos;
          Pausa;
          PutImage (0,0,Mapa1^,0);
          PutImage (MaxX div 2,0,Mapa4^,0);
          PutImage (0,MaxY div 2,Mapa3^,0);
          PutImage (MaxX div 2,MaxY div 2,Mapa2^,0);
          FreeMem (Mapa1,Imagesize (0,0,MaxX div 2, MaxY div 2));
          FreeMem (Mapa2,Imagesize (MaxX div 2, MaxY div 2,MaxX,MaxY));
          FreeMem (Mapa3,Imagesize (0,MaxY div 2,MaxX div 2,MaxY));
          FreeMem (Mapa4,Imagesize (MaxX div 2,0,MaxX,MaxY div 2));
END;
BEGIN
        Tiempo:=0;
          MaxX:=GetmaxX;
          MaxY:=GetmaxY;
          WHILE NOT Keypressed DO
                     BEGIN
                          Tiempo:=Tiempo+1;
                          Delay(10);
                          IF Tiempo=3000 THEN Actuar;
                     END;{While}
END;{Protector}
{****************************************}
   PROCEDURE Inicializargraficos(Ruta:DIRECTORIO);
{****************************************}
Var modo,drive:INTEGER;
    Codigoerror:INTEGER;
            BEGIN
                 modo:=DETECT;
                 Initgraph (modo,drive,ruta);
                 Codigoerror:=GraphResult;
                 IF Codigoerror <> grOk then
                    BEGIN
                         Writeln;
                         Writeln ('Error de graficos: ',GraphErrorMsg(Codigoerror),' Copyrigth (c), 1994-1996 PackSoft');
                         Halt;
                    END;
            END;{Inicializargraficos}
{****************************************}
   PROCEDURE Borde (CordX,CordY,CordX1,CordY1,Color,AltBaj:INTEGER);
{****************************************}
VAR Sombra:INTEGER;
    BEGIN
         Setcolor (8);
         IF (AltBaj<> BAJO) AND (Color<>0) THEN Rectangle (CordX-1,CordY-1,CordX1+1,CordY1+1);
         Setfillstyle (1,Color);
         Bar (CordX,CordY,CordX1,CordY1);
         IF AltBaj>BAJO THEN AltBaj:=ALTO;
         IF AltBaj<ALTO THEN AltBaj:=ALTO;
         IF Color=8 THEN Sombra:=0;
         IF Color<>8 THEN Sombra:=8;
         IF AltBaj=ALTO THEN
            BEGIN
                 Setcolor (15);
                 Line (CordX,CordY,CordX1,CordY);
                 Line (CordX,CordY,CordX,CordY1);
                 Setcolor (Sombra);
                 Line (CordX,CordY1,CordX1,CordY1);
                 Line (CordX1,CordY1,CordX1,CordY);
                 Line (CordX+1,CordY1+1,CordX1+1,CordY1+1);
                 Line (CordX1+1,CordY1+1,CordX1+1,CordY+1);
            END;
         IF AltBaj=BAJO THEN
            BEGIN
                 IF Color=8 THEN Sombra:=8;
                 Setcolor (Sombra);
                 Line (CordX,CordY,CordX1,CordY);
                 Line (CordX,CordY,CordX,CordY1);
                 Line (CordX,CordY-1,CordX1,CordY-1);
                 Line (CordX,CordY-1,CordX,CordY1-1);
                 Setcolor (15);
                 Line (CordX,CordY1,CordX1,CordY1);
                 Line (CordX1,CordY1,CordX1,CordY);

            END;
    END;


{****************************************}
PROCEDURE EstadoTexto(Modo:INTEGER);
{****************************************}
       BEGIN
            SettextJustify (Modo,Modo);
       END;

PROCEDURE Efectosalidagraf (Tipo,Tiempo:INTEGER);
Var Salir:INTEGER;
BEGIN
     IF (tipo<1) OR (tipo>2) then tipo:=1;
     IF tipo=1 then
        BEGIN
             FOR Salir:=0 TO GetmaxY DO
                 BEGIN
                      Setcolor (0);
                      Line (0,Salir,GetmaxX,Salir);
                      Delay (tiempo);
                 END;
        END;{TIPO1}

     IF tipo=2 then
        BEGIN
             FOR Salir:=GetmaxY DOWNTO 0 DO
                 BEGIN
                      Setcolor (0);
                      Line (0,Salir,GetmaxX,Salir);
                      Delay (tiempo);
                 END;
        END;{TIPO2}
        Cerrargraficos;
END;{Efectosalidagraf}
{****************************************}
   PROCEDURE Cerrargraficos;
{****************************************}
             BEGIN
                  Closegraph;
             END;

{****************************************}
   PROCEDURE EscribirSombreado (CordX,CordY:INTEGER;
                               Mensaje:TEXTO;
                               EstiloLetra,VerHor,Tamagno,Color,AltBaj:SHORTINT);
{****************************************}
VAR Sombra:SHORTINT;
        BEGIN
             Settextstyle (EstiloLetra,VerHor,Tamagno);
             Sombra:=Color-8;
             IF Color=7 THEN Sombra:=8;
             IF AltBaj=ALTO THEN
                BEGIN
                     Setcolor (15);
                     Outtextxy (CordX-1,CordY-1,Mensaje);
                     Setcolor (Sombra);
                     Outtextxy (CordX+1,CordY+1,Mensaje);
                     Setcolor (Color);
                     Outtextxy (CordX,CordY,Mensaje);
                END;
             IF AltBaj=BAJO THEN
                BEGIN
                     Setcolor (Sombra);
                     Outtextxy (CordX-1,CordY-1,Mensaje);
                     Setcolor (15);
                     Outtextxy (CordX+1,CordY+1,Mensaje);
                     Setcolor (Color);
                     Outtextxy (CordX,CordY,Mensaje);
                END;
        END;
{****************************************}
   PROCEDURE
   Menugrafsom (cordx,cordy,cordx1,cordy1,Colrec,EstiloFon,Colorfon:INTEGER);
{****************************************}
             BEGIN

                  Setfillstyle (Estilofon,Colorfon);
                  Bar (cordx,cordy,cordx1,cordy1);
                  {Margen}
                  Setcolor (Colrec);
                  Rectangle (cordx,cordy,cordx1,cordy1);

                  Setfillstyle (1,15);

             END;{Menugraf}

{****************************************}
   PROCEDURE
   Menugrafsom3d (cordx,cordy,cordx1,cordy1,EstiloLin,EstiloFon,Colorfon,ancho:INTEGER);
{****************************************}
             BEGIN


                  Setlinestyle (0,0,Estilolin);
                  Setfillstyle (Estilofon,Colorfon);
                  Bar3d (cordx,cordy,cordx1,cordy1,ancho,true);
                  {Margen}
                  Rectangle (cordx-1,cordy-1,cordx1+1,cordy1+1);
                  Setlinestyle (0,0,1);
                  Setfillstyle (1,15);

             END;{Menugraf}

{****************************************}
       PROCEDURE
       Margengraf (cordx,cordy,cordx1,cordy1,EstiloLin:INTEGER);
{****************************************}
BEGIN
     SetLineStyle (0,0,EstiloLin);
     Rectangle (cordx,cordy,cordx1,cordy1);
     SetLineStyle (0,0,1);
END;{Margengraf}

{****************************************}
       PROCEDURE
       RestauraGraficos;
{****************************************}
BEGIN
     SetgraphMode(GetgraphMode);
END;{RestauraGraficos}
{*****************************************************************}
PROCEDURE GrafEscribir (CordX,CordY:INTEGER;
                        Mensaje:Texto;
                        EstiloLetra,VerHor,Tamagno,Color:INTEGER);
{*****************************************************************}
    BEGIN
         Settextstyle (EstiloLetra,VerHor,Tamagno);
         Setcolor (Color);
         Outtextxy (CordX,CordY,Mensaje);
    END;{GrafEscribir}

{*****************************************************************}
PROCEDURE LeerCadenaGrafica(CordX,CordY,Limite,EstiloLetra,Tamagno,ColorLetra,ColorFondo:INTEGER;
          Var CadenaResultante:STRING);
{*****************************************************************}
VAR Tecla:ARRAY [1..6000] OF CHAR;
    Residuo:CHAR;
    Letra,Escribir,ValorPrimario:INTEGER;
    Mensaje:STRING;
PROCEDURE Protector2;
PROCEDURE Gotas;
VAR ALBAJ:SHORTINT;
    sombra,color:INTEGER;
    Cordx,Cordy:INTEGER;
    Tamano,Letra:Shortint;
    Tiempos:STRING;
          BEGIN
          Randomize;
          Albaj:=Random (3);

          Setfillstyle (1,0);
          CASE Albaj OF
               1:BEGIN
                      Sombra:=0;
                      Color:=15;
                 END;{1}
               2:BEGIN
                      Sombra:=15;
                      Color:=0;
                 END{2}
               ELSE BEGIN
                         Sombra:=0;
                         Color:=15;
                    END;{Else}
          END;{Case}
          REPEAT
               CordX:=Random(GetmaxX);
               CordY:=Random(GetmaxY);
               Tamano:=Random(20);
               Setcolor (Sombra);
               circle (CORDX-1,CordY-1,Tamano);
               Setcolor (Color);
               circle (CORDX+1,CordY+1,Tamano);
               Setcolor (0);
               Fillellipse(CordX,CordY,Tamano,Tamano);
               Delay (850);
          UNTIL Keypressed;
          END;{Gotas}
PROCEDURE Signos;
VAR Tamano,Letra:Shortint;
    Cordx1,Cordy1:INTEGER;
    Tiempos:STRING;
    ALBAJ:SHORTINT;
          BEGIN
               Randomize;
               REPEAT
                     Albaj:=Random (3);
                     CordX1:=Random(GetmaxX);
                     CordY1:=Random(GetmaxY);
                     Tamano:=Random(6);
                     Letra:=Random (11);
                     EscribirSombreado (CordX1,CordY1,'?',Letra,0,Tamano,0,Albaj);
                     Delay (400);
               UNTIL Keypressed;
          END;{Signos}
          VAR
              TipoProtector:SHORTINT;
              MaxX,MaxY:INTEGER;
              Mapa1,Mapa2,Mapa3,Mapa4:Pointer;
PROCEDURE Actuar;
          BEGIN
          Tiempo:=0;
          MaxX:=GetmaxX;
          MaxY:=GetmaxY;
          Getmem   (Mapa1,Imagesize (0,0,MaxX div 2, MaxY div 2));
          GetImage (0,0,MaxX div 2, MaxY div 2,Mapa1^);
          Getmem   (Mapa2,Imagesize (MaxX div 2, MaxY div 2,MaxX,MaxY));
          GetImage (MaxX div 2, MaxY div 2,MaxX,MaxY,Mapa2^);
          Getmem   (Mapa3,Imagesize (0,MaxY div 2,MaxX div 2,MaxY));
          GetImage (0,MaxY div 2,MaxX div 2, MaxY,Mapa3^);
          Getmem   (Mapa4,Imagesize (MaxX div 2,0,MaxX,MaxY div 2));
          GetImage (MaxX div 2,0,MaxX,MaxY div 2,Mapa4^);
          Randomize;
          TipoProtector:=Random (3);
          IF TipoProtector=2 THEN Gotas
             ELSE Signos;
          Pausa;
          PutImage (0,0,Mapa1^,0);
          PutImage (MaxX div 2,0,Mapa4^,0);
          PutImage (0,MaxY div 2,Mapa3^,0);
          PutImage (MaxX div 2,MaxY div 2,Mapa2^,0);
          FreeMem (Mapa1,Imagesize (0,0,MaxX div 2, MaxY div 2));
          FreeMem (Mapa2,Imagesize (MaxX div 2, MaxY div 2,MaxX,MaxY));
          FreeMem (Mapa3,Imagesize (0,MaxY div 2,MaxX div 2,MaxY));
          FreeMem (Mapa4,Imagesize (MaxX div 2,0,MaxX,MaxY div 2));
          Settextstyle (EstiloLetra,0,Tamagno);
END;
BEGIN
        Tiempo:=0;
          MaxX:=GetmaxX;
          MaxY:=GetmaxY;
          WHILE NOT Keypressed DO
                     BEGIN
                          Delay (10);
                          Setcolor (15);
                          IF CordX<ValorPrimario THEN CordX:=ValorPrimario;
                          Line(CordX,CordY+3,CordX,CordY+TextHeight('H'));
                          Delay (10);
                          Setfillstyle (1,ColorFondo);
                          Bar (CordX,CordY+3,CordX,CordY+TextHeight('H'));
                          Tiempo:=Tiempo+1;
                          IF Tiempo=1000 THEN Actuar;
                     END;{While}
END;{Protecto}
PROCEDURE Retroceso;
          BEGIN
               Letra:=Letra-1;
               IF Letra<0 THEN Letra:=0;
               IF CordX<=ValorPrimario THEN CordX:=ValorPrimario;
               CordX:=CordX-TextWidth(Tecla[Letra]);
               SetFillStyle (1,ColorFondo);
               IF CordX>ValorPrimario THEN Bar (CordX,CordY+3,CordX+TextWidth(Tecla[Letra]),CordY+TextHeight(Tecla[Letra])+6)
                  ELSE Bar (ValorPrimario,CordY+3,CordX+TextWidth(Tecla[Letra]),CordY+TextHeight(Tecla[Letra])+6);
               Letra:=Letra-1;
               IF Letra<0 THEN Letra:=0;
               CordX:=CordX-TextWidth(Tecla[Letra]);
{               IF CordX<=ValorPrimario THEN CordX:=ValorPrimario;}

          END;

BEGIN
Valorprimario:=CordX;
Letra:=0;
Setfillstyle (1,ColorLetra);
Mensaje:='';
Settextstyle (EstiloLetra,0,Tamagno);
Borde (CordX-3,CordY,Limite,CordY+(TextHeight('H')+7),ColorFondo,Bajo);
Repeat
     IF Letra=0 THEN CordX:=ValorPrimario;
     IF Letra=0 THEN Tecla[Letra]:=' ';
     (*Cursor*)
     Protector2;
     Settextstyle (Estiloletra,0,tamagno);
     Letra:=Letra+1;
     Tecla[Letra]:=Readkey;
     IF Tecla[Letra]=#0 THEN BEGIN
                             {Basura}
                             Tecla[Letra]:=Readkey;
                             Tecla[Letra]:=#0;
                             END;
     IF Tecla[Letra]=#25 THEN BEGIN Borde (ValorPrimario-3,CordY,Limite,CordY+TextHeight('H')+7,ColorFondo,Bajo);Letra:=0;END;
     IF Tecla[Letra]=#27 THEN BEGIN Borde (ValorPrimario-3,CordY,Limite,CordY+TextHeight('H')+7,ColorFondo,Bajo);Letra:=0;END;
     IF Tecla[Letra]=#8 THEN Retroceso;
     IF CordX<ValorPrimario THEN CordX:=ValorPrimario;
     Grafescribir (CordX,CordY,Tecla[Letra],EstiloLetra,0,Tamagno,ColorLetra);
     CordX:=CordX+TextWidth(Tecla[Letra]);
     IF CordX>=Limite THEN Tecla[Letra]:=#13;
Until Tecla[Letra]=#13;
FOR Escribir:=1 TO Letra-1 DO
    BEGIN
         Mensaje:=Mensaje+Tecla[Escribir];
    END;
CadenaResultante:=Mensaje;
      Bar (CordX-TextWidth(Tecla[Letra]),CordY,CordX+TextWidth(Tecla[Letra]),CordY+TextHeight(Tecla[Letra]));
END;{LeerCadenaGrafica}
{*****************************************************************}
PROCEDURE LeerCaracterGrafico(CordX,CordY,EstiloLetra,Tamagno,Color:INTEGER;
          Var LeerCaracter:CHAR);
{*****************************************************************}
VAR Tecla:CHAR;
    Residuo:CHAR;
    Caracter:CHAR;
BEGIN
Setfillstyle (1,Color);
Repeat
     (*Cursor*)
     Caracter:=Tecla;
     Repeat
           Delay (10);
           Line(CordX,CordY,CordX,CordY+TextHeight('H'));
           Delay (10);
           Bar (CordX,CordY,CordX,CordY+TextHeight('H'));
     Until Keypressed;
     Tecla:=Readkey;
     Bar (CordX,CordY-3,CordX+TextWidth(Tecla),CordY+TextHeight(Tecla)+6);
     IF Tecla=#0 THEN Residuo:=Readkey;
     Grafescribir (CordX,CordY,Tecla,EstiloLetra,0,Tamagno,Color);
Until Tecla=#13;
LeerCaracter:=Caracter;
      Bar (CordX,CordY,CordX+TextWidth(Tecla),CordY+TextHeight(Tecla));
END;{LeerCaracterGrafico}

{*****************************************************************}
PROCEDURE FechaGrafica(CordX,CordY,TipoLetra,VerHor,Tamagno,ColorTexto,Altbaj:INTEGER);
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
                 Ano,Fecha,NumDia:STRING;
         BEGIN
              GetDate (Agno,Mes,Dia,DiaSemana);
              Str (Agno:0,Ano);
              Str (Dia:0,NumDia);
Fecha:=Dias[DiaSemana]+' '+NumDia+' de '+Meses[Mes]+' de '+Ano;
EscribirSombreado (CordX,CordY,Fecha,TipoLetra,VerHor,Tamagno,ColorTexto,Altbaj);
         END;{FechaGrafica}

{*****************************************************************}
PROCEDURE HoraGrafica (CordX,CordY,TipoLetra,Tamagno,ColorTexto,ColorFondo,Altbaj:INTEGER);
{*****************************************************************}
Var Horas,Minutos,Segundos,Centesimas:WORD;
    Hora:STRING;
    Salir:CHAR;
    ContadorSegundos,ContadorMinutos,ContadorHoras:INTEGER;
    Poner,Poner1,Poner2:INTEGER;
    LargoCadena:INTEGER;
    NumeroPoner:STRING;

Function AgregarCero (FragHora:WORD):STRING;
VAR
   Numero:STRING;
 BEGIN
      Str (FragHora:0,Numero);
      IF Length(Numero)=1 THEN Numero:='0'+Numero;
      AgregarCero:=Numero;
 END;{AgregarCero}

   BEGIN
        GetTime (Horas,Minutos,Segundos,Centesimas);
        ContadorSegundos:=Segundos;
        ContadorMinutos:=Minutos;
        ContadorHoras:=Horas;
        Hora:=AgregarCero(Horas)+':'+AgregarCero(Minutos)+':'+AgregarCero(Segundos);
        Largocadena:=Textwidth (Hora);
        EscribirSombreado (CordX,CordY,Hora,TipoLetra,0,Tamagno,ColorTexto,Altbaj);
   REPEAT
         Poner:=0;
         Poner1:=0;
         Poner2:=0;
    REPEAT
        GetTime (Horas,Minutos,Segundos,Centesimas);
        Hora:=AgregarCero(Horas)+':'+AgregarCero(Minutos)+':'+AgregarCero(Segundos);
        ContadorSegundos:=Segundos;
        ContadorMinutos:=Minutos;
        ContadorHoras:=Horas;
        Largocadena:=CordX+TextWidth(Hora);
        {Ponersegundos}
        IF Centesimas MOD 10=0 THEN
           BEGIN
           Poner:=Poner+1;
           NumeroPoner:=Copy(AgregarCero(ContadorSegundos),2,1);
           IF Poner=1 THEN
              BEGIN
              Menugrafsom (Largocadena-(TextWidth('0')+7),CordY,LargoCadena,CordY+(TextHeight('0')+2),ColorFondo,1,ColorFondo);
              EscribirSombreado (Largocadena-(Textwidth('0')+5),CordY,NumeroPoner,TipoLetra,0,Tamagno,ColorTexto,Altbaj);
              END;
           IF Poner=5 THEN Poner:=0;
           END;{Poner segundo segundo}
        IF Segundos MOD 10=0 THEN
         BEGIN
          IF Poner=4 THEN
           BEGIN
            NumeroPoner:=Copy(AgregarCero(ContadorSegundos),1,2);
            Menugrafsom (Largocadena-(TextWidth('00')+7),CordY,LargoCadena,CordY+(TextHeight('0')+2),ColorFondo,1,ColorFondo);
            EscribirSombreado(Largocadena-(Textwidth('00')+5),CordY,NumeroPoner,TipoLetra,0,Tamagno,ColorTexto,Altbaj);
           END;
         END; {Poner segundos}
         IF Segundos MOD 60=0 THEN
           BEGIN
           Poner1:=Poner1+1;
           NumeroPoner:=Copy(AgregarCero(ContadorMinutos),2,1);
           IF Poner1=1 THEN
              BEGIN
                Menugrafsom (Largocadena-(TextWidth('000')+40),CordY,LargoCadena-(TextWidth(':00')+14),
                CordY+(TextHeight('0')+2),ColorFondo,1,ColorFondo);
                EscribirSombreado (Largocadena-(Textwidth('0:00')),CordY,NumeroPoner,TipoLetra,0,Tamagno,ColorTexto,Altbaj);
              END;
           IF Poner1=6 THEN Poner1:=0;
           END;{Poner segundo minuto}
        IF (Minutos MOD 10=0) AND (Segundos MOD 60=0) THEN
         BEGIN
          IF Poner1=4 THEN
           BEGIN
            NumeroPoner:=Copy(AgregarCero(ContadorMinutos),1,2);
            Menugrafsom (Largocadena-(TextWidth('00:00')+10),CordY,LargoCadena-(TextWidth(':00')+14),CordY+(TextHeight('0')+2),
            ColorFondo,1,ColorFondo);
            EscribirSombreado (Largocadena-(Textwidth('00:00')),CordY,NumeroPoner,TipoLetra,0,Tamagno,ColorTexto,Altbaj);
           END;
        IF (Minutos MOD 60=0) AND (Segundos MOD 60=0) THEN
           BEGIN
                Poner2:=Poner2+1;
                NumeroPoner:=Copy(AgregarCero(ContadorHoras),1,2);
                IF Poner2=1 THEN
                   BEGIN
                        MenugrafSom (CordX,CordY,CordX+TextWidth('00'),CordY+(TextHeight('0')+2),ColorFondo,1,ColorFondo);
                        EscribirSombreado(CordX,CordY,NumeroPoner,TipoLetra,0,Tamagno,ColorTexto,Altbaj);
                   END;
                IF Poner2=5 THEN Poner2:=0;
           END;
        END {Poner minutos}
    UNTIL Keypressed;
    Salir:=Readkey;
  UNTIL (Salir=#27) OR (Salir=#13);
   END;{HoraGrafica}

{*****************************************************************}
PROCEDURE BotonAceptar (CordX,CordY,EstiloFondo,Color:INTEGER;
                       Mensaje:STRING);
{*****************************************************************}
    BEGIN
         Settextstyle (0,0,1);
         Borde (CordX,CordY,CordX+(TextWidth(Mensaje))+8,CordY+19,EstiloFondo,ALTO);
         EscribirSombreado (CordX+5,CordY+7,Mensaje,0,0,1,Color,BAJO);
    END;{BotonAceptar}


{**********************************************************************}
{                    OBJETO BOTON GRAFICO                              }
{**********************************************************************}

PROCEDURE BotonGr.IniBotones(Fonres:SHORTINT);
          BEGIN
               ContarBot:=0;
               Desplegar:=0;
               Som:=Fonres;
          END;

{**********************************************************************}
PROCEDURE BotonGr.AgregarBot(TextoBoton:CadenaBot;CordX,CordY:INTEGER);
          BEGIN
               IF ContarBot>=MaxBotGr THEN Exit;
                  ContarBot:=ContarBot+1;
                  TitBot[ContarBot]:=TextoBoton;
                  BotCordX[ContarBot]:=CordX;
                  BotCordY[ContarBot]:=CordY;
          END;

{**********************************************************************}
PROCEDURE BotonGr.PreguntaBot(TipoLetra,Tamano,TextNorm,FondNorm,TextIlum,FondIlum:SHORTINT;
                                        VAR Resultado:SHORTINT);
VAR Selec:SHORTINT;

PROCEDURE Sombrabot (Som:INTEGER);
          BEGIN
               IF Som=1 THEN
                  BEGIN
                       Setlinestyle (1,1,1);
                       IF FondNorm=7 THEN Selec:=8 ELSE Selec:=15;
                       Setcolor (FondIlum);
                       Rectangle
                       (BotCordX[NumOpcion]+8,BotCordY[NumOpcion]+5,
                       BotCordX[NumOpcion]+TextWidth (TitBot[NumOpcion])+22,
                       BotCordY[NumOpcion]+TextHeight('H')+11);
                       Setlinestyle (0,0,1);
                  END;
               IF Som=2 THEN
                  BEGIN
                       Borde
                       (BotCordX[NumOpcion]+8,BotCordY[NumOpcion]+5,
                       BotCordX[NumOpcion]+TextWidth (TitBot[NumOpcion])+22,
                       BotCordY[NumOpcion]+TextHeight('H')+11,FondIlum,Bajo);
                       GrafEscribir(BotCordX[NumOpcion]+16,BotCordY[NumOpcion]+9,
                       TitBot[NumOpcion],TipoLetra,0,Tamano,TextIlum);
                  END;
          END;

          BEGIN
               {Desplegar Opciones}
               WHILE Desplegar <> ContarBot DO
                     BEGIN

                          Desplegar:=Desplegar+1;

                          EscribirSombreado
                          (BotCordX[Desplegar]+16,BotCordY[Desplegar]+9,TitBot[Desplegar],TipoLetra,0,Tamano,TextNorm,Bajo);

                          Borde
                          (BotCordX[Desplegar],BotCordY[Desplegar],
                           BotCordX[Desplegar]+TextWidth (TitBot[Desplegar])+32,
                           BotCordY[Desplegar]+TextHeight('H')+16,FondNorm,Alto);

                          EscribirSombreado
                          (BotCordX[Desplegar]+16,BotCordY[Desplegar]+9,TitBot[Desplegar],TipoLetra,0,Tamano,TextNorm,Bajo);

                      END;
               NumOpcion:=1;
               NumOpcion2:=1;

                  REPEAT

                        IF NumOpcion > ContarBot THEN NumOpcion:=1;
                        IF NumOpcion < 1 THEN NumOpcion:=ContarBot;
                        Borde
                          (BotCordX[NumOpcion2],BotCordY[NumOpcion2],
                           BotCordX[NumOpcion2]+TextWidth (TitBot[NumOpcion2])+32,
                           BotCordY[NumOpcion2]+TextHeight('H')+16,FondNorm,Alto);
                        EscribirSombreado
                          (BotCordX[NumOpcion2]+16,BotCordY[NumOpcion2]+9,TitBot[NumOpcion2],TipoLetra,0,Tamano,TextNorm,Bajo);
                        Sombrabot(Som);
                        Protector;
                        Settextstyle (TipoLetra,0,Tamano);

                        TeclaPresionar:=Readkey;

                        IF TeclaPresionar=NULO THEN
                           BEGIN
                                TeclaPresionar:=Readkey;
                                IF TeclaPresionar=SHIFTAB THEN TeclaPresionar:=ARRIBA;
                                IF (TeclaPresionar=ABAJO) OR (TeclaPresionar=DERECHA) THEN
                                    BEGIN
                                         NumOpcion2:=NumOpcion;
                                         NumOpcion:=NumOpcion+1;
                                    END;
                                  IF (TeclaPresionar=ARRIBA) OR (TeclaPresionar=IZQUIERDA) THEN
                                     BEGIN
                                          NumOpcion2:=NumOpcion;
                                          NumOpcion:=NumOpcion-1;
                                     END;
                                  IF TeclaPresionar= F1 THEN
                                     BEGIN
                                          NumOpcion:=-1;
                                          TeclaPresionar:=ENTER;
                                     END;
                                  IF TeclaPresionar= F2 THEN
                                     BEGIN
                                          NumOpcion:=-2;
                                          TeclaPresionar:=ENTER;
                                     END;
                                  IF TeclaPresionar= F3 THEN
                                     BEGIN
                                          NumOpcion:=-3;
                                          TeclaPresionar:=ENTER;
                                     END;
                                  IF TeclaPresionar= F4 THEN
                                     BEGIN
                                          NumOpcion:=-4;
                                          TeclaPresionar:=ENTER;
                                     END;
                                  IF TeclaPresionar= F10 THEN
                                     BEGIN
                                          NumOpcion:=-10;
                                          TeclaPresionar:=ENTER;
                                     END;
                                END;{Si es nulo}
                           IF TeclaPresionar=TAB THEN
                              BEGIN
                                   NumOpcion2:=NumOpcion;
                                   NumOpcion:=NumOpcion+1;
                              END;

                           IF TeclaPresionar=ESC THEN
                              BEGIN
                                   Numopcion:=0;
                                   TeclaPresionar:=ENTER;
                              END;

                  UNTIL TeclaPresionar=ENTER;
                  Resultado:=NumOpcion;
                  IF NumOpcion>0 THEN
                     BEGIN
                        Borde
                          (BotCordX[NumOpcion],BotCordY[NumOpcion],
                           BotCordX[NumOpcion]+TextWidth (TitBot[NumOpcion])+32,
                           BotCordY[NumOpcion]+TextHeight('H')+16,FondNorm,Bajo);
                        EscribirSombreado
                          (BotCordX[NumOpcion]+16,BotCordY[NumOpcion]+9,TitBot[NumOpcion],TipoLetra,0,Tamano,TextNorm,Bajo);
                        Delay (100);
                        Borde
                          (BotCordX[NumOpcion],BotCordY[NumOpcion],
                           BotCordX[NumOpcion]+TextWidth (TitBot[NumOpcion])+32,
                           BotCordY[NumOpcion]+TextHeight('H')+16,FondNorm,Alto);
                        EscribirSombreado
                          (BotCordX[NumOpcion]+16,BotCordY[NumOpcion]+9,TitBot[NumOpcion],TipoLetra,0,Tamano,TextNorm,Bajo);
                          Sombrabot(Som);
                        Delay (100);

                     END
{                  ELSE}
          END;



{*********************************************************************}
{                       OBJETO MENU GRAFICO                           }
{*********************************************************************}

PROCEDURE GrafMenu.IniGrafMnu (CordX,CordY:INTEGER);
          BEGIN
               XIni:=CordX;
               YIni:=CordY;
               ContarOpc:=0;
               Desplegar:=0;
          END;

PROCEDURE GrafMenu.AgrOpcGraf (Opcion:STRING);
          BEGIN
               IF ContarOpc>=20 THEN Exit;
               ContarOpc:=ContarOpc+1;
               OpcDesplegar[ContarOpc]:=Opcion;
          END;
PROCEDURE GrafMenu.DialogarGr (TipoLetra,TamanoLetra,
                              ColorNorm,ColorResalt,
                              FondNorm,FondResalt,Altbaj1,Altbaj2:INTEGER;
                              Var OpcionEscogida:INTEGER);
          BEGIN
          IF TipoLetra>0 THEN Cuad:=4
             ELSE Cuad:=0;
          IF TipoLetra>0 THEN Cuad2:=2
             ELSE Cuad2:=0;
          IF Lin>0 THEN Lin:=3
             ELSE Lin:=0;
          SetTextStyle (TipoLetra,0,TamanoLetra);
LargoMnuGraf:=XIni+TextWidth(OpcDesplegar[1]);
AnchoMnuGraf:=YIni+(TextHeight ('H')*(ContarOpc+1)+7);
               SetColor (ColorNorm);
Borde (XIni-2,YIni+(TextHeight(' '))-1,LargoMnuGraf,AnchoMnuGraf,FondNorm,AltBaj1);

          {Desplegar Opciones Graficas en el Monitor}

          CorY:=YIni;
          Setcolor (ColorNorm);
          WHILE Desplegar <> ContarOpc  DO
                BEGIN
                  Desplegar:=Desplegar+1;
                  EscribirSombreado
                  (XIni,CorY+TextHeight('H'),OpcDesplegar[Desplegar],TipoLetra,0,TamanoLetra,ColorNorm,Altbaj2);
                  CorY:=CorY+TextHeight('H');
                END;{Desplegar}

          OpcionNormal:=1;
          OpcionIlumi:=1;
          CordAnt:=YIni+TextHeight('H');
          CordAct:=YIni+TextHeight('H');
          REPEAT
                Setfillstyle (1,FondNorm);
                Bar (XIni+1,CordAnt+Cuad-2,LargoMnuGraf-1,CordAnt+(TextHeight('H')+Cuad2)+2);
                EscribirSombreado (XIni+1,CordAnt,OpcDesplegar[OpcionNormal],TipoLetra,0,TamanoLetra,ColorNorm,AltBaj2);
                Borde (XIni+2,CordAct+Cuad-1,LargoMnuGraf-3,CordAct+(TextHeight('H')+Cuad2)+1,FondResalt,Altbaj2);
                GrafEscribir (XIni+1,CordAct,OpcDesplegar[OpcionIlumi],TipoLetra,0,TamanoLetra,ColorResalt);
                Protector;
                Settextstyle (Tipoletra,0,Tamanoletra);
                TeclaPresionada:=Readkey;
                IF TeclaPresionada=NULO THEN
                   BEGIN
                        TeclaPresionada:=Readkey;
                        IF TeclaPresionada=ARRIBA THEN
                           BEGIN
                                CordAnt:=CordAct;
                                CordAct:=CordAct-TextHeight('H');
                                OpcionNormal:=OpcionIlumi;
                                OpcionIlumi:=OpcionIlumi-1;
                           IF CordAct <YIni+TextHeight('H') THEN
                           CordAct:=YIni+(TextHeight('H')*ContarOpc);
                           IF OpcionIlumi<1 THEN OpcionIlumi:=ContarOpc;
                           END;{Arriba}
                        IF TeclaPresionada=ABAJO THEN
                           BEGIN
                                CordAnt:=CordAct;
                                CordAct:=CordAct+TextHeight('H');
                                OpcionNormal:=OpcionIlumi;
                                OpcionIlumi:=OpcionIlumi+1;
                           IF CordAct >YIni+(TextHeight('H')*ContarOpc) THEN
                           CordAct:=YIni+(TextHeight('H'));
                           IF OpcionIlumi>ContarOpc THEN OpcionIlumi:=1;
                           END;{Abajo}
                           IF Teclapresionada= F1 THEN
                                     BEGIN
                                          OpcionIlumi:=-1;
                                          Teclapresionada:=ENTER;
                                     END;
                                  IF Teclapresionada= F2 THEN
                                     BEGIN
                                          OpcionIlumi:=-2;
                                          Teclapresionada:=ENTER;
                                     END;
                                  IF Teclapresionada= F3 THEN
                                     BEGIN
                                          OpcionIlumi:=-3;
                                          Teclapresionada:=ENTER;
                                     END;
                                  IF Teclapresionada= F4 THEN
                                     BEGIN
                                          OpcionIlumi:=-4;
                                          Teclapresionada:=ENTER;
                                     END;
                                  IF Teclapresionada= F10 THEN
                                     BEGIN
                                          OpcionIlumi:=-10;
                                          Teclapresionada:=ENTER;
                                     END;
                                  IF Teclapresionada=ALTX THEN
                                     BEGIN
                                          OpcionIlumi:=-11;
                                          TeclaPresionada:=ENTER;
                                     END;
                   END;{Si fue NULO}
                           {IF TeclaPresionada=ESC THEN
                              BEGIN
                                   OpcionIlumi:=0;
                                   TeclaPresionada:=ENTER;
                              END;}
          UNTIL TeclaPresionada=ENTER;
          OpcionEscogida:=OpcionIlumi
          END;{GrafMenuDialogar}
{----------------------------------------------------------------------}
PROCEDURE Relieve;
{----------------------------------------------------------------------}
CONST
	ARRIBA = 1;
	ABAJO = 0;
	FONDO = 7;
	SOMBRA = 8;
	LUZ   = 15;

VAR
	nivel,
	maxX,maxY,
	x,y,colorActual:Integer;

BEGIN
	maxX := GetMaxX;
	maxY := GetMaxY;
	nivel := ABAJO;
	colorActual := GetPixel(0,0);
	FOR y := 0 TO maxY DO
		FOR x:=0 TO maxX DO
			BEGIN
				IF colorActual = GetPixel(x,y)
					THEN { Si se mantiene el color actual }
						BEGIN
							IF colorActual = GetPixel(x,y+1) { al color de abajo }
								THEN PutPixel(x,y,FONDO)
								ELSE IF nivel = ABAJO
									THEN PutPixel(x,y,LUZ)
									ELSE PutPixel(x,y,SOMBRA);
						END
					ELSE { Si cambia color cambia el nivel }
						BEGIN
						colorActual := GetPixel(x,y);
						IF nivel = ABAJO
							THEN  BEGIN { Sube el nivel }
									nivel := ARRIBA;
									PutPixel(x,y,LUZ);
								  END

							ELSE BEGIN { BAja el nivel }
									nivel := ABAJO;
									PutPixel(x,y,SOMBRA);
								 END;
						END;
			END;


END;
END.{Windows}
