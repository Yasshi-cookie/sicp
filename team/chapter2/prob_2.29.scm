; 練習問題 2.29: ⼆枝モビールは、左の枝と右の枝のという⼆つの
; 枝から構成されている。それぞれの枝はある⻑さを持つ棒で、おも
; りか別の⼆枝モビールがぶら下がっている。⼆枝モビールは、⼆
; つの枝によって構成することで、(例えば list を使って) 複合デー
; タによって表現できる。

(define (make-mobile left right)
  (list left right))

; 枝は、⻑さ length(必ず数値) と構造 structure からなり、structure
; は数値 (単純なおもりを表す) か、または別のモビールである。

(define (make-branch length structure)
  (list length structure))

; sample
(define r-list (list 3 4))
(define l-list (list 1 2))

; a. これに対応する、モビールの枝を返すセレクタ left-branch
; と right-branch、枝の構成要素を返す branch-length と
; branch-structure を書け。
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cadr mobile))

(define (branch-length branch) (car branch))
(define (branch-structure branch) (cadr branch))

; b. これらのセレクタを使って、モビールの総重量を返す⼿続き
; total-weight を定義せよ。
; sample
(define m1 (make-mobile l1 r1))
(define l1 (make-branch 2 m2))
(define r1 (make-branch 2 m3))
(define m2 (make-mobile l2 r2))
(define l2 (make-branch 1 10))
(define r2 (make-branch 1 20))
(define m3 (make-mobile l3 r3))
(define l3 (make-branch 1 m4))
(define r3 (make-branch 1 10))
(define m4 (make-mobile l4 r4))
(define l4 (make-branch 1 10))
(define r4 (make-branch 1 10))

; gosh> ((2 ((1 1) (1 2))) (2 ((1 ((1 1) (1 1))) (1 1))))
; gosh> ((2 ((1 7) (1 8))) (2 ((1 ((1 7) (1 8))) (1 9))))

(define (total-weight mobile)
  (define (is-weight structure)
    (not (pair? structure)))
  (define (branch-weight branch)
    (cond
     ((is-weight (branch-structure branch)) (branch-structure branch))
     (else (total-weight branch))))
  (let (
        (right-b (right-branch mobile))
        (left-b (left-branch mobile)))
    (+ (branch-weight right-b) (branch-weight left-b))))

(total-weight m1)

(let ((i 1) (j 2))
  (+ i j))

(define (fee age)
  (cond
   ((or (<= age 3) (>= age 65)) 0)
   ((<= 4 age 6) 50)
   ((<= 7 age 12) 100)
   ((<= 13 age 15) 150)
   ((<= 16 age 18) 180)
   (else 200)))

; PHPの場合
class Mobile
{
    public Branch $right_branch;
    public Branch $left_branch;

    public function total_weight(): int
    {
        $right_branch = $this->right;
        $left_branch = $this->left;

        $right_weight = $right_branch->getWeight();
        $left_weight = $left_branch->getWeight();

        return $right_weight + $left_weight;
    }
}

class Branch
{
    public int $length;
    public int|Mobile $structure;

    public function getWeight(): int
    {
        if ($this->isWeight()) {
            // 重りの場合
            return $this->weight;
        }

        // Mobileの場合
        return $this->structure->tota_weight();
    }

    public funciton isWeight(): bool
    {
        return pair?($this->structure) ? false : true;
    }
}
