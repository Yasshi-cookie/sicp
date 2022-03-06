; 2.12
; 中央値とパーセント許容誤差を取り、求める範囲を返すコンストラクタ
; make-center-percent を定義せよ。
; また、与えられた区間に対してパーセント許容誤差を返すセレクタ
; percentも定義する必要がある。center セレクタは上に書いたものと同じである。
; コンストラクタ
(define (make-interval a b)
  (cons a b))
; セレクタ
(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
; (define (center i)
;   (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c percent)
  (make-interval (- c (* c (/ percent 100))) (+ c (* c (/ percent 100)))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (* 100
     (/ (- (upper-bound i) (lower-bound i))
        (+ (upper-bound i) (lower-bound i)))))

