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
    :depends-on (:split-sequence
		 :optima)
    :components ((:file "packages")
		 (:module src
			  :components ((:file "cl-wegner"
					      :depends-on ())
				       (:module functions
						:components ((:file "bool-functions")))
				       (:module curry
						:components ((:file "curry"))
						:depends-on ())
				       (:module immutable
						:components ((:file "immutable"))
						:depends-on ())
				       (:module algdata
						:components ((:file "algdata"))
						:depends-on ())
				       (:module syntax
						:components ((:file "syntax"))
						:depends-on ("curry"
							     "immutable"
							     "algdata"))
				       (:module alists
						:components ((:file "alists"))
						:depends-on ("functions"))
				       (:module lambda-lists
						:components ((:file "lambda-lists")))
				       (:module gensyms
						:components ((:file "gensyms")))
				       (:module destructuring
						:components ((:file "destructuring")))
				       (:module symbols
						:components ((:file "symbols"))))
			  :depends-on ("packages"))))

(defsystem cl-wegner-tests
    :name "cl-wegner-tests"
    :depends-on (:cl-wegner
		 :fiveam)
    :components ((:file "packages.tests")
		 (:module tests
			  :components ((:file "cl-wegner")
				       (:module syntax
						:components ((:file "syntax"))
						:depends-on ("cl-wegner")))
			  :depends-on ("packages.tests"))))
