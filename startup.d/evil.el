;; https://github.com/emacs-evil/evil
(require 'evil)

;; use C-g to exit the INSERT mode
(define-key evil-insert-state-map (kbd "C-g") 'evil-force-normal-state)

(evil-mode 1)