{
  Libreria para el uso de la impresora.

  Copyrigth (c), 1994-1996 PackSoft
  Autor:  Geronimo Orozco Martinez
  Version 1.0
  Ultima actualizacion: Mayo 22 de 1996
  Este es codigo GNU/GPL
}

UNIT Impresora;
INTERFACE
USES Printer;
FUNCTION ImpresoraLista:Boolean;
PROCEDURE ImpresoraAvancePagina;
PROCEDURE ImpresoraDesComprimido;
PROCEDURE ImpresoraComprimido;
PROCEDURE ImpresoraDesdoblepasada;
PROCEDURE Impresoradoblepasada;
PROCEDURE ImpresoraDesEnfatizado;
PROCEDURE ImpresoraEnfatizado;
PROCEDURE ImpresoraDesExpandido;
PROCEDURE ImpresoraExpandido;
PROCEDURE ImpresoraDesItalica;
PROCEDURE ImpresoraItalica;
PROCEDURE ImpresoraDessubindice;
PROCEDURE Impresorasubindice;
PROCEDURE ImpresoraDesSuperindice;
PROCEDURE ImpresoraSuperindice;
PROCEDURE ImpresoraDesSubrayado;
PROCEDURE ImpresoraSubrayado;

IMPLEMENTATION
FUNCTION ImpresoraLista:Boolean;
         BEGIN
         {$I-}
         Write (Lst,#0);
         {$I+}
         ImpresoraLista:=(IOResult=0);
         END;{Impresora Lista}
PROCEDURE ImpresoraAvancePagina;
          BEGIN
               Write (lst,#12);
          END;{Avance pagina}

PROCEDURE ImpresoraDesComprimido;
          BEGIN
               Write (LST,Chr(18));
          END;
PROCEDURE ImpresoraComprimido;
          BEGIN
               Write (LST,Chr(15));
          END;

PROCEDURE ImpresoraDesDoblepasada;
          BEGIN
               Write (LST,Chr(27),Chr(72));
          END;
PROCEDURE ImpresoraDoblepasada;
          BEGIN
               Write (LST,Chr(27),Chr(71));
          END;

PROCEDURE ImpresoraDesEnfatizado;
          BEGIN
               Write (LST,CHR(27),Chr(70));
          END;
PROCEDURE ImpresoraEnfatizado;
          BEGIN
               Write (LST,CHR(27),Chr(69));
          END;

PROCEDURE ImpresoraDesExpandido;
          BEGIN
               Write (LST,Chr(27),Chr(20));
          END;
PROCEDURE ImpresoraExpandido;
          BEGIN
                Write (LST,Chr(27),Chr(14));
          END;

PROCEDURE ImpresoraDesItalica;
          BEGIN
               Write (LST,Chr(27),Chr(53));
          END;
PROCEDURE ImpresoraItalica;
          BEGIN
               Write (LST,Chr(27),Chr(54));
          END;

PROCEDURE ImpresoraDessubindice;
          BEGIN
               Write (LST,Chr(21),Chr(84));
          END;
PROCEDURE Impresorasubindice;
          BEGIN
               Write (LST,Chr(27),Chr(15));
          END;

PROCEDURE ImpresoraDessuperindice;
          BEGIN
               Write (LST,Chr(27),Chr(84));
          END;
PROCEDURE Impresorasuperindice;
          BEGIN
               Write (LST,Chr(27),Chr(14));
          END;

PROCEDURE ImpresoraDesSubrayado;
          BEGIN
               Write (LST,Chr(27),Chr(45),Chr(0));
          END;
PROCEDURE ImpresoraSubrayado;
          BEGIN
               Write (LST,Chr(27),Chr(45));
          END;





END.
