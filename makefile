# where to install systemd units
SYSTEMD := /etc/systemd/system
MODE := -m 644 -o root -g root

# construct unit names
NAME := zpool-scrub
SUFFIXES := -weekly@.timer -monthly@.timer @.service
UNITS := $(addprefix $(SYSTEMD)/$(NAME),$(SUFFIXES))

# not actually files
.PHONY : install reload

install : $(UNITS)
	@echo "Reload your systemd daemon if new files were installed:"
	@echo " $$ systemctl daemon-reload"
	@echo "Enable for zpool 'tank' with:"
	@echo " $$ systemctl enable --now zpool-scrub-monthly@tank.timer"

$(SYSTEMD)/% : %
	install $(MODE) $< $@
