#!/bin/sh

## if these are blank, they are generated on first boot
echo -n > /var/lib/dbus/machine-id
echo -n > /etc/machine-id
