(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define v (list 1 1 0 1))
(define w (list 1 0 1 1))
(define n (list (list 0 1 1 1) (list 1 0 1 1) (list 1 1 0 1) (list 1 1 1 0)))

(define nil '())
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
(dot-product v w)
; 2
(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))
(define (transpose mat)
  (accumulate-n cons nil mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

(matrix-*-vector m v)
(transpose m)
(matrix-*-matrix m n)

;; m
;; +-         -+
;; |  1 2 3 4  |
;; |  4 5 6 6  |
;; |  6 7 8 9  |
;; +-         -+

;; v
;; +-         -+
;; |  1 1 0 1  |
;; +-         -+

;; w
;; +-         -+
;; |  1 0 1 1  |
;; +-         -+

;; n
;; +-         -+
;; |  0 1 1 1  |
;; |  1 0 1 1  |
;; |  1 1 0 1  |
;; |  1 1 1 0  |
;; +-         -+

;; m * n
;; +-            -+
;; |  9  8  7  6  |
;; |  17 16 15 15 |
;; |  24 23 22 21 |
;; +-            -+
