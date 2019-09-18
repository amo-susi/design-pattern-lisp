```common-lisp
(ql:quickload :composite)

(setf root (composite:make-folder "root"))
(setf user (composite:make-folder "user"))
(setf temp (composite:make-folder "temp"))
(setf documents (composite:make-folder "documents"))
(setf game (composite:make-folder "game"))

(setf gomi (composite:make-file "gomi"))
(setf ika (composite:make-file "ika"))
(setf tako (composite:make-file "tako"))
(setf salmon (composite:make-file "salmon"))

(composite:add-entry user root)
(composite:add-entry temp root)
(composite:add-entry documents user)
(composite:add-entry game user)

(composite:add-entry gomi temp)
(composite:add-entry ika game)
(composite:add-entry tako game)
(composite:add-entry salmon game)

(composite:output 0 root)

```