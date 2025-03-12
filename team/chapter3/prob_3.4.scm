; 練習問題 3.4: 練習問題 3.3の make-account ⼿続きを変更して別
; の局所状態変数を追加し、間違ったパスワードで⼝座に 7 回連続
; アクセスされると call-the-cops(警察を呼ぶ) という⼿続きを呼
; ぶようにせよ。

(define (call-the-cops)
  (error "警察に通報します"))

(define (make-account balance password)
  (define incorrect-count 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (eq? p password)
        (begin (set! incorrect-count 0)
               (cond ((eq? m 'withdraw) withdraw)
                     ((eq? m 'deposit) deposit)
                     (else (error "Unknown request: MAKE-ACCOUNT"
                                  m))))
        (begin (set! incorrect-count (+ incorrect-count 1))
               (if (>= incorrect-count 7)
                   (call-the-cops))
               (error "Incorrect password"))))
  dispatch)

(define acc (make-account 100 'secret-password))
((acc 'aaaaa 'withdraw) 40)
