(in-package :adapter)

;; あらかじめ提供されているクラス
(defclass banner ()
  ((str :accessor str :initform "" :initarg :str)))

(defmethod show-with-paren ((banner banner))
  (format t "(~A)~%" (str banner)))

(defmethod show-with-aster ((banner banner))
  (format t "*~A*~%" (str banner)))

;; 必要とされているインターフェース
(defclass iprint () ())

(defgeneric print-weak (iprint))
(defgeneric print-strong (iprint))

;; アダプターの役目を果すクラス
(defclass print-banner (iprint)
  ((banner :accessor banner :initarg :banner)))

(defun make-print-banner (str)
  (make-instance 'print-banner :banner (make-instance 'banner :str str)))

(defmethod print-weak ((iprint iprint))
  (show-with-paren (banner iprint)))

(defmethod print-strong ((iprint iprint))
  (show-with-aster (banner iprint)))
