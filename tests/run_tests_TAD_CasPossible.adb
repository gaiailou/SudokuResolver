with tests_TAD_CasPossible; use tests_TAD_CasPossible;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure run_tests_TAD_CasPossible is
begin
   -- execution automatique des tests pour le TAD CasPossible
   Put_Line("***** Tests TAD CasPossible");
   for i in tests_TAD_CasPossible.les_Tests'Range loop
      put("test ");
      put(i,0);
      tests_TAD_CasPossible.resultats(i) := tests_TAD_CasPossible.les_Tests(i).function_Of_Test.all;
      Put_Line (" passé");
   end loop;
   -- affichage des resultats
   if (for all i in tests_TAD_CasPossible.resultats'Range => tests_TAD_CasPossible.resultats(i)) then
      put_line ("Tous les tests OK");
   else
      put_line ("***** ATTENTION *****");
      for i in tests_TAD_CasPossible.resultats'Range loop
         if not tests_TAD_CasPossible.resultats(i) then
            put_line (to_String(tests_TAD_CasPossible.les_Tests(i).error_Test));
         end if;
      end loop;
   end if;

end run_tests_TAD_CasPossible;
