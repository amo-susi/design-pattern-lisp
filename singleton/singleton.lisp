(in-package :singleton)

;; インスタンスが1つしか存在しないクラス
(defclass singleton ()
  ((_singleton :accessor _singleton :initarg :_singleton :allocation :class)))

(let ((instance (make-instance 'singleton :_singleton (make-instance 'singleton))))
  (defun get-instance ()
    (print "インスタンスを生成しました")
    (_singleton instance)))
