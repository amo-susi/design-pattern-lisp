```common-lisp
(ql:quickload :chain-of-responsibility)

(setf limit-support (corr:make-limit-support "Nagatomo" 3))
(setf odd-support (cor:make-odd-support "Kagawa"))
(setf special-support (cor:make-special-support "Honda" 4))

(cor:set-next-support odd-support (cor:set-next-support special-support limit-support))

(defvar *issue-count* 6)

(dotimes (i *issue-count*)
  (cor:support-issue (cor:make-issue i) limit-support))

```