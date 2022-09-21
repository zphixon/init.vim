return {
  asdf = function()
    print('wowowow')
  end,
  format_lines = function(from, to)
    -- set rustfmt options, get number of indent steps (in spaces)
    local ts = vim.opt.tabstop:get()
    local num_indent = ts
    local first_line = vim.fn.getline(from)
    local rustfmt_opts = ''
    if first_line:find('\t') then
      rustfmt_opts = rustfmt_opts .. 'hard_tabs=true'
    else
      rustfmt_opts = rustfmt_opts .. 'tab_spaces='
      local sw = vim.opt.shiftwidth:get()
      if sw ~= 0 then
        rustfmt_opts = rustfmt_opts .. sw
        num_indent = sw
      else
        -- see :h 'sw'
        rustfmt_opts = rustfmt_opts .. ts
      end
    end

    -- calculate number of nested indentations
    local num_visual_spaces = vim.fn.indent(from)
    local num_nest = num_visual_spaces / num_indent

    -- make some artificial nesting so rustfmt has something to indent
    local nest_begin = vim.fn['repeat']('fn x(){', num_nest)
    local nest_end = vim.fn['repeat']('}', num_nest)

    -- get the lines the user has highlighted
    local lines_list = vim.fn.getline(from, to)
    local lines_to_fmt = vim.fn.join(lines_list, '\n')

    -- TODO use plenary.job or jobstart
    -- format the text
    local to_fmt = nest_begin .. lines_to_fmt .. nest_end
    local rustfmt_output = vim.fn.system('rustfmt --config '.. rustfmt_opts, to_fmt)

    -- split the output into lines
    local rustfmt_lines = {}
    for line in rustfmt_output:gmatch('([^\n]+)') do
      table.insert(rustfmt_lines, line)
    end

    -- extract the lines we care about
    local formatted_lines = {}
    for lineno, line in ipairs(rustfmt_lines) do
      if num_nest < lineno and lineno <= #rustfmt_lines - num_nest then
        table.insert(formatted_lines, line)
      end
    end

    -- set the lines in the buffer
    local buffer = vim.fn.bufnr('%')
    vim.api.nvim_buf_set_lines(
      buffer,
      from - 1,
      to,
      true,
      formatted_lines
    )
  end,
  setup = function()
    vim.api.nvim_create_user_command(
      'FormatLines',
      'lua require("xd").format_lines(<line1>, <line2>)',
      {range = '%'}
    )
  end
}
