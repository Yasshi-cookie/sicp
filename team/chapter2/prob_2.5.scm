; a と b のペアを積 2^a * 3^b の整数で表現することによって、
; ⾮負整数のペアを数値と数値演算だけを使って表現できるということを⽰せ。
; それに対応する cons, car, cdr ⼿続きを定義せよ。
(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))
(define (car z)
  (factor-num-count z 2 0))
(define (cdr z)
  (factor-num-count z 3 0))

(define (factor-num-count z num count)
  (if (not (= (mod z num) 0))
      count
      (factor-num-count (/ z num) num (+ count 1))))
(define z (cons 3 4))
(car z)
(cdr z)
