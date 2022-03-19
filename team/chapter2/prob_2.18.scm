; 練習問題 2.18: リストを引数として取り、同じ要素を逆順に持つ
; リストを返す⼿続き reverse を定義せよ。
(define nil '())
(null? nil)

(define list-a (list 1 2 3 4 5))
(define (reverse list-arg)
  (define (reverse-iter list-res list-arg)
    (if (null? list-arg)
        list-res
        (reverse-iter (cons (car list-arg) list-res) (cdr list-arg))))
  (reverse-iter nil list-arg))

(reverse-custom list-a)
