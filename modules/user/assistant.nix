{config, pkgs, inputs, unstable, ...}:
{
  services.ollama.enable = true;
  services.ollama.acceleration = "cuda";
  services.ollama.package = pkgs.ollama;
  services.ollama.environmentVariables = {
    OLLAMA_ORIGINS = "*";
  }; 
  services.ollama.host = "0.0.0.0";

  # services.llama-cpp = {
  #  package = ;
  #  enable = true;
  #  host = "0.0.0.0";
  #  port = "42069";
  #  modelsDir = "${config.home.homeDirectory}/LLMS"
  #};

  home.packages = [
    (unstable.llama-cpp.override { cudaSupport = true; })
  ];
}
