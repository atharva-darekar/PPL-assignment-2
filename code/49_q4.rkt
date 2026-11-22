#lang racket/base

(define (my-length lst)
  (let loop ((rest lst) (count 0))
    (if (null? rest)
        count
        (loop (cdr rest) (+ count 1)))))

(define (my-reverse lst)
  (let loop ((rest lst) (result '()))
    (if (null? rest)
        result
        (loop (cdr rest) (cons (car rest) result)))))

(define (my-map f lst)
  (let loop ((rest lst) (result '()))
    (if (null? rest)
        (my-reverse result)
        (loop (cdr rest) (cons (f (car rest)) result)))))

(define (insert-if-short x lst n)
  (let ((processed
         (my-map (lambda (element)
                   (if (or (pair? element) (null? element))
                       (insert-if-short x element n)
                       element))
                 lst)))
    (if (< (my-length lst) n)
        (cons x processed)
        processed)))

(define (print-insert-result)
  (let ((x (read))
        (lst (read))
        (n (read)))
    (begin
      (display (insert-if-short x lst n))
      (newline))))
