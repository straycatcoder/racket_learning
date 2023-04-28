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

;; char: a unicode scalar value
(integer->char 65)
(integer->char #x03bb)
(char->integer #\A)
(char->integer #\space)
(char->integer #\newline)
;; char=? char-ci=?
(char=? #\a #\A)
(char-ci=? #\a #\A)
;; char-alphabetic? char-numeric? char-whitespace?
;; char-upcase char-downcase

;; string: a fixed-length array of chars
;; string written directly as expressions are immutable
;; make-string: mutable string
;; string-ref: access a char (0 based index)
;; sting-set!: change a char in a string
(string-ref "Apple" 1)
(define s (make-string 10 #\.))
s
(string-set! s 2 #\A)
s
;; ording and case operations are generally locale-independent
(string<? "apple" "Banana")
(string-ci<? "apple" "Banana")
(string<? "20230416" "20230415")

;; Bytes and Byte Strings
;; bytes: int [0~255]
(byte? 0)
(byte? 256)
;; byte strins to process pure ASCII, prefix with #
#"Apple"
(bytes-ref #"Apple" 0)
(define b (make-bytes 5 65))
(bytes-set! b 2 255)
b
(display #"Apple\n")
(display "\316\273\n")
(display #"\316\273\n")

(bytes->string/utf-8 #"\316\273")
(bytes->string/latin-1 #"\316\273")

;; Symbols
;; an atomic value preceded with '
;; symbole are case-sensitive
(symbol? 'apple)
(symbol? "apple")
(eq? 'a (string->symbol "a"))
;; Whitespace or special characters can be included
;; in an identifier by quoting them with | or \.
(string->symbol "one, two")
(string->symbol "6")
;; write prints a symbol without ' prefix
(write 'Apple)
(write '|6|)
(display '|6|)
;; gensym, string->uninterned-symbol
;; fresh symbole not equal to any previous symbol
(define su (gensym))
su
(eq? 'a (string->uninterned-symbol "a"))

;; keyword similar to symbol, prefixed with #:
;; use (unquoted) as special markers in argument lists and other forms
(string->keyword "apple")
(eq? '#:apple (string->keyword "apple"))
(define dir (find-system-path 'temp-dir))
(with-output-to-file (build-path dir "stuff.txt")
  (lambda () (printf "example\n"))
  #:mode 'text
  #:exists 'replace)

;; Pairs and Lists
;; pair joins two arbitray value
;; cons, car, cdr, pair?
;; list: empty list null, a pair cons (a list element, list)
null
(list? null)
(list? (cons 1 (cons 2 null)))
(list? (cons 1 2))
(list 1 2 3 4 5)
;; quasiquote and unquote
`(1 2 ,(length '(1 2 3)) 4 5)
;; map, andmap, ormap, filter, foldl, for-each, member, assoc
(map (lambda (i) (/ 1 i)) '(1 2 3))
(andmap (lambda (i) (< i 3)) '(1 2 3))
(ormap (lambda (i) (< i 3)) '(1 2 3))
(filter (lambda (i) (< i 3)) '(1 2 3))
(foldl (lambda (v i) (+ v i))
       10
       '(1 2 3))
(for-each (lambda (i) (display i))
          '(1 2 3))
(member "Keys" '("Florida" "Keys", "U.S.A."))
(assoc 'where '((when "3:30") (where "Florida") (who "Mickey")))
;; mutable pair: mcons, mcar, mcdr, set-mcar!, set_mcdr!, mpair?
(define pp (mcons 1 2))
(display pp)
;; mutable pair is not a pair, same for the list
(pair? pp)
(mpair? pp)

;; Vector
;; vector is a fixed-length array of values
;; vector->list, list->vectory
#(1 2 3)
(vector? #(1 2 3))
(vector-ref #(4 5 6) 2)
#10(1 2 3)
