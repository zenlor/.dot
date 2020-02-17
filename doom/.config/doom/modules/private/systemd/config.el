;;
;; Systemd
;;
(def-package! systemd-mode
  :mode "\\.service$"
  :config
  (set! :company-backend 'systemd-mode '(systemd-mode-hook)))

