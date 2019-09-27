(in-package :strategy)

(defconstant +handvalue-stone+ 0)
(defconstant +handvalue-scissors+ 1)
(defconstant +handvalue-paper+ 2)

(defgeneric meke-hand (handvalue))

(defclass hand ()
  ((hand :accessor hand
	 :initform (list (make-hand +handvalue-stone+)
			 (make-hand +handvalue-scissors+)
			 (make-hand +handvalue-paper+))
	 :initarg :hand)
   (name :accessor name :initform '("STONE" "SCISSORS" "PAPER") :initarg :name)
   (handvlue :accessor handvalue :initform nil :initarg :handvalue)))

(defmethod make-hand ((handvalue integer))
  (make-instance 'hand :handvalue handvalue :hand nil))

(defmethod get-hand ((handvalue integer))
  (make-instance 'hand :handvalue handvalue))

(defmethod fight ((h hand) (hand hand))
  (cond ((equal h hand) 0)
	((= (rem (1+ (handvalue hand)) 3)
	    (handvalue h))
	 1)
	(t -1)))

(defmethod is-stronger-than ((h hand) (hand hand))
  (fight h hand))

(defmethod to-string ((hand hand))
  (nth (handvalue hand) (name hand)))

;; じゃんけんの「戦略」を表すインタフェース
(defclass strategy () ())

(defgeneric next-hand (instance))
(defgeneric study (win))

;; 勝ったら次も同じ手を出す戦略
(defclass won-strategy (strategy)
  ((won :accessor won :initform nil :initarg :won)
   (prev-hand :accessor prev-hand :initarg :prev-hand)))

(defmethod make-won-strategy ()
  (make-instance 'won-strategy))

(defmethod next-hand ((won-strategy won-strategy))
  (unless won (setf (prev-hand won-strategy)
		    (get-hand (random 3)))))

(defmethod study ((win boolean) (won-strategy won-strategy))
  (setf (won won-strategy) win))


