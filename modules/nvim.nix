{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    clang
    libcxx
    libgcc
    pyright
    nodejs_24
  ];
  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = config.dotfiles.directory + "/nvim";
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
        plugin = blink-cmp;
        type = "lua";
        config = ''
          require("config.cmp")
        '';
      }
      blink-pairs
      {
        plugin = nvim-lint;
        type = "lua";
        config = ''
          require("config.lint")
        '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          require("config.which-key")
        '';
      }
      luasnip
      # {
      #   plugin = neorg;
      #   type = "lua";
      #   config = ''
      # require("config.neorg")
      #   '';
      # }
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
      # neorg-telescope
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
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = ''
          require("todo-comments").setup{}
        '';
      }
      kanagawa-nvim
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup{}
        '';
      }
      # {
      #   plugin = neoscroll-nvim;
      #   type = "lua";
      #   config = ''
      #   require("config.neoscroll")
      #   '';
      # }
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

      opencode-nvim
      {
        plugin = opencode-nvim;
        type = "lua";
        config = ''
                vim.g.opencode_opts = {
                provider = {
                enabled = "wezterm",
                wezterm = {
                --...
                }
                }
                }
                    -- Required for `opts.events.reload`.
          vim.o.autoread = true

          -- Recommended/example keymaps.
          vim.keymap.set({ "n", "x" }, "<leader>ao", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
          vim.keymap.set({ "n", "x" }, "<leader>ax", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
          vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

          vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { expr = true, desc = "Add range to opencode" })
          vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })

          vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
          vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
        '';
      }

      # {
      #   plugin = image-nvim;
      #   type = "lua";
      #   config = ''
      #     require("image").setup()
      #     '';
      # }

      {
        plugin = nabla-nvim;
        type = "lua";
        config = ''
          require("config.nabla")
        '';
      }

      # For plugins not in nixpkgs, fetch from GitHub
      (pkgs.vimUtils.buildVimPlugin {
        name = "org-bullets";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-orgmode";
          repo = "org-bullets.nvim";
          rev = "21437cf";
          sha256 = "/l8IfvVSPK7pt3Or39+uenryTM5aBvyJZX5trKNh0X0="; # Use lib.fakeSha256 first, then replace
        };
      })

      (pkgs.vimUtils.buildVimPlugin {
        name = "telescope-orgmode";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-orgmode";
          repo = "telescope-orgmode.nvim";
          rev = "a73d9b7";
          sha256 = "sha256-u3ZntL8qcS/SP1ZQqgx5q6zfGb/8L8xiguvsmU1M5XE="; # Use lib.fakeSha256 first, then replace
        };
        doCheck = false;
      })

      {
        plugin = orgmode;
        type = "lua";
        config = ''
            require('orgmode').setup({
                org_agenda_files = '~/orgfiles/**/*',
                org_default_notes_file = '~/orgfiles/refile.org',
                })
          require('org-bullets').setup()


          require('telescope').setup()
            require('telescope').load_extension('orgmode')
            vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
            vim.keymap.set('n', '<leader>fh', require('telescope').extensions.orgmode.search_headings)
            vim.keymap.set('n', '<leader>li', require('telescope').extensions.orgmode.insert_link)
        '';
      }

      {
        plugin = org-roam-nvim;
        type = "lua";
        config = ''
          require("org-roam").setup({
              directory = "~/orgfiles",
              })
        '';
      }

      {
        plugin = typst-preview-nvim;
        type = "lua";
        config = ''
          require("typst-preview").setup()
        '';
      }

      nvim-treesitter-textobjects

      nvim-remote-containers

      {
        plugin = remote-nvim-nvim;
        type = "lua";
        config = ''
          require("remote-nvim").setup()
        '';
      }
      # Factor this out
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
                    require("conform").setup({
                      formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- You can customize some of the format options for the filetype (:help conform.format)
            rust = { "rustfmt", lsp_format = "fallback" },
            ocaml = {"ocamlformat"},
            nix = {"alejandra", "nixfmt"}
          },
           format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
          },
                    })
        '';
      }

      {
        plugin = nvim-treesitter.withPlugins (_:
          nvim-treesitter.allGrammars
          ++ [
            (pkgs.tree-sitter-grammars.tree-sitter-org-nvim)
          ]);

        type = "lua";
        config = ''
          require("config.treesitter")
        '';
      }
    ];
    extraLuaPackages = luaPkgs: [
      luaPkgs.pathlib-nvim # For neorg
      luaPkgs.lua-utils-nvim # For neorg
      # luaPkgs.magick # For image
    ];
    extraPackages = with pkgs; [
      # lsp
      lua-language-server
      rust-analyzer
      tinymist
      selene
      clang-tools

      # Nix
      statix
      nixpkgs-fmt
      nil
      alejandra

      # Image
      # imagemagick

      # Other
      fortune
    ];
    extraLuaConfig = ''
      require("config.general")
      require("config.remaps")
    '';
  };
}
