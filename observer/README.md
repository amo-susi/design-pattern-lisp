```common-lisp
(ql:quickload :observer)

(setf generator (observer:make-random-number-generator))

(setf observer1 (observer:make-digit-observer))
(setf observer2 (observer:make-graph-observer))

(observer:add-observer observer1 generator)
(observer:add-observer observer2 generator)

(observer:execute generator)

```