package TAD_ensemble is
   APPARTIENT_ENSEMBLE : exception;
   NON_APPARTIENT_ENSEMBLE : exception;
   INDEX_NON_VALIDE : exception;
   ENSEMBLE_VIDE : exception;
   type Type_Ensemble is private;
   -- retourne un ensemble vide
   function construireEnsemble return Type_Ensemble;
   -- retourne VRAI si l'ensemble e est vide et FAUX sinon
   function ensembleVide (e : in Type_Ensemble) return Boolean;
   -- retourne VRAI si le chiffre v est present dans l'ensemble e
   function appartientChiffre
     (e : in Type_Ensemble; v :    Integer) return Boolean;
   -- retourne le nombre d'elements de l'ensemble e
   function nombreChiffres (e : in Type_Ensemble) return Integer;
   -- ajoute le chiffre v dans l'ensemble e
   -- nécessite l'element v n'existe pas dans l'ensemble e
   -- lève l'exception APPARTIENT_ENSEMBLE si v appartient à l'ensemble
   procedure ajouterChiffre (e : in out Type_Ensemble; v : in Integer);
   -- supprime le chiffre v dans l'ensemble e
   -- nécessite l'element v existe dans l'ensemble e
   -- lève l'exception NON_APPARTIENT_ENSEMBLE si v n'appartient pas à l'ensemble
   procedure retirerChiffre (e : in out Type_Ensemble; v : in Integer);
   -- Renvoies le ieme numero de l'ensemble e
   -- necessite l'element 1 <= i < nombreChiffres(e)
   -- l�ve l'exception ENSEMBLE_VIDE si l'ensemble e = 0
   -- l�ve l'exception INDEX_NON_VALIDE si i < 1
   function iemeChiffre(e : in Type_Ensemble; i : in Integer) return Integer;
private
   type Type_Ensemble is array (1 .. 9) of Boolean;
end TAD_ensemble;
