with TAD_Coordonnee;   use TAD_Coordonnee;
with TAD_ensemble;     use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;
with Ada.Text_IO;      use Ada.Text_IO;

package body TAD_CasPossible is

   function construireCasPossible return Type_CasPossible is
      gc : Type_CasPossible;
   begin
      for i in 1 .. 9 loop
         for j in 1 .. 9 loop
            gc (i, j) := construireEnsemble;
         end loop;
      end loop;
      return gc;
   end construireCasPossible;

   function casePossibiliteVide
     (gc : in Type_CasPossible; c : in Type_Coordonnee) return Boolean
   is
   begin
      if gc (obtenirLigne (c), obtenirColonne (c)) = construireEnsemble then
         return True;
      else
         return False;
      end if;
   end casePossibiliteVide;

   function obtenirCasPossible
     (gc : in Type_CasPossible; c : in Type_Coordonnee) return Type_Ensemble
   is
   begin
      if casePossibiliteVide (gc, c) then
         raise OBTENIR_ENSEMBLE_NUL;
      end if;
      return gc (obtenirLigne (c), obtenirColonne (c));
   end obtenirCasPossible;

   procedure fixerCasPossible
     (gc : in out Type_CasPossible; c : in Type_Coordonnee;
      e  : in     Type_Ensemble)
   is
   begin
      if not casePossibiliteVide (gc, c) then
         raise FIXER_ENSEMBLE_NON_NUL;
      end if;
      gc (obtenirLigne (c), obtenirColonne (c)) := e;
   end fixerCasPossible;

   procedure viderCasPossible
     (gc : in out Type_CasPossible; c : in out Type_Coordonnee)
   is
      ens : Type_Ensemble;
   begin
      ens := construireEnsemble;
      if casePossibiliteVide (gc, c) then
         raise VIDER_CASE_VIDE;
      end if;
      gc (obtenirLigne (c), obtenirColonne (c)) := ens;
   end viderCasPossible;

   procedure eliminerPossibiliteLigne
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer)
   is
      coord : Type_Coordonnee;
      ens   : Type_Ensemble;
   begin
      for i in 1 .. 9 loop
         coord := construireCoordonnees (i, obtenirColonne (c));
         if caseVide (g, coord) then
            if not casePossibiliteVide (gc, coord) then
               ens := obtenirCasPossible (gc, coord);
               if appartientChiffre (ens, v) then
                  retirerChiffre (ens, v);
                  viderCasPossible (gc, coord);
                  fixerCasPossible (gc, coord, ens);
               end if;
            end if;
         end if;
      end loop;
   end eliminerPossibiliteLigne;

   procedure eliminerPossibiliteColonne
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer)
   is
      coord : Type_Coordonnee;
      ens   : Type_Ensemble;
   begin
      for i in 1 .. 9 loop
         coord := construireCoordonnees (obtenirLigne (c), i);
         if caseVide (g, coord) then
            if not casePossibiliteVide (gc, coord) then
               ens := obtenirCasPossible (gc, coord);
               if appartientChiffre (ens, v) then
                  retirerChiffre (ens, v);
                  viderCasPossible (gc, coord);
                  fixerCasPossible (gc, coord, ens);
               end if;
            end if;
         end if;
      end loop;
   end eliminerPossibiliteColonne;

   procedure eliminerPossibiliteCarre
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer)
   is
      coord   : Type_Coordonnee;
      ens     : Type_Ensemble;
      ligne   : Integer;
      colonne : Integer;
   begin
      coord   := obtenirCoordonneeCarre (obtenirCarre (c));
      ligne   := obtenirLigne (coord);
      colonne := obtenirColonne (coord);
      for i in ligne .. ligne + 2 loop
         for j in colonne .. colonne + 2 loop
            coord := construireCoordonnees (i, j);
            if caseVide (g, coord) then
               if not casePossibiliteVide (gc, coord) then
                  ens := obtenirCasPossible (gc, coord);
                  if appartientChiffre (ens, v) then
                     retirerChiffre (ens, v);
                     viderCasPossible (gc, coord);
                     fixerCasPossible (gc, coord, ens);
                  end if;
               end if;
            end if;
         end loop;
      end loop;
   end eliminerPossibiliteCarre;

   procedure eliminerPossibilite
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer)
   is
   begin
      eliminerPossibiliteLigne (gc, g, c, v);
      eliminerPossibiliteColonne (gc, g, c, v);
      eliminerPossibiliteCarre (gc, g, c, v);
   end eliminerPossibilite;

end TAD_CasPossible;
