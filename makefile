DESTDIR :=
SYSTEMD := /etc/systemd/system
MANUALS := /usr/local/man

# find zpool binary
ZPOOL_BIN  := $(shell which zpool || echo /sbin/zpool)

NAME     := zpool-scrub
SERVICES := $(NAME)@.service
TIMERS   := $(NAME)-weekly@.timer \
						$(NAME)-monthly@.timer

.PHONY : build install install-units install-man man

# build systemd unit files
build : $(TIMERS) $(SERVICES)

# render scheduled timers
$(NAME)-%@.timer: $(NAME)@.timer.in
	sed 's/@SCHEDULE@/$*/g' $< > $@

# render service
$(NAME)@.service: $(NAME)@.service.in
	sed 's,@ZPOOL_BIN@,$(ZPOOL_BIN),g' $< > $@

# install all files
install : install-units install-man

# install systemd units in system
SYSTEMDDIR := $(DESTDIR)$(SYSTEMD)
install-units : $(addprefix $(SYSTEMDDIR)/,$(SERVICES) $(TIMERS))
$(SYSTEMDDIR) :
	install -m 755 -d $@
$(SYSTEMDDIR)/% : % $(SYSTEMDDIR)
	install -m 644 $< $@

# render manpage from markdown
MANPAGE := $(NAME)-timers.8
man : $(MANPAGE)
$(MANPAGE) : README.md
	marked-man \
		--version git-$$(git describe --always --abbrev) \
		--manual 'ZFS Utilities' \
		$< > $@

# install manpage in system
MANPAGEDIR := $(DESTDIR)$(MANUALS)/man8
install-man : $(MANPAGEDIR)/$(MANPAGE)
$(MANPAGEDIR) :
	install -m 755 -d $@
$(MANPAGEDIR)/$(MANPAGE) : $(MANPAGE) $(MANPAGEDIR)
	install -d $(@D)
	install -m 644 $< $@
	
# clean built files
clean:
	rm -f $(TIMERS) $(SERVICES)
