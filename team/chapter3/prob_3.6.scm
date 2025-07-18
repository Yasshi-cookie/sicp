練習問題 3.6: 乱数⽣成器をリセットして、与えられた値から始
まる数列を作れるようにできると便利だ。記号 generate または
reset のどちらかを引数として取り、次のようなふるまいをする新
しい rand ⼿続きを設計せよ。(rand 'generate) は新しい乱数を
⽣成する。((rand 'reset) ⟨new-value ⟩) は内部の状態変数を指定
された ⟨new-value⟩ にリセットする。つまり、状態をリセットする
ことによって、再現可能な数列が⽣成できる。これは乱数を使うプ
ログラムをテストしたりデバッグしたりするのにとても役に⽴つ。

; 既存の定義
(define rand (let ((x random-init))
               (lambda ()
                 (set! x (rand-update x))
                 x)))

(define (rand operator)
  (cond ((eq? operator 'generate)
         (let ((x random-init))
           (set! x (rand-update x))
           x))
        ((eq? operator 'reset))
         (lambda (new-value)
           (set! random-init new-value)
           (set! x new-value))
        (else
         (error "Unknown operator" operator))))
