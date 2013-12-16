(in-package :cl-wegner)

(export '(fn-const-true
	  fn-const-false))



(defun fn-const-true (&rest args)
  (declare (ignore args))
  t)

(defun fn-const-false (&rest args)
  (declare (ignore args))
  nil)
