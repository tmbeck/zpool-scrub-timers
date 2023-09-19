# zpool-scrub-timers(8) -- scheduled zpool scrubbing

## SYNOPSIS

    systemctl enable --now zpool-scrub-monthly@tank.timer

or

    systemctl enable --now zpool-scrub-weekly@tank.timer

## DESCRIPTION

These unit files initiate a zpool scrub on a regular basis (weekly or monthly). For one-off scrubs
you should simply use `zpool scrub tank`, where `tank` is the pool to be scrubbed.

See `zpool(8)` for documentation of zpool subcommands.

**Note** that some time ago `zfsutils` started packaging a cron job in `/etc/cron.d/zfsutils-linux`, which simply scrubs all pools on every 2nd Sunday of the month. So you might not actually *need* this separate unit anymore, unless you want finer granularity or just prefer to use a systemd timer.

## USAGE

The only option to these timers is the pool name to be scrubbed. If your pool name is `mypool` and
you want to schedule weekly scrubs use

    systemctl enable --now zpool-scrub-weekly@mypool.timer

## INSTALLATION

After cloning the repository or downloading and extracting a release use `make install` to install
the unit files in `/etc/systemd/system`.

Afterwards reload your daemon with `systemd daemon-reload` and enable the desired timer (see
USAGE).

## EXAMPLE

Clone the repository:

    cd /tmp
    git clone https://github.com/ansemjo/systemd-zpool-scrub-timers.git
    cd systemd-zpool-scrub-timers/

Install unit files:

    sudo make install

Enable timer:

    sudo systemctl enable --now zpool-scrub-weekly@tank.timer
