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
(define (avg1 . l)
  (/ (apply + l) (length l)))
(avg1 1 2 3 4 5)

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

;; multiple values/results
(values 1 2 3)
(define (split-name name)
  (let ([parts (regexp-split " " name)])
    (if (= (length parts) 2)
        (values (list-ref parts 0) (list-ref parts 1))
        (error "not a <first> <last> name"))))
(split-name "John Doe")
;; this will produce an error
;;(split-name "John J. Doe")

(define-values (given surname) (split-name "John Doe"))
given
surname

;; local bining
;; parallel binding: let
;; sequential binding: let*
;; recursive binding: letrec
(let ([+ (lambda (x y)
           (if (string? x)
               (string-append x y)
               (+ x y)))])
  (list (+ 1 2)
        (+ "see" "saw")))
(let* ([x (list "Burroughs")]
       [y (cons "Rice" x)]
       [z (cons "Edgar" y)])
  (list x y z))
(let* ([name (list "Burroughs")]
       [name (cons "Rice" name)]
       [name (cons "Edgar" name)])
  name)
(letrec ([swing (lambda (t)
                  (if (eq? (car t) 'tarzan)
                      (cons 'vine (cons 'tarzan (cddr t)))
                      (cons (car t)
                            (swing (cdr t)))))])
  (swing '(vine tarzan vine vine)))
;; let-values, let*-vaules letrec-values
(let-values ([(q r) (quotient/remainder 14 3)])
  (list q r))

;; conditions
;; any value other than #f as true
(member "Apple" '("Peach" "Pear"))
(member "Apple" '("Peach" "Apple" "Pear"))

;; if must have then-expr and else-expr
;; (and expr ...) -> the value of last expr
;; (or expre ...) -> the first non-#f value
;; (and) -> #t, (or) -> #f
(and)
(or)
(define (got-milk? lst)
  (and (not (null? lst))
       (or (eq? 'milk (car lst))
           (got-milk? (cdr lst))))) ;; recurs only if needed
(got-milk? '(apple banana))
(got-milk? '(apple milk banana))
(got-milk? '())

;; cond
;; if no true/no else -> #(void)
(define (got-milk2? lst)
  (cond
    [(null? lst) #f]
    [(eq? 'milk (car lst)) #t]
    [else (got-milk2? (cdr lst))]))
(got-milk2? '(apple milk banana))
(got-milk2? '())
;; [test-expr => proc-expr]
;; [(memeber "Apple" lst)] => cdr]

;; Sequencing
;; interaction with the external enviroment
(define (print-triangle height)
  (if (zero? height)
      (void)
      (begin
        (display (make-string height #\*))
        (newline)
        (print-triangle (sub1 height)))))
(print-triangle 5)

;; lambda, cond support implicit begin
(define (print-triangle-cond height)
  (cond
    [(positive? height)
     (display (make-string height #\*))
     (newline)
     (print-triangle-cond (sub1 height))]))
(print-triangle-cond 5)

;; sliced into the surrounding context
(let ([curly 0])
  (begin
    (define moe (+ 1 curly))
    (define larry (+ 1 moe)))
  (list larry moe curly))

;; begin0 returns the result of the first expr
(define (log-times thunk)
  (printf "Start: ~s\n" (current-inexact-milliseconds))
  (begin0
    (thunk)
    (printf "End..: ~s\n" (current-inexact-milliseconds))))
(log-times (lambda () (sleep 0.1) 0))
(log-times (lambda () (values 1 2)))

;; when: if-style conditional with sequencing for then without else
;; unless: test-expr is #f
(define (print-triangle-when height)
  (unless (zero? height)
    (display (make-string height #\*))
    (newline)
    (print-triangle-when (sub1 height))))
(print-triangle-when 5)

(define (enumerate lst)
  (if (null? (cdr lst))
      (printf "~a.\n" (car lst))
      (begin
        (printf "~a, " (car lst))
        (when (null? (cdr (cdr lst)))
          (printf "and "))
        (enumerate (cdr lst)))))
(enumerate '("Larry" "Curly" "Moe" "John"))

;; assignment: set!
(define greeted null)
(define (greet-set name)
  (set! greeted (cons name greeted))
  (string-append "Hello, " name))
(greet-set "Anthos")
(greet-set "Porthos")
(greet-set "Aramis")
greeted

(define (make-running-total)
  (let ([n 0])
    (lambda ()
      (set! n (+ n 1))
      n)))
(define win (make-running-total))
(define lose (make-running-total))
(win)
(win)
(lose)
(win)
;;when statful objects are necessary, use set! is fine
(define next-number!
  (let ([n 0])
    (lambda ()
      (set! n (add1 n))
      n)))
(next-number!)
(next-number!)
(next-number!)
;; multiple values: set!-values
(define game
  (let ([w 0]
        [l 0])
    (lambda (win?)
      (if win?
          (set! w (+ w 1))
          (set! l (+ l 1)))
      (begin0
        (values w l)
        ;; (swap sides...
        (set!-values (w l) (values l w))))))
(game #t)
(game #t)
(game #f)
