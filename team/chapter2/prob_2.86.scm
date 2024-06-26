; 練習問題 2.86: 複素数の実部、虚部、絶対値、偏⾓に、通常の数値
; や有理数や、これからシステムに追加するその他の数値を使える
; ようにしたいとする。そのような複素数を使えるようにするため
; に、システムにどのような変更を加える必要があるか説明し、そ
; れを実装せよ。通常の数値と有理数に対してジェネリックに使え
; る sine や cosine のような演算を定義する必要があるだろう。

(define (sine x)
  (apply-generic 'sine x))

(define (sine-int n)
  (sin n))

(define (sine-rational r)
  (sin (/ (numer r) (denom r))))

(define (sine-real x)
  (sin x))

(put 'sine 'integer (lambda (x) (sine-int x)))
(put 'sine 'rational (lambda (x) (sine-rational x)))
(put 'sine 'real (lambda (x) (sine-real x)))

(define (cosine x)
  (apply-generic 'cosine x))

(define (cosine-int n)
  (cos n))

(define (cosine-rational r)
  (cos (/ (numer r) (denom r))))

(define (cosine-real x)
  (cos x))

(put 'cosine 'integer (lambda (x) (cosine-int x)))
(put 'cosine 'rational (lambda (x) (cosine-rational x)))
(put 'cosine 'real (lambda (x) (cosine-real x)))
