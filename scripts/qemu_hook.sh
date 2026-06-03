#!/run/current-system/sw/bin/bash

# Set up persistent logging
LOGFILE="/var/log/qemu-hook.log"
exec >> "$LOGFILE" 2>&1

echo "========== Hook Triggered =========="
echo "Date: $(date)"

GUEST_NAME="$1"
OPERATION="$2"

echo "Guest: $GUEST_NAME | Operation: $OPERATION"

if [ "$GUEST_NAME" == "win11" ]; then
  if [ "$OPERATION" == "prepare" ] || [ "$OPERATION" == "begin" ]; then
    echo "Stopping display manager..."
    systemctl stop display-manager.service
    
    # Give the display manager time to fully die
    sleep 2 
    
    echo "Unbinding console and unloading NVIDIA drivers..."
    echo 0 > /sys/class/vtconsole/vtcon0/bind
    echo 0 > /sys/class/vtconsole/vtcon1/bind

    if test -e "/sys/bus/platform/drivers/simple-framebuffer/simple-framebuffer.0"; then 
        echo "simple-framebuffer.0" > /sys/bus/platform/drivers/simple-framebuffer/unbind
    fi

    if test -e "/sys/bus/platform/drivers/efi-framebuffer/efi-framebuffer.0"; then 
        echo "efi-framebuffer.0" > /sys/bus/platform/drivers/simple-framebuffer/unbind
    fi

    modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia
    
    echo "Loading VFIO drivers..."
    modprobe vfio-pci

    echo "Unmounting drives"
    unmount /mnt/hdd1
    unmount /mnt/hdd1

    echo "Prepare phase complete."

  elif [ "$OPERATION" == "release" ] || [ "$OPERATION" == "end" ]; then
    echo "Unloading VFIO drivers..."
    modprobe -r vfio-pci
    
    echo "Reloading NVIDIA drivers and binding console..."
    modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia
    echo 1 > /sys/class/vtconsole/vtcon0/bind
    echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

    echo "Mounting Drives"
    mount /mnt/hdd1
    mount /mnt/sdd1

    echo "Starting display manager..."
    systemctl start display-manager.service
    echo "Release phase complete."
  fi
fi
