return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
  opts = {
    'css',
    'html',
    'lua',
    'python',
  }
}
