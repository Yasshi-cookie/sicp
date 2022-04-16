(define mylist (list 1 2))
(car mylist)
(cdr mylist)
(cadr mylist)
(cddr mylist)

(define res_list (list 1 (list 2 (list 3 4))))

(cdr res_list)

(define test_list (list 1 (list 2)))
(car test_list)
(cdr test_list)

(define test2_list (list (list 1 2) (list 3 4)))
