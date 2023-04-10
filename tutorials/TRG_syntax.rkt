#lang racket/base

;; syntax-overview
;; definition
;; ( define ‹id› ‹expr› )
;; ( define ( ‹id› ‹id›* ) ‹expr›+ )

;; function call
;; ( ‹id› ‹expr›* )
;; ( ‹expr› ‹expr›* )
;; ( lambda ( ‹id›* ) ‹expr›+ )

;; conditions
;; ( if ‹expr› ‹expr› ‹expr› )
;; ( and ‹expr›* )
;; ( or ‹expr›* )
;; ( cond {[ ‹expr› ‹expr›* ]}* )

;; local binding
;; ( define ( ‹id› ‹id›* ) ‹definition›* ‹expr›+ )
;; ( lambda ( ‹id›* ) ‹definition›* ‹expr›+ )
;; ( let ( {[ ‹id› ‹expr› ]}* ) ‹expr›+ )
;; let* allows later clauses to use earlier bindings:

;; if example
(define (double v)
  ((if (string? v) string-append +) v v))
(double 10)
(double "Hello")

;; let example
(let ([x (random 4)]
      [o (random 4)])
  (cond
    [(> x o) "X wins"]
    [(> o x) "O wins"]
    [else "cat's game"]))

;; let* example
(let* ([x (random 4)]
        [o (random 4)]
        [diff (number->string (abs (- x o)))])
  (cond
    [(> x o) (string-append "X wins by " diff)]
    [(> o x) (string-append "O wins by " diff)]
    [else "cat's game"]))

