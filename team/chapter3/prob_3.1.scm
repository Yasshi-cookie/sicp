; 練習問題 3.1: アキュムレータ (accumulator) は、ひとつの数値引
; 数を伴って繰り返し呼ばれる⼿続きで、引数を合計に集積してい
; くというものである。呼び出されるたびに現在までに集積された
; 合計を返す。それぞれ独⽴した合計を持つアキュムレータを返す
; ⼿続き make-accumulator を書け。make-accumulator への⼊⼒は、
; 合計の初期値を指定する。例えば、以下のようになる。
(define (make-accumulator value)
  (lambda (x) (begin (set! value (+ value x))
                     value)))
(define A (make-accumulator 5))
(A 10)
(A 10)

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: MAKE-ACCOUNT"
                       m))))
  dispatch)
