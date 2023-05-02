#lang racket

;; https://docs.racket-lang.org/guide/scheme-forms.html
;; Expressions and Definitions

;; identifiers and binding
;; define, lambda, let: bind inentifiers
(define f
  (lambda (x)
    (let ([y 5])
      (+ x y))))
(f 10)
;; a local binding can shadows the exsting binding
(define f1
  (lambda (append) (define cons (append "ugly" "confusing"))
    (let ([append 'this-was])
      (list append cons))))
(f1 list)

;; function call
;; arity: the number of arguments that a function accepts
;; keyword arguments
;; (go "super.rkt" #:mode 'fast)
;; (go #:mode 'fast "super.rkt")
;; apply applies the functionto the values in the list
(define (avg lst)
  (/ (apply + lst) (length lst)))
(avg '(1 2 3 4))
(map + '(1 2 3 4))
;; keyword apply
(define (fk x #:y y #:z [z 10])
  (list x y z))
(apply fk #:y 2 '(1))
(keyword-apply fk '(#:y) '(2) '(1))
(apply fk '(1) #:y 2 #:z 7)
(keyword-apply fk '(#:y #:z) '(2 7) '(1))
(keyword-apply fk #:z 7 '(#:y) '(2) '(1))

;; lambda
;; (lambda (arg-id ...) body ...+)
((lambda (x y) (+ x y)) 1 2)
;; lambda with a rest argument
;; a single rest-id: any number of argument into a list
((lambda x x) 1 2 3)
((lambda x (first x)) 1 2 3)
;; optional argument
(define greet
  (lambda (given [surname "Smith"])
    (string-append "Hello, " given " " surname)))
(greet "John")
(greet "John" "Doe")
;; keyword argument
(define greet2
  (lambda (#:hi [hi "Hello"] given #:last [surname "Smith"])
    (string-append hi ", " given " " surname)))
(greet2 "John")
(greet2 "Karl" #:last "Marx")
(greet2 "Karl" #:last "Marx" #:hi "Guten Tag")

;; case-lambda: arity sensitive
;; not directly support optional or keyword arguments
(define greet3
  (case-lambda
    [(name) (string-append "Hello, " name)]
    [(given surname) (string-append "Hello, " given " " surname)]))
(greet3 "John")
(greet3 "John" "Smith")

;; (define id expr)
;; (define (id arg ...) body ...+)
;; (define (id arg ... . rest-id) body ...+)
(define salutation (list-ref '("Hi" "Hello") (random 2)))
salutation
(define (greet4 name) (string-append salutation ", " name))
(greet4 "John")
(define (greet5 first [surname "Smith"] #:hi [hi salutation])
  (string-append hi ", " first " " surname))
(greet5 "John")
(greet5 "John" #:hi "Hey")
(greet5 "John" "Doe")
;; rest-id
(define (avg . l)
  (/ (apply + l) (length l)))
(avg)
(avg 1 2 3 4 5)

;; curried function shorthand

;; (define make-add-suffix
;;   (lambda (s2)
;;     (lambda (s) (string-append s s2))))
;; ==> 
;; (define (make-add-suffix s2)
;;   (lambda (s) (string-append s s2)))
;; =>
(define ((make-add-suffix s2) s)
  (string-append s s2))
((make-add-suffix "!") "hello")
(define louder (make-add-suffix "!"))
(define less-sure (make-add-suffix "?"))
(less-sure "really")
(louder "really")

