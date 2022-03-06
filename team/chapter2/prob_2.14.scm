; Lem が正しいことを⽰せ。いろいろな数値演算の
; 式についてこのシステムの挙動を調査せよ。何らかの区間 A と B
; を作成し、それらを使って式 A/A と A/B を計算せよ。中央値に
; 対して⼩さなパーセンテージの幅を持つ区間について調べると得
; られるところが⼤きいだろう。中央値-パーセント形式 (練習問題
; 2.12参照) の計算結果を調べよ。

; 考察
; 注意点について：「代数的に等価」とテキストには書かれてあるが、Lemが行った変形は区間に対する四則演算においては「等価ではない」
; なぜなら、任意の区間 I = (l, u)（簡単にするためIは正の区間とする）にたいして、I/I = (l/u, u/l)であり、これは単位元にならない。
; したがって、Lemが行った「(R_1 * R_2)^(-1)を分母分子にかける」、つまり「(R_1 * R_2)^(-1) / (R_1 * R_2)^(-1)をかける」という操作は
; 元の式を「元の式と等価でないもの」に変形してしまうものである。

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
                       (div-interval one r2)))))

; 前回までの定義
(define (make-interval a b)
  (cons a b))
; セレクタ
(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

; 和
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

; -1倍
(define (minus-1 x)
  (make-interval (* -1 (upper-bound x))
                 (* -1 (lower-bound x))))

; 差
(define (sub-interval x y)
  (add-interval x (minus-1 y)))


; 積
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; 除
(define (div-interval x y)
  (if (< (* (upper-bound y) (lower-bound y))
          0)
      (error "割る方の区間は0をまたいではいけません。"))
  (if (= (* (upper-bound y) (lower-bound y))
         0)
      (error "割る方の区間の端点は0であってはいけません。"))
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
; (define (center i)
;   (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c percent)
  (make-interval (- c (* c (/ percent 100))) (+ c (* c (/ percent 100)))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (* 100
     (/ (- (upper-bound i) (lower-bound i))
        (+ (upper-bound i) (lower-bound i)))))


(define interval-a (make-center-percent 6.0 0.1))
(define interval-b (make-center-percent 3.0 0.2))

(define par1-intvl (par1 interval-a interval-b))
; (1.9913488681757654 . 2.008682242990654)
(define par2-intvl (par2 interval-a interval-b))
; (1.9966662216288384 . 2.003332889480692)

(define par1-center (center par1-intvl))
; 2.00001555558321
(define par2-center (center par2-intvl))
; 1.9999995555547652
(define par1-percent (percent par1-intvl))
; 0.433331000014004
(define par2-percent (percent par2-intvl))
; 0.16666673333345916

(make-center-percent par1-center par1-percent)
; (1.9913488681757656 . 2.0086822429906546)
(make-center-percent par2-center par2-percent)
; (1.9966662216288382 . 2.003332889480692)

(define a/a (div-interval interval-a interval-a))
(define a/b (div-interval interval-a interval-b))

(center a/a)
(center a/b)
(percent a/a)
(percent a/b)
