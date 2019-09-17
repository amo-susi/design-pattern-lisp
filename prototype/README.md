```common-lisp
(ql:quickload :prototype)

(setf manager (prototype:make-manager))

(setf upen (prototype:make-underline-pen #\-))

(setf mbox (prototype:make-message-box #\*))

(setf sbox (prototype:make-message-box #\/))

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
