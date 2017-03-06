#lang racket/base
 
(require rackunit
          "sch17s__ppl__asgmt3__scheme_parser.rkt")

(current_token);x
(next_token)
(current_token);ws
(next_token)
(current_token);=
(next_token)
(current_token);ws
(next_token)
(current_token);3
(next_token)
(current_token);nl
(next_token)
(current_token);y
(next_token)
(current_token);ws
(next_token)
(current_token);=
(next_token)
(current_token);ws
(next_token)
(current_token);5
(next_token)
(current_token);ln
(next_token)
(current_token);z
(next_token)
(current_token);ws
(next_token)
(current_token);=
(next_token)
(current_token);ws
(next_token)
(current_token);(
(newline)

(display (current_token))
(factor)

(newline)
(display "End of Test")
(newline)
(newline)





; (id)
; (newline)
; (next_token)

; (factor)
; (newline)
; (next_token)

; (factor)
; (newline)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (next_token)
; (factor)







; ;(require tests-ui)
; ;(run-tests file-tests)

; (define file-tests
;   (test-suite
;    "Tests for sch17s__ppl__asgmt3__scheme_parser.rkt"
 
;     (test-case "current_token"
;       (check-equal? (current_token)'("id" "x"))
;     )              
   
;     ; (test-case "print first factor"
;     ;     (current_token)
;     ;     (check-equal? (factor)
;     ;              (display
;     ;              "Entering <factor>
;     ;              Entering <int>
;     ;              Found 1
;     ;              Leaving <int>
;     ;              Leaving <factor"
;     ;              (newline)
;     ;              )
;     ;     )
;     ; )

;     (test-case "id test"
;       (set!(tokens("id x")))
;       (cond)
;     )

  
;   )
; )
; (require rackunit/text-ui)
; (run-tests file-tests)
 
;    ;(check-equal? (my-* 1 2) 2 "Simple multiplication")
 
; ;   (test-case
;  ;   "List has length 4 and all elements even"
;   ;  (let ([lst (list 2 4 6 9)])
;    ;   (check = (length lst) 4)
;     ;  (for-each
;      ;   (lambda (elt)
;       ;    (check-pred even? elt))
;       ;lst)))))

