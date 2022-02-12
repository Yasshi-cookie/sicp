(define (midpoint-segment segment)
  (scalar-point (/ 1 2)
                (add-point (start-segment segment)
                           (end-segment segment))))

(define (make-segment a b)
  (cons a b))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (add-point a b)
  (make-point (+ (x-point a) (x-point b))
              (+ (y-point a) (y-point b))))
(define (scalar-point c vector)
  (make-point (* c (x-point vector))
              (* c (y-point vector))))

(define (make-point x y)
  (cons x y))
(define (x-point a)
  (car a))
(define (y-point a)
  (cdr a))

(define x (make-point 1 1))
(define y (make-point 3 5))
(define segment (make-segment x y))
(make-segment x y)
(midpoint-segment segment)


(define (midpoint-segment-iriya seg)
  (let ((start-p (start-segment seg))
        (end-p (end-segment seg)))
    (make-point (/ (+ (x-point start-p) (x-point end-p)) 2)
                (/ (+ (y-point start-p) (y-point end-p)) 2))))
(midpoint-segment-iriya segment)