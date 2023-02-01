pragma Ada_2012;
package body TAD_Coordonnee is

   ----------------------------
   -- construireCoordonnnees --
   ----------------------------
   function construireCoordonnees
     (ligne : Integer; colonne : Integer) return Type_Coordonnee is
     c : Type_Coordonnee;
   begin
      C.ligne   := ligne ;
      c.colonne := colonne ;
      return c ;
   end construireCoordonnees;

   ------------------
   -- obtenirLigne --
   ------------------
   function obtenirLigne (c : Type_Coordonnee) return Integer is
   begin
     return c.ligne;
   end obtenirLigne;

   --------------------
   -- obtenirColonne --
   --------------------
   function obtenirColonne (c : Type_Coordonnee) return Integer is
   begin
      return C.colonne;
   end obtenirColonne;

   ------------------
   -- obtenirCarre --
   ------------------
   function obtenirCarre (c : Type_Coordonnee) return Integer is
   begin
      return (3*((c.ligne-1)/3)+(c.colonne-1)/3)+1;
   end obtenirCarre;

   ----------------------------
   -- obtenirCoordonneeCarre --
   ----------------------------
  function obtenirCoordonneeCarre
     (numCarre : Integer) return Type_Coordonnee is
      c:Type_Coordonnee;
      ligne:Tab_Entiers:=(1,1,1,4,4,4,7,7,7);
      colonne:Tab_Entiers:=(1,4,7,1,4,7,1,4,7);
  begin
      c.ligne   := ligne(numCarre);
      c.colonne := colonne(numCarre);
      return c;
   end obtenirCoordonneeCarre;
end TAD_Coordonnee;
