#lang plai

(require racket/path)

;;creates global list variable called tokens
;;reads in every line from tokens file and saves
;;each token/lexeme pair as a separate list item
;(define tokens (file->lines (string->path "D:\\Dropbox\\auburn_faculty\\RacketPrograms\\tokens")));;school computer
(define tokens (file->lines (string->path "/home/asearle/dev/asgmt3_/kss0024output.txt")));;home computer
;(define tokens (file->lines (string->path "/home/asearle/dev/asgmt3/test.txt")));;home computer

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
          )     
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
(define factor
  (lambda ()
    (display "Entering <factor>")
    (newline)
    (cond
      [(equal? (car (current_token)) "(")
        (display "Found ")
        (display (second (current_token)))
        (next_token)
        (exp)
        (display (second (current_token)))
        (newline)
        (next_token)
        ((factor))
        (newline)
      ];end first equality check in condition
      [(equal? (car (current_token)) "+")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end second equality check in condition
      [(equal? (car (current_token)) "-")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end third equality check in condition
      [(equal? (car (current_token)) "=")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end forth equality check in condition
      [(equal? (car (current_token)) "*")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end fifth equality check in condition
      [(equal? (car (current_token)) "/")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end sixth equality check in condition
      [(equal? (car (current_token)) "EPSILON")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end seventh equality check in condition
      [(equal? (car (current_token)) "print")
        (display "Found ")
        (display (second (current_token)))
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end eighth equality check in condition
      [(equal? (car (current_token)) "factor")
        (display "Found ")
        (newline)
        (exp)
        (newline)
        (next_token)
        (display "Leaving <factor>")
        (newline)
      ];end ninth equality check in condition
      [(equal? (car (current_token)) "int")
        (int)
        (display "Leaving <factor>")
        (newline)
      ];end tenth equality check in condition
      [(equal? (car (current_token)) "id")
        (id)
        (display "Leaving <factor>")
        (newline)
      ];end eleventh equality check in condition
      [ else
        (display "Not an factor token: Error")
        (newline)
      ];end else statement
    );end condition block
  );end lambda
);end define factor
         

;;checks exp rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define (exp)
 (+ 1)
  );end define exp

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

;;helper function for factor function
(define (fctr i)
  (display "Found ")
  (display (second (current_token)))
  (newline)
  (next_token)
  (display "Leaving <factor>")
  (newline)
)

;;helper function to test factor function
;;factors everything in file
(define (factorAll)
  (eof)
  (factor)
  (next_token)
  (factorAll)
)

;;helper function to check for EOF
(define (eof)
  (cond 
    [(equal? current_token "eof")
      (display "End of File")
      (exit)
    ]
  )
)