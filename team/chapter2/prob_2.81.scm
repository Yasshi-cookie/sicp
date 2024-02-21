; 練習問題 2.81: Louis Reasoner は、引数の型がすでに同じであっ
; ても、apply-generic は引数をお互いの型に強制型変換しようと
; してもいいのではないかと気がついた。そのため、それぞれの型
; の引数をそれ⾃⾝の型に強制型変換 (coerce) する⼿続きを強制型
; 変換テーブルに⼊れる必要があると彼は考えた。例えば、上に⽰
; した scheme-number->complex という強制型変換に加え、彼は次
; のことを⾏う。
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number
              'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)

; a. Louis の強制型変換⼿続きを組み込むと、もし scheme-number
    ; 型の⼆つの引数や complex 型の⼆つの引数とある演算に対
    ; して apply-generic が呼ばれ、その演算がテーブル内でそれ
    ; らの型に対して⾒つからない場合は、何が起こるだろうか。
    ; 例えば、ジェネリックな指数関数演算を定義したとする。
    ; (define (exp x y) (apply-generic 'exp x y))
    ; そして、Scheme-number パッケージに対して指数関数⼿続き
    ; を追加し、ほかのパッケージには追加しないとする。
    ; ;; 以下は Scheme-number パッケージに追加する
    ; (put 'exp '(scheme-number scheme-number)
    ; (lambda (x y) (tag (expt x y))))
    ; ; 基本⼿続き expt を使う
    ; exp を⼆つの複素数の引数で呼び出した場合、何が起こるだ
    ; ろうか。
; Ans. 型変換が行われた後も自分自身の型になり無限ループが発生する。

; b. 同じ型の引数に対する強制型変換について⼿を加えないと
; いけないとする Louis の考え⽅は正しいだろうか。それと
; も、apply-generic はそのままの状態で正しく動作するだろ
; うか。
; c. apply-generic を修正し、⼆つの引数が同じ型であれば強制
; 型変換を試⾏しないようにせよ。
