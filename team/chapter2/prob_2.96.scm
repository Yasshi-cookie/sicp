; 練習問題 2.96:
; a. ⼿続き pseudoremainder-terms を実装せよ。これは remainderterms と同じようなものになるが、div-terms を呼ぶ前に、上
; で述べた整数化因数を被除数にかけるというところが違う。
; gcd-terms を修正して pseudoremainder-terms を使うよう
; にし、greatest-common-divisor が練習問題 2.95の例に対し
; て整数係数の答えを返すようになっていることを確認せよ。
(define (integerizing-factor L1 L2)
  (let ((o1 (order L1))
        (o2 (order L2))
        (c (coeff (first-term L2))))
    (expt c (+ 1 o1 (-o2)))))
(define (pseudoremainder-terms L1 L2)
  (cadr (div-terms (mul-term-by-all-terms (make-term (0, integerizing-factor L1 L2)) L1) L2)))
(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (pseudoremainder-terms a b))))

; b. これで gcd は整数係数になる。しかし、係数は P1 の係数よ
; りも⼤きくなる。gcd-terms を修正し、答えの係数すべての
; (整数の) 最⼤公約数で係数を割ることによって答えの係数か
; ら共通因数を取り除くようにせよ。
(define (gcd-terms a b)
  (define (old-gcd-terms a b)
    (if (empty-termlist? b)
        a
        (old-gcd-terms b (pseudoremainder-terms a b))))
  (mul-term-by-all-terms
   (make-term 0
              (/ 1 (gcd (map coeff (term-list (old-gcd-terms a b)))))) (old-gcd-terms a b)))

(define (gcd-terms a b)
  (let ((g (gcd (map coeff (term-list a)))))
    (if (empty-termlist? b)
        (mul-term-by-all-terms (make-term 0 (/ (coeff (first-term a)) g)) a)
        (gcd-terms b (pseudoremainder-terms a b)))))

; remainder-termsの実装
(define (remainder-terms L1 L2)
  (cadr (div-terms L1 L2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))
