# Reference: https://gitlab.com/risingprismtv/single-gpu-passthrough/-/blob/master/hooks/vfio-startup?ref_type=heads
# Trimmed (non-general) version because I know what my specific configuration is

################################# Variables #################################

## Adds current time to var for use in echo for a cleaner log and script ##
DATE=$(date +"%m/%d/%Y %R:%S :")

################################## Script ###################################

echo "$DATE Beginning of Startup!"


function stop_display_manager_if_running {
    rm "/tmp/vfio-sway-was-running"
    for sock in /run/user/1000/sway-ipc.*; do
        echo "true" >"/tmp/vfio-sway-was-running"
        swaymsg exit -s "$sock"
    done

    return
}

####################################################################################################################
## Checks to see if your running KDE. If not it will run the function to collect your display manager.            ##
## Have to specify the display manager because kde is weird and uses display-manager even though it returns sddm. ##
####################################################################################################################

stop_display_manager_if_running

## Unbind EFI-Framebuffer ##
if test -e "/tmp/vfio-is-amd"; then
    rm -f /tmp/vfio-is-amd
fi

sleep "1"

##############################################################################################################################
## Unbind VTconsoles if currently bound (adapted and modernised from https://www.kernel.org/doc/Documentation/fb/fbcon.txt) ##
##############################################################################################################################
if test -e "/tmp/vfio-bound-consoles"; then
    rm -f /tmp/vfio-bound-consoles
fi
for (( i = 0; i < 16; i++))
do
  if test -x /sys/class/vtconsole/vtcon"${i}"; then
      if [ "$(grep -c "frame buffer" /sys/class/vtconsole/vtcon"${i}"/name)" = 1 ]; then
	       echo 0 > /sys/class/vtconsole/vtcon"${i}"/bind
           echo "$DATE Unbinding Console ${i}"
           echo "$i" >> /tmp/vfio-bound-consoles
      fi
  fi
done

sleep "1"

echo "$DATE System has an AMD GPU"
grep -qsF "true" "/tmp/vfio-is-amd" || echo "true" >/tmp/vfio-is-amd
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

## Unload AMD GPU drivers ##
modprobe -r drm_kms_helper
modprobe -r amdgpu
modprobe -r radeon
modprobe -r drm

echo "$DATE AMD GPU Drivers Unloaded"

## Load VFIO-PCI driver ##
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1

echo "$DATE End of Startup!"

