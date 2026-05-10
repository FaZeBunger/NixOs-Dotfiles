{ config, ... }:
{
  # Enable sound
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true; # Ensure WirePlumber is enabled
      extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = false; # Often recommended to disable if having issues
          "bluez5.enable-hw-volume" = true;
          "bluez5.auto-connect" = [ "a2dp_sink" ];
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
        };
      };
    };
  };

}
