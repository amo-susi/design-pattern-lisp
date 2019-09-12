(in-package :list-factory)

;; 具体的な部品：HTMLのリンクを表すクラス
(defclass list-link (link) ())

(defmethod make-list-link ((caption string) (url string))
  (make-instance 'list-link :caption caption :url url))

(defmethod make-html ((list-link list-link))
  (format nil "<li><a href=\"~A\">~A</a></li>~%"
	  (url list-link)
	  (caption list-link)))

;; 具体的な部品：LinkやTrayを集めたクラス
(defclass list-tray (tray) ())

(defmethod make-list-tray ((caption string))
  (make-instance 'list-tray :caption caption))

(defmethod make-html ((list-tray list-tray))
  (with-output-to-string (*standard-output*)
    (princ "<li>")
    (terpri)
    (princ (caption list-tray))
    (terpri)
    (princ "<ul>")
    (terpri)

    (mapc #'make-html (tray list-tray))

    (princ "</ul>")
    (terpri)
    (princ "</li>")
    (terpri)))

;; 具体的な部品：HTMLのページを表すクラス
(defclass  list-page (page) ())

(defmethod make-list-page ((title string) (author string))
  (make-instance 'list-page :title title :author author))

(defmethod make-html ((list-page list-page))
  (with-output-to-string (*standard-output*)
    (format t "<html><head><title>~A</title></head>~%<body>~%<h1>~A</h1><ul>~%" (title list-page) (title list-page))
    (mapc #'make-html (content list-page))
    (format t "</ul>~%<hr><address>~A</address></body></html>~%")))

;; 具体的な工場を表すクラス(ListLink, ListTray, ListPageを作る)
(defclass list-factory (factory) ())

(defmethod create-link ((caption string) (url string) (list-factory list-factory))
  (make-list-link caption url))

(defmethod create-tray ((caption string) (create-link create-link))
  (make-list-tray caption))

(defmethod create-page ((title string) (author string))
  (make-list-page author))

