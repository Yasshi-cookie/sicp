; 練習問題 2.41: ある整数 n 以下の異なる正の整数が⼤⼩順に並ん
; だ三つ組 i, j, k の中で、合計がある整数 s となるものすべてを⾒
; つける⼿続きを書け。

(define (find-pairs-whose-sum-is-s n s)
  )

(define (unique-triple n)
  (flatmap
   (lambda (i)
     (map (lambda (j)
            (map (lambda (k) (list i j k)
                         (enumerate-interval 1 (- i 1)))
                 (enumerate-interval 1 (- j 1))))
          (enumerate-interval 1 (- k 1))))))
(unique-triple 5)

(define nil '())
(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
(define (enum-n n)
  (enumerate-interval 1 n))
