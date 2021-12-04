; 1.45
(define (find-nth-root x n)
  (fixed-point ((repeated average-damp (ceiling (log n 2)))
                (lambda (y) (/ x (expt y (- n 1))))) 1.0))

(find-nth-root 16 4)

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

;average-damp
(define (average-damp f)
  (lambda (x) (average x (f x))))
(define (average x y)
  (/ (+ x y) 2))

;repeated
(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

;compose
(define (compose f g)
  (lambda (x) (f (g x))))
