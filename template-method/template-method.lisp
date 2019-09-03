(in-package :template-method)

;; メソッドDisplayのみ実装されている抽象クラス
(defclass abstract-display () ())

(defgeneric aopen (abstract-display))
(defgeneric aprint (abstract-display))
(defgeneric aclose (abstract-display))

(defmethod display ((abstract-display abstract-display))
  (aopen abstract-display)
  (loop for i
     from 0
     to 5
     do (aprint abstract-display))
  (aclose abstract-display))


;; メソッドaopen,aprint,acloseを実装しているクラス
(defclass char-display (abstract-display)
  ((ch :accessor ch :initform #\space :initarg :ch)))

(defmethod make-char-display ((ch character))
  (make-instance 'char-display :ch ch))

(defmethod aopen ((char-display char-display))
  (princ "<<"))

(defmethod aprint ((char-display char-display))
  (princ (ch char-display)))

(defmethod aclose ((char-display char-display))
  (princ ">>"))

;; メソッドaopen,aprint,acloseを実装しているクラス
(defclass string-display (abstract-display)
  ((string-view :accessor string-view :initform "" :initarg :string-view)
   (width :accessor width :initform 0 :initarg :width)))

(defmethod make-string-display ((string-view string))
  (make-instance 'string-display :string-view string-view :width (length string-view)))

(defmethod print-line ((string-display string-display))
  (princ "+")
  (loop for i
     from 0
     to (width string-display)
     do (princ "+"))
  (princ "+")
  (terpri))

(defmethod aopen ((string-display string-display))
  (print-line string-display))

(defmethod aprint ((string-display string-display))
  (format t "| ~A |~%" (string-view string-display)))

(defmethod aclose ((string-display string-display))
  (print-line string-display))
