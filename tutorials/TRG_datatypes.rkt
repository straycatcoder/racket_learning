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
