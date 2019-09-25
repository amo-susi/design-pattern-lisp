(in-package :common-lisp)

(defpackage memento
  (:use :cl)
  (:export :make-gamer
	   :create-memento
	   :restore-memento
	   :bet
	   :money
	   :to-string))
