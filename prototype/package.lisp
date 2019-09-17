(in-package :common-lisp)

(defpackage framework
  (:use :cl)
  (:export :product
	   :use
	   :make-manager
	   :register
	   :create))

(defpackage prototype
  (:use :cl
	:framework)
  (:export :make-manager
	   :make-message-box
	   :make-underline-pen
	   :use
	   :register
	   :create))
