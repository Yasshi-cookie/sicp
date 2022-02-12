; 練習問題 2.10:
; エキスパートシステムプログラマの Ben Bitdiddle
; は、Alyssa の肩越しにのぞいてきて、ゼロをまたぐ区間で割った
; 場合にどうなるかはっきりしていないとコメントした。Alyssa の
; コードを修正し、この条件についてチェックして、もしこれが起
; こればエラーのシグナルを送るようにせよ。

; 考え方
; 割る方の区間の上限と下限が0をまたぐ場合orどちらかが0の場合
; （上限、下限の積が0以下の場合）=> 例外を投げる

; 練習問題2.7-2.8
; コンストラクタ
(define (make-interval a b)
  (cons a b))
; セレクタ
(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

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

(define x (make-interval 2 8))
(define y (make-interval 0 4))
(div-interval x y)
