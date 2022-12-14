(car ''abracadabra)
(quote (quote abracadabra))
; クォートのあとが丸括弧の場合は、シンボルではなくリストを返すため、carはエラーを吐くこと無く評価される

(car '''abc)
(cdr '''abc)

(cadr '''abc)

(quote (quote (quote abc)))
(quote (quote abc))

(cdr 'abc)
(car (quote abc))
'abc
(quote abc)
(car 'abc)
(car ''(a b))
(car '(list 'a 'b))

'(a b)
(list 'a 'b)
(car '(a b))
(car (list 'a 'b))
''('a 'b)

(car ''('a 'b))
(cdr ''('a 'b))
(cadr ''('a 'b))

'('abc)
(car '('abc))
(cdr '('abc))
(cadr '('abc))

(car ''(q abc))
(cdr ''(q abc))
(car ''(quote abc))
(cdr ''(quote abc))

(define abc 2)
(define (q x)
  (* x 2))
