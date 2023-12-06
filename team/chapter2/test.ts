class ComplexRealImag implements Complex
{
    private x: number;
    private y: number;

    constructor(x: number, y: number) {
        this.x = x
        this.y = y
    }

    add_complex(): number {
        return 1
    }

    sub_complex(): number {
        return 1
    }

    mul_complex(): number {
        return 1
    }

    div_complex(): number {
        return 1
    }
}

class ComplexMagAng implements Complex
{
    private r: number;
    private a: number;

    constructor(r: number, a: number) {
        this.r = r
        this.a = a
    }

    add_complex(): number {
        return 1
    }

    sub_complex(): number {
        return 1
    }

    mul_complex(): number {
        return 1
    }

    div_complex(): number {
        return 1
    }
}

interface Complex
{
    add_complex(): number

    sub_complex(): number

    mul_complex(): number

    div_complex(): number
}

class DataDirectedComplex
{
    static add_complex(complex: Complex) {
        return complex.add_complex();
    }

    static sub_complex(complex: Complex) {
        return complex.sub_complex();
    }

    static mul_complex(complex: Complex) {
        return complex.mul_complex();
    }

    static div_complex(complex: Complex) {
        return complex.div_complex();
    }
}

// データ主導プログラミング
DataDirectedComplex.add_complex(new ComplexRealImag(1, 2));
// メッセージパッシング
(new ComplexRealImag(1, 2)).add_complex();
