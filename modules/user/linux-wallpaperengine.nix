{config, ...}:
{
  services.linux-wallpaperengine = {
  enable = true;
  
  # Point this to your Steam installation's asset directory
  assetsPath = "/home/ebeyl/.local/share/Steam/steamapps/common/wallpaper_engine/assets";
  
  wallpapers = [
    {
      monitor = "DP-1"; # Change this to match your monitor name (run `hyprctl monitors` or `xrandr`)
      wallpaperId = "2955378002"; # Replace with your specific Wallpaper's Steam Workshop ID or local path
      scaling = "fill";
      extraOptions = [ "--fps" "60" ];
    }
  ];
};

}
