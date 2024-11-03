source ~/.exrc
set autoread
function! GitVimFormat(filename)
	call system('git vim-format ' . shellescape(a:filename))
	e
endfunction
au BufWritePost *.c call GitVimFormat(bufname())
