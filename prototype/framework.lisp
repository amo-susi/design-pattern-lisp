(in-package :framework)

;; 複製を行うメソッドを定義するインターフェイス
(defclass product () ())

(defgeneric use (s ins))

;; インスタンスの複製を指示するクラス
(defclass manager ()
  ((showcase :accessor showcase :initform (make-hash-table) :initarg :showcase)))

;; 引数で渡された雛形インスタンスをshowcase内に格納する
(defmethod register ((name symbol) (proto product) (manager manager))
  (setf (gethash name (showcase manager)) proto))

;; shocase内に存在する雛形インスタンスのコピーを返す
(defmethod create ((protoname symbol) (manager manager))
  (copy-tree (gethash protoname (showcase manager))))
