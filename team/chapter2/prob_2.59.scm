; 練習問題 2.59: 順序なしリストとして表現した集合に対する
; union-set 演算を実装せよ。
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(intersection-set '(1 2 3) '(2 3 4))
; (2 3)

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((not (element-of-set? (car set1) set2))
         (cons (car set1) (union-set (cdr set1) set2)))
        (else (union-set (cdr set1) set2))))

; (union-set '(1 2 3 4) '(3 4 5 6))
; gosh> (1 2 3 4 5 6)
; (union-set '(1 2 3 4) '())
; gosh> (1 2 3 4)
; (union-set '() '(1 2 3 4))
; gosh> (1 2 3 4)
