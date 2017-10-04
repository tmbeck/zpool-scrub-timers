
systemd = /etc/systemd/system
mode = -m 644 -o root -g root

help:
	@echo "Please run 'make install' to install unit files and reload daemon."

install:
	install $(mode) zpool-scrub@.service $(systemd)
	install $(mode) zpool-scrub@.timer   $(systemd)
	systemctl daemon-reload

.PHONY: install
