let s:plugin_dir = expand("<sfile>:p:h:h")
let s:words_dir = s:plugin_dir . "/words"
let s:spell_dir = s:plugin_dir . "/spell"

function! spell#generate_all_spell_files()
  let wordlists = split(globpath(s:words_dir, "*.txt"))
  for inname in wordlists
    let outname = s:spell_dir . (inname[len(s:spell_dir):-5])
    exe join(["mkspell! -ascii", outname, inname])
  endfor
endfunction

function! spell#add_spelllang()
  let spellfile = s:spell_dir . "/" . &filetype . ".ascii.spl"
  if !filereadable(spellfile)
    return
  endif
  exe "setlocal spelllang+=" . &filetype
endfunction

augroup VimSpell
  autocmd!
  autocmd BufReadPost * :call spell#add_spelllang()
augroup END

function! spell#generate_spell_file(filetype)
  let wordfile = s:words_dir . "/" . a:filetype . ".txt"
  let spellfile = s:spell_dir . "/" . a:filetype . ".ascii.spl"
  exe join(["silent mkspell! -ascii", spellfile, wordfile])
endfunction

function! spell#spell_good(...)
  let word = a:0 == 0 ? expand("<cword>") : a:1
  echo "Adding word \"" . word . "\""
  let wordfile = s:words_dir . "/" . &filetype . ".txt"
  call writefile([word], wordfile, "a")
  call spell#generate_spell_file(&filetype)
endfunction

command! -nargs=? SpellGood :call spell#spell_good(<f-args>)
