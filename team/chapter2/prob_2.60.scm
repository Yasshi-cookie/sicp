; 練習問題 2.60: 上の例では、集合は重複のないリストとして表現す
; るよう規定した。ここで、重複を許す場合について考えてみよう。
; その場合、例えば {1, 2, 3} という集合は (2 3 2 1 3 2 2) というリ
; ストとして表現することもできる。この表現に対して演算を⾏う
; ⼿続き element-of-set?, adjoin-set, union-set, intersectionset を設計せよ。それぞれの効率は、重複なし表現に対する⼿続き
; でそれに対応するものと⽐べてどうだろうか。重複なしの表現よ
; りもこの表現のほうが向いているような応⽤はあるだろうか。

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(adjoin-set 1 '(1 2 3))
; gosh> (1 1 2 3)

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(intersection-set '(2 3 3 4) '(3 4 1 2 3 4 3))
(intersection-set '(3 4 1 2 3 4 3) '(2 3 3 4))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        (else (union-set (cdr set1) set2))))
