-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
local opt = vim.opt
local cache_dir = require('core.helper').get_cache_path()

--[[
  Appearance
--]]
-- Global
opt.cmdheight = 0 -- Number of screen lines to use for the command-line
opt.laststatus = 3 -- The value of this option influences when the last window will have a status line
opt.list = true -- List mode: By default, show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+"
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←' -- Comma-separated list of strings to use in 'list' mode and for the :list command
opt.ruler = false -- Show the line and column number of the cursor position, separated by a comma
opt.showcmd = false -- Show (partial) command in the last line of the screen
opt.showmode = false -- If in Insert, Replace or Visual mode put a message on the last line
opt.showtabline = 0 -- The value of this option specifies when the line with tab page labels will be displayed
opt.signcolumn = 'yes' -- When and how to draw the signcolumn
opt.termguicolors = true -- Enables 24-bit RGB color (required for some themes)
opt.title = true -- When on, the title of the window will be set to the value of 'titlestring' (if it is not empty), or to filename [+=-] (path)

-- Lines
opt.cursorline = true -- Highlight the text line of the cursor with CursorLine hl-CursorLine
opt.number = true -- Print the line number in front of each line
opt.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line

-- Popup Menu
opt.pumblend = 10 -- Enables pseudo-transparency for the popup-menu
opt.pumheight = 15 -- Maximum number of items to show in the popup menu

-- Window
opt.winblend = 10 -- Enables pseudo-transparency for a floating window
opt.winwidth = 30 -- Minimal number of columns for the current window

--[[
  Behaviour
--]]
-- Global
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.backspace = 'eol,start,indent' -- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode
opt.clipboard = 'unnamed,unnamedplus' -- Default to system clipboard
opt.colorcolumn = '100' -- Comma-separated list of screen columns that are highlighted with ColorColumn hl-ColorColumn
opt.complete = '.,w,b,u' -- This option specifies how keyword completion ins-completion works when CTRL-P or CTRL-N are used
opt.completeopt = 'menu,menuone,noinsert,noselect,preview' -- A comma-separated list of options for Insert mode completion
opt.cpoptions:append '>' -- A sequence of single character flags
opt.encoding = 'utf-8' -- String-encoding used internally and for RPC communication
opt.formatoptions = 'qnj1' -- This is a sequence of letters which describes how automatic formatting is to be done
opt.hidden = true -- Set hidden to allow switching to other buffer if it is modified
opt.history = 2000 -- A history of ":" commands, and a history of previous search patterns
opt.matchpairs:append '<:>' -- Characters that form pairs
opt.mouse = 'a' -- Enables mouse support
opt.scrolloff = 2 -- Minimal number of screen lines to keep above and below the cursor
opt.shortmess = 'aoOTIcF' -- This option helps to avoid all the hit-enter prompts caused by file messages
opt.showmatch = true -- When a bracket is inserted, briefly jump to the matching one
opt.sidescrolloff = 5 -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set
opt.smarttab = true -- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'
opt.spelloptions = 'camel' -- A comma-separated list of options for spell checking
opt.swapfile = false -- Use a swapfile for the buffer
opt.textwidth = 100 -- Maximum width of text that is being inserted
opt.undofile = true -- When on, Vim automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read
opt.visualbell = true -- Use visual bell instead of beeping
opt.wildignorecase = true -- When set case is ignored when completing file names and directories
opt.writebackup = false -- Make a backup before overwriting a file

-- Search
opt.ignorecase = true -- Ignore case in search patterns
opt.infercase = true -- When doing keyword completion in insert mode ins-completion, and 'ignorecase' is also on, the case of the match is adjusted depending on the typed text
opt.magic = true -- Changes the special characters that can be used in search patterns (may break plugins if switched off)
if vim.fn.executable('rg') == 1 then
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m' -- Format to recognize for the ":grep" command output
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case' -- Use rg in vim grep
end
opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters

-- Selection
opt.virtualedit = 'block' -- VirtualEdit block allow selection everywhere in visual block mode

-- Tabs / Spaces
opt.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>
opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for

-- Timers
opt.redrawtime = 1500 -- Time in milliseconds for redrawing the display
opt.timeout = true -- Determine with timeoutlen the behavior when part of a mapped key sequence has been received
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete
opt.ttimeout = true -- Determine with ttimeoutlen the behavior when part of a key code sequence has been received by the TUI
opt.ttimeoutlen = 10 -- Time in milliseconds to wait for a key code sequence to complete
opt.updatetime = 300 -- If this many milliseconds nothing is typed the swap file will be written to disk

-- Views
opt.splitbelow = true -- When on, splitting a window will put the new window below the current one
opt.splitright = true -- When on, splitting a window will put the new window right of the current one

-- Wrap
opt.breakindent = false -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks of text
opt.breakindentopt = 'shift:2,min:20' -- Settings for 'breakindent'
opt.foldlevel = 0 -- Sets the fold level: Folds with a higher level will be closed
opt.foldlevelstart = 99 -- Sets 'foldlevel' when starting to edit another buffer in a window
opt.foldmethod = 'marker' -- The kind of folding used for the current window
opt.linebreak = true -- If on, Vim will wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
opt.linespace = 0 -- Number of pixel lines inserted between characters
opt.showbreak = '↳  ' -- String to put at the start of lines that have been wrapped
opt.whichwrap = 'h,l,<,>,[,],~' -- Allow specified keys that move the cursor left/right to move to the previous/next line when the cursor is on the first/last character in the line

--[[
  Configuration Layout
--]]
-- Directories
opt.backupdir = cache_dir .. 'backup/' -- List of directories for the backup file, separated with commas
opt.directory = cache_dir .. 'swap/' -- List of directory names for the swap file, separated with commas
opt.undodir = cache_dir .. 'undo/' -- List of directory names for undo files, separated with commas
opt.viewdir = cache_dir .. 'view/' -- Name of the directory where to store files for :mkview

-- Files
opt.spellfile = cache_dir .. 'spell/en.uft-8.add' -- Name of the word list file where words are added for the zg and zw commands, it must end in ".{encoding}.add"

if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end
