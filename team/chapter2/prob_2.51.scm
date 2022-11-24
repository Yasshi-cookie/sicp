; 練習問題 2.51: ペインタに対する below 演算を定義せよ。below は
; ⼆つのペインタを引数に取る。返り値となるペインタは、枠が与
; えられたとき、⼀つ⽬のペインタで枠の下部を描画し、⼆つ⽬のペ
; インタで上部を描画する。⼆つのやり⽅で below を定義せよ。⼀
; つ⽬は、上に⽰した beside ⼿続きと似たような⼿続きを書くとい
; うもので、⼆つ⽬は、beside と適切な回転演算 (練習問題 2.50の
; もの) によって定義するというものである。

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-below
           (transform-painter
            painter1
            (make-vect 0.0 0.0)
            (make-vect 1.0 0.0)
            split-point))
          (paint-above
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.5)
            (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))


; 参考
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter
            painter1
            (make-vect 0.0 0.0)
            split-point
            (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.0)
            (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))
