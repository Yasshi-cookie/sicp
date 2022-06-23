; 練習問題 2.30: 練習問題 2.21の square-list と似たような⼿続き
; square-tree を定義せよ。square-tree は以下のように動作する。
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
; (1 (4 (9 16) 25) (36 49))

(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree sub-tree factor)
             (* sub-tree factor)))
       tree))
(define tree1 (list 1
                    (list 2 (list 3 4) 5)
                    (list 6 7)))
(scale-tree tree1 10)

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))

(square-tree tree1)

; 練習問題 2.31: 練習問題 2.30の解答を抽象化し、⼿続き tree-map
; を作れ。square-tree が tree-map によって以下のように定義でき
; るようにせよ。
(define (tree-map func tree)
  )
(define (tree-map func tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map func sub-tree)
             (func sub-tree)))
       tree))
(define (plus-five x)
  (+ x 5))
(tree-map plus-five tree1)

(define (square-tree tree) (tree-map square tree))
(square-tree tree1)
