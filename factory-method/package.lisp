(in-package :common-lisp)

(defpackage framework
  (:use :cl)
  (:export :product
	   :factory))

(defpackage idcard
  (:use :cl
	:framework)
  (:export :id-card-factory
	   :create
	   :use))
