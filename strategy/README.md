```common-lisp
(ql:quickload :strategy)

(do* ((player1 (strategy:make-player "Taro" (strategy:make-won-strategy)))
	       (player2 (strategy:make-player "Hana" (strategy:make-prob-strategy)))
	       (nexthand1 (strategy:next-hand player1) (strategy:next-hand player1))
	       (nexthand2 (strategy:next-hand player2) (strategy:next-hand player2))
	       (won (strategy:is-stronger-than nexthand1 nexthand2) (strategy:is-stronger-than nexthand1 nexthand2))
	       (count 1 (incf count)))
	      ((< 1000 count) (format t "Total result:~%~A~%~A~%" (strategy:to-string player1) (strategy:to-string player2)))
	   (case won
	     (1 (format t "Winner:~A~%" (strategy:to-string player1))
		(strategy:win player1)
		(strategy:lose player2))
	     (-1 (format t "Winner:~A~%" (strategy:to-string player2))
		 (strategy:win player2)
		 (strategy:lose player1))
	     (t (format t "Even...~%")
		(strategy:even player1)
		(strategy:even player2))))

```
