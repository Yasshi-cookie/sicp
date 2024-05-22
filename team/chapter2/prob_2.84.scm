; 練習問題 2.84: 練習問題 2.83の raise 演算を使って apply-generic
; ⼿続きを修正して、この節で検討した通り、連続して “上げる” と
; いう⽅法によって引数が同じ型を持つよう強制型変換を⾏うよう
; にせよ。⼆つの型のどちらがタワーの中で⾼い位置にあるかをテ
; ストする⽅法を考える必要がある。システムのほかの部分と “互換
; 性がある” ようなやり⽅でこれを⾏い、タワーに新しい階を追加す
; る際に問題を引き起こさないようにせよ。

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args))
                    (diff (sub-nest (car type-tags) (cadr type-tags))))
                (cond ((> diff 0)
                       (apply-generic op a1 (raise a2)))
                      ((< diff 0)
                       (apply-generic op (raise a1) a2))
                      (else
                       (apply-generic op a1 a2))))
              (error "No method for these types"
                     (list op type-tags)))))))

; argに対するタワーの中の深さを返す
(define (nest arg)
  (if (eq? arg 'complex)
      0
      (+ 1 (nest (raise arg)))))

; arg-aとarg-bのタワーの中の位置の差を返す
(define (sub-nest arg-a arg-b)
  (- (nest arg-a) (nest arg-b)))
