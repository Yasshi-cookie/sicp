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
(define (make-sum a1 a2) (list '+ a1 a2))
(define (make-product m1 m2) (list '* m1 m2))
; • 和は、最初の要素が記号 + であるリストである。
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
; • 加数は、和のリストの⼆つ⽬の項である。
(define (addend s) (cadr s))
; • 被加数は、和のリストの三つ⽬の項である。
(define (augend s) (caddr s))
; • 積は、最初の要素が記号 * であるリストである。
(define (product? x) (and (pair? x) (eq? (car x) '*)))
; • 乗数は、積のリストの⼆つ⽬の項である。
(define (multiplier p) (cadr p))
; • 被乗数は、積のリストの三つ⽬の項である。
(define (multiplicand p) (caddr p))

(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)

(define (=number? exp num)
  (and (number? exp)
       (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))


(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))
(define (base e) (cadr e))
(define (exponent e) (caddr e))
(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((=number? base 0) 0)
        ((=number? base 1) 1)
        (else (list '** base exponent))))

(deriv (make-exponentiation 'x 3) 'x)
(deriv (make-exponentiation (make-sum 'x 1) 2) 'x)
; gosh> (* 2 (+ x 1))
