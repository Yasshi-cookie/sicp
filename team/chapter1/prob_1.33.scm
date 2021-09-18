;1.33
(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a)
          (combiner (term a)
                    (filtered-accumulate filter combiner null-value term (next a)  next b))
          (filtered-accumulate filter combiner null-value term (next a)  next b))))

;1.33-a
(filtered-accumulate prime? + 0 square 1 inc 10)
;88

;1.33-b
(define (product-of-coprime n)
  (define (coprime? i)
          (= (gcd i n) 1))
  (filtered-accumulate coprime? * 1 identity 1 inc (- n 1)))

(product-of-coprime 12)

;385

;product
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result)))
    (iter a 1)))

;prime?
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (if (= n 1)
      #f
      (= n (smallest-divisor n))))

;1.32
;線形再帰プロセス
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

;線形反復プロセス
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate combiner (combiner (term a) null-value) term (next a) next b)))

;例
(define (identity x) x)
(define (inc x)
  (+ x 1))
(accumulate + 0 identity 1 inc 10)
;55
(accumulate * 1 identity 1 inc 6)
;720
