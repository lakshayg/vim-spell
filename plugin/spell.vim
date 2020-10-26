command! -nargs=? SpellSyntaxAdd :call spell#SpellSyntaxAdd(<f-args>)
command! -nargs=0 SpellBuildTags
      \   :call spell#BuildTagsFile()
      \ | :call spell#LoadTagsFile()

augroup VimSpell
  autocmd!

  " No spell check in terminal
  autocmd TermOpen * setlocal nospell

  " Load spell check files if buffer is modifiable
  autocmd BufReadPost *
        \   if &modifiable
        \ |   :call spell#LoadSyntaxFile()
        \ |   :call spell#LoadTagsFile()
        \ | else
        \ |   setlocal nospell
        \ | endif
augroup END
