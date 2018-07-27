# zpool-scrub-timers(8) -- scheduled zpool scrubbing

## SYNOPSIS

    systemctl enable --now zpool-scrub-monthly@tank.timer

or

    systemctl enable --now zpool-scrub-weekly@tank.timer

## DESCRIPTION

These unit files initiate a zpool scrub on a regular basis (weekly or monthly). For one-off scrubs
you should simply use `zpool scrub tank`, where `tank` is the pool to be scrubbed.

See `zpool(8)` for documentation of zpool subcommands.

See `zpool-scrub-timers(8)` to see this manual as a manpage.

## USAGE

The only option to these timers is the pool name to be scrubbed. If your pool name is `mypool` and
you want to schedule weekly scrubs use

    systemctl enable --now zpool-scrub-weekly@mypool.timer

## INSTALLATION

After cloning the repository or downloading and extracting a release use `make install` to install
the unit files in `/etc/systemd/system`.

Afterwards reload your daemon with `systemd daemon-reload` and enable the desired timer (see
OPTIONS).

## EXAMPLE

Clone the repository:

    mkdir -p ~/src/zpool-scrub
    cd ~/src/zpool-scrub
    git clone https://git.rz.semjonov.de/systemd/zpool-scrub.git .

Install unit files:

    make install

Enable timer:

    systemctl enable --now zpool-scrub-weekly@tank.timer
