# Reference: https://gitlab.com/risingprismtv/single-gpu-passthrough/-/blob/master/hooks/vfio-teardown?ref_type=heads
# Trimmed (non-general) version because I know what my specific configuration is

################################# Variables #################################

## Adds current time to var for use in echo for a cleaner log and script ##
DATE=$(date +"%m/%d/%Y %R:%S :")

################################## Script ###################################

echo "$DATE Beginning of Teardown!"

## Unload VFIO-PCI driver ##
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

echo "$DATE Loading AMD GPU Drivers"

modprobe drm
modprobe amdgpu
modprobe radeon
modprobe drm_kms_helper

echo "$DATE AMD GPU Drivers Loaded"

## Restart Display Manager ##
input="/tmp/vfio-store-display-manager"
if grep -qsF "true" "/tmp/vfio-sway-was-running"; then
    wall "You might want to restart sway or smth idk"
    rm "/tmp/vfio-sway-was-running"
fi

############################################################################################################
## Rebind VT consoles (adapted and modernised from https://www.kernel.org/doc/Documentation/fb/fbcon.txt) ##
############################################################################################################

input="/tmp/vfio-bound-consoles"
while read -r consoleNumber; do
  if test -x /sys/class/vtconsole/vtcon"${consoleNumber}"; then
      if [ "$(grep -c "frame buffer" "/sys/class/vtconsole/vtcon${consoleNumber}/name")" \
           = 1 ]; then
    echo "$DATE Rebinding console ${consoleNumber}"
	  echo 1 > /sys/class/vtconsole/vtcon"${consoleNumber}"/bind
      fi
  fi
done < "$input"


echo "$DATE End of Teardown!"
