#lang racket

;; https://docs.racket-lang.org/guide/to-scheme.html
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

;; loop through list
;; map, andmap, ormap
;; fitler
;; foldl, foldr

;; empty? detects empty lists
;; cons? detects non-empty lists

;; pair/cons, car/cdr
;; pair is not a list

;; reader layer -> expander layer

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

;; loop through lists
(map sqrt '(1 4 9 16))
(map (lambda (i)
      (if (string-suffix? i "!") i (string-append i "!")))
     '("peanuts" "popcorn!" "crackerjack!"))
(filter even? '(2 3 4 5))
;; (3 (2 (1 0)))
;; 1 + 0*0 =1 -> 1 + 2*2 = 5 -> 5 + 3*3 = 14 
(foldl (lambda (elem v)
         (+ v (* elem elem)))
       0
       '(1 2 3))
(foldr (lambda (elem v)
         (+ v (* elem elem)))
       0
       '(1 2 3))
;;(4 - (3 - (2 - (1 - 0))))
(foldl - 0 '(1 2 3 4))

;; list example length, map
(define (my-length lst)
  (cond
    [(empty? lst) 0]
    [else (+ 1 (my-length (rest lst)))]))
(my-length empty)
(my-length '(1 2 3 4 5))

(define (my-map f lst)
  [cond
    [(empty? lst) empty]
    [else (cons (f (first lst))
                (my-map f (rest lst)))]])
(my-map + empty)
(my-map (lambda (x) (* x x)) '(1 2 3 4 5))
(my-map string-upcase '("ready" "set" "go"))

;; tail-recursion
;(my-length (list "a" "b" "c"))
;= (+ 1 (my-length (list "b" "c")))
;= (+ 1 (+ 1 (my-length (list "c"))))
;= (+ 1 (+ 1 (+ 1 (my-length (list)))))
;= (+ 1 (+ 1 (+ 1 0)))
;= (+ 1 (+ 1 1))
;= (+ 1 2)
;= 3

;(my-length-tail (list "a" "b" "c"))
;= (iter (list "a" "b" "c") 0)
;= (iter (list "b" "c") 1)
;= (iter (list "c") 2)
;= (iter (list) 3)
;3

(define (my-length-tail lst)
  ; local function iter:
  (define (iter lst len)
    (cond
      [(empty? lst) len]
      [else (iter (rest lst) (+ len 1))]))
  ; body of my-length-tail
  (iter lst 0))
(my-length-tail empty)
(my-length-tail '(1 2 3 4 5))

(define (my-map-tail f lst)
  ; local function iter
  (define (iter lst backward-result)
    (cond
      [(empty? lst) (reverse backward-result)]
      [else (iter (rest lst)
                  (cons (f (first lst)) backward-result))]))
  (iter lst empty))
(my-map-tail + empty)
(my-map-tail (lambda (x) (* x x)) '(1 2 3 4 5))
(my-map-tail string-upcase '("ready" "set" "go"))

(define (my-map-for f lst)
  (for/list ([i lst])
    (f i)))
(my-map-for + empty)
(my-map-for (lambda (x) (* x x)) '(1 2 3 4 5))
(my-map-for string-upcase '("ready" "set" "go"))

;; remove consecutive duplicates
(define (remove-dups l)
  (cond
    [(empty? l) empty]
    [(empty? (rest l)) l] ; (empty? (rest '(1))) -> t
    [else
     (let ([i (first l)])
       (if (equal? i (first (rest l)))
           (remove-dups (rest l))
           (cons i (remove-dups (rest l)))))]))
(remove-dups '("a" "b" "a" "b" "c" "d"))
(remove-dups '("a" "a" "b" "b" "c" "c"))

