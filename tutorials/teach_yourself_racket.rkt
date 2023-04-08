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
(define (fact n)
  (cond
    [(= n 1) 1]
    [else (* n (fact (- n 1)))]))
(fact 10)
(fact 50)
;; tail-recusion
(define (fact-with-helper n)
  ;; local function
  (define (fact-helper n acc)
    (cond
      [(= n 1) acc]
      [else (fact-helper (- n 1) (* n acc))]))
  ;; body of fact-with-helper
  (fact-helper n 1))
(fact-with-helper 10)
(fact-with-helper 50)

;; Pairs - Compound data
(display "==pairs==\n")
(cons 1 2)
(cons 1 empty)
(cons 1 (cons 2 empty))
(pair? (cons 1 2))
(pair? (cons (list 2 3) 1))
(pair? (cons 1 (list 2 3)))
(pair? (list 1 2 3))

(car (cons "first" "second"))
(cdr (cons "first" "second"))
(first (cons 1 (cons 2 (cons 3 empty))))
(rest (cons 1 (cons 2 (cons 3 empty))))

;; Quote and Symbols
(display "==quote and symbols==\n")
(quote (1 2 3 (4 5)))
;; pair is not a list
(list? (cons 1 2))
(list? (quote (cons (1 2))))
(list? empty)
(symbol? 'map)
(symbol? map)
(procedure? map)
(string->symbol "map")
(symbol->string 'map)
