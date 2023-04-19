; 練習問題 2.65: 練習問題 2.63と練習問題 2.64の結果を使って、(バ
; ランスの取れた) ⼆分⽊として実装された集合に対する union-set
; と intersection-set を Θ(n) で実装せよ。

(define (union-set-of-trees tree-a tree-b)
  (list->tree (union-set (tree->list-1 tree-a) (tree->list-1 tree-b))))

(define (intersection-set-of-trees tree-a tree-b)
  (list->tree (intersection-set (tree->list-1 tree-a) (tree->list-1 tree-b))))

(define tree1
  (make-tree 7
             (make-tree 4
                        (make-tree 2 '() '())
                        (make-tree 6 '() '()))
             (make-tree 10
                        '()
                        (make-tree 12 '() '()))))

(define tree2
  (make-tree 3
             (make-tree 1 '() '())
             (make-tree 7
                        (make-tree 5 '() '())
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '())))))

(union-set-of-trees tree1 tree2)
; gosh>
(6
 (3
  (1
   ()
   (2 () ()))
  (4
   ()
   (5 () ())))
 (9
  (7
   ()
   (8 () ()))
  (11
   (10 () ())
   (12 () ()))))

(intersection-set-of-trees tree1 tree2)

; 2.63
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set) (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define tree3
  (make-tree 5
             (make-tree 3
                        (make-tree 1 '() '())
                        '())
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))

(define unbalanced-tree
  (make-tree 1
             '()
             (make-tree 2
                        '()
                        (make-tree 3
                                   '()
                                   (make-tree 4
                                              '()
                                              (make-tree 5
                                                         '()
                                                         (make-tree 6
                                                                    '()
                                                                    (make-tree 7
                                                                               '()
                                                                               '()))))))))
(define easy-tree
  (make-tree 2
             (make-tree 1
                        '()
                        '())
             (make-tree 3
                        '()
                        '())))

; 2.64

(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

; リスト世界のunion-set, intersection-set
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1)) (x2 (car set2)))
           (cond ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
                 ((= x1 x2) (cons x1 (union-set (cdr set1) (cdr set2))))
                 (else (cons x2 (union-set set1 (cdr set2)))))))))

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
