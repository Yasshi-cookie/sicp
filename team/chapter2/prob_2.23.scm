; 練習問題 2.23: ⼿続き for-each は map に似ている。引数として⼿
; 続きと要素のリストを取る。しかし、結果のリストを⽣成するの
; ではなく、for-each は⼿続きをそれぞれの要素に左から右に順番
; に⼿続きを適⽤していくだけである。⼿続きを要素に適⽤して返
; される値はまったく使わない—for-each は、表⽰のような、何か
; のアクションを実⾏する⼿続きとともに使う。例えば次の例で、
(for-each (lambda (x)
            (newline)
            (display x))
          (list 57 321 88))
; 57
; 321
; 88
; for-each への呼び出し (上では⽰していないが) に返される値は
; 何でもよく、例えば真の値などでもよい。for-each を実装せよ。

(define (for-each proc items)
  (cond ((null? items) (newline))
        (else (proc (car items))
              (for-each proc (cdr items)))))
