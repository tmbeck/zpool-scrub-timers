# zpool-scrub

systemd zpool scrub service and timer

## Installation

Run `make install` to install unit files and reload systemd daemon.

Afterwards enable the timer, specifying your pool:

    systemctl enable --now zpool-scrub@tank.timer
