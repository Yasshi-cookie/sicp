; 練習問題 2.75: コンストラクタ make-from-mag-ang をメッセージパッシングスタイルで実装せよ。
; この⼿続きは、上で与えた makefrom-real-imag と似たようなものになるだろう。
(define (make-from-mag-lang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else (error "Unknown op: MAKE-FROM-MAG-LANG" op))))
  dispatch)

; 参考
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude) (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
  dispatch)
