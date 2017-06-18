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

(golden-ratio-mode 1)