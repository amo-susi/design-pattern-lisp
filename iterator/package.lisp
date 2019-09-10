(in-package :common-lisp)

(defpackage iterator
  (:use :cl)
  (:export :make-book-shelf
	   :append-book
	   :make-book
	   :get-iterator
	   :has-next
	   :next
	   :name))
