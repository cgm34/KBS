
(defrule iniciar
   "Regla inicial: detecta el estado de inicio y comienza la búsqueda de plan."
   (declare (salience 100))
   ?s <- (estado (tipo inicial)
                 (posicion-horizontal ?ph)
                 (posicion-vertical ?pv)
                 (posicion-caja ?pc)
                 (tiene-banana no))
   =>
   (printout t "=== INICIO DEL PROCESO ===" crlf)
   (printout t "El mono comienza en la " ?ph ", la caja está en la " ?pc "." crlf)
   (assert (meta alcanzada no))
)



(defrule accion-caminar
   ?s <- (estado (posicion-horizontal ?desde)
                 (posicion-vertical en-suelo)
                 (posicion-caja ?caja)
                 (tiene-banana no))
   (test (neq ?desde ?caja))
   =>
   (retract ?s)
   (assert (estado
               (posicion-horizontal ?caja)
               (posicion-vertical en-suelo)
               (posicion-caja ?caja)
               (tiene-banana no)))
   (printout t "- El mono camina desde " ?desde " hacia la " ?caja " donde está la caja." crlf))



(defrule accion-empujar-caja
   ?s <- (estado (posicion-horizontal ?desde)
                 (posicion-vertical en-suelo)
                 (posicion-caja ?desde)
                 (tiene-banana no))
   (test (neq ?desde centro))
   =>
   (retract ?s)
   (assert (estado
               (posicion-horizontal centro)
               (posicion-vertical en-suelo)
               (posicion-caja centro)
               (tiene-banana no)))
   (printout t "- El mono empuja la caja desde " ?desde " hasta el centro de la habitación." crlf)
)



(defrule accion-subir-caja
   ?s <- (estado (posicion-horizontal centro)
                 (posicion-vertical en-suelo)
                 (posicion-caja centro)
                 (tiene-banana no))
   =>
   (retract ?s)
   (assert (estado
               (posicion-horizontal centro)
               (posicion-vertical sobre-caja)
               (posicion-caja centro)
               (tiene-banana no)))
   (printout t "- El mono se sube a la caja que está en el centro." crlf)
)


(defrule accion-agarrar-banana
   ?s <- (estado (posicion-horizontal centro)
                 (posicion-vertical sobre-caja)
                 (posicion-caja centro)
                 (tiene-banana no))
   =>
   (retract ?s)
   (assert (estado
               (posicion-horizontal centro)
               (posicion-vertical sobre-caja)
               (posicion-caja centro)
               (tiene-banana si)))
   (assert (meta alcanzada si))
   (printout t "- El mono agarra la banana. ¡Éxito!" crlf)
)


