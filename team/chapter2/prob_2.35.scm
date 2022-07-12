(define (count-leaves t)
  (print t)
  (accumulate + 0 (map local-count-leaves t)))
(define (local-count-leaves tree)
  (if (not (pair? tree))
      1
      (count-leaves tree)))

(define tree (cons (list 1 (list 2 3)) (list 4 5)))
(count-leaves tree)

; 従来のcount-leaves
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
