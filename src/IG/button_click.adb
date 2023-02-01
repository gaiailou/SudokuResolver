-- bibliothèques d'entrée sortie
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
-- TAD
with TAD_Coordonnee;   use TAD_Coordonnee;
with TAD_ensemble;     use TAD_ensemble;
with TAD_grilleSudoku; use TAD_grilleSudoku;
-- Résolutions de sudoku
with affichageIG;     use affichageIG;
with resolutions;   use resolutions;
with remplirGrille; use remplirGrille;

with Gtk.Button;      use Gtk.Button;
with Gtk.Label;       use Gtk.Label;
with Gtk.Text_View;   use Gtk.Text_View;
with Gtk.Text_Buffer; use Gtk.Text_Buffer;
with Gtk.Text_Iter;   use Gtk.Text_Iter;

with run_tests_resolutionsIG;
with run_tests_TAD_CoordonneeIG;
with run_tests_TAD_EnsembleIG;
with run_tests_TAD_GrilleIG;
with run_tests_TAD_CasPossibleIG;
package body button_click is

   procedure button_clicked (Self : access Gtk_Button_Record'Class) is
      B: Gtk_Text_Buffer := Get_Buffer(TextBox);
      I: Gtk_Text_Iter ;
      F:Ada.Text_IO.File_Type;
      g      : Type_Grille;
      trouve : Boolean;
      cpt:Integer;
   begin
      Create(F,Out_File,"affichage.txt");
      Close(F);
      if self = Button1 then
         Set_Text(Label, "Run test resolution");
         Set_Text(B,"");
         run_tests_resolutionsIG;
      elsif self = Button2 then
         Set_Text(Label, "Run Test Coord");
         Set_Text(B,"");
         run_tests_TAD_CoordonneeIG;
      elsif self = Button3 then
         Set_Text(Label, "Run Test Ensemble");
         Set_Text(B,"");
         run_tests_TAD_EnsembleIG;

      elsif self = Button4 then
         Set_Text(Label, "Run Test Grille");
         Set_Text(B,"");
         run_tests_TAD_GrilleIG;
      elsif self = Button5 then
         Set_Text(Label, "Run Grille 1");
         Set_Text(B,"");
         Get_Start_Iter(B,I);
         g := grille1TresTresFacileDuNouvelAn2018;
         afficherGrille(g);
         ecrireBuffer(B,I);
         cpt:=0;
         resoudreSudoku (g, trouve,cpt);
         Forward_To_End(I);
         if trouve then
            Insert(B,I,"Grille 1 reussie avec "&integer'image(cpt)&" valeurs positionees" & ASCII.CR);
            afficherGrille(g);
         else
            Insert(B,I,"grille 1 ratee" & ASCII.CR);
         end if;
      elsif self = Button6 then
         Set_Text(Label, "Run Grille 2");
         Set_Text(B,"");
         Get_Start_Iter(B,I);
         g := grille2TresTresFacile;
         afficherGrille(g);
         ecrireBuffer(B,I);
         cpt:=0;
         resoudreSudoku (g, trouve,cpt);
         Forward_To_End(I);
         if trouve then
            Insert(B,I,"Grille 2 reussie avec " & integer'image(cpt) & " valeurs positionees" & ASCII.CR);
            afficherGrille(g);
         else
            Insert(B,I,"grille 2 ratee" & ASCII.CR);
         end if;
      elsif self = Button7 then
         Set_Text(Label, "Run Grille 4");
         Set_Text(B,"");
         Get_Start_Iter(B,I);
         g := grille4Facile;
         afficherGrille(g);
         ecrireBuffer(B,I);
         cpt:=0;
         resoudreSudoku (g, trouve,cpt);
         Forward_To_End(I);
         if trouve then
            Insert(B,I,"Grille 4 reussie avec " & integer'image(cpt) & " valeurs positionees" & ASCII.CR);
            afficherGrille(g);
         else
            Insert(B,I,"grille 4 ratee" & ASCII.CR);
         end if;
      elsif self = Button8 then
         Set_Text(Label, "Run Test Cas Possible");
         Set_Text(B,"");
         run_tests_TAD_CasPossibleIG;
      end if;
      Get_Start_Iter(B,I);
      ecrireBuffer(B,I);
   end button_clicked;

   procedure ecrireBuffer(B : in out Gtk_Text_Buffer; I : in out Gtk_Text_Iter) is
      F: File_Type;
   begin
      open(F,In_File,"affichage.txt");
      while not End_Of_File(F) loop
         Forward_To_End(I);
         Insert(B,I,Get_Line(F));
         Forward_To_End(I);
         Insert(B,I," "&ASCII.CR);
      end loop;
      close(F);
   end ecrireBuffer;

end button_click;
