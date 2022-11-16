(define (make-segment start-s end-s)
  (cons start-s end-s))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))


(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segment-list)))

; a. 指定された枠の輪郭を描くペインタ。
(define segment-list1
  (list (make-segment (make-vect 0 0) (make-vect 1 0))
        (make-segment (make-vect 1 0) (make-vect 1 1))
        (make-segment (make-vect 1 1) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 0 0))))

; b. 枠の対⾓線同⼠をつないで “X” を描くペインタ。
(define segment-list2
  (list (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 0 1) (make-vect 1 0))))

; c. 枠の辺の中点をつないで菱形を描くペインタ。
(define segment-list3
  (list (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
        (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
        (make-segment (make-vect 0.5 1) (make-vect 0 0.5))
        (make-segment (make-vect 0 0.5) (make-vect 0.5 0))))
