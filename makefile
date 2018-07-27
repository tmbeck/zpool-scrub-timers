# where to install systemd units
SYSTEMD := /etc/systemd/system
MODE := -m 644 -o root -g root

# construct unit names
NAME := zpool-scrub
SUFFIXES := -weekly@.timer -monthly@.timer @.service
UNITS := $(addprefix $(SYSTEMD)/$(NAME),$(SUFFIXES))

# manuals go here
MANUALS := /usr/local/man

# not actually files
.PHONY : install install-man man

install : $(UNITS) install-man
	@echo "Reload your systemd daemon if new files were installed:"
	@echo " $$ systemctl daemon-reload"
	@echo "Enable for zpool 'tank' with:"
	@echo " $$ systemctl enable --now zpool-scrub-monthly@tank.timer"

$(SYSTEMD)/% : %
	install $(MODE) $< $@


man : $(NAME)-timers.8
$(NAME)-timers.8 : README.md
	marked-man \
		--version git-$$(git describe --always --abbrev) \
		--manual 'ZFS Utilities' \
		$< > $@

install-man : man $(MANUALS)/man8/$(NAME)-timers.8
$(MANUALS)/man8/% : %
	install -d $$(dirname $@)
	install $(MODE) $< $@