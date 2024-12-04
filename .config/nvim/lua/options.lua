require "nvchad.options"

local o = vim.o
o.shell = "/usr/bin/zsh"
o.clipboard = "unnamedplus"
o.relativenumber = true
o.shiftwidth = 2
o.tabstop = 2

local g = vim.g
g.markdown_recommended_style = 0
