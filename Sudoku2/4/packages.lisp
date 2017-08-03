(defpackage #:sudoku-game
    (:use #:cl)
  (:export #:game
	   #:make-classic-game
	   #:make-non-rect-game
	   #:size
	   #:alphabet
	   #:blank
	   #:board
	   #:colors
	   #:allowed
	   #:row-set
	   #:col-set
	   #:area-set
	   #:all-sets
	   #:board-length))

(defpackage #:sudoku-solver
    (:use #:cl)
  (:export #:stupid-solver
           #:allowed-values-in-cell
           #:set-cell-sets
           #:solve-one-step))

(defpackage #:sudoku-draw-board
    (:use :cl)
  (:export #:draw-board))

(defpackage #:sudoku-gui
    (:use #:clim-lisp #:clim)
  (:export))

(defpackage #:sudoku-example-games
    (:use #:cl)
  (:export #:*games*))
