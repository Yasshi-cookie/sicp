; 練習問題 2.54: ⼆つのリストは、同じ要素を同じ順番で持つとき
; に equal? であると⾔える。例えば、
; (equal? '(this is a list) '(this is a list))
; は真である。しかし、
; (equal? '(this is a list) '(this (is a) list))
; は偽である。

(define (equal? list1 list2)
  (cond ((not (= (length list1)
                 (length list2))) #f)
        (else (equal-for-same-length-list? list1 list2))))

(define (equal-for-same-length-list? list1 list2)
  (cond ((and (null? list1)
              (null? list2)) #t)
        ((and (symbol? (car list1))
              (symbol? (car list2))) (and (eq? (car list1) (car list2))
                                          (equal? (cdr list1) (cdr list2))))
        ((and (pair? (car list1))
              (pair? (car list2))) (and (equal? (car list1) (car list2))
                                        (equal? (cdr list1) (cdr list2))))
        (else #f)))

(define list1 '(this is a list))
(define list2 '(this is a))

(equal? list1 list2)
