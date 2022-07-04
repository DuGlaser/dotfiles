vim.g.bookmark_sign = "🔖"
vim.g.bookmark_save_per_working_dir = 1
vim.g.bookmark_auto_save = 1

vim.cmd([[
function! g:BMWorkDirFileLocation()
    let filename = 'bookmarks'
    let location = ''
    if isdirectory('.git')
        let location = getcwd().'/.git'
    else
        let location = finddir('.git', '.;')
    endif
    if len(location) > 0
        return location.'/'.filename
    else
        return getcwd().'/.'.filename
    endif
endfunction
]])
