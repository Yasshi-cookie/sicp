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
(define unbaranced-m1 (make-mobile unb-l1 unb-r1))
(define unb-l1 (make-branch 2 unb-m2))
(define unb-r1 (make-branch 2 unb-m3))
(define unb-m2 (make-mobile unb-l2 unb-r2))
(define unb-l2 (make-branch 1 10))
(define unb-r2 (make-branch 1 20))
(define unb-m3 (make-mobile unb-l3 unb-r3))
(define unb-l3 (make-branch 1 unb-m4))
(define unb-r3 (make-branch 1 10))
(define unb-m4 (make-mobile unb-l4 unb-r4))
(define unb-l4 (make-branch 1 10))
(define unb-r4 (make-branch 1 10))

; gosh> ((2 ((1 1) (1 2))) (2 ((1 ((1 1) (1 1))) (1 1))))
; gosh> ((2 ((1 7) (1 8))) (2 ((1 ((1 7) (1 8))) (1 9))))

(define (total-weight mobile)
  (define (is-weight structure)
    (not (pair? structure)))
  (define (branch-weight branch)
    (cond
     ((is-weight (branch-structure branch)) (branch-structure branch))
     (else (total-weight (branch-structure branch)))))
  (let (
        (right-b (right-branch mobile))
        (left-b (left-branch mobile)))
    (+ (branch-weight right-b) (branch-weight left-b))))

(total-weight not-baranced-m1)

; test
(define baranced-m1 (make-mobile l1 r1))
(define l1 (make-branch 2 m2))
(define r1 (make-branch 2 m3))
(define m2 (make-mobile l2 r2))
(define l2 (make-branch 2 10))
(define r2 (make-branch 1 20))
(define m3 (make-mobile l3 r3))
(define l3 (make-branch 1 m4))
(define r3 (make-branch 2 10))
(define m4 (make-mobile l4 r4))
(define l4 (make-branch 1 10))
(define r4 (make-branch 1 10))

(is-baranced baranced-m1 #t)
(is-baranced unbaranced-m1 #t)

; Mobile
(define (is-baranced mobile result-bool)
  (if (not (has-mobile mobile))
      result-bool
      (and (if (is-whose-structre-is-mobile (right-branch mobile))
               (is-baranced (branch-structure (right-branch mobile)) (and (is-local-baranced (branch-structure (right-branch mobile))) result-bool))
               #t)
           (if (is-whose-structre-is-mobile (left-branch mobile))
               (is-baranced (branch-structure (left-branch mobile)) (and (is-local-baranced (branch-structure (left-branch mobile))) result-bool))
               #t))))

(define (is-local-baranced mobile)
  (= (moment (right-branch mobile))
     (moment (left-branch mobile))))

(define (has-mobile mobile)
  (or (pair? (right-branch mobile))
      (pair? (left-branch mobile))))

; Branch
(define (branch-weight branch)
  (cond
   ((is-whose-structre-is-weight branch) (branch-structure branch))
   (else (total-weight (branch-structure branch)))))

(define (is-whose-structre-is-weight branch)
  (not (pair? (branch-structure branch))))

(define (is-whose-structre-is-mobile branch)
  (pair? (branch-structure branch)))

(define (moment branch)
  (* (branch-length branch) (branch-weight branch)))

; (let ((i 1) (j 2))
;   (+ i j))

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
        $right_branch = $this->right_branch;
        $left_branch = $this->left_branch;

        $right_weight = $right_branch->getWeight();
        $left_weight = $left_branch->getWeight();

        return $right_weight + $left_weight;
    }

    public function is_baranced()
    {
        if (!$this->hasMobile) {
            return $this->result;
        }

        if ($this->right_branch->isWhoseStructureIsMobile()) {
            $this->result = $this->result && $this->right_branch->structure->is_local_baranced();
            $this->right_branch->structure->is_baranced()
        }

        if ($this->left_branch->isWhoseStructureIsMobile()) {
            $this->result = $this->result && $this->left_branch->structure->is_local_baranced();
            $this->left_branch->structure->is_baranced()
        }
    }

    private function is_local_baranced()
    {
        return $this->right_branch->moment()
            === $this->left_branch->moment();
    }

    private function hasMobile()
    {
        return pair?($this->right_branch) || pair?($this->left_branch);
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
            return $this->structure;
        }

        // Mobileの場合
        return $this->structure->tota_weight();
    }

    public funciton isWeight(): bool
    {
        return pair?($this->structure) ? false : true;
    }

    public function moment(): float
    {
        $this->length * $this->getWeight();
    }
}
