```common-lisp
(ql:quickload :proxy)

(setf iprintable (proxy:make-printer-proxy "ç≤ì°"))

(proxy:get-printer-name iprintable)

(proxy:set-printer-name "ìcíÜ" iprintable)

(proxy:get-printer-name iprintable)

(proxy:prprint "Hello World!" iprintable)

```