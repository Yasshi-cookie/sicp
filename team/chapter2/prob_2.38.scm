; 練習問題 2.38: accumulate ⼿続きは、列の最初の要素と、右の
; すべての要素を組み合わせた結果とを組み合わせるため、foldright としても知られている。fold-left というものもあり、これ
; は fold-right に似ているが、要素の組み合わせを逆⽅向に⾏うと
; いう点が違う。
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define nil '())

(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list nil (list 1 2 3))
(fold-left list nil (list 1 2 3))
(fold-right + 0 (list 1 2 3))
(fold-left + 0 (list 1 2 3))

; fold-right と fold-left が任意の列に対して同じ値を返すこと
; を保証するために、op が満たさなければならない性質を答えよ。

交換律（交換法則）が成り立つこと

