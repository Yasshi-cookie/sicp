; a このアルゴリズムを reduce-terms という⼿続きとして実装
; せよ。⼿続きは n と d という⼆つの項リストを引数として取
; り、上で説明したアルゴリズムによって n と d を既約にし
; た nn と dd のリストを返す。また、add-poly と同様の⼿続
; き reduce-poly を実装せよ。これは⼆つの poly が同じ変数
; を持つかどうかチェックし、もし同じであれば変数を取り去
; って問題を reduce-terms に渡し、reduce-terms に返された
; ⼆つの項リストにその変数をつけ直す。
(define (reduce-terms n d)
    (let ((g (gcd (map coeff (term-list n))))
            (h (gcd (map coeff (term-list d))))
            (nn (mul-term-by-all-terms (make-term 0 (/ (coeff (first-term n)) g)) n))
            (dd (mul-term-by-all-terms (make-term 0 (/ (coeff (first-term d)) h)) d)))
        (list nn dd)))
(define (reduce-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (let ((new-p1 (make-polynomial (variable p1) (reduce-terms (term-list p1) (term-list p2)))))
            (make-polynomial (variable p1) (term-list new-p1)))
        (error "Polynomials not in the same varialbe -- REDUCE-POLY" p1 p2)))

; b reduce-terms と似たような⼿続きとして、元々の make-rat
; が整数に対して⾏っていたことと同じことを実⾏するものを
; 次のように定義せよ。
(define (reduce-integers n d)
(let ((g (gcd n d)))
(list (/ n g) (/ d g))))
; そして、reduce というジェネリック演算を定義せよ。これ
; は、apply-generic を呼んで、reduce-poly(polynomial 型引
; 数に対して) または reduce-integers(scheme-number 型引
; 数に対して) にディスパッチする。こうすると、make-rat が
; 分⼦と分⺟を組み合わせて有理数を作る前に reduce を呼ぶ
; ようにすることで、有理数算術演算パッケージが有理数を既
; 約にするようにできる。これで、このシステムは整数と多項
; 式のどちらの有理式も扱えるようになった。プログラムをテ
; ストするために、この拡張練習問題の最初に出てきた例を試
; してみよ。
(define p1 (make-polynomial 'x '((1 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 -1))))
(define p3 (make-polynomial 'x '((1 1))))
(define p4 (make-polynomial 'x '((2 1) (0 -1))))
(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))
(add rf1 rf2)
; 正しく既約になっている正しい答えが返ってくるかどうかを
; 確認せよ。
