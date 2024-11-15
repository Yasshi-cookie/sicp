; 練習問題 2.94: div-terms を使って⼿続き remainder-terms を実
; 装し、それを使って gcd-terms を上記のように定義せよ。次に、⼆
; つの多項式に対して多項式 gcd を求める⼿続き gcd-poly を書け
; (この⼿続きは、⼆つの多項式が同じ変数のものでなければエラー
; を出すようにする)。システムに greatest-common-divisor とい
; うジェネリック演算を組み込み、多項式は gcd-poly によって簡約
; し、通常の数値は通常の gcd によって簡約するようにせよ。テス
; トとして以下を実⾏せよ。

(define (remainder-terms L1 L2)
  (cadr (div-terms L1 L2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (install-palynomial-package)
  ; ... 省略
  (define (gcd-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (gcd-terms (term-list p1) (term-list p2))
                   )
        (error "2つの多項式の変数が異なります！" (list p1 p2))))
  (put 'greatest-common-divisor '(polynomial polynomial)
       (lambda (p1 p2) (tag (gcd-poly p1 p2))))
  'done)

(define (install-scheme-number-package)
  ; ... 省略
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (put 'greatest-common-divisor '(scheme-number scheme-number)
       (lambda (a b) (tag (gcd a b))))
  'done)
