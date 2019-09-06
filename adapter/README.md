```common-lisp
(ql:quickload :adapter)

(setf pnt (adapter:make-print-banner "Hello"))

(adapter:print-weak pnt)

(adapter:print-strong pnt)

```
