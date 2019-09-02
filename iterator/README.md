```common-lisp
(ql:quickload :iterator)

(setf book-shelf (make-instance 'iteraotr:book-shelf))

(iterator:append-book (make-instance 'iterator:book :name "Around the World in 80 Days") book-shelf)
;; => 1

(iterator:append-book (make-instance 'iterator:book :name "Cinderella") book-shelf)
;; => 2

(iterator:append-book (make-instance 'iterator:book :name "Bible") book-shelf)
;; => 3

(iterator:append-book (make-instance 'iterator:book :name "Daddy-Long-Legs") book-shelf)
;; => 4

(setf iterator (iterator:get-iterator book-shelf))

(loop for book = (iterator:next iterator)
      while (iterator:has-next iterator)
      do (print (iterator:name book))
      finally (print (iterator:name book)))

;; => "Around the World in 80 Days" 
;;    "Cinderella" 
;;    "Bible" 
;;    "Daddy-Long-Legs"
```