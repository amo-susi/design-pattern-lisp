(in-package :common-lisp)

(defpackage builder
  (:use :cl)
  (:export :director
	   :construct
	   :text-builder
	   :html-builder
	   :get-result))
