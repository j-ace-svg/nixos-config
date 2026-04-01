OBJECT="$1"
OPERATION="$2"

if [[ $OBJECT == "vr-guest-passthrough" ]]; then
        case "$OPERATION" in
                "prepare")
                systemctl start libvirt-nosleep@"$OBJECT"  2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                vfio-startup 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                ;;

                "release")
                systemctl stop libvirt-nosleep@"$OBJECT"  2>&1 | tee -a /var/log/libvirt/custom_hooks.log  
                vfio-teardown 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
                ;;
        esac
fi
