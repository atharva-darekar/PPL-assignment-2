#lang racket/base

(require racket/runtime-path)

(define-runtime-path solution-module "../code/25_q4.rkt")

(define solution-namespace
  (begin
    (dynamic-require solution-module #f)
    (module->namespace solution-module)))

(define (captured-output input expression)
  (define input-port (open-input-string input))
  (define output-port (open-output-string))
  (parameterize ((current-input-port input-port)
                 (current-output-port output-port)
                 (current-namespace solution-namespace))
    (eval expression))
  (get-output-string output-port))

(define (check-output label actual expected)
  (if (equal? actual expected)
      (void)
      (error label actual expected)))

;; PDF examples.
(check-output 'pdf-example-1
              (captured-output "42 ((1 2) (3 4 5) (6) ()) 3"
                               '(print-insert-result))
              "((42 1 2) (3 4 5) (42 6) (42))\n")
(check-output 'pdf-example-2
              (captured-output "0 (((1) 2) (3) ((4 5 6) ())) 3"
                               '(print-insert-result))
              "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))\n")
(check-output 'pdf-example-3
              (captured-output "7 () 3" '(print-insert-result))
              "(7)\n")
(check-output 'pdf-example-4
              (captured-output "7 () 0" '(print-insert-result))
              "()\n")

;; Edge cases: threshold boundary, nested empty lists, symbols, and no match.
(check-output 'threshold-boundary
              (captured-output "q ((1) (2 3)) 2" '(print-insert-result))
              "((q 1) (2 3))\n")
(check-output 'nested-empty-lists
              (captured-output "m (() (())) 1" '(print-insert-result))
              "((m) ((m)))\n")
(check-output 'symbols-and-empty-list
              (captured-output "mark (a (b) ()) 2" '(print-insert-result))
              "(a (mark b) (mark))\n")
(check-output 'no-list-is-short-enough
              (captured-output "z (1 2 3) 2" '(print-insert-result))
              "(1 2 3)\n")

;; A non-"short" predicate proves make-inserter itself is generic.
(check-output 'generic-make-inserter
              (captured-output ""
                               '(begin
                                  (display ((make-inserter 'z
                                                           (lambda (len) (= len 0)))
                                            '(a (b c) ())))
                                  (newline)))
              "(a (b c) (z))\n")

;; Required hidden-test shapes: a 10,000-element list and nesting depth 100.
(check-output 'wide-list
              (captured-output ""
                               '(let loop ((i 10000) (acc '()))
                                  (if (= i 0)
                                      (begin
                                        (insert-if-short 'x acc 0)
                                        (display 'wide-ok))
                                      (loop (- i 1) (cons i acc)))))
              "wide-ok")
(check-output 'deep-list
              (captured-output ""
                               '(let loop ((i 100) (acc '()))
                                  (if (= i 0)
                                      (begin
                                        (insert-if-short 'x acc 2)
                                        (display 'deep-ok))
                                      (loop (- i 1) (list acc)))))
              "deep-ok")
