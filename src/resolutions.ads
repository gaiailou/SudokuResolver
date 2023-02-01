with TAD_Coordonnee;   use TAD_Coordonnee;
with TAD_ensemble;     use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;
with TAD_CasPossible; use TAD_CasPossible;

package resolutions is

   PLUS_DE_UN_CHIFFRE : exception;
   CASE_NON_VIDE : exception;
   ENSEMBLE_VIDE : exception;

   -- retourne VRAI si la valeur v peut rentrer dans la case c de la grille g
   -- et FAUX sinon
   -- nécessite la case c est vide
   -- lève l'exception CASE_NON_VIDE si la case n'est pas vide
   function estChiffreValable
     (g : in Type_Grille;
      v :    Integer;
      c :    Type_Coordonnee) return Boolean;

   -- retourne l'ensemble des valeurs possibles pour la case c de la grille g
   -- necessite que la case c soit vide
   -- lève l'exception CASE_NON_VIDE si la case étudiée n'est pas vide
   function obtenirSolutionsPossibles
     (g : in Type_Grille;
      c : in Type_Coordonnee) return Type_Ensemble;

   -- retourne la valeur unique de v dans le tableau resultats
   -- nécessite qu'il n'y ait qu'un seul chiffre dans resultats
   -- lève l'exception PLUS_DE_UN_CHIFFRE s'il y a plus d'un chiffre dans resultats
   -- lève l'exception ENSEMBLE_VIDE si résultat est vide
   function rechercherSolutionUniqueDansEnsemble
     (resultats : in Type_Ensemble) return Integer;

   -- si la solution a ete trouve pour la grille g, alors Trouve est a VRAI et
   -- la grille est complete
   -- sinon Trouve est a FAUX et la grille n'a aucune valeur significative
   procedure resoudreSudoku
     (g      : in out Type_Grille;
      trouve :    out Boolean;
      cpt : out Integer);

   -- Fonction r�cursive de back tracking. Utilise une grille de r�ponse g et une grille de cas possible gc
   -- Renvoie un paradoxe si arrive a une impossibilit�
   procedure doSudoku(g : in out Type_Grille;gc : in out Type_CasPossible; paradoxe : in out Boolean; cpt : in out Integer);

   -- parcours la grille et instance les possibilit� dans la grille gc
   -- place les chiffres evident
   procedure PlacerChiffreEvident(g : in out Type_Grille; changes : out Boolean; gc : in out Type_CasPossible; cpt : in out Integer);
end resolutions;
