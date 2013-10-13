(in-package :cl-wegner)

(export '(defun/w))

(defvar *functions* (make-hash-table))

(defstruct function/w
  function
  arity)

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

(defmacro defun/w (name (&rest args) &body body)
  (setf (gethash name *functions*)
	(make-function/w
	 :function (eval `(lambda (,@args)
			    ,@body))
	 :arity (length (get-required-params args))))
  (let ((args-without-keywords
	 (filter-keywords-from-params args))
	(call-fn
	 (funcall-or-apply args)))
    `(defun ,name (,@args)
       (let* ((fn-s (gethash ',name *functions*))
	      (fn (function/w-function fn-s)))
	 (,call-fn fn ,@args-without-keywords)))))

(defun call/w (stream char)
  (declare (ignore char))
  (let* ((delimited-list (read-delimited-list #\] stream t))
	 (fn-name (car delimited-list))
	 (fn-args (cdr delimited-list))
	 (fn-args-len (length fn-args))
	 (fn-struct (gethash fn-name *functions*))
	 ;; TODO: we don't even need this: (fn (function/w-function fn-struct))
	 (fn-arity (function/w-arity fn-struct)))
    (if (>= fn-args-len fn-arity)
	`(funcall #',fn-name ,@fn-args)
	`(curry #',fn-name ,@fn-args))))

(set-macro-character #\[ #'call/w)
(set-macro-character #\] (get-macro-character #\)))
