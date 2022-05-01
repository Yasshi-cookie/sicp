; 練習問題 2.26: ⼆つのリスト x と y を定義するとする。
(define x (list 1 2 3))
(define y (list 4 5 6))
; 次のそれぞれの式を評価すると、インタプリタはどのような結果
; を表⽰するだろうか。
(append x y)
; gosh> (1 2 3 4 5 6)
(cons x y)
; gosh> ((1 2 3) 4 5 6)
(list x y)
; gosh> ((1 2 3) (4 5 6))

(define cons_xy (cons x y))
(define list_xy (list x y))

(car cons_xy)
(cadr cons_xy)

(car list_xy)
(cddr list_xy)

(cdr (list (list 1) (list 2)))
