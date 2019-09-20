```common-lisp
(ql:quickload :builder)

(setf text-builder (make-text-builder)
(setf director (make-director text-builder))

(builder:construct director)
(builder:get-result text-builder)

(setf html-builder (make-html-builder))
(setf director (make-director html-builder))

(builder:construct director)
(builder:get-result html-builder)

```