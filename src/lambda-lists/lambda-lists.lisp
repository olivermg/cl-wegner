(in-package :cl-wegner)

(export '(get-required-params
	  filter-keywords-from-params))

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
