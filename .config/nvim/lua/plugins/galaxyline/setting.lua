local gl = require('galaxyline')
local fileinfo = require('galaxyline.provider_fileinfo')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg = '#282c34',
  line_bg = '#353644',
  fg = '#8FBCBB',
  fg_green = '#65a380',

  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#c678dd',
  blue = '#51afef';
  red = '#ec5f67'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  FirstElement = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue,colors.line_bg}
  },
}
gls.left[2] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.line_bg},
  },
}
gls.left[3] = {
  FileName = {
    provider = function()
      local path = vim.fn.expand('%:p')
      local _, git_path = pcall(vim.api.nvim_buf_get_var,0,'git_dir')

      if git_path == "" then
        return fileinfo.get_current_file_name()
      end

      if string.find(git_path, ".git/modules") ~= nil then
        -- git_path -> ~~~/.git/modules
        return string.sub(path, string.len(git_path)-11)
      end

      -- git_path -> ~~~/.git
      return string.sub(path, string.len(git_path)-3)
    end,
    condition = buffer_not_empty,
    highlight = {colors.fg,colors.line_bg,'bold'}
  }
}

gls.left[4] = {
  GitIcon = {
    provider = function() return '   ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange,colors.line_bg},
  }
}
gls.left[5] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = ' ',
    separator_highlight = {colors.blue,colors.line_bg},
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {'#8FBCBB',colors.line_bg,'bold'},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[6] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.green,colors.line_bg},
  }
}
gls.left[7] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.orange,colors.line_bg},
  }
}
gls.left[8] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.red,colors.line_bg},
  }
}
gls.left[9] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = {colors.bg,colors.line_bg},
    highlight = {colors.line_bg,colors.line_bg}
  }
}
gls.left[10] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[11] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.right[1]= {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' ',
    separator_highlight = {colors.bg,colors.line_bg},
    highlight = {colors.fg,colors.line_bg,'bold'},
  }
}
gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.blue,colors.line_bg},
    highlight = {colors.fg,colors.line_bg},
  },
}
gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {colors.line_bg,colors.line_bg},
    highlight = {colors.cyan,colors.darkblue,'bold'},
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.fg,colors.purple}
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.fg,colors.purple}
  }
}
