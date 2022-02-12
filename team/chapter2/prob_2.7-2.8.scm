; 練習問題2.7-2.8
; コンストラクタ
(define (make-interval a b)
  (cons a b))
; セレクタ
(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

; 和
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

; -1倍
(define (minus-1 x)
  (make-interval (* -1 (upper-bound x))
                 (* -1 (lower-bound x))))

; 差
(define (sub-interval x y)
  (add-interval x (minus-1 y)))

; 積
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; 除
(define (div-interval x y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))



(define interval-x (make-interval 2 3))
(define interval-y (make-interval 4 5))
interval-x
interval-y
(sub-interval interval-x interval-y)
