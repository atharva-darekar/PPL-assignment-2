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

;; Produce the inorder values, followed by accumulator.
(define (inorder-values tree accumulator)
  (if (empty-tree? tree)
      accumulator
      (inorder-values
        (tree-left tree)
       (cons (tree-value tree)
             (inorder-values (tree-right tree) accumulator)))))

;; Print the inorder traversal of tree on one line.
(define (print-inorder tree)
  (display (inorder-values tree '()))
  (newline))
