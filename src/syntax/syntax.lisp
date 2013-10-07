(in-package :cl-wegner)

(export '(defun/w))

(defvar *functions* (make-hash-table))

(defun get-required-params (all-args)
  (car (split-sequence:split-sequence
	#\&
	all-args
	:test (lambda (separator arg)
		(eql (position separator
			       (symbol-name arg))
		     0)))))

(defmacro defun/w (name (&rest args) &body body)
  (setf (gethash name *functions*)
	(length (get-required-params args)))
  `(defun ,name (,@args)
     ,@body))
