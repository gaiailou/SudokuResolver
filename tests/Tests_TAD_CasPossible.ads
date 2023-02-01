with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with tests;                 use tests;

package tests_TAD_CasPossible is

   -- tests TAD GrillesSudoku
   function test_Grille_P1 return Boolean;
   function test_Grille_P2 return Boolean;
   function test_Grille_P3 return Boolean;
   function test_Grille_P4 return Boolean;
   function test_Grille_P5 return Boolean;
   function test_Grille_P6 return Boolean;
   function test_Grille_P7 return Boolean;
   function test_Grille_P8 return Boolean;

   les_Tests : constant array (Positive range <>) of Test_Unitaire :=
     ((test_Grille_P1'Access,
       To_Unbounded_String ("echec de la propriete 1 Grille")),
      (test_Grille_P2'Access,
       To_Unbounded_String ("echec de la propriete 2 Grille")),
      (test_Grille_P3'Access,
       To_Unbounded_String ("echec de la propriete 3 Grille")),
      (test_Grille_P4'Access,
       To_Unbounded_String ("echec de la propriete 4 Grille")),
      (test_Grille_P5'Access,
       To_Unbounded_String ("echec de la propriete 5 Grille")),
      (test_Grille_P6'Access,
       To_Unbounded_String ("echec de la propriete 6 Grille")),
      (test_Grille_P7'Access,
       To_Unbounded_String ("echec de la propriete 7 Grille")),
     (test_Grille_P8'Access,
       To_Unbounded_String ("echec de la propriete 8 Grille")));

   resultats : array (les_Tests'Range) of Boolean;

end tests_TAD_CasPossible;
