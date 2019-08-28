(in-package :framework)

;; Product
(defclass product () ())

;; Creator
(defclass factory () ())

(defgeneric create (owner factory))
(defgeneric create-product (owner))
(defgeneric register-product (product factory))
