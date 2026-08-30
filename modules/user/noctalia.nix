{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    
    settings = {
      # The main bar definition
      bar.default = {
        # Modules on the left side
        start = [ "workspaces" "active_window" ];
        
        # Modules on the right side
        end = [ 
          "tray" 
          "notifications" 
          "network" 
          "bluetooth" 
          "volume" 
          "battery" 
          "clock" 
          "session" 
        ];
        
        thickness = 36;
        margin_ends = 0.0; # full width
        padding = 4;
        capsule = false;
      };

      # Example: Noctalia uses the default styling and allows you to
      # configure the exact look inside the GUI settings menu!
    };
  };
}
