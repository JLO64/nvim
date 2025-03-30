local header_1 = [[
 __   __     ______     ______     __   __   __     __    __    
/\ "-.\ \   /\  ___\   /\  __ \   /\ \ / /  /\ \   /\ "-./  \   
\ \ \-.  \  \ \  __\   \ \ \/\ \  \ \ \'/   \ \ \  \ \ \-./\ \  
 \ \_\\"\_\  \ \_____\  \ \_____\  \ \__|    \ \_\  \ \_\ \ \_\ 
  \/_/ \/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/ 
 ]]
local header_2 = [[
NNNNNNNN        NNNNNNNN                                                              iiii                          
N:::::::N       N::::::N                                                             i::::i                         
N::::::::N      N::::::N                                                              iiii                          
N:::::::::N     N::::::N                                                                                            
N::::::::::N    N::::::N    eeeeeeeeeeee       ooooooooooo vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm   
N:::::::::::N   N::::::N  ee::::::::::::ee   oo:::::::::::oov:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm 
N:::::::N::::N  N::::::N e::::::eeeee:::::eeo:::::::::::::::ov:::::v       v:::::v   i::::i m::::::::::mm::::::::::m
N::::::N N::::N N::::::Ne::::::e     e:::::eo:::::ooooo:::::o v:::::v     v:::::v    i::::i m::::::::::::::::::::::m
N::::::N  N::::N:::::::Ne:::::::eeeee::::::eo::::o     o::::o  v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m
N::::::N   N:::::::::::Ne:::::::::::::::::e o::::o     o::::o   v:::::v v:::::v      i::::i m::::m   m::::m   m::::m
N::::::N    N::::::::::Ne::::::eeeeeeeeeee  o::::o     o::::o    v:::::v:::::v       i::::i m::::m   m::::m   m::::m
N::::::N     N:::::::::Ne:::::::e           o::::o     o::::o     v:::::::::v        i::::i m::::m   m::::m   m::::m
N::::::N      N::::::::Ne::::::::e          o:::::ooooo:::::o      v:::::::v        i::::::im::::m   m::::m   m::::m
N::::::N       N:::::::N e::::::::eeeeeeee  o:::::::::::::::o       v:::::v         i::::::im::::m   m::::m   m::::m
N::::::N        N::::::N  ee:::::::::::::e   oo:::::::::::oo         v:::v          i::::::im::::m   m::::m   m::::m
NNNNNNNN         NNNNNNN    eeeeeeeeeeeeee     ooooooooooo            vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm
]]
local header_3 = [[
 /$$   /$$                                /$$              
| $$$ | $$                               |__/              
| $$$$| $$  /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$ 
| $$ $$ $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
| $$  $$$$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
| $$\  $$$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
| $$ \  $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
|__/  \__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/
]]
local header_4 = [[


███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

]]
return {
  {
    "snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        sources = {
          files = {
            hidden = true,
            ignored = true,
            include = {
              "*.json",
            },
          },
        },
      },
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = header_4,
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          --{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
        sections = {
          {
            -- { section = "header", height = 10 },
            {
              section = "terminal",
              cmd = "viu ~/.config/nvim/neovim-mark-flat.png -t -h 13",
              height = 15,
              indent = 20,
              padding = 1,
              -- ttl = 10,
            },
            { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1, gap = 1 },
            { section = "startup" },
          },
          {
            pane = 2,
            padding = 1,
            { icon = " ", title = "Git Repositories", section = "projects", indent = 2, padding = 10, gap = 1 },
            { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, gap = 1, padding = 1 },
            {
              section = "terminal",
              cmd = "~/.config/nvim/dashboard_status.sh",
              height = 1,
              indent = 9,
              ttl = 10,
            },
          },
        },
      },
    },
  },
}
