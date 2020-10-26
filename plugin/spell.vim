command! -nargs=? SpellSyntaxAdd :call spell#SpellSyntaxAdd(<f-args>)
command! -nargs=0 SpellBuildTags
      \   :call spell#BuildTagsFile()
      \ | :call spell#LoadTagsFile()

augroup VimSpell
  autocmd!
  autocmd BufReadPost *
        \   :call spell#LoadSyntaxFile()
        \ | :call spell#LoadTagsFile()
augroup END
