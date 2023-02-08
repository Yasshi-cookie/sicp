; 練習問題 2.61: 順序つき表現を使った adjoin-set を実装せよ。
; element-of-set? から類推して、順序つきであることの利点を⽣
; かして、順序なしの表現に⽐べて平均的に半分のステップを必要
; とする⼿続きを作るやり⽅を⽰せ。

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< x (car set)) (cons x set))
        ((= x (car set)) set)
        (else (cons (car set) (adjoin-set x (cdr set))))))

(adjoin-set 10 '(1 3 5 7 9))
; gosh> (1 3 5 7 9 10)
(adjoin-set 4 '(1 3 5 7 9))
; gosh> (1 3 4 5 7 9)
(adjoin-set 0 '(1 3 5 7 9))
; gosh> (0 1 3 5 7 9)
(adjoin-set 1 '(1 3 5 7 9))
; gosh> (1 3 5 7 9)

; 参考
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

; もともとのadjoin-set
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))
