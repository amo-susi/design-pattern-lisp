(in-package :common-lisp)

(defpackage list-factory
  (:export :make-html))

(defpackage framework
  (:use :cl)
  (:import-from :list-factory
		:make-html)
  (:export :get-factory
	   :page
	   :factory
	   :tray
	   :link
	   :caption
	   :url
	   :title
	   :author
	   :content
	   :add
	   :output))

(defpackage list-factory
  (:use :cl
	:framework)
  (:export :create-link
	   :create-tray
	   :create-page))

(defpackage abstract-factory
  (:use :cl
	:framework
	:list-factory)
  (:export :get-factory
	   :create-link
	   :create-tray
	   :create-page
	   :add
	   :output))
