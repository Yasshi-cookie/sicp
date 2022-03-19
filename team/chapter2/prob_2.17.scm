; 2.2階層データと閉包性
(define nil '())
(null? nil)

(list 1)
(define list-a (list 1 2 3 4 5))
(list (list-ref list-a (- (length list-a) 1)))

(define (last-pair list-arg)
  (list (list-ref list-arg (- (length list-arg) 1))))

(define list-a (list 1 2 3 4 5))
(last-pair list-a)
; gosh> (5)
