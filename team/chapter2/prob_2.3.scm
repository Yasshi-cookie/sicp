; 2.3
; 面積
(define (area rectangle)
  (* (length-seg (length-rec rectangle))
     (length-seg (width-rec rectangle))))

; 外周の長さ
(define (circumference rectangle)
  (+ (* 2 (length-seg (length-rec rectangle)))
     (* 2 (length-seg (width-rec rectangle)))))

; 長方形を作る
(define (make-rectangle length width)
  (cons length width))
(define (length-rec rectangle)
  (car rectangle))
(define (width-rec rectangle)
  (cdr rectangle))

; 線分の長さ
(define (length-seg segment)
  (norm (sub-point (start-segment segment)
                   (end-segment segment))))

(define (norm vector)
  (sqrt (+ (square (x-point vector))
           (square (y-point vector)))))

; 2乗根
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) x))

(define (iterative-improve good-enough? improve-guess)
  (lambda (first-guess)
    (if (good-enough? first-guess)
        first-guess
        ((iterative-improve good-enough? improve-guess) (improve-guess first-guess)))))
(define (average x y)
  (/ (+ x y) 2))

; 線分を作る
(define (make-segment a b)
  (cons a b))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

; 2次元ベクトル空間の和とスカラー倍の定義
(define (add-point a b)
  (make-point (+ (x-point a) (x-point b))
              (+ (y-point a) (y-point b))))
(define (scalar-point c vector)
  (make-point (* c (x-point vector))
              (* c (y-point vector))))
(define (sub-point a b)
  (add-point a (scalar-point -1 b)))

; 2次元平面の点を作る
(define (make-point x y)
  (cons x y))
(define (x-point a)
  (car a))
(define (y-point a)
  (cdr a))

; テスト
(define x (make-point 0 0))
(define y (make-point 2.0 0))
(define z (make-point 0 1.0))
(define w (make-point 2 2))

(define length-segment (make-segment x y))
(define width-segment (make-segment x z))

(define rectangle_a (make-rectangle length-segment width-segment))
(area rectangle_a)
; 2.000000092922294
(circumference rectangle_a)
; 6.0000001858445895
