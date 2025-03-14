{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      black
      efm-langserver
    ];
    extraPython3Packages = (ps: with ps; [
      jedi
    ]);
    plugins = [
      pkgs.vimPlugins.lsp-format-nvim
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
      }
    ];
    extraConfig = ''
      set number relativenumber
    '';
  };
}
