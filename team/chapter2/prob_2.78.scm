; 練習問題 2.78: scheme-number パッケージの内部⼿続きは、本質
; 的に基本⼿続き +, - その他に対する呼び出しでしかない。ここで
; のタイプタグシステムでは、各データオブジェクトに型がくっつ
; いていないといけないようになっていたので、直接この⾔語の基
; 本⼿続きを使うことはできなかった。しかし、実際のところ、Lisp
; の実装はすべて型システムを持っていて、内部で使⽤している。
; symbol? や number? のような基本述語は、データオブジェクトが
; 特定の型を持つか識別している。2.4.2 節の type-tag, contents,
; attach-tag の定義を変更し、ここでのジェネリックシステムが
; Scheme の内部型システムを利⽤できるようにせよ。つまり、シス
; テムの挙動はそのままで、普通の数値を car が scheme-number と
; いう記号であるペアとして表すのではなく、単に Scheme の数値
; として表現されるようにせよ。

; @return integer|pair
(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))
; @param integer|pair datum
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: TYPE-TAG" datum))))
; @param integer|pair datum
(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum: CONTENTS" datum))))

; テスト
(define scheme-num (attach-tag 'scheme-number 2))
(type-tag scheme-number)
(contents scheme-number)
