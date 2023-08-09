; 練習問題 2.73: 2.3.2 節では、記号微分を⾏うプログラムについて説明した。
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product
                    (multiplier exp)
                    (deriv (multiplicand exp) var))
                   (make-product
                    (deriv (multiplier exp) var)
                    (multiplicand exp))))
        ⟨more rules can be added here⟩
        (else (error "unknown expression type:DERIV" exp))))

; このプログラムは、微分する式の型によってディスパッチを実⾏
; していると捉えることもできる。この場合、データの “タイプタ
; グ” は代数演算記号 (+ など) で、⾏う演算は deriv ということに
; なる。基本的な微分を⾏う⼿続きを次のように書き直すと、プロ
; グラムをデータ主導スタイルに変形できる。

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a. 上で何をしているか説明せよ。⼿続き number? と variable?
; は、なぜデータ主導ディスパッチとして取り込むことができ
; ないのだろうか。
; b. 和と積に対する微分⼿続きと、上記のプログラムで使ってい
; るテーブルにそれらを組み込む補助コードを書け。
; c. 任意の微分規則 (例えば、練習問題 2.56の指数の微分など) を
; 選び、それをこのデータ主導システムに組み込め。
; d. この単純な代数操作では、式の型は式をまとめる代数演算
; ⼦となっている。しかし、仮に⼿続きのインデックスを逆に
; して、deriv でディスパッチを⾏う箇所を次のようにすると
; する。
; ((get (operator exp) 'deriv) (operands exp) var)
; これに対応して、微分システムにはどのような変更を加える
; 必要があるだろうか。



; 参考
;; 直行形式表現 Ben
(define (install-rectangular-package)
  ;; 内部⼿続き
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; システムのほかの部分とのインターフェイス
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;; 極形式表現 Alyassa
(define (install-polar-package)
  ;; 内部⼿続き
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (define (imag-part z) (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; システムのほかの部分とのインターフェイス
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;; generic演算
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types: APPLY-GENERIC"
           (list op type-tags ))))))

; apply-generic を使うと、複素数演算のジェネリックセレクタは以下のように
; 定義できます。
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))
