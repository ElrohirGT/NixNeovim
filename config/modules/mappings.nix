{
  keymaps = [
    # Append previous line to current line
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
    }

    # Toggle NvimTree
    {
      mode = "n";
      key = "<leader>e";
      action = ":NvimTreeToggle<CR>";
    }

    # CTRL-q saves and closes file
    {
      mode = "n";
      key = "<C-Q>";
      action = ":wq<CR>";
    }

    # :w and :q are case insensitive
    {
      mode = "n";
      key = ":W";
      action = ":w";
    }
    {
      mode = "n";
      key = ":Q";
      action = ":q<CR>";
    }

    # CTRL-d/CTRL-u now centers the screen at cursor
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }

    # Next/Previous in search centers the screen
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
    }
    {
      mode = "x";
      key = "<leader>p";
      action = "\"_dP";
    }

    # Yank to system clipboard
    {
      mode = "n";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "v";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = "\"+Y";
    }

    # Disable Q
    {
      mode = "n";
      key = "Q";
      action = "<nop>";
    }

    # Rename symbol using IncRename
    {
      mode = "n";
      key = "<leader>rn";
      action = ":IncRename ";
    }

    # Vim fugitive
    {
      mode = "n";
      key = "<leader>gl";
      action = ":Git log --oneline --graph<CR>";
    }
  ];
}
