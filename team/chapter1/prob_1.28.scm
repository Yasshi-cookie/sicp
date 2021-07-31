(define (expmod base exp m)
    (cond ((= exp 0) 1)
        ((even? exp)
            (remainder
                (square (expmod base (/ exp 2) m))
            m))
        (else
            (remainder
                (* base (expmod base (- exp 1) m))
            m))))

(define (fermat-test a n)
    (define (try-it a n)
        (= (expmod a (n - 1) n) 1)
    )
    (try-it (+ 1 (random (- n 1)))
    )
)

; expmodの処理
; n = 15, a = 2
(expmod 2 14 15)
(remainder (square (expmod 2 7 15)) 15)
(remainder (square
    (remainder (* 2 (expmod 2 6 15)) 15)
    ) 15)
(remainder (square (
    (remainder (* 2
        (remainder (square (expmod 2 3 15)) 15)) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (expmod 2 2 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (
                remainder (square (expmod 2 1 15)) 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (
                remainder (square (
                    remainder (* 2 (expmod 2 0 15)) 15)) 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (
                remainder (square (
                    remainder (* 2 1) 15)) 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (
                remainder (square (
                    remainder 2 15)) 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (
                remainder (square 2) 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 (
                remainder 4 15)) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder (* 2 4) 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square
            (remainder 8 15)) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder (square 8) 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 (
        (remainder 64 15))) 15)
    )) 15)
(remainder (square (
    (remainder (* 2 4)) 15)
    ) 15)
(remainder (square
    (remainder 8 15)
    ) 15)
(remainder (square 8
    ) 15)
(remainder 64 15)
4
