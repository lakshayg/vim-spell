command! -nargs=? SpellSyntaxAdd :call spell#SpellSyntaxAdd(<f-args>)
command! -nargs=? SpellBuildSyntax :call spell#BuildSyntaxFile(<f-args>)
command! -nargs=0 SpellBuildSyntaxAll :call spell#BuildAllSyntaxFiles()
command! -nargs=0 SpellBuildTags :call spell#BuildTagsFile()

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
