#lang racket

(require (for-syntax racket/base
                     syntax/parse))

(require rackunit)

(define-syntax (~~> stx)
  (syntax-parse stx
    [(_ x)
     #'x]
    [(_ x (f a ...) more ...) 
     #'(~~> (f x a ...) more ...)]))

(check-equal? (~~> 'hello) 'hello)
(check-equal? (~~> (+ 1 2)) 3)
(check-equal? (~~> (let ([x 12])
                     (* x 3))) 36)

(check-equal?  (~~> 5 (+ 1)) 6)
(check-equal? (~~> 5 (+ 1) (* 2)) 12)


#;(check-equal? (~~> #\a
                   (list #\z)
                   list->string)
              "az")
#;(check-equal?(~~> 'abc
                 symbol->string
                 string->bytes/utf-8
                 (bytes-ref 1)
                 (- 2))
             96)




