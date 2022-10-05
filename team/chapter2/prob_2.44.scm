; 練習問題 2.44: corner-split で使われている up-split ⼿続きを
; 定義せよ。right-split に似ているが、below と beside の役割を⼊れ替えている。
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
