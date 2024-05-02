{
  Libreria para agregar los archivos de monitores y letras al codigo de un programa
  que use Graficos en Turbo Pascal 7.0

  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.0
  Ultima actualizacion: Mayo 22 de 1996

  Este es codigo GNU/GPL
}

UNIT BGICHR;
INTERFACE
USES Graph,Monitores,Letras1,Letras2;

PROCEDURE EncuentranBGICHR;

IMPLEMENTATION

{****************************************}
   PROCEDURE EncuentranBGICHR;
{****************************************}
PROCEDURE Salir(Msg:STRING);
          BEGIN
               Writeln (Msg, ': ',GraphErrorMsg(GraphResult));
               Halt(1);
          END;
     BEGIN
          { Si se encuentran registrados monitores }
          IF RegisterBGIdriver (@MonitorHERC) <0 THEN
             Salir ('HERC');
          IF RegisterBGIdriver (@MonitorEGAVGA) <0 THEN
             Salir ('EGAVGA');
          { Si se encuentran registradas letras }
          IF RegisterBGIfont (@LetraTRIP) <0 THEN
             Salir ('TRIP');
          IF RegisterBGIfont (@LetraLITT) <0 THEN
             Salir ('LITT');
          IF RegisterBGIfont (@LetraSANS) <0 THEN
             Salir ('SANS');
          IF RegisterBGIfont (@LetraBOLD) <0 THEN
             Salir ('BOLD');
          IF RegisterBGIfont (@LetraLCOM) <0 THEN
             Salir ('LCOM');
          IF RegisterBGIfont (@LetraSCRI) <0 THEN
             Salir ('SCRI');
          IF RegisterBGIfont (@LetraSIMP) <0 THEN
             Salir ('SIMP');
          IF RegisterBGIfont (@LetraTSCR) <0 THEN
             Salir ('TSCR');
          IF RegisterBGIfont (@LetraEURO) <0 THEN
             Salir ('EURO');
     END;
END.
