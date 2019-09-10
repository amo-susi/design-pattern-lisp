```common-lisp
(ql:quickload :bridge)

(setf d1 (bridge:make-display (bridge:make-normal-display-impl "枠線で表示")))
(setf d2 (bridge:make-display (bridge:make-star-display-impl "星で表示")))
(setf d3 (bridge:count-display (bridge:make-star-display-impl "星で表示(クラス)")))

(setf c1 (bridge:make-count-display (bridge:make-normal-display-impl "増幅して枠線で表示")))
(setf c2 (bridge:make-count-display (bridge:make-star-display-impl "増幅して星で表示")))

(bridge:execute-display d1)
(bridge:execute-display d2)
(bridge:execute-display d3)

(bridge:multi-display 5 c1)
(bridge:multi-display 3 c2)

```
