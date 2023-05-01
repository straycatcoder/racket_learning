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
(keyword-apply fk '(#;y) '(2) '(1))
(apply fk '(1) #:y 2 #:z 7)
(keyword-apply fk '(#:y #:z) '(2 7) '(1))
(keyword-apply fk #:z 7 '(#:y) '(2) '(1))

