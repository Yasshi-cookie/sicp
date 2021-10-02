;; a
(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n 1) (+ (d 1) (cont-frac (lambda (i) (n (+ i 1)))
                                   (lambda (i) (d (+ i 1)))
                                   (- k 1))))))

;; n = d = 1, k = 3の場合
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           17)

;; b 反復プロセス
(define (cont-frac-iterate n d k value)
  (if (= k 0)
      value
      (cont-frac (lambda (i) (n (+ i 1)))
                 (lambda (i) (d (+ i 1)))
                 (- k 1))))
