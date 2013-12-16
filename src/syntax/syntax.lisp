(in-package :cl-wegner)

(export '(defun/w))

(defvar *functions* (make-hash-table))

(defstruct function/w
  arity)

#|
(defun funcall-or-apply (arglist)
  (if (some
       (lambda (s)
	 (eql
	  (position #\&
		    (symbol-name s))
	  0))
       arglist)
      'apply
      'funcall))
|#

(defmacro defun/w (name (&rest args) &body body)
  (setf (gethash name *functions*)
	(make-function/w
	 :arity (length (get-required-params args))))
  `(defun ,name (,@args)
     ,@body))

(defun call/w (stream char)
  (declare (ignore char))
  (let* ((delimited-list (read-delimited-list #\] stream t))
	 (fn-name (car delimited-list))
	 (fn (cond ((symbolp fn-name) `#',fn-name)
		   (t fn-name)))
	 (fn-args (cdr delimited-list))
	 (fn-args-len (length fn-args))
	 (fn-struct (if (symbolp fn-name)
			(gethash fn-name *functions*)))
	 (fn-arity (if fn-struct
		       (function/w-arity fn-struct)
		       0)))
    (if (>= fn-args-len fn-arity)
	`(funcall ,fn ,@fn-args)
	`(curry ,fn ,@fn-args))))

(set-macro-character #\[ #'call/w)
(set-macro-character #\] (get-macro-character #\)))
