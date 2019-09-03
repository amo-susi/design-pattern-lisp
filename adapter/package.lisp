(in-package :common-lisp)

(defpackage adapter
  (:use :cl)
  (:export :iprint
	   :make-print-banner
	   :print-weak
	   :print-strong))
