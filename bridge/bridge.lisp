(in-package :bridge)

;; 「表示する」ために使用するメソッドのインターフェース
(defclass display-impl () ())

(defgeneric raw-open (instance))
(defgeneric raw-print (instance))
(defgeneric raw-close (instance))


;; 「表示する」クラス
(defclass display ()
  ((display-impl :accessor display-impl :initform nil :initarg :display-impl)))

(defmethod make-display ((display-impl display-impl))
  (make-instance 'display :display-impl display-impl))

(defmethod bopen ((display display))
  (raw-open (display-impl display)))

(defmethod bprint ((display display))
  (raw-print (display-impl display)))

(defmethod bclose ((display display))
  (raw-close (display-impl display)))

(defmethod execute-display ((display display))
  (bopen display)
  (bprint display)
  (bclose display))

;; 「指定回数だけ表示する」という機能を追加したクラス
(defclass count-display (display) ())

(defmethod make-count-display ((display-impl display-impl))
  (make-instance 'count-display :display-impl display-impl))

(defmethod multi-display ((times integer) (count-display count-display))
  (bopen count-display)
  (loop repeat times
     do (bprint count-display))
  (bclose count-display))

;; 通常の表示を実装したクラス
(defclass normal-display-impl (display-impl)
  ((_string :accessor _string :initform "" :initarg :_string)
   (_width :accessor _width :initform 0 :initarg :_width)))

(defun make-normal-display-impl (str)
  (make-instance 'normal-display-impl :_string str :_width (length str)))

(defmethod print-line ((normal-display-impl normal-display-impl))
  (princ "+")
  (loop repeat (_width normal-display-impl)
     do (princ "-"))
  (princ "+")
  (terpri))

(defmethod raw-open ((normal-display-impl normal-display-impl))
  (print-line normal-display-impl))

(defmethod raw-print ((normal-display-impl normal-display-impl))
  (format t "| ~A |~%" (_string normal-display-impl)))

(defmethod raw-close ((normal-display-impl normal-display-impl))
  (print-line normal-display-impl))

;; 強調した表示を実装したクラス
(defclass star-display-impl (display-impl)
  ((_string :accessor _string :initform "" :initarg :_string)
   (_widht :accessor _width :initform 0 :initarg :_width)))

(defun make-star-display-impl (str)
  (make-instance 'star-display-impl :_string str :_width (length str)))

(defmethod print-line ((star-display-impl star-display-impl))
  (princ "*")
  (loop repeat (_width star-display-impl)
     do (princ "*"))
  (princ "*")
  (terpri))

(defmethod raw-open ((star-display-impl star-display-impl))
  (print-line star-display-impl))

(defmethod raw-print ((star-display-impl star-display-impl))
  (format t "* ~A *~%" (_string star-display-impl)))

(defmethod raw-close ((star-display-impl star-display-impl))
  (print-line star-display-impl))
