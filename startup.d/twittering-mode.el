;; https://github.com/hayamiz/twittering-mode
(require 'twittering-mode)

;; https://emacs.stackexchange.com/questions/35138/using-a-master-password-gnupg-with-twittering-mode
;; $ gpg --generate-key
(setq twittering-use-master-password t)

;; my personal style of the timeline
(setq twittering-status-format
      "%i %RT{(RT)} %FACE[bold]{%S},  %@:\n%FOLD[  ]{%T %r%R%QT{\n+----\n%FOLD[|]{%i %S,  %@:\n%FOLD[  ]{%T %r%R}}\n+----}}\n ")

;; remove linum-mode in twittering-mode
(add-hook 'twittering-mode-hook (lambda () (linum-mode 0)))

(global-set-key (kbd "<f10>") 'twit)
