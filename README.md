# DEPRECATED
AUTOMATIC SCRUB TIMERS ARE IN OPENZFS UPSTREAM, see openzfs/zfs#12193 (released in zfs-2.1.3).

Maintained here because [ProxMox](https://www.proxmox.com/en/) doesn't seem to include them from upstream (even with newer upstream versions, such as `zfs-2.1.7-pve1`).

# zpool-scrub-timers(8) -- scheduled zpool scrubbing

## SYNOPSIS

    systemctl enable --now zpool-scrub-monthly@tank.timer

or

    systemctl enable --now zpool-scrub-weekly@tank.timer

## DESCRIPTION

These unit files initiate a zpool scrub on a regular basis (weekly or monthly). For one-off scrubs
you should simply use `zpool scrub tank`, where `tank` is the pool to be scrubbed.

See `zpool(8)` for documentation of zpool subcommands.

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
    git clone https://github.com/tmbeck/systemd-zpool-scrub-timers.git
    cd systemd-zpool-scrub-timers/

Install unit files:

    sudo make install

Enable timer with your desired periodicity:

    sudo systemctl enable --now zpool-scrub-weekly@tank.timer

or

    sudo systemctl enable --now zpool-scrub-monthly@tank.timer

or

    sudo systemctl enable --now zpool-scrub-quarterly@tank.timer
