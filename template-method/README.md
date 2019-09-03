``` common-lisp
(ql:quickload :template-method)

(setf char-display (template-method:make-char-display #\H))

(setf string-display1 (template-method:make-string-display "Hello"))

(setf string-display2 (template-method:make-string-display "Good night"))

(template-method:display char-display)
(template-method:display string-display1)
(template-method:display string-display2)
```