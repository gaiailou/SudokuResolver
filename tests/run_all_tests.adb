with run_Tests_TAD_Coordonnee;
with run_Tests_TAD_Ensemble;
with run_Tests_TAD_Grille;
with run_Tests_Resolutions;
with run_tests_TAD_CasPossible;

procedure run_All_Tests is
begin
   -- execution automatique de tous les tests
   run_Tests_TAD_Coordonnee;
   run_Tests_TAD_Ensemble;
   run_Tests_TAD_Grille;
   run_Tests_Resolutions;
   run_tests_TAD_CasPossible;
end run_All_Tests;
