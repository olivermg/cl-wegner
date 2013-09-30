;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(in-package :cl-user)

(defpackage #:cl-wegner-asd
  (:use :cl :asdf))

(in-package :cl-wegner-asd)

(defsystem cl-wegner
    :name "cl-wegner"
    :version "0.0.1"
    :maintainer "Oliver Wegner <void1976@gmail.com>"
    :author "Oliver Wegner <void1976@gmail.com"
    :license "BSD"
    :description "cl-wegner"
    :depends-on ()
    :components ((:file "packages")
		 (:module src
			  :components ((:file "cl-wegner"
					      :depends-on ())
				       (:module curry
						:components ((:file "curry"
								    :depends-on ()))))
			  :depends-on ("packages"))))

(defsystem cl-wegner-tests
    :name "cl-wegner-tests"
    :depends-on (:cl-wegner
		 :fiveam)
    :components ((:file "packages.tests")
		 (:module tests
			  :components ((:file "cl-wegner"))
			  :depends-on ("packages.tests"))))
