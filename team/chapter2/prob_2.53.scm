; 練習問題 2.53: 以下の式をそれぞれ評価したとき、それらに対し
; てインタプリタは何を表⽰するか。

(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))

; gosh> (a b c)
; gosh> ((george))
; gosh> ((y1 y2))
; gosh> (y1 y2)
; gosh> #f
; gosh> #f
; gosh> (red shoes blue socks)

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

'(a b c)
(quote (a b c))
(list 'quote '(a b c))

(quote ())

(cons 1 2)
'(1 . 2)

(quote (+ 1 2))
(car '(a b c))

(define (execute list)
  list)

(execute '(1 2))
(execute '(+ 1 2))

''()
'()
'(list 1 2)
(car '(list 1 2))

(cadr (quote (quote (a b c))))

(quote (a b c))
(car (quote (a b c)))
