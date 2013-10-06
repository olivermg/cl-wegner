(in-package :cl-wegner)

(export '(defun/w))

(defmacro defun/w (name (&rest args) &body body)
  `(defun ,name (,@args)
     ,@body))
