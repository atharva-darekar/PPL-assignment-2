#lang racket/base

(require racket/runtime-path)

(define-runtime-path solution-module "../code/49_q3.rkt")

(define solution-namespace
  (begin
    (dynamic-require solution-module #f)
    (module->namespace solution-module)))

(define (captured-output expression)
  (define output-port (open-output-string))
  (parameterize ((current-output-port output-port)
                 (current-namespace solution-namespace))
    (eval expression))
  (get-output-string output-port))

(define (check-output label actual expected)
  (if (equal? actual expected)
      (void)
      (error label actual expected)))

;; PDF examples.
(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))

(check-output 't1-inorder (captured-output `(print-inorder ',t1))
              "(1 2 3 4 5 6 7)\n")
(check-output 't1-all-traversals (captured-output `(print-all-traversals ',t1))
              "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n")
(check-output 't1-height-and-leaves (captured-output `(print-height-and-leaves ',t1))
              "(3 4)\n")

(check-output 't2-all-traversals (captured-output `(print-all-traversals ',t2))
              "(1 2 3)\n(1 2 3)\n(3 2 1)\n")
(check-output 't2-height-and-leaves (captured-output `(print-height-and-leaves ',t2))
              "(3 1)\n")

(check-output 't3-all-traversals (captured-output `(print-all-traversals ',t3))
              "(b a c)\n(a b c)\n(b c a)\n")
(check-output 't3-height-and-leaves (captured-output `(print-height-and-leaves ',t3))
              "(2 2)\n")

(check-output 'empty-inorder (captured-output '(print-inorder '())) "()\n")
(check-output 'empty-all-traversals (captured-output '(print-all-traversals '())) "()\n()\n()\n")
(check-output 'empty-height-and-leaves (captured-output '(print-height-and-leaves '())) "(0 0)\n")

;; Edge cases: a single leaf, a left-skewed tree, and an asymmetric tree.
(define single-node '(42 () ()))
(define left-skewed '(4 (3 (2 (1 () ()) ()) ()) ()))
(define asymmetric '(a (b () (c () ())) (d (e () ()) ())))

(check-output 'single-node-all-traversals (captured-output `(print-all-traversals ',single-node))
              "(42)\n(42)\n(42)\n")
(check-output 'single-node-height-and-leaves (captured-output `(print-height-and-leaves ',single-node))
              "(1 1)\n")

(check-output 'left-skewed-all-traversals (captured-output `(print-all-traversals ',left-skewed))
              "(1 2 3 4)\n(4 3 2 1)\n(1 2 3 4)\n")
(check-output 'left-skewed-height-and-leaves (captured-output `(print-height-and-leaves ',left-skewed))
              "(4 1)\n")

(check-output 'asymmetric-all-traversals (captured-output `(print-all-traversals ',asymmetric))
              "(b c a e d)\n(a b c d e)\n(c b e d a)\n")
(check-output 'asymmetric-height-and-leaves (captured-output `(print-height-and-leaves ',asymmetric))
              "(3 2)\n")
