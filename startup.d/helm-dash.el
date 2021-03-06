;; use google-chrome to open the documentation
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")
(setq helm-dash-browser-func 'browse-url-generic)

(setq helm-dash-docsets-path (concat emacs-user-directory "docsets"))

;; use Python 2 documentation as default for python-mode
(defun python2-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Python 2")))
(add-hook 'python-mode-hook 'python2-doc)
