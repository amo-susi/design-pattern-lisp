(in-package :common-lisp)

(defpackage observer
  (:use :cl)
  (:export :make-random-number-generator
	   :make-digit-observer
	   :make-graph-observer
	   :add-observer
	   :execute))
