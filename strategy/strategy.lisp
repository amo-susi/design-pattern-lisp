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
  (cond ((= (handvalue h) (handvalue hand)) 0)
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
(defgeneric study (win instance))

;; 勝ったら次も同じ手を出す戦略
(defclass won-strategy (strategy)
  ((won :accessor won :initform nil :initarg :won)
   (prev-hand :accessor prev-hand :initarg :prev-hand)))

(defmethod make-won-strategy ()
  (make-instance 'won-strategy))

(defmethod next-hand ((won-strategy won-strategy))
  (unless (won won-strategy)
    (setf (prev-hand won-strategy)
	  (get-hand (random 3))))
  (prev-hand won-strategy))

(defmethod study ((win symbol) (won-strategy won-strategy))
  (setf (won won-strategy) win))

;; 一回前の手から次の手を確立的に計算する戦略
(defclass prob-strategy (strategy)
  ((prev-handvalue :accessor prev-handvalue :initform 0 :initarg :prev-handvalue)
   (current-handvalue :accessor current-handvalue :initform 0 :initarg :current-handvalue)
   (history :accessor history :initform '((1 1 1) (1 1 1) (1 1 1)) :initarg :history)))

(defmethod make-prob-strategy ()
  (make-instance 'prob-strategy))

(defmethod get-sum ((hv integer) (prob-strategy prob-strategy))
  (loop for x in (nth hv (history prob-strategy))
     sum x))

(defmethod next-hand ((prob-strategy prob-strategy))
  (let ((handvalue 0)
	(bet (random (get-sum (current-handvalue prob-strategy) prob-strategy))))
    (cond ((< bet (nth (current-handvalue prob-strategy)
		       (nth 0 (history prob-strategy))))
	   (setf handvalue 0))
	  ((< bet (+ (nth (current-handvalue prob-strategy)
			  (nth 0 (history prob-strategy)))
		     (nth (current-handvalue prob-strategy)
			  (nth 1 (history prob-strategy)))))
	   (setf handvalue 1))
	  (t (setf handvalue 2)))
    (setf (prev-handvalue prob-strategy) (current-handvalue prob-strategy))
    (setf (current-handvalue prob-strategy) handvalue)
    (get-hand handvalue)))

(defmethod study ((win symbol) (prob-strategy prob-strategy))
  (if win
      (incf (nth (current-handvalue prob-strategy)
		 (nth (prev-handvalue prob-strategy) (history prob-strategy))))
      (progn
	(incf (nth (rem (1+ (current-handvalue prob-strategy)) 3)
		   (nth (prev-handvalue prob-strategy) (history prob-strategy))))
	(incf (nth (rem (+ (current-handvalue prob-strategy) 2) 3)
		   (nth (prev-handvalue prob-strategy) (history prob-strategy)))))))

;; じゃんけんのプレイヤーを表すクラス
(defclass player ()
  ((name :accessor name :initform "" :initarg :name)
   (strategy :accessor strategy :initform nil :initarg :strategy)
   (win-count :accessor win-count :initform 0 :initarg :win-count)
   (lose-count :accessor lose-count :initform 0 :initarg :lose-count)
   (game-count :accessor game-count :initform 1 :initarg :game-count)))

(defmethod make-player ((name string) (strategy strategy))
  (make-instance 'player :name name :strategy strategy))

(defmethod next-hand ((player player))
  (next-hand (strategy player)))

(defmethod win ((player player))
  (study t (strategy player))
  (incf (win-count player))
  (incf (game-count player)))

(defmethod lose ((player player))
  (study nil (strategy player))
  (incf (lose-count player))
  (incf (game-count player)))

(defmethod even ((player player))
  (incf (game-count player)))


(defmethod to-string ((player player))
  (format nil "[ ~A :~A games, ~A win, ~A lose]"
	  (name player)
	  (game-count player)
	  (win-count player)
	  (lose-count player)))

