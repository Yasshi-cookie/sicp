; 練習問題 2.83: 図 2.25に⽰した型のタワー (整数、有理数、実数、
; 複素数) を扱うジェネリック算術演算システムを設計していると
; する。それぞれの型 (複素数を除く) に対し、その型のオブジェク
; トをタワーの中で⼀階上げる⼿続きを設計せよ。それぞれの型 (複
; 素数を除く) に対して動作するジェネリックな raise 演算を組み
; 込む⽅法を⽰せ。
(define (raise x)
  (apply-generic 'raise x))

; n → n/1（形式としての有理数）
(define (raise-int n)
  (make-rational n 1))

; a/b（形式としての有理数） → a ÷ b
(define (raise-rational r)
  (attach-tag 'real (/ (numer r) (denom r)))) ; 実数のタグってなんだっけ？

; x → x + 0 * i
(define (raise-real x)
  (make-from-real-imag x 0))

(put 'raise 'integer (lambda (x) (raise-int x)))
(put 'raise 'rational (lambda (x) (raise-rational x)))
(put 'raise 'real (lambda (x) (raise-real x)))
