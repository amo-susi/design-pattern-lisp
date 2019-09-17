(in-package :framework)

;; LinkとTrayを統一的に扱うためのインターフェイス
(defclass item ()
  ((caption :accessor caption :initform "" :initarg :caption)))

(defmethod make-item ((caption string))
  (make-instance 'item :caption caption))

(defgeneric set-caption (caption instance))
(defgeneric make-html (instance))
(defgeneric add (item instance))

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

;; HTMLのページを生成する
(defclass page ()
  ((title :accessor title :initform "" :initarg :title)
   (author :accessor author :initform "" :initarg :author)
   (content :accessor content :initform () :initarg :content)))

(defmethod make-page ((title string) (author string))
  (make-instance 'page :title title :author author))

(defmethod add ((item item) (page page))
  (push item (content page)))

(defmethod output ((page page))
  (print (make-html page)))

;; 部品を作成する
(defclass factory () ())

(defmethod get-factory ((class string))
  (make-instance (intern (string-upcase class) :list-factory)))
