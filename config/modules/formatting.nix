{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 1000;
    };
    formattersByFt = {
      nix = ["alejandra"];
      javascript = [["npm format" "yarn format" "prettierd"]];
      typescript = [["npm format" "yarn format" "prettierd"]];
      bash = ["shfmt"];
    };
  };

  extraPlugins = with pkgs; [
    prettierd
    alejandra
    shfmt
  ];
}
