; 練習問題 2.69: 以下の⼿続きは、引数として記号・頻度ペアのリ
; スト (同じ記号が⼆つ以上のペアに出てくることはない) を取り、
; ハフマンアルゴリズムに従ってハフマン符号化⽊を⽣成する。

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; make-leaf-set は、上で記述した、ペアのリストを葉の順序つき
; 集合に変換する⼿続きである。successive-merge は、集合の中で
; 重みが最⼩の要素を make-code-tree を使って順番にくっつけて
; いき、最後に要素がひとつだけ残るようにするというものである。
; その要素が求めるハフマン⽊となる。この⼿続きを書け (この⼿続
; きにはちょっと厄介なところがあるが、そこまで複雑ではない。も
; し⼿続きの設計が複雑になったとしたら、ほぼ確実に何かを間違
; えている。順序つきの集合表現を使っているということが⼤きな
; 助けになる)。

(define sample-pairs '((A 4) (B 2) (C 1) (D 1)))

(define (successive-merge ordered-pairs)
  (cond ((<= (length ordered-pairs) 1) ordered-pairs)
        (else (successive-merge (adjoin-set (make-code-tree (car ordered-pairs) (cadr ordered-pairs))
                                            (cddr ordered-pairs))))))

(generate-huffman-tree sample-pairs)
; (((leaf A 4) ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4) (A B D C) 8))

(make-code-tree (make-leaf 'C 1) (make-leaf 'D 1))

; 参考
(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))
