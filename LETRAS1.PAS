
{
  Libreria para usar las letras en un programa de Turbo Pascal 7.0
  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.0
  Ultima actualizacion: Mayo 22 de 1996
  Este es codigo GNU/GPL
}

unit Letras1;

interface

procedure LetraSANS;
procedure LetraLITT;
procedure LetraTRIP;
procedure LetraBOLD;



implementation


procedure LetraSANS; external;
{$L SANS.OBJ }

procedure LetraLITT; external;
{$L LITT.OBJ }

procedure LetraTRIP; external;
{$L TRIP.OBJ }

PROCEDURE LetraBOLD; external;
{$L BOLD.OBJ}

end.
