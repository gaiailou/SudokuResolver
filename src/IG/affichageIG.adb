with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body affichageIG is

   --------------------
   -- afficherValeur --
   --------------------

   -- affiche la valeur de la case v sur NB_POSITIONS
   procedure afficherValeur (v : in Integer; F : File_Type) is
   begin
      Put (F,v, NB_POSITIONS);
   end afficherValeur;

   ------------------
   -- afficherCase --
   ------------------

   procedure afficherCase (g : in Type_Grille; c : in Type_Coordonnee; F : in File_Type) is
      valeur : Integer;
   begin
      if caseVide (g, c) then
	 valeur := 0;
      else
	 valeur := obtenirChiffre (g, c);
      end if;
      afficherValeur (valeur,F);
   end afficherCase;

   ----------------------
   -- afficherEnsemble --
   ----------------------

   procedure afficherEnsemble (e : in Type_Ensemble; F : File_Type) is
   begin
      for i in 1 .. 9 loop
	 if appartientChiffre (e, i) then
	    afficherValeur (i,F);
	 else
	    afficherValeur (NUL,F);
	 end if;
      end loop;
      New_Line(F);
   end afficherEnsemble;

   --------------------
   -- afficherGrille --
   --------------------

   procedure afficherLigne(F: in File_Type) is
   begin
      Put (F,"      ");
      for k in 1 .. NB_POSITIONS loop
	 for l in 1 .. 9 loop
	    Put (F,"-");
	 end loop;
      end loop;
      New_Line(F);
   end afficherLigne;

   procedure afficherGrille (g : in Type_Grille) is
      c : Type_Coordonnee;
      F: Ada.Text_IO.File_Type;
   begin
      Create(F,Append_File,"affichage.txt");

      New_Line(F);
      afficherLigne(F);
      for i in 1 .. 9 loop
	 Put (F," |");
	 for j in 1 .. 9 loop
	    c := construireCoordonnees (i, j);
	    afficherCase (g, c, F);
	    if j mod 3 = 0 then
	       Put (F," |");
	    end if;
	 end loop;
	 New_Line(F);
	 if i mod 3 = 0 then
	    afficherLigne(F);
	 end if;
      end loop;
      New_Line(F);
      Close(F);
   end afficherGrille;

   ----------------------
   -- afficherResultat --
   ----------------------

   procedure afficherResultat
     (g                : in Type_Grille;
      trouve           : in Boolean;
      nbChiffresDepart : in Integer)
   is
   begin
      if trouve then
	 Put_Line ("Sudoku résolu");
      else
	 Put_Line ("Resultat non trouve");
	 Put ("Nombre de chiffres trouves : ");
	 Put (nombreChiffres (g) - nbChiffresDepart, 0);
	 Put_Line (" sur 81");
      end if;
      afficherGrille (g);
   end afficherResultat;

end affichageIG;
