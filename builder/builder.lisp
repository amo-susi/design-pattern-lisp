(in-package :builder)

;; 文章を構成するためのメソッドを定めたインターフェース
(defclass builder () ())

(defgeneric make-title (title ins))
(defgeneric make-string-b (str ins))
(defgeneric make-items (items ins))
(defgeneric bclose (ins))

;; ひとつの文章を作成するクラス
(defclass director ()
  ((builder :accessor builder  :initarg :builder)))

(defmethod construct ((director director))
  (make-title "Greeting" (builder director))
  (make-string-b "朝から昼にかけて" (builder director))
  (make-items '("おはようございます。" "こんにちは。") (builder director))
  (make-string-b "夜に" (builder director))
  (make-items '("こんばんわ。" "おやすみなさい。" "さようなら。") (builder director))
  (bclose (builder director)))

;; プレーンテキストを使って文章作成するクラス
(defclass text-builder (builder)
  ((buffer :accessor buffer :initform () :initarg :buffer)))

(defmethod make-title ((title string) (text-builder text-builder))
  (push "============================" (buffer text-builder))
  (push (format nil "『 ~A 』" title) (buffer text-builder)))

(defmethod make-string-b ((str string) (text-builder text-builder))
  (push (format nil "■ ~A" str) (buffer text-builder)))

(defmethod make-items ((items list) (text-builder text-builder))
  (setf (buffer text-builder) (append (reverse items) (buffer text-builder))))

(defmethod bclose ((text-builder text-builder))
  (push "===========================" (buffer text-builder)))

(defmethod get-result ((text-builder text-builder))
  (format nil "~{~A~%~}" (reverse (buffer text-builder))))

;; HTMLファイルを使って文章を作成するクラス
(defclass html-builder (builder)
  ((buffer :accessor buffer :initform () :initarg :buffer)))

(defmethod make-title ((title string) (html-builder html-builder))
  (push (format nil "<html><head><title>~A</title></head><body>" title)
	(buffer html-builder))
  (push (format nil "<h1>~A</h1>" title) (buffer html-builder)))

(defmethod make-string-b ((str string) (html-builder html-builder))
  (push (format nil "<p>~A</p>" str) (buffer html-builder)))

(defmethod make-items ((items list) (html-builder html-builder))
  (push "<ul>" (buffer html-builder))
  (setf (buffer html-builder)
	(append (mapcar #'(lambda (str) (format nil "<li>~A</li>" str)) (reverse items))
		(buffer html-builder)))
  (push "</ul>" (buffer html-builder)))

(defmethod bclose ((html-builder html-builder))
  (push "</body></html>" (buffer html-builder)))

(defmethod get-result ((html-builder html-builder))
  (format nil "~{~A~%~}" (reverse (buffer html-builder))))
