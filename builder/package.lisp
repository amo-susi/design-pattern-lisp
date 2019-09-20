(in-package :common-lisp)

(defpackage builder
  (:use :cl)
  (:export :make-director
	   :make-text-builder
	   :make-html-builder
	   :construct
	   :get-result))
