; 練習問題 3.3: make-account ⼿続きを修正し、パスワードで守ら
; れた⼝座を作成するようにせよ。具体的には、次のように makeaccount が追加の引数としてひとつの記号を取るようにする。
; (define acc (make-account 100 'secret-password))
; 結果としてできる⼝座オブジェクトは、アカウント作成時のパス
; ワードを伴っている場合にだけ要求を処理し、その他の場合には
; エラーメッセージを出す。
; ((acc 'secret-password 'withdraw) 40)
; 60
; ((acc 'some-other-password 'deposit) 50)
; "Incorrect password"

(define (make-account balance password)
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
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT"
                           m)))
        (error "Incorrect password")))
  dispatch)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
