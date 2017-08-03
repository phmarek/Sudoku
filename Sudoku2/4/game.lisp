(in-package #:sudoku-game)

(defgeneric size (game))
(defgeneric alphabet (game))
(defgeneric blank (game))
(defgeneric board (game))

(defclass game ()
  ((%size :initarg :size :reader size)
   (%alphabet :initarg :alphabet :reader alphabet)
   (%blank :initarg :blank :reader blank)
   (%colors :initarg :colors :accessor colors)
   (%board :initarg :board :reader board)
   ;; bit-arrays of allowed values for each cell
   (%allowed :initform nil :accessor allowed)
   ;; areas in which values need to be unique - typically rows, columns, and the 3x3 quadrants.
   (%rows :initform nil :accessor row-set)
   (%cols :initform nil :accessor col-set)
   (%areas :initform nil :accessor area-set)
   ;; all these areas in one list.
   (%all :initform nil :accessor all-sets)))


(defun make-colors (length)
  (coerce (mapcar (lambda (i)
                    (clim:make-ihs-color (- 0.95 (* 0.16 (mod i 2)))
                                         (mod (/ (* 1 i) length) 1d0)
                                         (- 0.9 (* 0.3 (mod i 2))))
                  (alexandria:iota length))
          'vector))


;;; take a 9x9 matrix containing numbers 0-9 
;;; (where 0 means a blank cell) and produce 
;;; a game instance
(defun make-classic-game (matrix)
  (let ((alphabet '(1 2 3 4 5 6 7 8 9))
	(board (make-array '(9 9))))
    ;; just copy the matrix
    (loop for r from 0 below 9
	  do (loop for c from 0 below 9
		   do (setf (aref board r c)
			    (aref matrix r c))))
    (make-instance 'game
      :size 3
      :alphabet alphabet
      :blank 0
      :colors (make-colors (length alphabet))
      :board board)))


(defun convert-2d-to-cell-set (length areas)
  (loop with area-sets = (make-array length :initial-element nil)
        for i below (* length length)
        do (push i
                 (aref area-sets
                       (row-major-aref areas i)))
        finally (return (coerce area-sets 'list))))


(defun make-non-rect-game (matrix area-array)
  (let ((game (make-classic-game matrix)))
    (when area-array
        (sudoku-solver:set-cell-sets
          game
          (convert-2d-to-cell-set (sudoku-game:board-length game)
                                  area-array)))
    game))


(defun board-length (game)
  (expt (size game) 2))
