# vim-spell

Syntax specific spell files

I like keeping spell check on, however it has a few problems:

1. Often times, I'll use a word specific to the language I'm using in
   a comment which isn't a valid English word. This will cause vim to
   mark it as a mis-spelling. For example, if I use the word "const"
   in a c/c++ comment, vim will mark it. vim-spell works around this
   annoyance by providing syntax specific spelling files and loading
   them as needed.

2. When I use a word that is a project specific identifier, vim marks
   it as a mis-spelling as well. For example, if I were to define a
   class called "MyVector", it would be marked as a mis-spelling if I
   were to use it in a comment.

This plugin solves these issues by:

1. Providing languages specific word lists and spell files
2. Allowing the user to create a spell file from tags file
3. Set nospell for terminal and other non-modifiable buffers

A nice side-effect of 1 and 2 is that it acts kind of like
a very coarse syntax checker for code in comment and tells
the user when code in comments is incorrect or out-of-date

NOTE: A plugin that modifies spell checker to work properly
with CamelCase and identifiers with numbers in them will
probably solve a large subset of the problem this plugin
solves. However, I prefer this approach primarily due to
the syntax checking side-effect

## Installation

Using vim-plug:

```
Plug 'lakshayg/vim-spell', { 'branch': 'main', 'do': { -> spell#BuildAllSyntaxFiles() } }
```

The process should be similar for other plugin managers.

## Usage

Since this is a spell check plugin, make sure you "set spell"
otherwise the plugin doesn't really do anything.

The plugin works under the hood for the most part and requires
user interaction only when the user wants to build a spell file
from tags or add a new word to the syntax spell file.

To generate a spell file from the currently loaded tags files:

```
:SpellBuildTags
```

To add a new word to the syntax specific spell file:

```
:SpellSyntaxAdd [word]
```

If [word] is omitted, the word under the cursor is added.

If more advanced editing of word lists is required, use:

```
:SpellEdit [filetype]
```

When a word list is saved, it is automatically sorted, deduped and the
corresponding spell file is updated. If [filetype] is left unspecified,
filetype of the current buffer is used

To re-build all the spell files

```
:SpellBuildSyntaxAll
```

You might notice that identifiers are still highlighted as mis-spellings
even after generating the spell files. This is because the command only
build the spell files, to get vim to start using them, re-read the buffer
by using ":edit"
