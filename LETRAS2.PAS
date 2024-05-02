{
  Segunda parte de la Libreria para usar las letras en un
  programa de Turbo Pascal 7.0
  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.0
  Ultima actualizacion: Mayo 22 de 1996
  Este es codigo GNU/GPL
}

UNIT LETRAS2;

INTERFACE

procedure LetraEURO;
procedure LetraLCOM;
procedure LetraTSCR;
procedure LetraSCRI;
procedure LetraSIMP;

IMPLEMENTATION

PROCEDURE LetraEURO; external;
{$L EURO.OBJ}

PROCEDURE LetraLCOM; external;
{$L LCOM.OBJ}

PROCEDURE LetraTSCR; external;
{$L TSCR.OBJ}

PROCEDURE LetraSCRI; external;
{$L SCRI.OBJ}

PROCEDURE LetraSIMP; external;
{$L SIMP.OBJ}

END.
