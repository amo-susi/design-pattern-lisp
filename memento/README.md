```common-lisp
(ql:quickload :memento)

(setf gamer (memento:make-gamer 100))
(setf memento (memento:create-memento gamer))

(dotimes (i 100)
	   (format t "====~A~%" i)
	   (format t "現状~A" (memento:to-string gamer))
	   (memento:bet gamer)
	   (format t "所持金は~A円になりました。~%" (memento:money gamer))
	   (if (> (memento:money gamer) (/ (memento:money memento) 2))
	       (progn (format t "だいぶ増えたので、現在の状態を保存しておこう~%")
		      (setf memento (memento:create-memento gamer)))
	       (progn (format t "だいぶ減ったので、以前の状態に復帰しよう~%")
		      (memento:restore-memento memento gamer))))

```