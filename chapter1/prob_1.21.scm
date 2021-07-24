(define (smallest-divsor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
      ((divides? test-divisor n) test-divisor) (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(smallest-divisor 199)

(define (timed-prime-test n)
(newline)
(display n)
(start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
(display " *** ")
(display elapsed-time))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-time)))
(define (start-prime-test n start-time)
  (and (prime? n)
       (report-prime (time-difference (current-time) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(smallest-divsor 19999)
