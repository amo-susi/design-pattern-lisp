``` common-lisp
(ql:quickload :iterator)

(setf book-shelf (make-book-shelf))

(iterator:append-book (make-book "Around the World in 80 Days") book-shelf)

(iterator:append-book (make-book "Cinderella") book-shelf)

(iterator:append-book (make-book "Bible") book-shelf)

(iterator:append-book (make-book "Daddy-Long-Legs") book-shelf)

(setf iterator (iterator:get-iterator book-shelf))

(loop for book = (iterator:next iterator)
      while (iterator:has-next iterator)
      do (print (iterator:name book))
      finally (print (iterator:name book)))

```
