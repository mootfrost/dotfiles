{config, ...}: {
  programs.tofi = {
    enable = true;
    settings = {
      font = config.preferences.font.monospace-path;
      font-size = 13;
      hint-font = false;
      width = 640;
      height = 360;
      text-color = "#e8cdf4";
      prompt-color = "#f38ba8";
      selection-color = "#f9e2af";
      background-color = "#2b1e2e";
      border-width = 2;
      border-color = "#8F00FF";
      outline-width = 0;
      corner-radius = 5;
      padding-left = 16;
      padding-right = 16;
      prompt-text = "\"\"";
    };
  };
}
