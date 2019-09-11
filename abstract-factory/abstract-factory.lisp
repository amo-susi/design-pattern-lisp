(in-package :abstract-factory)

;; LinkとTrayを統一的に扱うためのインターフェイス
(defclass item ()
  ((caption :accessor caption :initform "" :initarg :caption)))

(defmethod make-item ((caption string))
  (make-instance 'item :caption caption))

(defgeneric set-caption (caption instance))
(defgeneric make-html (instance))

;; 抽象的な部品：HTMLのリンクを表す
(defclass link (item)
  ((url :accessor url :initform "" :initarg :url)))

(defmethod make-link ((caption string) (url string))
  (make-instance 'link :caption caption :url url))

;; 抽象的な部品：LinkやTrayを集めた部品
(defclass tray (item)
  ((tray :accessor tray :initform () :initarg :tray)))

(defmethod make-tray ((caption string))
  (make-instance 'tray :caption caption))

(defmethod add ((item item) (tray tray))
  (push item (tray tray)))

(defmethod set-caption ((caption string) (tray tray))
  (setf (caption tray) caption))

