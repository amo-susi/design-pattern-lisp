(in-package :common-lisp)

(defpackage chain-of-responsibility
  (:nicknames :cor)
  (:use :cl)
  (:export :make-issue
	   :make-limit-support
	   :make-odd-support
	   :make-special-support
	   :set-next-support
	   :support-issue))
