(in-package :bridge)

;; 「表示する」ために使用するメソッドのインターフェース
(defclass display-impl ())

(defgeneric raw-open (instance) ())
(defgeneric raw-print (instance) ())
(defgeneric raw-close (instance) ())


;; 「表示する」クラス
(defclass display ()
  ((display-impl :accessor display-impl :initform nil :initag :display-impl)))

(defmethod make-display ((display-impl display-impl))
  (make-instance 'display :display-impl display-impl))

(defmethod open ((display display))
  (raw-open (display-impl display)))

(defmethod print ((display display))
  (raw-print (display-impl display)))

(defmethod close ((display display))
  (raw-close (display-impl display)))

(defmethod execute-display ((display display))
  (open display)
  (print display)
  (close display))

