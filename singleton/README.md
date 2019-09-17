```common-lisp
(ql:quickload :singleton)

(setf obj1 (singleton:get-instance))
(setf obj2 (singleton:get-instance))

(if (eq obj1 obj2)
  (print "obj1 = obj2")
  (print "obj1 /= obj2"))

```