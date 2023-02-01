with tests_TAD_Grille; use tests_TAD_Grille;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure run_Tests_TAD_GrilleIG is
   F : File_Type;
begin
   Open(F,Append_File,"affichage.txt");
   -- execution automatique des tests pour le TAD GrillesSudoku
   Put_Line(F,"***** Tests TAD Grille");
   for i in tests_TAD_Grille.les_Tests'Range loop
      put(F,"test ");
      put(F,i,0);
      tests_TAD_Grille.resultats(i) := tests_TAD_Grille.les_Tests(i).function_Of_Test.all;
      Put_Line (F," passé");
   end loop;
   -- affichage des resultats
   if (for all i in tests_TAD_Grille.resultats'Range => tests_TAD_Grille.resultats(i)) then
      put_line (F,"Tous les tests OK");
   else
      put_line (F,"***** ATTENTION *****");
      for i in tests_TAD_Grille.resultats'Range loop
         if not tests_TAD_Grille.resultats(i) then
            put_line (F,to_String(tests_TAD_Grille.les_Tests(i).error_Test));
         end if;
      end loop;
   end if;
   Close(F);
end run_Tests_TAD_GrilleIG;
