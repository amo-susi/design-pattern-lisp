```common-lisp
(ql:quickload :builder)

(setf text-builder (make-instance 'builder:text-builder)
(setf director (make-instance 'builder:director :builder text-builder))

(builder:construct director)
(builder:get-result text-builder)

(setf html-builder (make-instance 'builder:html-builder))
(setf director (make-instance 'builder:director :builder html-builder))

(builder:construct director)
(builder:get-result html-builder)