(deftemplate estado
   "Representa la situación actual del mono, la caja y la banana."
   (slot tipo)                      
   (slot posicion-horizontal)       
   (slot posicion-vertical)         
   (slot posicion-caja)             
   (slot tiene-banana))             

(deftemplate movimiento
   "Representa una transición entre dos estados mediante una acción."
   (slot estado-actual)
   (slot accion)
   (slot estado-siguiente))