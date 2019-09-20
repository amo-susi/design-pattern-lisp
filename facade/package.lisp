(in-package :common-lisp)

(defpackage facade
  (:use :cl)
  (:export :*page-maker*
	   :make-welcome-page))
