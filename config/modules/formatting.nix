{pkgs, ...}: {
	plugins.conform-nvim = {
		enable = true;
		formatOnSave = {
			lspFallback = true;
			timeoutMs = 1000;
		};
		formattersByFt = {
			nix = ["alejandra"];
			javascript = ["prettierd"];
			typescript = ["prettierd"];
			bash = ["shfmt"];
		};
	};

	extraPlugins = with pkgs; [
		prettierd
		alejandra
		shfmt
	];
}
