; 遅い方
(define (slow-queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list '())
        (filter
         (lambda (positions) (safe? positions))
         (flatmap
          (lambda (new-row)
            (map (lambda (rest-of-queens)
                   (print "new-row: " new-row ", k: " k ", rest-of-queens: " rest-of-queens ", adj: " (adjoin-position new-row k rest-of-queens))
                   (adjoin-position new-row k rest-of-queens))
                 (queen-cols (- k 1))))
          (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

; 速い方
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list '())
        (filter
         (lambda (positions) (safe? positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (print "new-row: " new-row ", k: " k ", rest-of-queens: " rest-of-queens ", adj: " (adjoin-position new-row k rest-of-queens))
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; 遅い方
(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row 2 rest-of-queens))
        '()))
 (enumerate-interval 1 3))


; 速い方
(flatmap
 (lambda (rest-of-queens)
   (map (lambda (new-row)
          (adjoin-position
           new-row 3 rest-of-queens))
        (enumerate-interval 1 3)))
 (list '()))

(time (queens 3))
(time (slow-queens 2))

(define (empty-board '()))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

 (define (adjoin-position row col rest)
   (cons (list row col) rest))

 (define (check a b)    ; returns true if two positions are compatible
   (let ((ax (car a))   ; x-coord of pos a
         (ay (cadr a))  ; y-coord of pos a
         (bx (car b))   ; x- coord of pos b
         (by (cadr b))) ; y-coord of pos b
     (and (not (= ax bx)) (not (= ay by))  ; checks col / row
          (not (= (abs (- ax bx)) (abs (- ay by))))))) ; checks diag

 (define (safe? y)
   (= 0 (accumulate + 0
                    (map (lambda (x)
                           (if (check (car y) x) 0 1))
                         (cdr y)))))
