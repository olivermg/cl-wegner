(in-package :cl-wegner)

(export '(defun/w))

(defvar *functions* (make-hash-table))

(defstruct function/w
  function
  argcount)

(defun get-required-params (all-args)
  (car (split-sequence:split-sequence
	#\&
	all-args
	:test (lambda (separator arg)
		(eql (position separator
			       (symbol-name arg))
		     0)))))

(defun filter-keywords-from-params (params)
  (remove-if
   (lambda (s)
     (eql
      (position #\&
		(symbol-name s))
      0))
   params))

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
	 :argcount (length (get-required-params args))))
  (let ((args-without-keywords
	 (filter-keywords-from-params args))
	(call-fn
	 (funcall-or-apply args)))
    `(defun ,name (,@args)
       (let* ((fn-s (gethash ',name *functions*))
	      (fn (function/w-function fn-s)))
	 (,call-fn fn ,@args-without-keywords)))))
