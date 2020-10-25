let s:plugin_dir = expand("<sfile>:p:h:h")
let s:words_dir = s:plugin_dir . "/words"
let s:spell_dir = s:plugin_dir . "/spell"

" Build .spl files from word lists
function! spell#BuildAllSpellFiles()
  let wordlists = split(globpath(s:words_dir, "*.txt"))
  for inname in wordlists
    let outname = s:spell_dir . (inname[len(s:spell_dir):-5])
    exe join(["mkspell! -ascii", outname, inname])
  endfor
endfunction

" If we have a spell file corresponding to the current filetype,
" include its path in `spelllang`
function! spell#AddSpelllang()
  let spellfile = s:spell_dir . "/" . &filetype . ".ascii.spl"
  if !filereadable(spellfile)
    return
  endif
  exe "setlocal spelllang+=" . &filetype
endfunction

augroup VimSpell
  autocmd!
  autocmd BufReadPost * :call spell#AddSpelllang()
augroup END

" Generate spell file for the specified filetype
function! spell#GenerateSpellFile(filetype)
  let wordfile = s:words_dir . "/" . a:filetype . ".txt"
  let spellfile = s:spell_dir . "/" . a:filetype . ".ascii.spl"
  exe join(["silent mkspell! -ascii", spellfile, wordfile])
endfunction

" Add a new word to the word list and spell file for the current
" filetype. This is currently terribly inefficient because we
" re-generate the spell file for each word added and should be
" improved. This is not a major problem for now because the word
" lists aren't too big
function! spell#SpellGood(...)
  let word = a:0 == 0 ? expand("<cword>") : a:1
  echo "Adding word \"" . word . "\""
  let wordfile = s:words_dir . "/" . &filetype . ".txt"
  call writefile([word], wordfile, "a")
  call spell#GenerateSpellFile(&filetype)
endfunction

command! -nargs=? SpellGood :call spell#SpellGood(<f-args>)
