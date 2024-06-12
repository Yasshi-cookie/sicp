; 練習問題 2.85: この節では、あるデータオブジェクトを型のタワ
; ーの中で可能な限り下げていくことによって “単純化” するという
; ⽅法について触れた。練習問題 2.83で述べたタワーについて、こ
; れを実⾏する⼿続き drop を設計せよ。ポイントは、オブジェクト
; を下げることができるかどうかを何らかの汎⽤的なやり⽅で決め
; るということにある。例えば、複素数 1.5 + 0i は real まで下げる
; ことができ、複素数 1 + 0i は integer まで下げることができるが、
; 複素数 2 + 3i はまったく下げることができない。以下に、あるオブ
; ジェクトを下げることができるかどうかを決める計画のひとつを
; ⽰す。まず、オブジェクトをタワーの中で⼀階下に “押す” ジェネ
; リック演算 project (射影) を定義する。例えば、複素数の射影で
; は虚部を捨てることになる。こうすると、ある数値を project し
; て、その結果を元の型に raise したときに、最初のものと等しい
; 何かになっていれば、その数値は下げることができるということ
; になる。可能な限りオブジェクトを落とす⼿続き drop を書くこと
; で、この考え⽅を実装するやり⽅を詳しく⽰せ。いろいろな射影
; 演算を設計し、project をジェネリック演算としてシステムに
; 組み込むことが必要になる。また、練習問題 2.79で述べたジェネ
; リック等価性述語を利⽤することも必要となる。最後に、drop を
; 使って練習問題 2.84の apply-generic を書き直し、解答を “単純
; 化” するようにせよ。

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (drop (car args)))
                    (a2 (drop (cadr args)))
                    (diff (sub-nest type1 type2)))
                (cond ((< diff 0)
                       (apply-generic op a1 (raise a2)))
                      ((> diff 0)
                       (apply-generic op (raise a1) a2))
                      (else
                       (apply-generic op a1 a2))))
              (error "No method for these types"
                     (list op type-tags)))))))

; argに対するタワーの中の深さを返す
(define (nest arg)
  (if (eq? arg 'complex)
      0
      (+ 1 (nest (raise arg)))))

; arg-aとarg-bのタワーの中の位置の差を返す
(define (sub-nest arg-a arg-b)
  (- (nest arg-a) (nest arg-b)))

; drop手続きの実装
(define (drop x)
  (if (can-drop? x)
      (drop (project x))
      x))

(define (can-drop? x)
  (eq? x (raise (project x))))

(define (project x)
  (apply-generic 'project x))

; z = x + yi → x
(define (project-complex z)
  (real-part z))

; x → xに最も近い整数
(define (project-real x)
  (round x))

; n/d → n
(define (project-rational r)
  (numer r))

(put 'project 'complex (lambda (x) (project-complex x)))
(put 'project 'real (lambda (x) (project-real x)))
(put 'project 'rational (lambda (x) (project-rational x)))
