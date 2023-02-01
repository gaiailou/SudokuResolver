with Gdk.Event;       use Gdk.Event;

with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Window;      use Gtk.Window;
with Gtk.Button;      use Gtk.Button;
with Gtk.Grid;        use Gtk.Grid;
with gtk.Text_View;   use Gtk.Text_View;
with Gtk.Menu;        use Gtk.Menu;
with Gtk.Menu_Bar;    use Gtk.Menu_Bar;
with Gtk.Menu_Button; use Gtk.Menu_Button;
with Gtk.Menu_Item;   use Gtk.Menu_Item;
with button_click; use button_click;
procedure Main is

   Win   : Gtk_Window;
   Box   : Gtk_Vbox;
   Grid  : Gtk_Grid;
   space, space2 : Gtk_Label;

   function Delete_Event_Cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return Boolean;

   ---------------------
   -- Delete_Event_Cb --
   ---------------------

   function Delete_Event_Cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return Boolean
   is
      pragma Unreferenced (Self, Event);
   begin
      Gtk.Main.Main_Quit;
      return True;
   end Delete_Event_Cb;

begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   --  Create a window with a size of 500x500
   Gtk_New (Win);
   Win.Set_Title("Resolution Sudoku");
   Win.Set_Border_Width(50);
   Win.Set_Default_Size (500,500);
   Set_Resizable(Win,False);
   --Fullscreen(Win);
   --  Create a box to organize vertically the contents of the window
   Gtk_New_Vbox (Box);
   Win.Add (Box);
   --  Add a label
   Gtk_New (button_click.Label, "Menu");
   Box.Add (button_click.Label);
   -- Add a Grid
   Gtk_New (Grid);
   Set_Column_Homogeneous(Grid,True);
   Set_Row_Spacing(Grid,5);
   Box.Add (Grid);
   -- Add TextBox
   Gtk_New (button_click.TextBox);
   Grid.Attach(button_click.TextBox, 5,0,2,7);
   -- Add le premier bouton a la grille
   Gtk_New (Button1, "Run test resolution");
   On_Clicked(button_click.Button1, button_clicked'Access);
   Grid.Attach (Button1, 1, 0, 1, 1);
   -- Add le second bouton a la grille
   Gtk_New (Button2, "Run test Coord");
   On_Clicked(button_click.Button2, button_clicked'Access);
   Grid.Attach (Button2, 1, 1, 1, 1);
   -- Add le troisieme bouton a la grille
   Gtk_New (Button3, "Run test Ensemble");
   On_Clicked(button_click.Button3, button_clicked'Access);
   Grid.Attach (Button3, 1, 2, 1, 1);
   -- Add le quatrieme bouton a la grille
   Gtk_New (Button4, "Run test Grille");
   On_Clicked(button_click.Button4, button_clicked'Access);
   Grid.Attach (Button4, 1, 3, 1, 1);
   -- Ajout du huitieme bouton
   Gtk_New (Button8, "Run test Cas Possible");
   On_Clicked(button_click.Button8, button_clicked'Access);
   Grid.Attach (Button8, 1, 4, 1, 1);
   -- Add le cinquieme bouton a la grille
   Gtk_New (Button5, "Run Grille 1");
   On_Clicked(button_click.Button5, button_clicked'Access);
   Grid.Attach (Button5, 1, 5, 1, 1);
   -- Add le sixieme bouton a la grille
   Gtk_New (Button6, "Run Grille 2");
   On_Clicked(button_click.Button6, button_clicked'Access);
   Grid.Attach (Button6, 1, 6, 1, 1);
   -- Add le septieme bouton a la grille
   Gtk_New (Button7, "Run Grille 4");
   On_Clicked(button_click.Button7, button_clicked'Access);
   Grid.Attach (Button7, 1, 7, 1, 1);
   -- Add space to grid
   Gtk_New (Space, " ");
   Grid.Attach(Space,2,0,1,1);
   Gtk_New (Space2, " ");
   Grid.Attach(Space2,1,7,1,5);
   -- Stop the Gtk process when closing the window
   Win.On_Delete_Event (Delete_Event_Cb'Unrestricted_Access);
   --  Show the window and present it;
   Win.Show_All;
   Win.Present;
   --  Start the Gtk+ main loop
   Gtk.Main.Main;
end Main;
