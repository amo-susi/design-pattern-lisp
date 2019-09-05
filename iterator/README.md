``` common-lisp
(ql:quickload :iterator)

(setf book-shelf (make-instance 'iteraotr:book-shelf))

(iterator:append-book (make-instance 'iterator:book :name "Around the World in 80 Days") book-shelf)

(iterator:append-book (make-instance 'iterator:book :name "Cinderella") book-shelf)

(iterator:append-book (make-instance 'iterator:book :name "Bible") book-shelf)

(iterator:append-book (make-instance 'iterator:book :name "Daddy-Long-Legs") book-shelf)

(setf iterator (iterator:get-iterator book-shelf))

(loop for book = (iterator:next iterator)
      while (iterator:has-next iterator)
      do (print (iterator:name book))
      finally (print (iterator:name book)))

```
