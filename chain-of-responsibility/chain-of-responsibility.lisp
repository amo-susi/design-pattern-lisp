(in-package :cor)

;; 発生した問題を表すクラス。問題管理番号(IssueNumber)を持つ
(defclass issue ()
  ((issue-number :accessor issue-number :initarg :issue-number)))

(defmethod make-issue ((issue-number number))
  (make-instance 'issue :issue-number issue-number))

;; 問題解決のサポートを行う抽象クラス
(defclass support ()
  ((_staff-name :accessor _staff-name :initform "" :initarg :_staff-name)
   (_next-support :accessor _next-support :initform nil :initarg _next-support)))

(defmethod make-support ((staff-name string))
  (make-instance 'support :_staff-name staff-name))

(defmethod set-next-support ((next-support support) (support support))
  (setf (_next-support support) next-support))

(defgeneric resolve (issue instance))

(defmethod support-issue ((issue issue) (support support))
  (cond ((resolve issue support)
	 (format t "問題~Aは~Aが解決しました。~%" (issue-number issue) (_staff-name support)))
	((_next-support support)
	 (support-issue issue (_next-support support)))
	(t
	 (format t "問題~Aは現在のサポート体制では解決できません。~%" (issue-number issue)))))

;; 問題解決のサポートを行う具象クラス（指定した番号未満の問題を解決）
(defclass limit-support (support)
  ((_limit-issue-number :accessor _limit-issue-number :initarg :_limit-issue-number)))

(defmethod make-limit-support ((staff-name string) (limit-issue-number number))
  (make-instance 'limit-support :_staff-name staff-name :_limit-issue-number limit-issue-number))

(defmethod resolve ((issue issue) (limit-support limit-support))
  (< (issue-number issue) (_limit-issue-number limit-support)))

;; 問題解決のサポートを行う具象クラス（奇数番号の問題を解決）
(defclass odd-support (support) ())

(defmethod make-odd-support ((staff-name string))
  (make-instance 'odd-support :_staff-name staff-name))

(defmethod resolve ((issue issue) (odd-support odd-support))
  (= (mod (issue-number issue) 2)))

;; 問題解決のサポートを行う具象クラス(特定の問題を解決)
(defclass special-support (support)
  ((_special-number :accessor _special-number :initarg :_special-number)))

(defmethod make-special-support ((staff-name string) (special-number number))
  (make-instance 'special-support :_staff-name staff-name :_special-number special-number))

(defmethod resolve ((issue issue) (special-support special-support))
  (= (issue-number issue) (_special-number special-support)))
