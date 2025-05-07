local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'nvim-telescope/telescope.nvim',    tag = '0.1.8' },
    {
        "rose-pine/neovim",
        name = "rose-pine"
    },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x'
    },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    -- code formatting
    {
        'google/vim-codefmt',
        -- enabled = working,
        dependencies = {
            'google/vim-maktaba',
            { 'google/vim-glaive', config = function() vim.cmd('call glaive#Install()') end },
        },
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
    },
    {
        "Diogo-ss/42-header.nvim",
        cmd = { "Stdheader" },
        keys = { "<F1>" },
        opts = {
            default_map = true, -- Maps <F1> to Stdheader in normal mode
            auto_update = false, -- Auto-updates the header on save
            user = "lnicolli", -- Replace with your 42 username
            mail = "lucas.nicollier@gmail.com", -- Replace with your 42 email
        },
        config = function(_, opts)
            require("42header").setup(opts)
        end,
    },
})
