with TAD_Coordonnee;   use TAD_Coordonnee;
with TAD_ensemble;     use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;

package TAD_CasPossible is

   type Type_CasPossible is private;

   FIXER_ENSEMBLE_NON_NUL : exception;
   OBTENIR_ENSEMBLE_NUL   : exception;

   -- cree une grille casPossible d'ensemble vide
   function construireCasPossible return Type_CasPossible;

   -- retourne VRAI si la case de coordonnee c de la grille casPossible gc est vide
   -- et FAUX sinon
   function casePossibiliteVide
     (gc : in Type_CasPossible; c : in Type_Coordonnee) return Boolean;

-- retourne l'ensemble de la case de coordonnee c de la grille casPossible gc
-- necessite la case c n'est pas vide
-- leve l'exception OBTENIR_ENSEMBLE_NUL si la case c est vide
   function obtenirCasPossible
     (gc : in Type_CasPossible; c : in Type_Coordonnee) return Type_Ensemble;

   -- positionne l'ensemble e de la case de coordonnee c de la grille casPossible gc
   -- necessite que la case c soit vide
   -- leve l'exception FIXER_ENSEMBLE_NON_NUL si la case est vide
   procedure fixerCasPossible
     (gc : in out Type_CasPossible; c : in Type_Coordonnee;
      e  : in     Type_Ensemble);

   -- vide la case de coordonnee c de la grille gc de cas possibles
   -- necessite que la case c ne soit pas vide
   -- leve l'exception VIDER_CASE_VIDE si c est vide
   procedure viderCasPossible
     (gc : in out Type_CasPossible; c : in out Type_Coordonnee);

   -- elimine la valeur v de chaque case de coordonnees c de la ligne de la grille gc
   -- si la grille g est vide et la case de la grille casPossible gc ne soit pas vide
   procedure eliminerPossibiliteLigne
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer);

   -- elimine la valeur v de chaque case de coordonnees c de la colonne de la grille gc
   -- si la grille g est vide et la case de la grille casPossible gc ne soit pas vide
   procedure eliminerPossibiliteColonne
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer);

   -- elimine la valeur v de chaque case de coordonnees c du carre de la grille gc
   -- si la grille g est vide et la case de la grille casPossible gc ne soit pas vide
   procedure eliminerPossibiliteCarre
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer);

   -- elimine la valeur v de chaque case de coordonnees c, de la ligne, de la colonne
   -- et du carre de la grille gc
   -- si la grille g est vide et la case de la grille casPossible gc ne soit pas vide
   procedure eliminerPossibilite
     (gc : in out Type_CasPossible; g : in Type_Grille; c : in Type_Coordonnee;
      v  : in     Integer);

private
   type Type_CasPossible is array (1 .. 9, 1 .. 9) of Type_Ensemble;

end TAD_CasPossible;
