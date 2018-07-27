# zpool-scrub

Scheduled zpool scrubbing with a systemd timer.

## installation

Run `make install` to install unit files.

Reload your systemd daemon with `systemctl daemon-reload`.

Finally enable a timer, specifying your pool name (`tank` in this example). A monthly and a weekly
timer are available.

    systemctl enable --now zpool-scrub-monthly@tank.timer

or

    systemctl enable --now zpool-scrub-weekly@tank.timer
