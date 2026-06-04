{config, pkgs, stylix, ...}:
{
  stylix.enable = true;
  stylix.image = ../../wallpapers/nasa.png; 
  stylix.polarity = "dark";
  stylix.targets.hyprland.hyprpaper.enable = true;

  # Wallpaper Daemon
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.stylix.image}"];
      wallpaper = [
      ",${config.stylix.image}"
      ];
    };
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
  };

  stylix.cursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
  };
}
