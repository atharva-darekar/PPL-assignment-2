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

;; Produce the preorder values, followed by accumulator.
(define (preorder-values tree accumulator)
  (if (empty-tree? tree)
      accumulator
      (cons (tree-value tree)
            (preorder-values
             (tree-left tree)
             (preorder-values (tree-right tree) accumulator)))))

;; Produce the postorder values, followed by accumulator.
(define (postorder-values tree accumulator)
  (if (empty-tree? tree)
      accumulator
      (postorder-values
       (tree-left tree)
       (postorder-values
        (tree-right tree)
        (cons (tree-value tree) accumulator)))))

;; Print the inorder, preorder, and postorder traversals of tree.
(define (print-all-traversals tree)
  (display (inorder-values tree '()))
  (newline)
  (display (preorder-values tree '()))
  (newline)
  (display (postorder-values tree '()))
  (newline))
