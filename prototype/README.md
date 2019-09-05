```common-lisp
(ql:quickload :prototype)

(setf manager (make-instance 'prototype:manager))

(setf upen (make-instance 'prototype:unerline-pen :ulchar #\-))

(setf mbox (make-instance 'prototype:message-box :decochar #\*))

(setf sbox (make-instance 'prototype:message-box :decochar #\/))

(prototype:register 'strong-message upen manager)
(prototype:register 'warning-box mbox manager)
(prototype:register 'slash-box sbox manager)

(setf p1 (prototype:create 'strong-message manager))
(setf p2 (prototype:create 'warning-box manager))
(setf p3 (prototype:create 'slash-box manager))

(prototype:use "Hello prototype!" p1)
(prototype:use "Hello prototype!" p2)
(prototype:use "Hello prototyep!" p3)

```
