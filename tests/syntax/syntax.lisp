(in-package :cl-wegner-tests)

(in-suite cl-wegner-tests)

(test dummy-test-2
  (is (= 2 2)))

(test defun/w-returns-function-symbol
  (is (eq (defun/w fn () 123)
	  'fn)))

(test defun/w-creates-callable-function
  (defun/w fn ()
    315)
  (is (= (fn)
	 315)))

(test defun/w-with-required-args
  (defun/w fn (a b)
    (+ a b))
  (is (= 5
	 (fn 2 3))))

(test defun/w-with-rest-args
  (defun/w fn (&rest args)
    (reduce #'+ args))
  (is (= 55
	 (fn 22 33))))

(test defun/w-with-required-and-rest-args
  (defun/w fn (a b &rest args)
    (+ a b
       (reduce #'+ args)))
  (is (= 55
	 (fn 2 3 20 30))))
