(in-package :visitor)

;; ファイルやディレクトリを訪れる訪問者を表す抽象クラス
(defclass visitor () ())
(defgeneric visit (object))

;; Visitorクラスのインスタンスを受け入れるデータ構造を表すインターフェース
(defclass element () ())

;; FileとDirectoryのスーパークラスとなる抽象クラスで、インターフェースElementの実装を行う
(defclass entry (element) ())

(defgeneric get-name (instance))
(defgeneric get-size (instance))
(defgeneric accept (v instance))

(defmethod add ((entry entry))
  (warn "File Treatment Exception"))

(defmethod enumerator ((entry entry))
  (warn "File TreatmentException"))

(defmethod to-string ((entry entry))
  (format nil "~A (~A)" (get-name entry) (get-size entry)))

;; ファイルを表すクラス
(defclass file (entry)
  ((name :accessor name :initform "" :initarg :name)
   (size :accessor size :initform nil :initarg :size)))

(defmethod get-name ((file file))
  (name file))

(defmethod get-size ((file file))
  (size file))

(defmethod accept ((v visitor) (file file))
  (visit v file))

;; ディレクトリを表すクラス
(defclass directory (entry)
  ((name :accessor name :initform "" :initarg :name)
   (dir :accessor dir :initform () :initarg :dir)))

(defmethod make-directory ((name string))
  (make-instance 'directory :name name))

(defmethod get-name ((directory directory))
  (name directory))

(defmethod get-size ((directory directory))
  (apply #'+ (mapcar #'get-size (dir direcory))))

(defmethod add ((entry entry) (directory directory))
  (push entry (dir directory)))

(defmethod accept ((v visitor) (directory directory))
  (visit v directory))

;; Visitorクラスのサブクラスで、データ構造の一覧を表示するためのクラス
(defclass list-visitor (visitor)
  ((current-dir :accessor current-dir :initform "" :initarg :current-dir)))

(defmethod visit ((file file) (list-visitor list-visitor))
  (format t "~A/~A~%" (current-dir list-visitor) (to-string file)))

(defmethod visit ((directory directory) (list-visitor list-visitor))
  (format t "~A/~A~%" (current-dir list-visitor) (to-string directory))
  (let* ((savedir (current-dir list-visitor))
	 ((current-dir list-visitor) (format nil "~A/~A" (current-dir list-visitor) (get-name directory))))
    (mapcan #'(lambda (v) (accept v list-visitor)) (dir directory))
    (setf (current-dir list-visitor) savedir)))
