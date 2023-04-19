; 練習問題 2.64: 次の⼿続き list->tree は、順序つきリストをバラ
; ンスの取れた⽊に変換する。補助⼿続き partial-tree は、整数 n
; と、少なくとも n 個の要素を持つリストを引数に取り、リストの最
; 初の n 個の要素を含むバランスの取れた⽊を⽣成する。partialtree の返り値はペア (cons で構築される) で、car には構築された
; ⽊を持ち、cdr には⽊に含まれなかった要素のリストを持つ。

(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (print c)
  (set! c (+ c 1))
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
                ; (print left-size)
                ; (print left-result)
                ; (print left-tree)
                ; (print non-left-elts)
                ; (print right-size)
                ; (print this-entry)
                ; (print right-result)
                ; (print right-tree)
                ; (print remaining-elts)
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

; n => ステップ数
; 3 => 7
; 10 => 21
; 20 => 40
; 100 => 200
; 200 => 400
; 400 => 800
; 一般的に
; n => 2n ?
O(n)

(define c 0)
(list->tree (iota 3))

(5
 (2
  (1 () ())
  (3 () (4 () ())))
 (8
  (6 () (7 () ()))
  (9 () (10 () ()))))

'(1 3 5 7 9 11)
(define '(1 2 3 4 5 6 7 8 9 10))

left-tree '(1 3)
this-entry 5
right-tree '(7 9 11)

left-result ((1 () ()) 2 3)

left-tree (1 () ())

non-left-elts (2 3)
right-size 1

this-entry 2

right-result ((3 () ()))

right-tree (3 () ())

remaining-elts '()
(partial-tree '(1 2 3) 3) = ((2 (1 () ()) (3 () ())))

(list->tree '(1 2 3))
(list->tree '(1 2 3 4 5 6 7 8 9 10))
(car (partial-tree '(1 2 3 4 5 6 7 8) 3))

(partial-tree '(1 2 3) 1)
(partial-tree '(3) 1)

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))


(5
 (1
  ()
  (3 () ()))
 (9
  (7 () ())
  (11 () ())))

(define elements '(1 3 5 7 9 11))
(partial-tree elements 3)


; chatGPT
(define (list->balanced-tree elements)
  (if (null? elements)
      '()
      (let* ((middle (quotient (length elements) 2))
             (left-elements (take elements middle))
             (right-elements (drop (cdr elements) middle)))
        (make-node (list-ref elements middle)
                   (list->balanced-tree left-elements)
                   (list->balanced-tree right-elements)))))

(define (take lst n)
  (if (or (null? lst) (= n 0))
      '()
      (cons (car lst) (take (cdr lst) (- n 1)))))

(define (drop lst n)
  (if (= n 0)
      lst
      (drop (cdr lst) (- n 1))))

(define (make-node entry left right)
  (list entry left right))

(list->balanced-tree elements)
