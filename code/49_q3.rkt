#lang racket/base

;; A binary tree is either '() or (value left right).
(define (empty-tree? tree)
  (null? tree))

(define (tree-value tree)
  (car tree))

(define (tree-left tree)
  (cadr tree))

(define (tree-right tree)
  (caddr tree))

;; Reverse a proper list without using the forbidden reverse procedure.
(define (my-reverse items)
  (let loop ((remaining items) (reversed '()))
    (if (null? remaining)
        reversed
        (loop (cdr remaining) (cons (car remaining) reversed)))))
