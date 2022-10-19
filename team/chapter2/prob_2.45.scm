(define right-split (split beside below))
(define up-split (split below beside))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (split trans_a trans_b)
  (lambda (painter n)
    (define (small-split painter n)
      (if (= n 0)
          painter
          (let ((smaller (small-split painter (- n 1))))
            (trans_a painter (trans_b smaller smaller)))))
    (small-split painter n)))
(define (beside painter)
  painter)
(define (below painter)
  painter)

(split below beside)

(define (split first-div second-div)
  (define (spliter painter n)
    (if (= n 0)
        painter
        (let ((smaller (spliter painter (- n 1))))
             (first-div painter (second-div smaller smaller)))))
  spliter)
(split beside below)
right-split
