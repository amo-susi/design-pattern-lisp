(in-package :memento)

;; Gamerの状態を表すクラス。
(defclass memento ()
  ((_fruits :accessor _fruits :initform () :initarg :_fruits)
   (money :accessor money :initarg :money)))

(defmethod make-memento ((money fixnum))
  (make-instance 'memento :money money))

(defmethod get-fruit ((memento memento))
  (copy-list (_fruits memento)))

(defmethod add-fruit ((fruit string) (memento memento))
  (push fruit (_fruits memento)))

;; ゲームを行う主人公のクラス。Mementoのインスタンスを作る。
(defclass gamer ()
  ((_fruit-names :accessor _fruit-names :initform '("リンゴ" "ぶどう" "バナナ" "みかん") :initarg :_fruit-names)
   (_fruits :accessor _fruits :initform () :initarg _fruits)
   (money :accessor money :initarg :money)))

(defmethod make-gamer ((money fixnum))
  (make-instance 'gamer :money money))

(defmethod get-fruit ((gamer gamer))
  (concatenate 'string
	       (if (= (random 1) 1) "おいしい" "")
	       (nth (random 4) (_fruit-names gamer))))

(defmethod bet ((gamer gamer))
  (let ((dice (random 6)))
    (case dice
      (1 (incf (money gamer) 100)
	 (format t "所持金が増えました。~%"))
      (2 (setf (money gamer) (/ (money gamer) 2))
	 (format t "所持金が半分になりました。~%"))
      (5 (push (get-fruit gamer) (_fruits gamer))
	 (format t "フルーツをもらいました。~%"))
      (t (format t "何も起りませんでした。~%")))))

(defmethod create-memento ((gamer gamer))
  (let ((memento (make-memento (money gamer))))
    (loop for i in (_fruits gamer)
       when (search "おいしい" i)
       do (add-fruit i memento))
    memento))

(defmethod restore-memento ((memento memento) (gamer gamer))
  (setf (money gamer) (money memento))
  (setf (_fruits gamer) (get-fruit memento)))

(defmethod to-string ((gamer gamer))
  (format nil "[money = ~A, fruits = ~{~A~^,~}]~%" (money gamer) (_fruits gamer)))
