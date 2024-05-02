{
  Libreria para usar los tipos de monitores un programa de Turbo Pascal 7.0
  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.0
  Ultima actualizacion: Mayo 22 de 1996
  Este es codigo GNU/GPL
}

unit Monitores;
interface

procedure MonitorEGAVGA;
procedure MonitorHERC;

implementation

procedure MonitorEGAVGA; external;
{$L EGAVGA.OBJ }

procedure MonitorHERC; external;
{$L HERC.OBJ }

end.
