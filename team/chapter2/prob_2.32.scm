; 練習問題 2.32: 集合は、それぞれ異なる要素を持つリストとして
; 表現できる。また、集合のすべての部分集合の集合は、リストのリ
; ストとして表現できる。例えば、集合が (1 2 3) の場合、すべて
; の部分集合の集合は (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2
; 3)) となる。以下に、集合のすべての部分集合の集合を⽣成する⼿
; 続きを⽰す。これを完成させ、なぜそれが動作するのかを明確に
; 説明せよ。

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (print rest)
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))
(define nil '())
(subsets (list 1 2 3))
s = (1 2 3)
(subset s)
=
(subsets (1 2 3))
=
(let ((rest (subsets (cdr (1 2 3)))))
(let ((rest (subsets (cdr (2 3)))))
(let ((rest (subsets (cdr (3)))))
    (append rest (map ⟨??⟩ rest)))
    = (let ((rest (list nil)))
        (append rest (map ⟨??⟩ rest)))
    = (append (list nil) (map ⟨??⟩ (list nil))))

(let ((rest (subsets (cdr (2 3)))))
    (append rest (map ⟨??⟩ rest)))
    = (let ((rest (append (list nil) (map ⟨??⟩ (list nil))))))
        (append rest (map ⟨??⟩ rest)))
    = (append (append (list nil) (map ⟨??⟩ (list nil))) (map ⟨??⟩ (append (list nil) (map ⟨??⟩ (list nil)))))
