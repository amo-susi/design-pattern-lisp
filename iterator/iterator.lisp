(in-package :iterator)

;; 集合体を表すインタフェース
(defclass iaggregate () ())

;; 逐次処理を行うインタフェース
(defclass iiterator () ())

;; 本を表すクラス
(defclass book ()
  ((name :accessor name :initform "" :initarg :name)))

;; 本棚を表すクラス
(defclass book-shelf (iaggregate)
  ((books :accessor books :initform () :initarg :books)
   (last :accessor get-length :initform 0 :initarg :last)))

(defmethod append-book ((book book) (book-shelf book-shelf))
  (push book (books book-shelf))
  (incf (get-length book-shelf)))

;; pushで格納するため、逆順でとりだし
(defmethod get-book-at ((index integer) (book-shelf book-shelf))
  (nth index (reverse (books book-shelf))))

(defmethod get-iterator ((book-shelf book-shelf))
  (make-instance 'book-shelf-iterator :book-shelf book-shelf))

;; 本棚内の本を逐次処理するクラス
(defclass book-shelf-iterator (iiterator)
  ((book-shelf :accessor book-shelf  :initarg :book-shelf)
   (index :accessor index :initform 0 :initarg :index)))

(defmethod has-next ((book-shelf-iterator book-shelf-iterator))
  (< (index book-shelf-iterator) (get-length (book-shelf book-shelf-iterator))))

(defmethod next ((book-shelf-iterator book-shelf-iterator))
  (prog1
      (get-book-at (index book-shelf-iterator) (book-shelf book-shelf-iterator))
    (incf (index book-shelf-iterator))))
