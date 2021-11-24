#!/bin/bash -eux

# Cleanup packer SSH key and machine ID generated for this boot
rm -f /root/.ssh/authorized_keys
rm -f /home/packer/.ssh/authorized_keys
rm -f /var/log/cloud-init.log /var/log/cloud-init-output.log 
rm -f /etc/machine-id
touch /etc/machine-id
chmod 644 /etc/machine-id
if [ "$(grep -m 1 '^ID=flatcar' /etc/os-release || true)" != "" ]; then
  # Remove the machine-id file to restore systemd's first-boot semantics
  # of preset evaluation, as Ignition relies on it to enable services
  rm /etc/machine-id
  # Create the Ignition flag file for Ignition to run on the next boot
  touch /boot/flatcar/first_boot
fi
