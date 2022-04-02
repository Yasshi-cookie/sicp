(define nil '())
(null? nil)

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination
                 coin-values))
            (cc (- amount
                   (first-denomination
                    coin-values))
                coin-values)))))

(define (no-more? list-values)
  (cond ((= (length list-values) 0) #t)
        (else #f)))

(define (except-first-denomination list-values)
  (cdr list-values))

(define (first-denomination list-values)
  (car list-values))

; 検証
(define us-coins (list 50 25 10 5 1))
(define inverse-us-coins (list 1 5 10 25 50))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
(define jp-coins (list 500 100 50 10 5 1))
(cc 100 inverse-us-coins)
