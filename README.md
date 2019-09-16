# scala-lsp

### Description

This [Spacemacs](http://spacemacs.org/) layer adds support for scala using
[metals](https://scalameta.org/metals/), following the
[official configuration advice](https://scalameta.org/metals/docs/editors/emacs.html).

### Install

First [install metals](https://scalameta.org/metals/docs/editors/emacs.html).

Then you need to clone this repository to `~/.emacs.d/private`:

`git clone git@github.com:TimWSpence/scala-lsp.git $HOME/.emacs.d/private/scala-lsp`

To use this configuration layer, add it to your `~/.spacemacs` You will need to
add `scala-lsp` to the existing `dotspacemacs-configuration-layers` list in this
file.

### Why another Scala LSP layer?

There already exists an [unofficial
Scala LSP layer](https://github.com/zheli/scala-lsp)
as well as [official support on the
develop branch](https://github.com/syl20bnr/spacemacs/tree/develop?files=1).

However, both of these depend heavily
on the now deprecated
[Scala LSP package](https://github.com/rossabaker/lsp-scala).
I looked briefly into updating either of them
but I'd already shaved enough yaks
doing this so I started from scratch instead.

If anyone fancies fixing this up and
merging it to Spacemacs, that would be much appreciated!!
