; 練習問題 2.52: 上で述べた各レベルに⼿を加え、図 2.9に⽰した
; wave による square-limit を変更せよ。具体的には、次のようなも
; のである。

; b. corner-split によって構築されるパターンを変更せよ (例
; えば、up-split や right-split の画像を⼆つではなく⼀つ
; だけ使うようにする)。
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter smaller))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter smaller))))

; c. square-of-four を使うほうの square-limit を修正し、四隅
; を違うパターンで組み⽴てるようにせよ (例えば、正⽅形の
; 四隅で⼤きなロジャーズ⽒が外を向くようにするなど)。
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-vert rotate180
                                  identity flip-horiz)))
    (combine4 (corner-split painter n))))
