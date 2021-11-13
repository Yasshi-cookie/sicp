(use math.const)
(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n 1) (+ (d 1) (cont-frac (lambda (i) (n (+ i 1)))
                                   (lambda (i) (d (+ i 1)))
                                   (- k 1))))))
;; n = x, -x^2, -x^2,...
;; d = 1, 3, 5,...
;; k = 3の場合
(define (tan-cf x k)
  (cont-frac
   (lambda (i)
     (cond
       ((= i 1) x)
       ((>= i 2) (* -1 (square x)))))
  (lambda (i) (- (* 2 i) 1)) k))

(define (square x) (* x x))
(tan-cf (/ pi 4) 5)
