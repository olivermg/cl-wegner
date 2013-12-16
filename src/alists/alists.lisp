(in-package :cl-wegner)

(export '(mapcar-alist))



(defun mapcar-alist (actionfn alist &key (testfn #'fn-const-true))
  (labels ((sub-map)))

  (let ((hits 0))
    (values
     (mapcar (lambda (elem)
	       (let ((key (car elem))
		     (value (cdr elem)))
		 (if (funcall testfn key value)
		     (progn
		       (incf hits)
		       (cons key
			     (funcall actionfn key value)))
		     elem)))
	     alist)
     hits)))
