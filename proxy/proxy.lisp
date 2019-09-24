(in-package :proxy)

;; PrinterとPrinterProxyのインタフェース(Subject)
(defclass iprintable () ())

(defgeneric set-printer-name (name instance))
(defgeneric get-printer-name (instance))
(defgeneric prprint (str instance))

;; 疑似的な処理の重い関数
(defun heavy-job (msg)
  (princ msg)
  (dotimes (i 5)
    (princ ".")
    (sleep 1))
  (princ "完了しました")
  (terpri))

;; 名前付きのプリンタを表すクラス(RealSubject)
(defclass printer (iprintable)
  ((_name :accessor _name :initform "" :initarg :_name)))

(defmethod make-printer (&rest name)
  (if name
      (progn
	(heavy-job (format nil "printerのインスタンス~Aを作成中" name))
	(make-instance 'printer :_name (car name)))
      (progn
	(heavy-job "printerのインスタンスを作成中")
	(make-instance 'printer))))

(defmethod set-printer-name ((name string) (printer printer))
  (setf (_name printer) name))

(defmethod get-printer-name ((printer printer))
  (_name printer))

(defmethod prprint ((str string) (printer printer))
  (format t "=== ~A ===~%~A~%" (_name printer) str))

;; 名前付きのプリンタを表すクラス(Proxy)
(defclass printer-proxy (iprintable)
  ((_name :accessor _name :initform "" :initarg :_name)
   (_real :accessor _real :initform nil :initarg :_real)))

(defmethod make-printer-proxy ((name string))
  (make-instance 'printer-proxy :_name name))

(defmethod set-printer-name ((name string) (printer-proxy printer-proxy))
  (when (null (_real printer-proxy))
    (setf (_name printer-proxy) name)))

(defmethod get-printer-name ((printer-proxy printer-proxy))
  (_name printer-proxy))

(defmethod realize ((printer-proxy printer-proxy))
  (unless (_real printer-proxy)
    (setf (_real printer-proxy)
	  (make-printer (_name printer-proxy)))))

(defmethod prprint ((str string) (printer-proxy printer-proxy))
  (realize printer-proxy)
  (prprint str (_real printer-proxy)))
