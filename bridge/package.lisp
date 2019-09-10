(in-package :common-lisp)

(defpackage bridge
  (:use :cl)
  (:export :make-display
	   :execute-display
	   :make-count-display
	   :multi-display
	   :make-normal-display-impl
	   :make-star-display-impl))
