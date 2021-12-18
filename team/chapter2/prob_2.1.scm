(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; 有理数の計算例
(define one-half (make-rat 1 2))
(print-rat one-half)
; 1/2
(define one-third (make-rat 1 3))
(print-rat (add-rat one-half one-third))
; 5/6
(print-rat (mul-rat one-half one-third))
; 1/6
(print-rat (add-rat one-third one-third))
; 6/9

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd -5 -3)

(define (make-rat x y)
  (let ((g (gcd x y)))
    (if (or (and (not (negative? x))
                 (not (negative? y)))
            (and (negative? x)
                 (negative? y)))
        (cons (abs (/ x g)) (abs (/ y g)))
        (cons (* -1 (abs (/ x g))) (abs (/ y g))))))
(make-rat 1 2)
(print-rat (make-rat -4 -8))
; 1/2
