pragma Ada_2012;
package body TAD_ensemble is
   ------------------------
   -- construireEnsemble --
   ------------------------
   function construireEnsemble return Type_Ensemble is
      e:Type_Ensemble;
   begin
      for i in 1..9 loop
         e(i):=False;
      end loop;
      return e;
   end construireEnsemble;
   ------------------
   -- ensembleVide --
   ------------------
   function ensembleVide (e : in Type_Ensemble) return Boolean is
   begin
         for i in 1..9 loop
            if e(i)=True then
            return False;
         end if;
      end loop;
      return True;
      end ensembleVide;
   -----------------------
   -- appartientChiffre --
   -----------------------
   function appartientChiffre
     (e : in Type_Ensemble; v : Integer) return Boolean
   is
   begin
      if e(v) = True then
         return True;
      else
         return False;
      end if;
   end appartientChiffre;
   --------------------
   -- nombreChiffres --
   --------------------
   function nombreChiffres (e : in Type_Ensemble) return Integer is
      compteur:Integer;
   begin
      compteur:=0;
      for i in 1..9 loop
         if e(i) = True then
            compteur:=compteur+1;
         end if;
      end loop;
      return compteur;
   end nombreChiffres;
   --------------------
   -- ajouterChiffre --
   --------------------
   procedure ajouterChiffre (e : in out Type_Ensemble; v : in Integer) is
   begin
      if e(v) = True then
         raise APPARTIENT_ENSEMBLE;
      end if;
      e(v):=True;
   end ajouterChiffre;
   --------------------
   -- retirerChiffre --
   --------------------
   procedure retirerChiffre (e : in out Type_Ensemble; v : in Integer) is
   begin
      if e(v) = False then
         raise NON_APPARTIENT_ENSEMBLE;
      end if;
      e(v):=False;
   end retirerChiffre;
   --------------------
   --   iemeChiffre  --
   --------------------
   function iemeChiffre(e : in Type_Ensemble; i : in Integer) return Integer is
      j:Integer;
   begin
      if nombreChiffres(e)=0 then
         raise ENSEMBLE_VIDE;
      end if;
      j:=1;
      for k in 1..9 loop
         if appartientChiffre(e,k) then
            if j=i then
               return k;
            end if;
            j:=j+1;
         end if;
      end loop;
      raise INDEX_NON_VALIDE;
   end iemeChiffre;
end TAD_ensemble;
