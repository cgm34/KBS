;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SISTEMA BASADO EN CONOCIMIENTO:
;; PROBLEMA DEL MONO Y LA BANANA
;; OBJETIVO: GENERAR UN PLAN DE ACCIONES
;; AUTOR: (Tu nombre)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --------------------------
;; 1. PLANTILLAS
;; --------------------------

(deftemplate estado
   (slot mono-posicion)
   (slot silla-posicion)
   (slot escritorio-posicion)
   (slot silla-sobre)
   (slot mono-sobre)
   (slot tiene-banana))

(deftemplate accion
   (slot descripcion))

;; --------------------------
;; 2. HECHOS INICIALES
;; --------------------------

(deffacts inicial
   (estado (mono-posicion puerta)
           (silla-posicion centro)
           (escritorio-posicion pared)
           (silla-sobre suelo)
           (mono-sobre suelo)
           (tiene-banana no)))

;; --------------------------
;; 3. REGLAS DE RAZONAMIENTO
;; --------------------------

;; El mono camina hasta el escritorio
(defrule mover-al-escritorio
   ?e <- (estado (mono-posicion puerta)
                 (escritorio-posicion pared)
                 (mono-sobre suelo)
                 (tiene-banana no))
   =>
   (retract ?e)
   (assert (estado (mono-posicion pared)
                   (silla-posicion centro)
                   (escritorio-posicion pared)
                   (silla-sobre suelo)
                   (mono-sobre suelo)
                   (tiene-banana no)))
   (assert (accion (descripcion "Caminar de la puerta al escritorio"))))

;; El mono sube la silla al escritorio
(defrule subir-silla-escritorio
   ?e <- (estado (mono-posicion pared)
                 (silla-posicion centro)
                 (escritorio-posicion pared)
                 (silla-sobre suelo)
                 (mono-sobre suelo)
                 (tiene-banana no))
   =>
   (retract ?e)
   (assert (estado (mono-posicion pared)
                   (silla-posicion pared)
                   (escritorio-posicion pared)
                   (silla-sobre escritorio)
                   (mono-sobre suelo)
                   (tiene-banana no)))
   (assert (accion (descripcion "Subir la silla al escritorio"))))

;; El mono se sube al escritorio
(defrule subir-escritorio
   ?e <- (estado (mono-posicion pared)
                 (silla-posicion pared)
                 (escritorio-posicion pared)
                 (silla-sobre escritorio)
                 (mono-sobre suelo)
                 (tiene-banana no))
   =>
   (retract ?e)
   (assert (estado (mono-posicion pared)
                   (silla-posicion pared)
                   (escritorio-posicion pared)
                   (silla-sobre escritorio)
                   (mono-sobre escritorio)
                   (tiene-banana no)))
   (assert (accion (descripcion "Subir al escritorio"))))

;; El mono se sube a la silla que está sobre el escritorio
(defrule subir-silla-sobre-escritorio
   ?e <- (estado (mono-posicion pared)
                 (silla-posicion pared)
                 (escritorio-posicion pared)
                 (silla-sobre escritorio)
                 (mono-sobre escritorio)
                 (tiene-banana no))
   =>
   (retract ?e)
   (assert (estado (mono-posicion pared)
                   (silla-posicion pared)
                   (escritorio-posicion pared)
                   (silla-sobre escritorio)
                   (mono-sobre silla)
                   (tiene-banana no)))
   (assert (accion (descripcion "Subir a la silla sobre el escritorio"))))

;; Finalmente, el mono alcanza la banana
(defrule alcanzar-banana
   ?e <- (estado (mono-posicion pared)
                 (silla-posicion pared)
                 (escritorio-posicion pared)
                 (silla-sobre escritorio)
                 (mono-sobre silla)
                 (tiene-banana no))
   =>
   (retract ?e)
   (assert (estado (mono-posicion pared)
                   (silla-posicion pared)
                   (escritorio-posicion pared)
                   (silla-sobre escritorio)
                   (mono-sobre silla)
                   (tiene-banana si)))
   (assert (accion (descripcion "Alcanzar y tomar la banana"))))

;; --------------------------
;; 4. PLAN FINAL
;; --------------------------

(defrule mostrar-plan
   (declare (salience -10)) ;; se ejecuta al final
   (not (estado (tiene-banana no)))
   =>
   (printout t crlf "=== PLAN DE ACCIONES ===" crlf)
   (do-for-all-facts ((?a accion)) TRUE
      (printout t "- " ?a:descripcion crlf))
   (printout t "✅ El mono ha obtenido la banana." crlf))
