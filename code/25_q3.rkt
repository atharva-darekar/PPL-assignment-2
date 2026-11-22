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

;; Return (height leaf-count) for tree.
(define (height-and-leaves tree)
  (if (empty-tree? tree)
      (list 0 0)
      (let* ((left-results (height-and-leaves (tree-left tree)))
             (right-results (height-and-leaves (tree-right tree))))
        (list (+ 1 (max (car left-results) (car right-results)))
              (if (and (empty-tree? (tree-left tree))
                       (empty-tree? (tree-right tree)))
                  1
                  (+ (cadr left-results) (cadr right-results)))))))

;; Print the height and leaf count of tree on one line.
(define (print-height-and-leaves tree)
  (display (height-and-leaves tree))
  (newline))
