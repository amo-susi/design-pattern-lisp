```common-lisp
(ql:quickload :decorator)

(setf display1 (decorator:make-string-display "Hello,world!"))
(setf display2 (decorator:make-side-border display1 #\"))
(setf display3 (decorator:make-full-border display2))

(decorator:show display1)
(decorator:show display2)
(decorator:show display3)

(setf display4
      (decorator:make-side-border
        (decorator:make-full-border
	  (decorator:make-side-border
	    (decorator:make-full-border
	      (decorator:make-string-display "Hellow,world!"))
	  #\*))
       #\/))

(decorator:show display4)

```