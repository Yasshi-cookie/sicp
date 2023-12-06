; 練習問題 2.76: ジェネリック演算を使った⼤きなシステムが発展
; するにつれ、新しいデータオブジェクトの型や新しい演算が必要
; になることがある。三つの戦略 (明⽰的ディスパッチによるジェネ
; リック演算、データ主導スタイル、メッセージパッシングスタイ
; ル) それぞれについて、新しい型や新しい演算を追加するために必
; 要な変更を記述せよ。新しい型がよく追加されるシステムでは、ど
; の組み⽴て⽅が最も適しているだろうか。新しい演算を追加する
; システムでは、どれが最も適しているだろうか。

演算が増える場合は、
「明⽰的ディスパッチによるジェネリック演算」のほうが楽

型が増える場合は、
「データ主導スタイル」と「メッセージパッシングスタイル」の方が楽。

「データ主導スタイル」と「メッセージパッシングスタイル」については、
オブジェクト指向で例えると下記のようなイメージです。
; class ComplexRealImag implements Complex
; {
;     private x: number;
;     private y: number;

;     constructor(x: number, y: number) {
;         this.x = x
;         this.y = y
;     }

;     add_complex(): number {
;         return 1
;     }

;     sub_complex(): number {
;         return 1
;     }

;     mul_complex(): number {
;         return 1
;     }

;     div_complex(): number {
;         return 1
;     }
; }

; class ComplexMagAng implements Complex
; {
;     private r: number;
;     private a: number;

;     constructor(r: number, a: number) {
;         this.r = r
;         this.a = a
;     }

;     add_complex(): number {
;         return 1
;     }

;     sub_complex(): number {
;         return 1
;     }

;     mul_complex(): number {
;         return 1
;     }

;     div_complex(): number {
;         return 1
;     }
; }

; interface Complex
; {
;     add_complex(): number

;     sub_complex(): number

;     mul_complex(): number

;     div_complex(): number
; }

; class DataDirectedComplex
; {
;     static add_complex(complex: Complex) {
;         return complex.add_complex();
;     }

;     static sub_complex(complex: Complex) {
;         return complex.sub_complex();
;     }

;     static mul_complex(complex: Complex) {
;         return complex.mul_complex();
;     }

;     static div_complex(complex: Complex) {
;         return complex.div_complex();
;     }
; }

; // データ主導プログラミング
; DataDirectedComplex.add_complex(new ComplexRealImag(1, 2));
; // メッセージパッシング
; (new ComplexRealImag(1, 2)).add_complex();
; // 明示的ディスパッチはDataDirectedComplexが具象クラスごとに用意されているイメージ
