```common-lisp
(ql:quickload :abstract-factory)

(setf abstract-factory (abstract-factory:get-factory "list-factory"))

(setf asahi (abstract-factory:create-link "朝日新聞" "http://www.asahi.com/" abstract-factory))
(setf yomiuri (abstract-factory:create-link "読売新聞" "http://www.yomiuri.co.jp/" abstract-factory))

(setf usyahoo (abstract-factory:create-link "Yahoo!" "http://www.yahoo.com/" abstract-factory))
(setf jpyahoo (abstract-factory:create-link "Yahoo!Japan" "http://www.yahoo.co.jp/" abstract-factory))
(setf excite (abstract-factory:create-link "Excite" "http://www.excite.co.jp/" abstract-factory))
(setf google (abstract-factory:create-link "Google" "http://www.google.com/" abstract-factory))

(setf traynews (abstract-factory:create-tray "新聞" abstract-factory))
(abstract-factory:add asahi traynews)
(abstract-factory:add yomiuri traynews)

(setf trayyahoo (abstract-factory:create-tray "Yahoo!" abstract-factory))
(abstract-factory:add usyahoo trayyahoo)
(abstract-factory:add jpyahoo trayyahoo)

(setf traysearch (abstract-factory:create-tray "サーチエンジン" abstract-factory))
(abstract-factory:add trayyahoo traysearch)
(abstract-factory:add excite traysearch)
(abstract-factory:add google traysearch)

(setf page (abstract-factory:create-page "LinkPage" "AbstractFactory Sample" abstract-factory))
(abstract-factory:add traynews page)
(abstract-factory:add traysearch page)

(abstract-factory:output page)

```