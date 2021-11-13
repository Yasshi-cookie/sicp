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

;; 反復的プロセス
(define (cont-frac-iter n d k)
  (define (iter i res)
    (if (= i 0)
        res
        (iter (- i 1) (/ (n i) (+ (d i) res)))))
  (iter (- k 1) (/ (n k) (d k))))

;; 例
(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                17)
