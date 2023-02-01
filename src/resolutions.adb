with ada.Text_IO; use ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with TAD_Coordonnee; use TAD_Coordonnee;
with TAD_ensemble; use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;
with TAD_CasPossible; use TAD_CasPossible;

with affichage; use affichage;
package body resolutions is

   -----------------------
   -- estChiffreValable --
   -----------------------

   function estChiffreValable
     (g : in Type_Grille; v : Integer; c : Type_Coordonnee) return Boolean
   is
      col,lig,car:Type_Ensemble;
   begin
      if not caseVide (g,c) then
            return False;
      end if;
      car:=obtenirChiffresDUnCarre(g,obtenirCarre(c));
      col:=obtenirChiffresDUneColonne(g,obtenirColonne(c));
      lig:=obtenirChiffresDUneLigne(g,obtenirLigne(c));
      if appartientChiffre(col,v) or appartientChiffre(lig,v) or appartientChiffre(car,v) then
         return False;
      end if;
      return True;
   end estChiffreValable;

   -------------------------------
   -- obtenirSolutionsPossibles --
   -------------------------------

   function obtenirSolutionsPossibles
     (g : in Type_Grille; c : in Type_Coordonnee) return Type_Ensemble
   is
      e:Type_Ensemble;
   begin
      e:=construireEnsemble;
      for i in 1..9 loop
         if estChiffreValable(g, i, c) then
               ajouterChiffre(e,i);
         end if;
      end loop;
      return e;
   end obtenirSolutionsPossibles;

   ------------------------------------------
   -- rechercherSolutionUniqueDansEnsemble --
   ------------------------------------------

   function rechercherSolutionUniqueDansEnsemble
     (resultats : in Type_Ensemble) return Integer
   is
   begin
      if nombreChiffres(resultats)>1 then
         raise PLUS_DE_UN_CHIFFRE;
      elsif nombreChiffres(resultats)=0 then
         raise ENSEMBLE_VIDE;
      else
         for i in 1..9 loop
            if appartientChiffre(resultats, i) then
               return i;
            end if;
         end loop;
      end if;

      return 0;
   end rechercherSolutionUniqueDansEnsemble;


   procedure doSudoku(g : in out Type_Grille; gc : in out Type_CasPossible; paradoxe : in out Boolean; cpt : in out Integer) is
      coord:Type_Coordonnee;
      ens:Type_Ensemble;
      k,i,j:Integer;
      gc2 : Type_CasPossible;
      g2:Type_Grille;
   begin
      paradoxe:=False;
      while not paradoxe and not estRemplie(g) loop
         i:=1;
         while i<=9 and not paradoxe loop
            j:=1;
            while j<=9 and not paradoxe loop
               coord:=construireCoordonnees(i,j);
               if caseVide(g,coord) then
                  if not casePossibiliteVide(gc,coord) then
                     ens:=obtenirCasPossible(gc,coord);
                     if nombreChiffres(ens)=1 then
                        fixerChiffre(g,coord,rechercherSolutionUniqueDansEnsemble(ens),cpt);
                        eliminerPossibilite(gc,g,coord,rechercherSolutionUniqueDansEnsemble(ens));
                     elsif nombreChiffres(ens)>1 then
                        k:=1;
                        paradoxe:=True;
                        while paradoxe and k<=nombreChiffres(ens) loop
                           g2:=g;
                           gc2:=gc;
                           fixerChiffre(g2,coord,iemeChiffre(ens,k),cpt);
                           eliminerPossibilite(gc2,g2,coord,iemeChiffre(ens,k));
                           doSudoku(g2,gc2,paradoxe,cpt);
                           k:=k+1;
                        end loop;
                        if not paradoxe then
                           g:=g2;
                           gc:=gc2;
                        end if;
                     end if;
                  else
                   paradoxe:=True;
                  end if;
               end if;
               j:=j+1;
            end loop;
            i:=i+1;
         end loop;
      end loop;
   end doSudoku;


   procedure PlacerChiffreEvident(g : in out Type_Grille; changes : out Boolean; gc : in out Type_CasPossible; cpt : in out Integer) is
      ens: Type_Ensemble;
      coord: Type_Coordonnee;
   begin
      changes:=True;
      while not estRemplie(g) and changes loop
         changes:=False;
         for i in 1..9 loop
            for j in 1..9 loop
               coord:=construireCoordonnees(i,j);
               if caseVide(g,coord) then
                  if casePossibiliteVide(gc,coord) then
                     ens:=obtenirSolutionsPossibles(g,coord);
                  else
                     ens:=obtenirCasPossible(gc,coord);
                  end if;
                  if nombreChiffres(ens)=1 then
                     fixerChiffre(g,coord,rechercherSolutionUniqueDansEnsemble(ens),cpt);
                     eliminerPossibilite(gc,g,coord,rechercherSolutionUniqueDansEnsemble(ens));
                     if not casePossibiliteVide(gc,coord) then
                        viderCasPossible(gc,coord);
                     end if;
                     fixerCasPossible(gc,coord,ens);
                     changes:=True;
                  else
                     if not casePossibiliteVide(gc,coord) then
                        viderCasPossible(gc,coord);
                     end if;
                     fixerCasPossible(gc,coord,ens);
                  end if;
               else
                  if casePossibiliteVide(gc,coord) then
                     ens:=construireEnsemble;
                     ajouterChiffre(ens,obtenirChiffre(g,coord));
                     fixerCasPossible(gc,coord,ens);
                  end if;
               end if;
            end loop;
         end loop;
      end loop;
   end PlacerChiffreEvident;

   --------------------
   -- resoudreSudoku --
   --------------------

   procedure resoudreSudoku(g: in out Type_Grille; trouve: out Boolean;cpt : out Integer) is
      changes,paradoxe:Boolean;
      gc:Type_CasPossible;
   begin
      cpt:=0;
      gc:=construireCasPossible;
      PlacerChiffreEvident(g,changes,gc,cpt);
      if changes then
         trouve:=True;
      else
         paradoxe:=False;
         doSudoku(g,gc,paradoxe,cpt);
         if paradoxe then
            trouve:=False;
         else
            trouve:=True;
         end if;
      end if;
   end resoudreSudoku;

end resolutions;
