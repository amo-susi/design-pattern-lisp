```common-lisp
(ql:quickload :singleton)

(setf obj1 (get-instance))
(setf obj2 (get-instance))

(if (eq obj1 obj2)
  (print "obj1 = obj2")
  (print "obj1 /= obj2"))

```