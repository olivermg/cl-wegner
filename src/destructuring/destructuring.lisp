(in-package #:cl-wegner)

(export '())

(defun read-destructuring (stream char-disp char-sub)
  (declare (ignore char-disp char-sub))
  (let ((readtable-bak (copy-readtable))
	(d-readtable (copy-readtable nil)))
    (setf *readtable* d-readtable)
    (let ((one (read stream t nil t))
	  (two (read stream t nil t))
	  (three (read stream t nil t))
	  (four (read stream t nil t)))
      (setf *readtable* readtable-bak)
      (if (not (equal '= two))
	  (error "invalid destructuring syntax"))
      `(destructuring-bind
	     ,one
	   ,three
	 ,four))))

(set-dispatch-macro-character #\# #\d #'read-destructuring)
