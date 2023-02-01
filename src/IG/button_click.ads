with Gtk.Button;  use Gtk.Button;
with Gtk.Label;       use Gtk.Label;
with Gtk.Text_View;   use Gtk.Text_View;
with Gtk.Menu_Item;   use Gtk.Menu_Item;
with Gtk.Menu_Button; use Gtk.Menu_Button;
with Gtk.Text_Buffer; use Gtk.Text_Buffer;
with Gtk.Text_Iter;   use Gtk.Text_Iter;

package button_click is

   Button1: Gtk_Button;
   Button2: Gtk_Button;
   Button3: Gtk_Button;
   Button4: Gtk_Button;
   Button5: Gtk_Button;
   Button6: Gtk_Button;
   Button7: Gtk_Button;
   Button8: Gtk_Button;

   TextBox: Gtk_Text_View;
   Label : Gtk_Label;
   --Procedure appelé lors du clic d'un bouton
   --Effectue les actions a faire en fonction de chaque bouton
   procedure button_clicked (Self : access Gtk_Button_Record'Class);

   --Ecris le texte contenu dans le fichier affiche.txt dans le buffer a afficher a l'ecran
   procedure ecrireBuffer(B : in out Gtk_Text_Buffer; I : in out Gtk_Text_Iter);

end button_click;
