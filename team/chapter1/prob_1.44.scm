(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(define dx 0.1)
(define (smooth f)
  (lambda (x) (/ (+ (f (+ x dx)) (f x) (f (- x dx))) 3)))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))

(define f abs)
((smooth f) 0)
((smooth f) dx)
((n-fold-smooth f 6) dx)
