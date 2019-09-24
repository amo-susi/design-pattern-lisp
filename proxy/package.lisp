(in-package :common-lisp)

(defpackage proxy
  (:use :cl)
  (:export :make-printer-proxy
	   :get-printer-name
	   :set-printer-name
	   :prprint))
