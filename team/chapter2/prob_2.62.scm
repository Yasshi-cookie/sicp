; 練習問題 2.62: 順序つきリストとして表現された集合に対して、
; union-set を O(n) で実装せよ。
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1)) (x2 (car set2)))
           (cond ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
                 ((= x1 x2) (cons x1 (union-set (cdr set1) (cdr set2))))
                 (else (cons x2 (union-set set1 (cdr set2)))))))))

(define set1 '(9))
(define set2 '(3 4 5))
(union-set set1 set2)
(union-set '() set2)
(union-set set1 '())

; 参考
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< x (car set)) (cons x set))
        ((= x (car set)) set)
        (else (cons (car set) (adjoin-set x (cdr set))))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))
