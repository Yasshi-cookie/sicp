(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
      (sum term (next a) next b))))

(define (simpthon f a b n)
  (define h (/ (- b a) n))
  (define (add-h h)
    (+ a h))
  (+ (f a)
  )
  (sum  a add-h b)
)

; 数値積分の定義
(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
      dx))
