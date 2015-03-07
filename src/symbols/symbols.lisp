(in-package #:cl-wegner)

(export '(build-symbol))

(defmacro build-symbol ((&rest symbols-or-strings) &optional (package '*package*))
  `(intern
    (concatenate 'string
		 ,@(mapcar #'(lambda (sos)
			       (cond ((stringp sos) sos)
				     (t `(symbol-name ,sos))))
			   symbols-or-strings))
    ,package))
