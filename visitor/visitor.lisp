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
(defclass vdirectory (entry)
  ((name :accessor name :initform "" :initarg :name)
   (dir :accessor dir :initform () :initarg :dir)))

(defmethod make-vdirectory ((name string))
  (make-instance 'vdirectory :name name))

(defmethod get-name ((vdirectory vdirectory))
  (name vdirectory))

(defmethod get-size ((vdirectory vdirectory))
  (apply #'+ (mapcar #'get-size (dir vdirecory))))

(defmethod vadd ((entry entry) (vdirectory vdirectory))
  (push entry (dir vdirectory)))

(defmethod accept ((v visitor) (vdirectory vdirectory))
  (visit v vdirectory))

;; Visitorクラスのサブクラスで、データ構造の一覧を表示するためのクラス
(defclass list-visitor (visitor)
  ((current-dir :accessor current-dir :initform "" :initarg :current-dir)))

(defmethod visit ((file file) (list-visitor list-visitor))
  (format t "~A/~A~%" (current-dir list-visitor) (to-string file)))

(defmethod visit ((vdirectory vdirectory) (list-visitor list-visitor))
  (format t "~A/~A~%" (current-dir list-visitor) (to-string vdirectory))
  (let* ((savedir (current-dir list-visitor))
	 (current-dir list-visitor) (format nil "~A/~A" (current-dir list-visitor) (get-name vdirectory)))
    (mapcan #'(lambda (v) (accept v list-visitor)) (dir vdirectory))
    (setf (current-dir list-visitor) savedir)))
