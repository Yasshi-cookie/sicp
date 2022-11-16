(define (make-segment start-s end-s)
  (cons start-s end-s))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

(define start-s (make-vect 1 2))
(define end-s (make-vect 3 4))

(define segment (make-segment start-s end-s))
segment
(start-segment segment)
(end-segment segment)
