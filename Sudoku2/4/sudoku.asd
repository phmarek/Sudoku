(cl:in-package #:asdf-user)

(defsystem :sudoku
  :depends-on (:mcclim :alexandria)
  :serial t
  :components
  ((:file "packages")
   (:file "game")
   (:file "solver")
   (:file "solve-by-rules")
   (:file "draw-board")
   (:file "example-games")
   (:file "gui")))
