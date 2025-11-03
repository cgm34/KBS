(deftemplate smartphone
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio))

(deftemplate computadora
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio))

(deftemplate accesorio
   (slot tipo)
   (slot descuento))

(deftemplate cliente
   (slot nombre)
   (slot tipo)) ; menudista / mayorista

(deftemplate tarjeta
   (slot banco)
   (slot grupo)
   (slot exp-date))

(deftemplate vale
   (slot monto)
   (slot motivo))

(deftemplate orden
   (slot producto)
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio)
   (slot tarjeta-banco)
   (slot tarjeta-grupo)
   (slot qty))




;; 1. Promo iPhone16 Banamex
(defrule promo-iphone16-banamex
   (orden (producto smartphone) (marca apple) (modelo iPhone16) (tarjeta-banco banamex))
   =>
   (printout t " Promoción: iPhone 16 con tarjeta Banamex - 24 meses sin intereses." crlf))

;; 2. Promo Samsung Note21 Liverpool
(defrule promo-note21-liverpool
   (orden (producto smartphone) (marca samsung) (modelo note21) (tarjeta-banco liverpool))
   =>
   (printout t " Promoción: Samsung Note21 con tarjeta Liverpool VISA - 12 meses sin intereses." crlf))

;; 3. Combo MacBook Air + iPhone16
(defrule combo-macbookair-iphone16
   (orden (producto computadora) (marca apple) (modelo macbookair))
   (orden (producto smartphone) (marca apple) (modelo iPhone16))
   =>
   (assert (vale (monto 100) (motivo "Compra combinada Apple")))
   (printout t " Combo: MacBook Air + iPhone16 → 100 pesos en vales por cada 1000." crlf))

;; 4. Descuento accesorios
(defrule descuento-accesorios
   (orden (producto smartphone))
   =>
   (assert (accesorio (tipo funda) (descuento 15)))
   (assert (accesorio (tipo mica) (descuento 15)))
   (printout t " Oferta: 15% de descuento en fundas y micas." crlf))

;; 5. Cliente menudista
(defrule tipo-cliente-menudista
   (orden (qty ?q&:(< ?q 10)))
   =>
   (assert (cliente (tipo menudista)))
   (printout t " Cliente clasificado como MENUDISTA." crlf))

;; 6. Cliente mayorista
(defrule tipo-cliente-mayorista
   (orden (qty ?q&:(>= ?q 10)))
   =>
   (assert (cliente (tipo mayorista)))
   (printout t " Cliente clasificado como MAYORISTA." crlf))

;; 7. Cashback BBVA
(defrule cashback-bbva
   (orden (tarjeta-banco bbva))
   =>
   (printout t " Promoción BBVA: 10% de cashback en compras mayores a 10,000." crlf))

;; 8. Recomendación Apple Music
(defrule recomendar-applemusic
   (orden (producto smartphone) (marca apple))
   =>
   (printout t " Recomendación: Prueba Apple Music gratis por 3 meses." crlf))

;; 9. Recomendación Samsung Cloud
(defrule recomendar-samsungcloud
   (orden (producto smartphone) (marca samsung))
   =>
   (printout t " Recomendación: Activa Samsung Cloud con 50 GB gratis." crlf))

;; 10. Envío gratis
(defrule envio-gratis
   (orden (precio ?p&:(> ?p 25000)))
   =>
   (printout t " Envío gratis por compras superiores a $25,000." crlf))

;; 11. Vales sin intereses
(defrule vales-sin-intereses
   (orden (tarjeta-grupo visa))
   =>
   (printout t " Beneficio VISA: 6 meses sin intereses en cualquier producto." crlf))

;; 12. Recomendar Apple Watch
(defrule recomendar-applewatch
   (orden (producto smartphone) (marca apple))
   =>
   (printout t " Recomendación: Completa tu ecosistema con un Apple Watch." crlf))

;; 13. Recomendar Galaxy Buds
(defrule recomendar-galaxybuds
   (orden (producto smartphone) (marca samsung))
   =>
   (printout t " Recomendación: Añade Galaxy Buds con 20% de descuento." crlf))

;; 14. Descuento estudiantes
(defrule descuento-estudiantes
   (cliente (tipo menudista))
   (orden (marca apple))
   =>
   (printout t " Descuento: 10% para estudiantes en productos Apple." crlf))

;; 15. Descuento por mayoreo
(defrule descuento-por-mayoreo
   (cliente (tipo mayorista))
   =>
   (printout t " Descuento: 12% por compra al mayoreo." crlf))

;; 16. Extender garantía AppleCare
(defrule extender-garantia
   (orden (marca apple) (producto computadora))
   =>
   (printout t " AppleCare disponible: extiende garantía 2 años más." crlf))

;; 17. Recomendación smartphone premium
(defrule recom-smartphone-premium
   (orden (producto computadora) (marca apple))
   =>
   (printout t " Recomendación: iPhone 16 como complemento ideal de tu Mac." crlf))

;; 18. Recomendación mouse Logitech
(defrule recom-mouse-logitech
   (orden (producto computadora))
   =>
   (printout t " Recomendación: Mouse Logitech MX con 10% de descuento." crlf))

;; 19. Recomendación funda laptop
(defrule recom-funda-laptop
   (orden (producto computadora))
   =>
   (printout t " Recomendación: Funda protectora premium con 15% de descuento." crlf))

;; 20. Actualizar stock
(defrule actualizar-stock
   (orden (producto ?p) (qty ?q))
   =>
   (printout t " Actualizando stock de " ?p " en -" ?q " unidades." crlf))




