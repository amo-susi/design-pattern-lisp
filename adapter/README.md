```
(ql:quickload :adapter)

(setf pnt (adapter:make-print-banner "Hello"))

(adapter:print-weak pnt)
;; => (Hello)

(adapter:print-strong pnt)
;; => *Hello*

```
