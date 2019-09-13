```common-lisp
(ql:quickload :factory-method)

(setf factory (make-id-card-factory))

(setf card1 (idcard:create "foo" factory))
(setf card2 (idcard:create "bar" factory))

(idcard:use card1)
(idcard:use card2)

```