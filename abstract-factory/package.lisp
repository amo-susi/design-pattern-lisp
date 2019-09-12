(in-package :common-lisp)

(defpackage abstract-factory
  (:use :cl))

(defpackage list-factory
  (:use :cl
	:list-factory))
