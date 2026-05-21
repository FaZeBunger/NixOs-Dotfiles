#!/run/current-system/sw/bin/bash

# Set up persistent logging
LOGFILE="/var/log/qemu-hook.log"
exec >> "$LOGFILE" 2>&1

echo "========== Hook Triggered =========="
echo "Date: $(date)"

GUEST_NAME="$1"
OPERATION="$2"

MOUSE="/dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse"
KEYBOARD="/dev/input/by-id/usb-0c45_2.4G_Dongle-event-kbd"

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
    echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/unbind
    modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia
    
    echo "Loading VFIO drivers..."
    modprobe vfio-pci

    echo "Hooking Mouse and Keyboard"
    virsh qemu-monitor-command "$GUEST_NAME" --hmp "object_add input-linux,id=mouse1,evdev=$MOUSE"
    virsh qemu-monitor-command "$GUEST_NAME" --hmp "object_add input-linux,id=kbd1,evdev=$KEYBOARD,grab_all=on,repeat=on"

    echo "Prepare phase complete."

  elif [ "$OPERATION" == "release" ] || [ "$OPERATION" == "end" ]; then
    echo "Unloading VFIO drivers..."
    modprobe -r vfio-pci
    
    echo "Reloading NVIDIA drivers and binding console..."
    modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia
    echo 1 > /sys/class/vtconsole/vtcon0/bind
    echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

    echo "Releasing Mouse and Keyboard"
    virsh qemu-monitor-command "$GUEST_NAME" --hmp "object_del mouse1"
    virsh qemu-monitor-command "$GUEST_NAME" --hmp "object_del kbd1"
    
    echo "Starting display manager..."
    systemctl start display-manager.service
    echo "Release phase complete."
  fi
fi
