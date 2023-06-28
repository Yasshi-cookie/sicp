; 練習問題 2.70: 以下に⽰す 8 記号の相対頻度つきアルファベット
; は、1950 年代のロックの歌詞を効率よく符号化できるよう設計さ
; れたものである (“アルファベット” の “記号” が単独の⽂字である
; とは限らないことに注意)。

; A 2 GET 2 SHA 3 WAH 1
; BOOM 1 JOB 2 NA 16 YIP 9

; generate-huffman-tree(練習問題 2.69) を使って対応するハフマ
; ン⽊を⽣成し、encode (練習問題 2.68) を使って次のメッセージを
; 符号化せよ。

; Get a job
; Sha na na na na na na na na
; Get a job
; Sha na na na na na na na na
; Wah yip yip yip yip yip yip yip yip yip
; Sha boom

; 符号化には何ビット必要だろうか。もし固定⻑符号をこの 8 記号
; アルファベットに使ったとしたら、最低でどれだけのビット数が
; 必要になるだろうか。

; 参考
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((element-of-set? symbol (symbols (left-branch tree)))
         (append '(0) (encode-symbol symbol (left-branch tree))))
        ((element-of-set? symbol (symbols (right-branch tree)))
         (append '(1) (encode-symbol symbol (right-branch tree))))
        (else (error "Given symbol is not contained in the tree" symbol))))

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

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch )))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-pairs)
  (cond ((<= (length ordered-pairs) 1) (car ordered-pairs))
        (else (successive-merge (adjoin-set (make-code-tree (car ordered-pairs) (cadr ordered-pairs))
                                            (cddr ordered-pairs))))))

(make-leaf-set '((E 16) (D 8) (C 4) (B 2) (A 1)))
(generate-huffman-tree '((A 1) (B 2) (C 4) (D 8) (E 16)))

 (((((leaf A 1) (leaf B 2) (A B) 3) (leaf C 4) (A B C) 7) (leaf D 8) (A B C D)
  15)
 (leaf E 16)
 (A B C D E)
 31)

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (= (length leaf-set) 1)
      (car leaf-set)
      (successive-merge (adjoin-set (make-code-tree (car leaf-set)
                                                    (cadr leaf-set))
                                    (cddr leaf-set)))))


(define sample-pairs '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9)))
(define sample-huffman-tree (generate-huffman-tree sample-pairs))
(define sample-message '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM))

(define sample-huffman-tree '((leaf NA 16)
                              ((leaf YIP 9)
                               (((leaf A 2) ((leaf BOOM 1) (leaf WAH 1) (BOOM WAH) 2) (A BOOM WAH) 4)
                                ((leaf SHA 3) ((leaf JOB 2) (leaf GET 2) (JOB GET) 4) (SHA JOB GET) 7)
                                (A BOOM WAH SHA JOB GET) 11)
                               (YIP A BOOM WAH SHA JOB GET)
                               20)
                              (NA YIP A BOOM WAH SHA JOB GET)
                              36))

(print (encode sample-message sample-huffman-tree))

(define l-pairs '((a 2) (Get 2) (Sha 3) (Wah 1) (boom 1) (job 2) (na 16) (yip 9)))

(define l-pairs '((a 2) (boom 1) (Get 2) (job 2) (Sha 3) (na 16) (Wah 1) (yip 9)))
(define l-huffman-tree (generate-huffman-tree l-pairs))
(define l-message '(Get a job Sha na na na na na na na na Get a job Sha na na na na na na na na Wah yip yip yip yip yip yip yip yip yip Sha boom))

l-huffman-tree

(print (encode l-message l-huffman-tree))

(decode '(0 1 1 1 1 1 0 1 1 0 0 0 1 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 1 1 0 0 0 1 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 0 0 1 1 0 1 0) sample-huffman-tree)

(define l-huffman-tree '((leaf na 16)
                         ((leaf yip 9)
                          (((leaf a 2) ((leaf Wah 1) (leaf boom 1) (Wah boom) 2) (a Wah boom) 4)
                           ((leaf Sha 3) ((leaf job 2) (leaf Get 2) (job Get) 4) (Sha job Get) 7)
                           (a Wah boom Sha job Get) 11)
                          (yip a Wah boom Sha job Get)
                          20)
                         (na yip a Wah boom Sha job Get)
                         36))

(define l-huffman-tree '((leaf na 16)
                         ((leaf yip 9)
                          (((leaf a 2) ((leaf boom 1) (leaf Wah 1) (boom Wah) 2) (a boom Wah) 4)
                           ((leaf Sha 3) ((leaf job 2) (leaf Get 2) (job Get) 4) (Sha job Get) 7)
                           (a boom Wah Sha job Get) 11)
                          (yip a boom Wah Sha job Get)
                          20)
                         (na yip a boom Wah Sha job Get)
                         36))


; 大文字
; me
(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 0)
; iriya
(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)

; 小文字
; me
(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 0)
(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)
