(in-package :common-lisp)

(defpackage composite
  (:use :cl)
  (:export :make-folder
	   :make-file
	   :add-entry
	   :output))
