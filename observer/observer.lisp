(in-package :observer)

;; 視察者を表すインタフェース
(defclass observer () ())

(defgeneric update (generator instance))

;; 数を生成するオブジェクトを表す抽象クラス
(defclass number-generator (observer)
  ((observers :accessor observers :initform () :initarg :observers)))

(defmethod add-observer ((_observer observer) (number-generator number-generator))
  (push _observer (observers number-generator)))

(defmethod delete-observer ((_observer observer) (number-generator number-generator))
  (setf (observers number-generator) (remove _observer (observers number-generator) :test #'equal)))

(defmethod notify-observers ((number-generator number-generator))
  (loop for o in (observers number-generator)
     do (update number-generator o)))

;; ランダムで数を生成する、NumberGeneratorの実装クラス。
(defclass random-number-generator (number-generator)
  ((num :accessor num :initform 0 :initarg :num)))

(defmethod make-random-number-generator ()
  (make-instance 'random-number-generator))

(defmethod get-number ((random-number-generator random-number-generator))
  (num random-number-generator))

(defmethod execute ((random-number-generator random-number-generator))
  (dotimes (i 20)
    (setf (num random-number-generator) (random 50))
    (notify-observers random-number-generator)))

;; 数字で表示するIObserverの実装クラス
(defclass digit-observer (observer) ())

(defmethod make-digit-observer ()
  (make-instance 'digit-observer))

(defmethod update ((generator number-generator) (digit-observe digit-observer))
  (format t "DigitObserver: ~A~%" (get-number generator))
  (sleep 0.1))

;; Observerインターフェイスの実装クラス。生成した数だけ"*"をコンソールに表示する。
(defclass graph-observer (observer) ())

(defmethod make-graph-observer ()
  (make-instance 'graph-observer))

(defmethod update ((generator number-generator) (graph-observer graph-observer))
  (format t "GraphObserver: ~A~%" (make-string (get-number generator) :initial-element #\*))
  (sleep 0.1))
