; 練習問題 2.54: ⼆つのリストは、同じ要素を同じ順番で持つとき
; に equal? であると⾔える。例えば、
; (equal? '(this is a list) '(this is a list))
; は真である。しかし、
; (equal? '(this is a list) '(this (is a) list))
; は偽である。

(define (equal? list1 list2)
  (cond ((and (null? list1)
              (null? list2)) true)
        ((and (symbol? (car list1))
              (symbol? (car list2))) (and (eq? (car list1) (car list2))
                                          (equal? (cadr list1) (cadr list2))))
        ((and (pair? (car list1))
              (pair? (car list2))) (and (equal? (car list1) (car list2))
                                        (equal? (cadr list1) (cadr list2))))
        (else false)))


(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(use srfi-18)
