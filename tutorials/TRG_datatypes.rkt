#lang racket

;; https://docs.racket-lang.org/guide/datatypes.html

;; booleans
;; #t, #f
;; boolean? any value other than #f counts as true
(= 2 (+ 1 1))
(boolean? "no")
(if "no" 1 0)

;; numbers
;; exact/inexact
;; exact: integer, rational (two intergers), complex with exact real numbers
;; inexact IEEE floating point, complex with floating part
;; #e, #i, #b, #o, #x
;; exact->inexact. inexact->exact
;; integer?, rational?, real?, complex?, number?

;; performance of computing large exact number vs inexact numbers
(define (sigma f a b)
  (if (= a b)
      0
      (+ (f a) (sigma f (+ a 1) b))))
(time (round (sigma (lambda (x) (/ 1 x)) 1 2000)))
(time (round (sigma (lambda (x) (/ 1.0 x)) 1 2000)))

(= 1 1.0)
(eqv? 1 1.0)
(equal? 1 1.0)
(= 1/2 0.5)
(= 1/10 0.1)
