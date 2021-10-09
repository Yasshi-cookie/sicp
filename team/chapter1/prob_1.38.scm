(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n 1) (+ (d 1) (cont-frac (lambda (i) (n (+ i 1)))
                                   (lambda (i) (d (+ i 1)))
                                   (- k 1))))))

;; n = 1,
;; d = 1, 2, 1, 1, 4, 1, 1, 6,...
;; k = 3の場合
(cont-frac (lambda (i) 1.0)
           (lambda (i)
             (cond
              ((= i 1) 1)
              ((= i 2) 2)
              ((or (= (remainder i 3) 0)
                   (= (remainder i 3) 1)) 1)
              ((= (remainder i 3) 2) (* 2 (+ 1 (quotient i 3))))))
             17)
