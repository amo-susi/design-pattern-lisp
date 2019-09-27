(in-package :strategy)

(defconstant +handvalue-stone+ 0)
(defconstant +handvalue-scissors+ 1)
(defconstant +handvalue-paper+ 2)

(defgeneric make-hand (handvalue))

(defclass hand ()
  ((hand :accessor hand
	 :initform (list (make-hand +handvalue-stone+)
			 (make-hand +handvalue-scissors+)
			 (make-hand +handvalue-paper+))
	 :initarg :hand)))

(defmethod make-hand ((handvalue number))
  (make-instance 'hand :hand handvalue))
