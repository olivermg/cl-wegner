(in-package #:cl-wegner)

(export '())

;;;
;;; example usage:
;;;
;;; (let ((vs '(33 44)))
;;;   [d (a b) = '(11 22)
;;;   [d (c d) = vs
;;;   (+ a b c d)]])
;;;

(defun read-destructuring (stream char-disp char-sub)
  (declare (ignore char-disp char-sub))
  (destructuring-bind
	(variable-list equal-sign value-list &rest body)
      (read-delimited-list #\] stream t)
    (if (not (equal '= equal-sign))
	(error "invalid destructuring syntax"))
    `(destructuring-bind
	   ,variable-list
	 ,value-list
       ,@body)))

(make-dispatch-macro-character #\[)
(set-dispatch-macro-character #\[ #\d #'read-destructuring)
(set-macro-character #\] (get-macro-character #\)))

;(set-dispatch-macro-character #\# #\d #'read-destructuring)

