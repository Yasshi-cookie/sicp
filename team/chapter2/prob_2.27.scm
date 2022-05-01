; 練習問題 2.27: 練習問題 2.18の reverse ⼿続きを修正し、deepreverse という⼿続きを書け。deep-reverse は、ひとつのリスト
; を引数として取り、要素が逆順で、サブリストもすべて要素が逆
; 順になっているリストを返す⼿続きである。例えば、次のようになる。
(define x (list (list 1 2) (list 3 4)))
x
; ((1 2) (3 4))
(reverse x)
; ((3 4) (1 2))
(deep-reverse x)
; ((4 3) (2 1))

(define list_nest2 (list (list 1 (list 2 3)) (list 4 (list 5 6))))
(define (deep-reverse x)
  )
(map reverse (reverse list_nest2))
(map reverse (reverse (map reverse (reverse list_nest2))))
(map reverse (list (list 1) (list 3 4)))
(length (list (list 1 2)))

(define (deep-reverse ls)
  (if (not (pair? ls))
      ls
      (reverse (map deep-reverse ls))))
(define y (list (list 5 6) (list 7 8)))
(define xy (list x y))
(map (lambda (ls) (map reverse ls)) (map reverse xy))
(reverse (map (lambda (ls) (map reverse (reverse ls))) xy))
; (((8 7) (6 5)) ((4 3) (2 1)))
(map (lambda (ls) (map reverse ls)) (map reverse xy))
(map (lambda (ls) (map reverse (reverse ls))) xy)
; どちらも (((4 3) (2 1)) ((8 7) (6 5)))
; なぜなら、(map f (map g ls)) = (map f○g ls)

(reverse (map (lambda (ls) (map reverse (map reverse ls))) xy))
; (map f (map g ls)) = (map f○g ls)
