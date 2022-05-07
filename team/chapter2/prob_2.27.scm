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

; よく分かってない。。。
(define (deep-reverse ls)
  (if (not (pair? ls))
      ls
      (reverse (map deep-reverse ls))))
(deep-reverse xyzw)

(define y (list (list 5 6) (list 7 8)))
(define xy (list x y))
(define z (list (list 11 12) (list 13 14)))
(define w (list (list 15 16) (list 17 18)))
(define zw (list z w))
(define xyzw (list xy zw))
xyzw
; ((((1 2) (3 4)) ((5 6) (7 8))) (((11 12) (13 14)) ((15 16) (17 18))))
(map reverse xyzw)
; ((((5 6) (7 8)) ((1 2) (3 4))) (((15 16) (17 18)) ((11 12) (13 14))))
(map (lambda (ls) (map reverse ls)) xyzw)
; ((((3 4) (1 2)) ((7 8) (5 6))) (((13 14) (11 12)) ((17 18) (15 16))))
(map (lambda (ls) (map (lambda (ls) (map reverse ls)) ls)) xyzw)
; ((((2 1) (4 3)) ((6 5) (8 7))) (((12 11) (14 13)) ((16 15) (18 17))))

(map (lambda (ls) (map reverse ls)) (map reverse xy))
(reverse (map (lambda (ls) (map reverse (reverse ls))) xy))
; (((8 7) (6 5)) ((4 3) (2 1)))
(map (lambda (ls) (map reverse ls)) (map reverse xy))
(map (lambda (ls) (map reverse (reverse ls))) xy)
; どちらも (((4 3) (2 1)) ((8 7) (6 5)))
; なぜなら、(map f (map g ls)) = (map f○g ls)

(reverse (map (lambda (ls) (map reverse (map reverse ls))) xy))
; (map f (map g ls)) = (map f○g ls)
