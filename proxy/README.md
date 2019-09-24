```common-lisp
(ql:quickload :proxy)

(setf iprintable (proxy:make-printer-proxy "佐藤"))

(proxy:get-printer-name iprintable)

(proxy:set-printer-name "田中" iprintable)

(proxy:get-printer-name iprintable)

(proxy:prprint "Hello World!" iprintable)

```