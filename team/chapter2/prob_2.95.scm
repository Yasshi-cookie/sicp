; 練習問題 2.95: 以下の多項式 P1, P2, P3 を定義せよ。
; P1 : x^2 - 2x + 1,
; P2 : 11x^2 + 7,
; P3 : 13x + 5.
; 次に、P1 と P2 の積 Q1、P1 と P3 の積 Q2 を定義し、greatest-common-divisor(練習問題 2.94) を使って
; Q1 と Q2 の gcd を求めよ。答えが P1 と同じにならないことに注意せよ。
; この例では計算に⾮整数演算の演算が絡んでくるので、gcd アルゴリズムが困難になっている。
; 何が起こっているか理解するために、gcd の計算時に gcd-terms をトレースせよ。
; または、この除算を⼿計算で実⾏せよ。

; Q1 = P1 * P2 = (x^2 - 2x + 1) * (11x^2 + 7) = 11x^4 - 22x^3 + 18x^2 - 14x + 7
; Q2 = P1 * P3 = (x^2 - 2x + 1) * (13x + 5) = 13x^3 - 21x^2 + 3x + 5

; Q1 = 11x^4 - 22x^3 + 18x^2 - 14x + 7
; Q2 = 13x^3 - 21x^2 + 3x + 5

; Q1 → Q1 - x*Q2 = -2x^4 - x^3 + 15x^2 - 19x + 7
; Q2             = 13x^3 - 21x^2 + 3x + 5
