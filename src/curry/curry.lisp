(in-package :cl-wegner)

(export '(curry))

(defun curry (function &rest args)
  (lambda (&rest more-args)
    (apply function (append args more-args))))
