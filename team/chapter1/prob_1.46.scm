; iterative-improve
(define (iterative-improve good-enough? improve-guess)
  (lambda (first-guess)
    (if (good-enough? first-guess)
        first-guess
        ((iterative-improve good-enough? improve-guess) (improve-guess first-guess)))))

; sqrt
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) x))

(define (average x y)
  (/ (+ x y) 2))

(sqrt 4.0)
(sqrt 5.0)
; fixed-point
(define (fixed-point f guess)
  (define tolerance 0.00001)
  (define (good-enough? guess)
    (< (abs (- guess (f guess)))
       tolerance))
  ((iterative-improve good-enough? f) guess))

(define (square x)
  (* x x))
(fixed-point sqrt 4.0)

(define (f x)
  (define (g x) x)
  (+ x (g 1)))
(f 2)
; => 3
; もし、gの定義の中のxが(f x)のxを継承しているならば
; => 4
; 継承していないならば
; => 3

; sqrt 元の定義
(define (sqrt x)
  (sqrt-iter 1.0 x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; fixed-point 元の定義
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (cond ((close-enough? guess next)
             next)
            (else (print guess)
                  (try next)))))
  (try first-guess))
