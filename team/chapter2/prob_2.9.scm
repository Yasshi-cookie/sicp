; 練習問題 2.9:
; 区間の幅 (width) は、上限と下限の差の半分である。
; 幅は、区間によって規定される数値の不確かさの程度である。い
; くつかの数値演算では、⼆つの区間を組み合わせた結果の幅は、引
; 数の区間の幅のみによる関数となるが、それら以外の演算では、組
; み合わせたものの幅は、引数の幅の関数とはならない。⼆つの区
; 間の和 (または差) の幅は、⾜される (または引かれる) 区間の幅の
; 関数となることを⽰せ。これが乗算と除算については正しくない
; ということを例を挙げて⽰せ。

; 区間Iに対してその幅をw(I)と書くことにする
; A, Bを区間とする
; このとき次が成り立つ；
; w(A + B) = w(A) + w(B)
; w(A - B) = w(A) + w(B)
; よって和と差に関しては示された。
; 積について、
; l_a : Aの下限
; u_a : Aの上限
; l_b : Bの下限
; u_b : Bの上限
; とするとき、mul-intervalの定義より、
; w(A * B)は、4つの項l_a * l_b, l_a * u_b, u_a * l_b, u_a * u_bの関数である。
; 一方で、
; w(A) = (u_a - l_a) / 2
; w(B) = (u_b - l_b) / 2
; である。
; 示すべきことは、「w(A * B)がw(A)とw(B)の関数ではない」ということである。
; つまり、「w(A)とw(B)を決めてもw(A * B)の値が（一意に）決まらないこと」を示せば良い。
; 実際にw(A)とw(B)が決まっても、l_a * l_b, l_a * u_b, u_a * l_b, u_a * u_bは決定されないから、
; w(A * B)の値は決まらない。よって、積の場合も示された。
; 商の場合も同様である。
