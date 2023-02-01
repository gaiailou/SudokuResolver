-- bibliothèques d'entrée sortie
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
-- TAD
with TAD_Coordonnee;   use TAD_Coordonnee;
with TAD_ensemble;     use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;
with TAD_CasPossible;  use TAD_CasPossible;
with affichage;        use affichage;

package body tests_TAD_CasPossible is

   ------------------
   -- Tests Grille --
   ------------------

   -- creation grille
   -- verification cases vides
   function test_Grille_P1 return Boolean is
      gc : Type_CasPossible;
      c : Type_Coordonnee;
   begin
      gc := construireCasPossible;
      for i in 1 .. 9 loop
         for j in 1 .. 9 loop
            c := construireCoordonnees (i, j);
            if (not casePossibiliteVide (gc, c)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   exception
      when others =>
         return False;
   end test_Grille_P1;

   -- creation grille
   -- verification lignes vides
   function test_Grille_P2 return Boolean is
      gc     : Type_CasPossible;
   begin
      gc := construireCasPossible;
      for i in 1 .. 9 loop
         if not casePossibiliteVide(gc,construireCoordonnees(i,1)) then
            return False;
         end if;
      end loop;
      return True;
   exception
      when others =>
         return False;
   end test_Grille_P2;

   -- creation grille
   -- verification colonnes vides
   function test_Grille_P3 return Boolean is
      gc     : Type_CasPossible;
   begin
      gc := construireCasPossible;
      for i in 1 .. 9 loop
         if not casePossibiliteVide(gc,construireCoordonnees(1,i)) then
            return False;
         end if;
      end loop;
      return True;
   exception
      when others =>
         return False;
   end test_Grille_P3;

   -- FixerChiffre
   -- case remplie devient non vide
   function test_Grille_P4 return Boolean is
      gc : Type_CasPossible;
      c : Type_Coordonnee;
      ens: Type_Ensemble;
   begin
      ens:=construireEnsemble;
      gc := construireCasPossible;
      c := construireCoordonnees (9, 9);
      ajouterChiffre(ens,8);
      fixerCasPossible (gc, c, ens);
      return not casePossibiliteVide (gc, c);
   exception
      when others =>
         return False;
   end test_Grille_P4;

   -- FixerChiffre
   -- autres cases non remplies restent vide
   function test_Grille_P5 return Boolean is
      gc  : Type_CasPossible;
      c1 : Type_Coordonnee;
      c2 : Type_Coordonnee;
      ens: Type_Ensemble;
   begin
      ens:=construireEnsemble;
      ajouterChiffre(ens,8);
      gc  := construireCasPossible;
      c1 := construireCoordonnees (9, 9);
      fixerCasPossible (gc, c1, ens);
      for i in 1 .. 9 loop
         for j in 1 .. 9 loop
            c2 := construireCoordonnees (i, j);
            if c2 /= c1 and not casePossibiliteVide (gc, c2) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   exception
      when others =>
         return False;
   end test_Grille_P5;

   -- FixerChiffre
   -- case remplie retourne la valeur entree
   function test_Grille_P6 return Boolean is
      gc : Type_CasPossible;
      c : Type_Coordonnee;
      ens : Type_Ensemble;
   begin
      ens:=construireEnsemble;
      ajouterChiffre(ens,8);
      gc := construireCasPossible;
      c := construireCoordonnees (9, 9);
      fixerCasPossible (gc, c, ens);
      return obtenirCasPossible (gc, c) = ens;
   exception
      when others =>
         return False;
   end test_Grille_P6;

   function test_Grille_P7 return Boolean is
      gc : Type_CasPossible;
      c : Type_Coordonnee;
      ens : Type_Ensemble;
   begin
      gc:=construireCasPossible;
      ens:=construireEnsemble;
      ajouterChiffre(ens,8);
      c:=construireCoordonnees(9,9);
      fixerCasPossible(gc,c,ens);
      viderCasPossible(gc,c);
      if casePossibiliteVide(gc,c) then
         return True;
      end if;
      return False;
   end test_Grille_P7;

   function test_Grille_P8 return Boolean is
      gc:Type_CasPossible;
      c:Type_Coordonnee;
      ens:Type_Ensemble;
      g:Type_Grille;
      c2:Type_Coordonnee;
   begin
      c2:=construireCoordonnees(9,9);
      g:=construireGrille;
      gc:=construireCasPossible;
      ens:=construireEnsemble;
      ajouterChiffre(ens,8);
      for i in 1..9 loop
         for j in 1..9 loop
            c:=construireCoordonnees(i,j);
            fixerCasPossible(gc,c,ens);
         end loop;
      end loop;
      eliminerPossibilite(gc,g,c2,8);
      for i in 1..9 loop
         for j in 1..9 loop
            c:=construireCoordonnees(i,j);
            if casePossibiliteVide(gc,c) and not ( obtenirCarre(c)=obtenirCarre(c2) or obtenirColonne(c)=obtenirColonne(c2) or obtenirLigne(c)=obtenirLigne(c2) ) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end test_Grille_P8;


end tests_TAD_CasPossible;
