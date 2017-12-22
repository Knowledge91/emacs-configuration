;; https://github.com/roman/golden-ratio.el
(require 'golden-ratio)

(setq golden-ratio-auto-scale t)

;; same as defaults but added `ignore-error-wrapper' since it's what
;; I'm using
(setq golden-ratio-extra-commands
      '(windmove-left
        windmove-right
        windmove-down
        windmove-up
        ignore-error-wrapper))

;; exclude ispell choices when pressing M-$
(setq golden-ratio-exclude-buffer-names
      '("*Choices*"
        "*twittering-edit*"
        "*Ediff Control Panel*"
        "*helm mini*"
        "*heml M-x*"))

(setq golden-ratio-exclude-buffer-regexp '("`_[Hh]elm.__'"))
(setq golden-ratio-exclude-modes '(ediff-mode calendar-mode wget-mode))
(setq golden-ratio-recenter t)

(golden-ratio-mode 1)
