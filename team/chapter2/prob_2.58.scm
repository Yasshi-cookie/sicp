; 練習問題 2.58: 微分プログラムを修正して、+ と * が前置演算⼦で
; はなく中置演算⼦となるような、通常の数学の記法に対して動作
; させたいとする。微分プログラムは抽象データによって定義され
; ているので、微分プログラムの動作基盤となる代数式の表現を定
; 義する述語、セレクタ、コンストラクタを変更するだけで、異なる
; 表現を扱うように修正できる。

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (make-product
                        (exponent exp)
                        (make-exponentiation (base exp) (- (exponent exp) 1)))
                       (deriv (base exp) var)))
        (else
         (error "unknown expression type: DERIV" exp))))

; • 変数は記号である。基本述語 symbol? で識別する。
(define (variable? x) (symbol? x))
; • ⼆つの変数は、それらを表現する記号が eq? であれば等しい。
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
; • 和と積は、リストとして構築する。
(define (make-sum a1 a2) (list a1 '+ a2))
(define (make-product m1 m2) (list m1 '* m2))
; • 和は、最初の要素が記号 + であるリストである。
(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
; • 加数は、和のリストの⼆つ⽬の項である。
(define (addend s) (car s))
; • 被加数は、和のリストの三つ⽬の項である。
; (define (augend s) (caddr s))
(define (augend s)
  (cond ((= (length (cddr s)) 1) (caddr s))
        (else (cddr s))))

; • 積は、最初の要素が記号 * であるリストである。
(define (product? x) (and (pair? x) (eq? (cadr x) '*)))
; • 乗数は、積のリストの⼆つ⽬の項である。
(define (multiplier p) (car p))
; • 被乗数は、積のリストの三つ⽬の項である。
; (define (multiplicand p) (caddr p))
(define (multiplicand p)
  (cond ((= (length (cddr p)) 1) (caddr p))
        (else (cddr p))))

(define (=number? exp num)
  (and (number? exp)
       (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(deriv '(x + (3 * (x + (y + 2)))) 'x)
; 4
(deriv '; 練習問題 2.58: 微分プログラムを修正して、+ と * が前置演算⼦で
; はなく中置演算⼦となるような、通常の数学の記法に対して動作
; させたいとする。微分プログラムは抽象データによって定義され
; ているので、微分プログラムの動作基盤となる代数式の表現を定
; 義する述語、セレクタ、コンストラクタを変更するだけで、異なる
; 表現を扱うように修正できる。

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (make-product
                        (exponent exp)
                        (make-exponentiation (base exp) (- (exponent exp) 1)))
                       (deriv (base exp) var)))
        (else
         (error "unknown expression type: DERIV" exp))))

; • 変数は記号である。基本述語 symbol? で識別する。
(define (variable? x) (symbol? x))
; • ⼆つの変数は、それらを表現する記号が eq? であれば等しい。
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
; • 和と積は、リストとして構築する。
(define (make-sum a1 a2) (list a1 '+ a2))
(define (make-product m1 m2) (list m1 '* m2))
; • 和は、最初の要素が記号 + であるリストである。
(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
; • 加数は、和のリストの⼆つ⽬の項である。
(define (addend s) (car s))
; • 被加数は、和のリストの三つ⽬の項である。
; (define (augend s) (caddr s))
(define (augend s)
  (cond ((= (length (cddr s)) 1) (caddr s))
        (else (cddr s))))

; • 積は、最初の要素が記号 * であるリストである。
(define (product? x) (and (pair? x) (eq? (cadr x) '*)))
; • 乗数は、積のリストの⼆つ⽬の項である。
(define (multiplier p) (car p))
; • 被乗数は、積のリストの三つ⽬の項である。
; (define (multiplicand p) (caddr p))
(define (multiplicand p)
  (cond ((= (length (cddr p)) 1) (caddr p))
        (else (cddr p))))

(define (=number? exp num)
  (and (number? exp)
       (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(deriv '(x + (3 * (x + (y + 2)))) 'x)
; 4
(deriv '(x + (x + (x + y + 2))) 'x)
; (1 + (x + (x + (y + 2))))

 (define (min-operator expr)
   (accumulate (lambda (x y)
     (if (and (operator? x) (or (null? y) (< (precedence x) (precedence y)))) x y))
          nil
          expr))
