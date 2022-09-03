(define n 5)
(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 2 7)

(accumulate
    append nil (map (lambda (i)
                      (map (lambda (j) (list i j))
                           (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 1 n)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define )

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (double x)
  (list (* x 2)))

(map double (list 1 2 3))
(flatmap double (list 1 2 3))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (unique-triple n)
  (flatmap
   (lambda (i)
     (map (lambda (j)
            (map (lambda (k) (list i j k)
                         (enumerate-interval 1 (- i 1)))
                 (enumerate-interval 1 (- j 1))))
          (enumerate-interval 1 (- k 1))))))
(unique-triple 5)

(unique-pairs n)

(enumerate-interval 1 (- k 1))

(prime-sum-pairs 5)

(map (lambda (i)
       (map (lambda (j)
              (map (lambda (k) (list i j k))
                   (iota 3 1)))
            (iota 4 1)))
     (iota 5 1))

; prime?の定義
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (if (= n 1)
      #f
      (= n (smallest-divisor n))))
