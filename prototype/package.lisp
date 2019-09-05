(in-package :common-lisp)

(defpackage framework
  (:use :cl)
  (:export :product
	   :use
	   :manager
	   :register
	   :create))

(defpackage prototype
  (:use :cl
	:framework)
  (:export :manager
	   :message-box
	   :underline-pen
	   :use
	   :register
	   :create))
