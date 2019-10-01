(in-package :common-lisp)

(defpackage strategy
  (:use :cl)
  (:export :make-player
	   :win
	   :lose
	   :even
	   :next-hand
	   :to-string
	   :make-won-strategy
	   :make-prob-strategy))
