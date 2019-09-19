(in-package :common-lisp)

(defpackage decorator
  (:use :cl)
  (:export :make-string-display
	   :make-side-border
	   :make-full-border
	   :show))
