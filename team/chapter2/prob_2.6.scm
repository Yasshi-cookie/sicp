(define zero
  (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; (add-2 n)
(define (add-2 n)
  (lambda (f)
    (lambda (x)
      (f (n (f (x (f (n f)))))))))
; (add-2 n)
(lambda (f)
  (lambda (x)
    (f (f ((n f) x)))))

; (add-1 zero)
(define one
  (lambda (f) (lambda (x) (f x))))

; (add-1 one)
(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (inc x)
  (+ x 1))

((one inc) 10)
; 11
((two inc) 10)
; 12
(((add-2 zero) inc) 10)

(add-1 one)
(add-1 (add-1 zero))
; #<closure ((add-1 add-1) f)>
