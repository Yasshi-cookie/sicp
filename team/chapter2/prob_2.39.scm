; 練習問題 2.39: 以下の reverse(練習問題 2.18) ⼿続きの定義を、練
; 習問題 2.38の fold-right と fold-left によって完成させよ。

(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))
(define (reverse sequence)
  (fold-left (lambda (x y) (append (list y) x)) nil sequence))

(define sequence '(1 2 3 4))
(reverse sequence)

(define nil '())

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
