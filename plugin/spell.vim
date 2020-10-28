command! -nargs=? SpellSyntaxAdd :call spell#SpellSyntaxAdd(<f-args>)
command! -nargs=? SpellBuildSyntax :call spell#BuildSyntaxFile(<f-args>)
command! -nargs=0 SpellBuildSyntaxAll :call spell#BuildAllSyntaxFiles()
command! -nargs=0 SpellBuildTags :call spell#BuildTagsFile()
command! -nargs=? SpellEdit :exe "edit" spell#GetWordList(<f-args>)

augroup VimSpell
  autocmd!

  " Load spell check files if buffer is modifiable
  autocmd BufReadPost *
        \   if &modifiable && &l:spell
        \ |   :call spell#LoadSyntaxFile()
        \ |   :call spell#LoadTagsFile()
        \ | else
        \ |   setlocal nospell
        \ | endif

  autocmd BufWritePost *.words :call spell#OnWordListWrite()
augroup END

" No spell check in terminal.
" Vim has TerminalOpen, Neovim has TermOpen
if has('nvim')
  autocmd VimSpell TermOpen * setlocal nospell
else
  autocmd VimSpell TerminalOpen * setlocal nospell
end
