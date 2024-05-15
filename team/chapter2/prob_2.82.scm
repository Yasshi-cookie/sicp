; 練習問題 2.82: apply-generic を⼀般化し、複数の引数⼀般につ
; いて強制型変換を扱うようにするやり⽅を⽰せ。戦略のひとつと
; しては、すべての引数を⼀つ⽬の引数の型に強制型変換すること
; を試み、次に⼆つ⽬の引数の型に強制型変換することを試み、と
; いうことを続けるというものだ。この戦略について (また、上で述
; べた⼆引数バージョンについても)、それが⼗分に⼀般的でないよ
; うな状況の例を挙げよ (ヒント：テーブルには適切な混合型演算
; があり、それが試⾏されないという場合について考える)。

; 具体的な実装は避けているが、coerce-argsが全ての引数を1つの引数に強制型変換を行なっている
; 問題点について
; 次のパッケージの例を考える
; ・パッケージには型Aと型Bがある
; ・型Aと型Bの間で強制型変換はできないとする
; ・型Aの要素と型Bの要素に対する混合型演算（例えば、A + B）が存在するとする。
; このとき、apply-generic演算が下記のような戦略で実装された場合、
; (apply-generic '+ Aの要素 Bの要素) がエラーとなる。
; しかし、一方でapply-generic演算の役割を考えると、A + Bの演算結果を返すべきである。
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((coerced-args (coerce-args args)))
            (if coerced-args
                (apply-generic op coerced-args)
                (error "No method for these types -- APPLY-GENERIC" (list op type-tags))))))))
