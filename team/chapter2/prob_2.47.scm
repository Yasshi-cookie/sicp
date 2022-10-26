; 練習問題 2.47: 次に、枠のコンストラクタとして使えるものを⼆
; つ挙げる。
; それぞれのコンストラクタに対し、適切なセレクタを加えて枠の
; 実装を完成させよ。

; case1
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (caddr frame))

; case2
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (cddr frame))

(define origin (make-vect 0 0))
(define edge1 (make-vect 1 2))
(define edge2 (make-vect 3 4))
(define frame (make-frame origin edge1 edge2))
(origin-frame frame)
(edge1-frame frame)
(edge2-frame frame)
; gosh> (0 . 0)
; gosh> (1 . 2)
; gosh> (3 . 4)
