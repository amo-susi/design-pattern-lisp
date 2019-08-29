(in-package :iterator)

(defclass iaggregate () ())

(defclass iiterator () ())

(defclass book ()
  ((name :accessor get-name :initform "" :initarg :name)))

#|
(defmethod getname ((book book))
  (name book))
|#

(defclass book-shelf (iaggregate)
  ((books :accessor books :initform () :initarg :books)
   (last :accessor get-length :initform 0 :initarg :last)))

(defmethod get-book-at ((index integer) (book-shelf book-shelf))
  (nth index (books book-shelf)))

(defmethod append-book ((book book) (book-shelf book-shelf))
  (push book (books book-shelf))
  (incf (get-length book-shelf)))

(defclass book-shelf-iterator (iiterator)
  ((book-shelf :accessor book-shelf :initarg :book-shelf)
   (index :accessor index :initform 0 :initarg :index)))

(defmethod iterator (book-shelf book-shelf)
  (make-instance 'book-shelf-iterator :bookshelf book-shelf))

(defmethod book-shelf-iterator ((book-shelf book-shelf) (book-shelf-iterator book-shelf-iterator))
  (setf (book-shelf book-shelf-iterator) book-shelf)
  (setf (index book-shelf-iterator) 0))

(defmethod has-next ()
