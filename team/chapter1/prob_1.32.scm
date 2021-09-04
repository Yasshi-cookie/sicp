;1.32-a
;線形再帰プロセス
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

;1.32-b
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
