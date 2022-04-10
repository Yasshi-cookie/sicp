(define nil '())

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

(square-list (list 1 2 3 4))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        (cons answer nil)
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter (cdr items) (car items)))

(square-list (list 1 2 3 4))
