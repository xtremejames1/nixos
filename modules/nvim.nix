{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
    libcxx
    libgcc
  ];
  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = config.dotfiles.directory+"/nvim";
    };
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-nio
      nui-nvim
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
            require("config.telescope")
        '';
      }
      telescope-ui-select-nvim
      nvim-web-devicons
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          require("config.cmp")
        '';
      }
      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      {
        plugin = nvim-lint;
        type = "lua";
        config = ''
          require("config.lint")
        '';
      }
      cmp-buffer
      cmp-cmdline
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          require("config.which-key")
        '';
      }
      luasnip
      {
        plugin = neorg;
        type = "lua";
        config = ''
        require("config.neorg")
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
        require("gitsigns").setup()
        '';
      }
      {
        plugin = neogit;
        type = "lua";
        config = ''
          require('neogit').setup{}
    '';
      }
      diffview-nvim
      neorg-telescope
      undotree
      plenary-nvim
      vim-sleuth
      comment-nvim
      {
        plugin = nvim-dap;
        type = "lua";
        config = ''
          require("config.debug")
        '';
      }
      nvim-dap-ui
      vim-surround
      vim-repeat
      indent-blankline-nvim
      lsp-zero-nvim
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          require("config.lsp")
        '';
      }
      fidget-nvim
      neodev-nvim
      {
        plugin = mini-nvim;
        type = "lua";
        config = ''
          require("config.mini")
        '';
      }
      todo-comments-nvim
      kanagawa-nvim
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup{}
        '';
      }
      {
        plugin = neoscroll-nvim;
        type = "lua";
        config = ''
          require("config.neoscroll")
          '';
      }
      {
        plugin = alpha-nvim;
        type = "lua";
        config = ''
          require("config.alpha")
    '';
     }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("config.lualine")
          '';
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
          require("config.noice")
          '';
      }
      nvim-notify
      {
        plugin = dressing-nvim;
        type = "lua";
        config = ''
          require('dressing').setup()
          '';
      }
      {
        plugin = vim-illuminate;
        type = "lua";
        config = ''
          require('illuminate').configure()
        '';
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = ''
          require('colorizer').setup()
          '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require("ibl").setup()
          '';
      }
      
      {
        plugin = oil-nvim;
        type = "lua";
        config = ''
          require("oil").setup({
            default_file_explorer = true,
          })
          '';
      }

      {
        plugin = flash-nvim;
        type = "lua";
        config = ''
          require("config.flash")
          '';
      }

      {
        plugin = harpoon2;
        type = "lua";
        config = ''
          require("config.harpoon")
          '';
      }

      vim-wakatime

      {
        plugin = persistence-nvim;
        type = "lua";
        config = ''
          require("persistence").setup()
          '';
      }

      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          require("config.trouble")
        '';
      }
      {
        plugin = barbecue-nvim;
        type = "lua";
        config = ''
          require("barbecue").setup()
          '';
      }
      nvim-navic

      nvim-treesitter-textobjects
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require("config.treesitter")
        '';
      }
    ];
    extraLuaPackages = luaPkgs : [
      luaPkgs.pathlib-nvim # For neorg
      luaPkgs.lua-utils-nvim # For neorg
    ];
    extraPackages = with pkgs; [
      tree-sitter-grammars.tree-sitter-norg-meta

      # Lua
      lua-language-server
      selene

      # Nix
      statix
      nixpkgs-fmt
      nil

    ];
    extraLuaConfig = ''
      require("config.general")
      require("config.remaps")
    '';
  };

}
