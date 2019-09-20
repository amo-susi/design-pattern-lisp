(in-package :facade)

;; ユーザー名を利用し、リソースファイルに登録されているメールアドレスの検索を行う
(defclass database () ())

(defmethod make-database ()
  (make-instance 'database))

(defvar *database* (make-database))

(defmethod get-user-mail-addr ((user-name string) (database database))
  "test@foo.bar")

;; 指定された情報を利用し、HTMLタグを生成する
(defclass html-writer ()
  ((_writer :accessor _writer :initarg :_writer)))

(defmethod make-html-writer ((writer synonym-stream))
  (make-instance 'html-writer :_writer writer))

(defmethod write-title ((title string) (html-writer html-writer))
  (format (_writer html-writer) "<html><head><title>~A</title></head>
                                 <body>~%<h1>~A</h1>"
	  title title))

(defmethod write-paragraph ((msg string) (html-writer html-writer))
  (format (_writer html-writer) "<p>~A</p>~%" msg))

(defmethod write-link ((href string) (caption string) (html-writer html-writer))
  (format (_writer html-writer) "<a href=\"~A\">~A</p>~%" href caption))

(defmethod write-mail-to ((mail-addr string) (user-name string) (html-writer html-writer))
  (write-link (concatenate 'string "mailto:" mail-addr) user-name html-writer))

(defmethod fclose ((html-writer html-writer))
  (format (_writer html-writer) "</body></html>~%"))

;; DatabaseとHtmlWriterを利用したHTMLページ作成処理を実行する
(defclass page-maker () ())

(defmethod make-page-maker ()
  (make-instance 'page-maker))

(defvar *page-maker* (make-page-maker))

(defmethod make-welcome-page ((user-name string) (file-name string) (page-maker page-maker))
  (let ((mail-addr (get-user-mail-addr user-name *database*))
	(html-writer (make-html-writer *standard-output*)))
    (write-title (concatenate 'string "Welcome to" user-name "'s Page!") html-writer)
    (write-paragraph (concatenate 'string user-name "のページへようこそ") html-writer)
    (write-paragraph (concatenate 'string user-name "メールまってますね。") html-writer)
    (write-mail-to mail-addr user-name html-writer)
    (fclose html-writer)))
