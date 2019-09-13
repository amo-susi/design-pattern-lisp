(in-package :idcard)

(defclass id-card (product)
  ((owner :accessor owner :initform "" :initarg :owner)))

(defclass id-card-factory (factory)
  ((owners :accessor owners :initform () :initarg :owners)))

(defun make-id-card-factory ()
  (make-instance 'id-card-factory))

(defmethod create-product ((owner string))
  (format t "~Aのカードを作ります。~%" owner)
  (make-instance 'id-card :owner owner))

(defmethod register-product ((product product) (factory factory))
  (push (owner product) (owners factory)))

(defmethod create ((owner string) (factory factory))
  (let ((p (create-product owner)))
    (register-product p factory)
    p))

(defmethod use ((id-card id-card))
  (format t "~Aのカードを使います。~%" (owner id-card)))


