{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 1000;
    };
    formatters = {
      sqlfluff = {
        "inherit" = false;
        command = "${pkgs.sqlfluff}/bin/sqlfluff";
        # Since `sqlfluff` formats the file on disk by default
        # and it doesn't support outputing the formatted file to stdout
        # we need to add the `cat` command to print to stdout
        args = ["format" "--dialect" "postgres" "$FILENAME" "&&" "cat" "$FILENAME"];
      };
    };

    formattersByFt = {
      nix = ["alejandra"];
      javascript = [["npm format" "yarn format" "prettierd"]];
      typescript = [["npm format" "yarn format" "prettierd"]];
      bash = ["shfmt"];
      sql = ["sqlfluff"];
    };
  };

  extraPlugins = with pkgs; [
    prettierd
    alejandra
    shfmt
    sqlfluff
  ];
}
