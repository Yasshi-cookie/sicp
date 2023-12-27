; 練習問題 2.77: Louis Reasoner は、式 (magnitude z) を評価し
; ようとした。ここで、z は 図 2.24に⽰したオブジェクトである。
; 驚いたことに、5 という答えが返ってくるのではなく、applygeneric からのエラーメッセージが返ってきて、型 (complex) に
; は magnitude という演算を⾏う⼿続きがないという。彼がこの
; 対話を Alyssa P. Hacker に⾒せると、Alyssa は “複素数セレクタ
; が polar と rectangular の数値にだけしか定義されていなくて、
; complex の数値に対して定義されていないのが問題なのよ。動く
; ようにするには complex パッケージに以下の式を追加すれば⼤丈
; 夫” と⾔う。

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

; なぜこれが動くのか、詳しく説明せよ。例として、z が図 2.24に
; ⽰したオブジェクトであるとき、式 (magnitude z) を評価した際
; に呼ばれるすべての⼿続きをトレースせよ。具体的には、applygeneric は何回起動されるだろうか。それぞれの場合について、デ
; ィスパッチ先の⼿続きは何になるだろうか。

; 2回呼び出される。
; 1回目の呼び出しでは引数の型がcomplexであり、2回目の型はrectanglerに変化する
