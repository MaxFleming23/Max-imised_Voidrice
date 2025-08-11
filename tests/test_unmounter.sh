#!/bin/sh

# Validate the filtering logic used in the `unmounter` script for selecting
# mounted devices. The logic should only list partitions or decrypted devices
# that are mounted somewhere other than /boot, /home or swap and whose
# mountpoints are longer than a single character (to exclude `/`).

set -e

# Simulated output of `lsblk -nrpo "name,type,size,mountpoint"`
lsblk_sample=$(cat <<'EOF'
/dev/sda disk 931G /
/dev/sda1 part 100M /boot
/dev/sda2 part 930G /
/dev/sdb disk 1000G
/dev/sdb1 part 1000G /mnt/data
/dev/mapper/crypt0 crypt 100G /mnt/secret
/dev/sdc disk 16G
/dev/sdc1 part 16G /media/usb
EOF
)

output=$(echo "$lsblk_sample" |
    awk '($2=="part"||$2=="crypt")&&$4!~/\/boot|\/home$|SWAP/&&length($4)>1{printf "💾%s (%s)\n",$4,$3}')

expected=$(cat <<'EOF'
💾/mnt/data (1000G)
💾/mnt/secret (100G)
💾/media/usb (16G)
EOF
)

[ "$output" = "$expected" ]

