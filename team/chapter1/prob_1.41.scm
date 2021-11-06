(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))
(((double (double double)) inc) 5)

((double (double (double inc))) 5)

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define dx 0.00001)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cube x) (* x x x))
(define (square x) (* x x))

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

((cubic 1 2 3) 1)
(newtons-method (cubic 1 0 1) 0)

; fixed-point
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

((double (double (double (double inc)))) 5)

; ((double g) f)
; = (g (g f))

; ((d1 (d2 d3)) f)
; = ((d2 d3) ((d2 d3) f))
; = ((d2 d3) (d2 (d3 f)))
; = (d3 (d3 (d2 (d3 f))))
; = (double (double (double (double f))))

; where d1 = d2 = d3 = double

; ((double g) f)
; = ((lambda (x) (g (g x))) f)
; = (g (g f))
