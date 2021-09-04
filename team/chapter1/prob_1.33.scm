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

;prime?
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

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
