; 練習問題 2.28: リストとして表現された⽊を引数として取り、
; その⽊のすべての葉を左から右の順で要素として持つリストを返す⼿続き
; fringe を書け。例えば、次のようになる。
(define x (list (list 1 2) (list 3 4)))
(fringe x)
; (1 2 3 4)
(fringe (list x x))
; (1 2 3 4 1 2 3 4)
(car x)
; gosh> (1 2)
(cdr x)
; gosh> ((3 4))
(cadr x)
; gosh> (3 4)
(caadr x)
; gosh> 3
(cdadr x)
; gosh> (4)
(cadadr x)
; gosh> 4
(cddadr x)
; gosh> ()

(pair? (cdr x))
(length (cdr x))

; count-leavesを参考にする。
(define (fringe tree)
  (cond ((null? tree) tree)
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree))
                      (fringe (cdr tree))))))
(fringe (list x x 1 (list 100)))
(append (list 1 2) '())
(pair? (list (list 1 2)))
