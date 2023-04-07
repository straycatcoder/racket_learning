;; teach_yourself_racket.rst
;; https://cs.uwaterloo.ca/~plragde/flaneries/TYR/
#lang racket

;; Basics
(display "==basics==\n")

"Hello World"

(max 3 -2 4.1 1/4)

(* (+ 1 2 3) (- 4 5 6) (/ 7 8 9))

;; Definitions
(display "==definitions==\n")

(define x 3)
(define y (+ x 1))
(define (sum-of-square x y)
  (+ (square x)
     (square y)))
(define (square x) (* x x))
(sum-of-square x y)

;; Conditional expressions
(display "==conditions==\n")

(= 2 2)
(> 2 4)
(= x y)
(equal? "Hello" "Hello")
(equal? "Hello" 2)
(>= 2 2 1)
(>= 4 3 5)
(not (even? 43))
(boolean? (> x y))
(exact? (sqrt 4))
(string? "hello")
(string>? "hello" "hawk")

;; if condition
(display "==if==\n")

(define z -2)
(if (> z (sqrt 5)) "greater" "not greater")
(if (positive? z) z (- z))

;; cond expression
(display "==cond==\n")
(cond)
(cond
  [else "Yes"])
(define (abs x)
  (cond
    [(> x 0) x]
    [else (- x)]))
(abs 5)
(abs -5)

;; and/or
(display "==and/or==\n")
(define (f x) (if (positive? x) x #f))
(and (> 3 4) (< 3 4))
(or (> 3 4) (< 3 4))
(or 3 4 5)
(and 3 4 5)
(and (f 3) (f 4))
(or (f -2) (f 3) (f 4))

;; Recursion
(display "==recursion==\n")
