;1.31-a
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (identity x) x)
(define (inc x)
  (+ x 1))
(define (factorial a b)
  (product identity a inc b))

(factorial 1 6)

(define (wallis-formular a b)
  (define (term x)
    (square (/ (* 2 x) (+ (* 2 x) 1))))
  (product term a inc b))

(wallis-formular 1.0 1000)

(define (wallis-formula a b)
  (define (term x)
    (/ (* (* 2 x) (* 2 (+ x 1)))
       (square (+ (* 2 x) 1))))
  (product term a inc b))

(* 4 (wallis-formula 1.0 1000.0))

;1.31-b
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result)))
  (iter a 1))
