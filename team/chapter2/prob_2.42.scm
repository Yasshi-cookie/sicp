(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

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


; queen-colsは、盤の最初の k 列にクイーンを置くすべてのパターンの列を返す内部⼿続き
; rest-of-queens は最初の k −1 列に k −1 個のクイーンを置くパターンのひとつ
; new-row は k 列⽬のクイーンを置く候補となる⾏
; 盤上の位置集合に対する表現⽅法を定義せよ
; adjoin-positionは位置集合に新しい⾏・列の位置を追加する手続き
; empty-boardは位置の空集合
; safe?は、位置集合に対してk 列⽬のクイーンがほかのクイーンに利いていないかを調べる手続き

; board-size = 4

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

 (define (queens board-size)
   (define (queen-cols k)
     (if (= k 0)
         (list '())
         (filter
          (lambda (positions) (safe? positions))
          (flatmap
           (lambda (rest-of-queens)
             (map (lambda (new-row)
                    (adjoin-position
                     new-row k rest-of-queens))
                  (enumerate-interval 1 board-size)))
           (queen-cols (- k 1))))))
   (queen-cols board-size))

(queens 8)
(length (queens 1))
(length (queens 8))
; 92
(length (queens 11))
; 2680
