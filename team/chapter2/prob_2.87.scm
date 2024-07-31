; 練習問題 2.87: 多項式に対する =zero? をジェネリック数値演算パ
; ッケージに組み込め。こうすることで、係数がそれ⾃⾝多項式と
; なっている多項式に対して adjoin-term が動作するようになる。

(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (install-polynomial-package)
  (define (=zero-poly? p)
    (let ((terms (term-list p)))
      (define (=zero-terms? terms)
        (if (empty-termlist? terms)
            #t
            (if (=zero? (coeff (first-term terms)))
                (=zero-terms? (rest-terms terms))
                #f)))
      (=zero-terms? terms)))
  (put '=zero? '(polynomial) (lambda (p) (=zero-poly? p)))
  'done)
