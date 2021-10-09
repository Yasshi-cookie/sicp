(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n 1) (+ (d 1) (cont-frac (lambda (i) (n (+ i 1)))
                                   (lambda (i) (d (+ i 1)))
                                   (- k 1))))))

(define (tan-cf x k)
  (cont-frac
   (lambda (i) (- (* 2 i) 1) k))

;; n = x, -x^2, -x^2,...
;; d = 1, 3, 5,...
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
