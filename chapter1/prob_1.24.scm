(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-time)))
(define (start-prime-test n start-time)
  (and (fast-prime? n trials)
       (report-prime (time-difference (current-time) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))
(define (search-for-primes from n)
  (cond ((= n 0) (newline))
        ((even? from) (search-for-primes (+ from 1) n))
        ((timed-prime-test from) (search-for-primes (+ from 2) (- n 1)))
        (else (search-for-primes (+ from 2) n))))
(define (search n)
  (search-for-primes n 3))

(define (fast-expt b n)
(cond ((= n 0) 1)
((even? n) (square (fast-expt b (/ n 2))))
(else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
(remainder (fast-expt base exp) m))
