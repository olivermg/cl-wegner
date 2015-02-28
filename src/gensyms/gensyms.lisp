(in-package #:cl-wegner)

(export '(with-gensyms))

(defmacro with-gensyms ((&rest syms) &body body)
  `(let ,(mapcar #'(lambda (sym)
		     `(,sym (gensym)))
		 syms)
     ,@body))
