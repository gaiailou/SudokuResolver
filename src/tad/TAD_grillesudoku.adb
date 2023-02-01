pragma Ada_2012;
with TAD_Coordonnee; use TAD_Coordonnee;
with TAD_ensemble; use TAD_ensemble;
package body TAD_grilleSudoku is

   ----------------------
   -- construireGrille --
   ----------------------

   function construireGrille return Type_Grille
   is
      g : Type_Grille; --grille
   begin
      for i in 1..9 loop
         for j in 1..9 loop
           g(i,j):= 0;
         end loop;
      end loop;
      return g;
   end construireGrille;

   --------------
   -- caseVide --
   --------------

   function caseVide
     (g : in Type_Grille; c : in Type_Coordonnee) return boolean
   is
   begin
      if g(obtenirLigne(c),obtenirColonne(c)) = 0 then
         return True ;
      else
         return False;
      end if;
   end caseVide;

   --------------------
   -- obtenirChiffre --
   --------------------

   function obtenirChiffre
     (g : in Type_Grille; c : in Type_Coordonnee) return integer
   is
   begin
      if caseVide(g,c) then
         raise OBTENIR_CHIFFRE_NUL;
      end if ;
      return g(obtenirLigne(c),obtenirColonne(c));
   end obtenirChiffre;

   --------------------
   -- nombreChiffres --
   --------------------

   function nombreChiffres (g : in Type_Grille) return integer
   is
      co:Type_Coordonnee; --coordonnée
      c1: integer; --compteur de chiffre deja place
      begin
      c1:= 0;
      for i in 1..9 loop
         for j in 1..9 loop
            co:=construireCoordonnees(i,j);
              if not caseVide(g,co) then
                 c1 := c1 +1 ;
              end if;
         end loop;
      end loop;
      return c1;
   end nombreChiffres;

   ------------------
   -- fixerChiffre --
   ------------------

   procedure fixerChiffre
     (g : in out Type_Grille; c : in Type_Coordonnee; v : in integer; cpt : in out Integer)
   is
   begin
      if not caseVide(g,c) then
         raise FIXER_CHIFFRE_NON_NUL;
      end if;
      g(obtenirLigne(c),obtenirColonne(c)):= v;
      cpt:=cpt+1;
   end fixerChiffre;

   ---------------
   -- viderCase --
   ---------------

   procedure viderCase (g : in out Type_Grille; c : in out Type_Coordonnee)
   is
   begin
      if caseVide(g,c) then
         raise VIDER_CASE_VIDE;
      end if;
      g(obtenirLigne(c),obtenirColonne(c)):=0;
   end viderCase;

   ----------------
   -- estRemplie --
   ----------------

   function estRemplie (g : in Type_Grille) return Boolean
   is
      c:Type_Coordonnee; --coordonnees
   begin
      for i in 1..9 loop
         for j in 1..9 loop
            c:=construireCoordonnees(i,j);
              if caseVide(g,c) then
                  return false;
              end if;
         end loop;
      end loop;
      return true;
   end estRemplie;

   ------------------------------
   -- obtenirChiffresDUneLigne --
   ------------------------------

   function obtenirChiffresDUneLigne
     (g : in Type_Grille; numLigne : in Integer) return Type_Ensemble
   is
      Ens:Type_Ensemble; --ensemble des chiffres present dans la ligne
      c:Type_Coordonnee; --coordonnees
   begin
      Ens:=construireEnsemble;
      for i in 1..9 loop
         c:=construireCoordonnees(numLigne,i);
         if not caseVide(g,c) then
            ajouterChiffre(Ens,obtenirChiffre(g,c));
         end if;
      end loop;
      return Ens;
   end obtenirChiffresDUneLigne;

   --------------------------------
   -- obtenirChiffresDUneColonne --
   --------------------------------

   function obtenirChiffresDUneColonne
     (g : in Type_Grille; numColonne : in Integer) return Type_Ensemble
   is
      Ens:Type_Ensemble; --ensemble des chiffres present dans la colonne
      c:Type_Coordonnee; --coordonnees
   begin
      Ens:=construireEnsemble;
      for i in 1..9 loop
         c:=construireCoordonnees(i,numColonne);
         if not caseVide(g,c) then
            ajouterChiffre(Ens,obtenirChiffre(g,c));
         end if;
      end loop;
      return Ens;
   end obtenirChiffresDUneColonne;

   -----------------------------
   -- obtenirChiffresDUnCarre --
   -----------------------------

   function obtenirChiffresDUnCarre
     (g : in Type_Grille; numCarre : in Integer) return Type_Ensemble
   is
      Ens:Type_Ensemble; --ensemble des chiffres present dans le carre
      c:Type_Coordonnee; --coordonnees
      ligne: Integer; --numero de la ligne
      colonne: Integer; --numero de colonne
   begin
      Ens:=construireEnsemble;
      ligne:= obtenirLigne(obtenirCoordonneeCarre(numCarre));
      colonne:= obtenirColonne(obtenirCoordonneeCarre(numCarre));
      for i in colonne..colonne+2 loop
         for j in ligne..ligne+2 loop
            c:=construireCoordonnees(j,i);
            if not caseVide(g,c) then
               ajouterChiffre(Ens,obtenirChiffre(g,c));
            end if;
          end loop;
      end loop;
      return Ens;
   end obtenirChiffresDUnCarre;

end TAD_grilleSudoku;
