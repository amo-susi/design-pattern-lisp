(in-package :common-lisp)

(defpackage iterator
  (:use :cl)
  (:export :book-shelf
	   :append-book
	   :book
	   :get-iterator
	   :has-next
	   :next
	   :name))
