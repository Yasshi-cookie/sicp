; 練習問題 2.25: 以下のそれぞれのリストから 7 を取り出す car と
; cdr の組み合わせを書け。
(define list1 (list 1 3 (list 5 7) 9))
(define list2 (list (list 7)))
(define list3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(define test_list (list 1 2 3))
(cdr test_list)

(cadr (caddr list1))
(caar list2)
(cadr (cadr (cadr (cadr (cadr (cadr list3))))))
