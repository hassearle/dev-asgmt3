#lang plai

(require racket/path)

; ;;creates global list variable called tokens
; ;;reads in every line from tokens file and saves
; ;;each token/lexeme pair as a separate list item
; ;(define tokens (file->lines (string->path "D:\\Dropbox\\auburn_faculty\\RacketPrograms\\tokens")));;school computer
(define tokens (file->lines (string->path "/home/asearle/dev/asgmt3_/kss0024output.txt")));;home computer

;;helper function
;;retrieves the first token from the list of tokens
(define current_token
  (lambda ()
    (regexp-split #px" " (car tokens))
    );end lambda
  );end current_token

;;helper function
;;removes one token from the tokens list
;;so that current_token function always extracts
;;the next available token
(define next_token
  (lambda ()
    (set! tokens (cdr tokens))
    (cond
      ((null? tokens)
       (display "No more tokens to parse!")
       (newline)
       (display "Exiting prematurely, no eof found")
       (newline)
       (exit));end null tokens
      (else
       (cond
         ((equal? (car (current_token)) "whitespace")
          (next_token);call yourself again
          );end of equality check 1     
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ((equal? (car (current_token)) "Whitespace")
            (next_token);call yourself again
          );end of equality check 2
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         );end cond
       );end else
      );end cond
    );end lambda
  );end next_token
    

;;checks ID rule
;;if current_token is an id token
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;;if current_token is not id, displays an error message
(define id
  (lambda ()
    (display "Entering <id>")
    (newline)
    (cond
      ((equal? (car (current_token)) "id")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (display "Leaving <id>")
       (newline)
       );end first equality check in condition
      (else
       (display "Not an id token: Error")
       (newline)
       );end else statement
      );end condition block
    );end lambda
  );end id

;;checks int rule
;;if current_token is an int token
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;;if current_token is not int, displays an error message
(define int
  (lambda ()
    (display "Entering <int>")
    (newline)
    (cond
      ((equal? (car (current_token)) "int")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (display "Leaving <int>")
       (newline)
       );end first equality check in condition
      (else
       (display "Not an int token: Error")
       (newline)
       );end else statement
      );end condition block
    );end lambda
  );end int

;;checks factor rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;( <exp> ) | <int> | <id> 
(define (factor)
  (display "Entering <factor>")
  (newline)
  (cond
    ((equal? (car (current_token)) "int")
      (int)
    );end of equality check 1
    ((equal? (car (current_token)) "id")
      (id)
    );end of equality check 2
    ((equal? (car (current_token)) "(")
      (display "Found ")
      (display (second(current_token)))
      (newline)
      (next_token)
      (exp)
      (cond
        ((equal? (car (current_token)) ")")
          (display "Found ")
          (display (second(current_token)))
          (newline)
          (next_token)
        );end of equality check 1
        (else
          (display "Error: missing )")
          (newline)
          (display "Found ")
          (display (first (current_token)))
          (newline)
          (next_token)
        );end of else
      );end of condition block
    );end of equality check 3
    (else
      (display "Error: factor token is neither: int, id, or (")
      (newline)
      (display "Found ")
      (display (first (current_token)))
      (newline)
      (next_token)
    );end of then
  );end of condition block
  (display "Leaving <factor>") 
  (newline)   
);end define factor
         

;;checks exp rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define (exp)
  (display "Entering <exp>")
  (newline)
  (term)
  (etail)
  (display "Leaving <exp>")
  (newline)
);end define exp


(define (etail)
  (display "Entering <etail>")
  (newline)
  (cond 
    ((equal? (car (current_token)) "+")
      (display "Found ")
      (display (first (current_token)))
      (newline)
      (next_token)
      (term)
      (etail)
    );end of equality check 1
    ((equal? (car (current_token)) "-")
      (display "Found ")
      (display (first (current_token)))
      (newline)
      (next_token)
      (term)
      (etail)
    );end of equality check 2
    (else
      (display "Next token is not + or -, choosing EPSILON production")
      (newline)
    );end of else
  );end of condition block
  (display "Leaving <etail>")
  (newline)
);end of definition

(define (term)
  (display "Entering <term>")
  (newline)
  (factor)
  (ttail)
  (display "Leaving <term>")
  (newline)
);end of definition

(define (ttail)
  (display "Entering <ttail>")
  (newline)
  (cond
    ((equal? (car (current_token)) "*")
      (display "Found ")
      (display (first (current_token)))
      (newline)
      (next_token)
      (factor)
      (ttail)
    );end of equality check 1
    ((equal? (car (current_token)) "/")
      (display "Found ")
      (display (first (current_token)))
      (newline)
      (next_token)
      (factor)
      (ttail)
    );end of equality check 2
    (else
      (display "Next token is not * or /, choosing EPSILON production")
      (newline)
    );end of else
  );end of condition block
  (display "Leaving <ttail>")
  (newline)
);end of definition

(define (stmt)
  (display "Entering <stmt>")
  (newline)
  (cond
    ((equal? (car (current_token)) "print")
      (display "Found ")
      (display (second (current_token)))
      (newline)
      (next_token)
      (exp)
    );end of equality check 1
    (else
      (assign)
    );end of else
  );end of condition block
  (display "Leaving <stmt>")
  (newline)
);end of definition

(define (assign)
  (display "Entering <assign>")
  (newline)
  (id)
  (cond
    ((equal? (car (current_token)) "=")
      (display "Found: ")
      (display (second(current_token)))
      (newline)

      ;comment following nt for error
      (next_token);token after '='
      ;(next_token);why am i calling this again?
      (exp)
    );end of equality check 2
    (else
      (display "Error: no = found")
      (newline)
    );end of else
  );end of condition block
  (display "Leaving <assign>")
  (newline) 
  (next_token);token after token after =
);end of definition

(define (pgm)
  (stmt)
  (cond
    ((equal? (car (current_token)) "eof")
      (display "Parse Complete")
      (newline)
    );end of equality check 1
    (else
      (pgm)
    );end of then
  );end of condition block
  (display "Leaving <pgm>")
  (exit)
);end of definition




;;test function to test whether or not next_token
;;will actually terminate program when it encounters
;;eof
(define tt
  (lambda ()
    (display (current_token))
    (newline)
    (next_token)
    (tt)
    )
  )