# Pset!
This repo is a collection of my various TeX classes/packages. It's
been over a year since I've updated this README, and a lot has
happened since then! I'll try to add documentation sometime soon. But
for now, here's a summary:

# Files in this repo:
## Class files
+ `fkpset.cls` is a "small" LaTeX class file for typesetting my
  problem sets, in addition to typesetting some common commands and
  such. It includes a (slightly _too_ heavily-weighted) header/footer,
  and a nice boxed problem statement environment. Lots of helpful math
  macros and stuff come from `fkmath.sty`. Sometime soon™, I'll
  automate the points table generation.

+ `fkbook.cls` is a bigger class file, for more book-like compendiums
  of stuff. It might not compile for you though, since it requires my
  current personal logo image thing to be present in the repo.

+ `fkpaper.cls` is a two-column scientific paper class. It uses some
  slightly modified `amsthm` environments to make breaks between
  things easier to identify visually. It's not super flexible yet, not
  sure when I'll come back to change that.

+ `fkpresentation.cls` is a barely-modified beamer template using
  Dresden. Currently, the color scheme is crane. Might not be
  everybody's cup of tea? I also made the fonts serifed, changed the
  default itemize symbol hierarchy and font sizing, and added space
  for logos. Honestly, that's pretty much it.

+ `fkmisc.cls` is basically the article class together with some minor
  formatting things and my math macro package. It's simple enough so
  as to almost not merit a dedicated class, but I was using it enough
  for REU apps that I figured I'd ensconce the template in its own
  class file.

## Package files
+ `fkmath.sty` has lots of cool math macros. Certainly, some part of
  `LaTeX` macros comes down to personal preference, but there's a lot
  here to love. I'll write full documentation for it sometime soon.

+ `fkmisc.sty` has some nice things to get code listings for `Python`
  and `LaTeX` formatted nicely. There's some weird business with
  vspace after listings that I'm not really sure what to do about, and
  `tipa` apparently breaks when used in conjunction with something in
  `fkmath.sty`, but I try not to think about it.

+ `fkthm.sty` defines common theorem/lemma/definition/etc.
  environments, and adds a hook into the definition/theorem
  environments that automatically generates a table of contents
  listing for them that you can insert into an appendix, etc.
  Unfortunately doesn't work with `hyperref` currently though.

  I might refactor soon and just move all of this stuff into
  `fkbook.cls` and `fkpset.cls` as appropriate though.

# Installing
If you'd like to use this to typeset _all_ of your homeworks, then you
should probably install the file to your local `texmf/` folder tree
directory what-have-you thing. Instructions
[here](https://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te).
Once you're in `texmf/tex/latex`, you can `git clone` the repository
there, and everything should be hunky-dory. On my computer, the full
path to `pset.cls` is
```zsh
/home/fkobayashi/texmf/tex/latex/pset/pset.cls
```

If you'd like to just take this for a test spin and not use it
permanently (lame), then just download `fkpset.cls`, `fkmath.sty`, and
`fkthm.sty`, placing them in the same directory as whatever `.tex`
file you'd like to typeset using it.

<!-- Then, all you'll need is a `\documentclass{fkpset}` at the top of your  -->
<!-- file, followed by something like -->
<!-- ```latex -->
<!-- % Substitute your name here! -->
<!-- \name{Forest Kobayashi} -->

<!-- % ...and the class this pset is for! -->
<!-- \class{Math 80} -->

<!-- % Self-explanatory. -->
<!-- \prof{Pippenger} -->
<!-- \assignment{1} -->
<!-- \duedate{3/27/2018} -->

<!-- % Takes (m/M)onday, (t/T)uesday, (w/W)ednesday, (t/T)hursday, or -->
<!-- % (f/F)riday as its argument. Whatever day is passed will be circled -->
<!-- % on the coversheet. -->
<!-- \dueday{Friday} -->

<!-- % To input the problems you were assigned, you can just enter them -->
<!-- % separated by commas. The table will automagically resize --- -->
<!-- % although, I can't guarantee that it'll look pretty if you have too -->
<!-- % many problems to fit on one coversheet. File an issue report if you -->
<!-- % are ever unfortunate enough to be assigned that many problems. -->

<!-- % Note that if you have something like `2(a, b)` and you don't want -->
<!-- % the `(a,b)` to be split apart, you can put {2(a,b)} into the list, -->
<!-- % and the braces will keep LaTeX from splitting on the comma. -->
<!-- \problems{1, 2, 3, 4} -->

<!-- % Similarly here -->
<!-- \acknowledgements{{}, {}, {}, {}} -->

<!-- % This takes as argument either 0, 1, or 2. 0 will place an X mark in -->
<!-- % the "on time" box, 1 in the "late, without deduction" (e.g. if you -->
<!-- % have a note from the Dean of Students), and 2 in the "late, with -->
<!-- % deduction" box. -->
<!-- \onTime{0} -->

<!-- % This is just here so that I can pust stuff like "Spring 2018" for -->
<!-- % whatever semester this is. Again, if TeX weren't unbearable, I'd -->
<!-- % automate this. But eh. -->
<!-- \season{Spring} -->

<!-- % Display the full date in the bottom left of the footer. -->
<!-- % Realistically, I could probably automate this (the only part that's -->
<!-- % not trivial is getting the date superscript right), but idk how to -->
<!-- % do RegEx in TeX, and in general, programming in TeX is unbearable. -->
<!-- \lfoot{Due Tuesday, March 27th 2018} -->
<!-- ``` -->

# Some (possibly out-of-date) documentation
Below is some of the documentation I added a year or so ago. I haven't
gone through it yet to check which parts are still current, so no
guarantees on correctness here.

If you're not familiar with the structure of `.cls` files and/or
defining TeX commands, don't worry! Here is an explanation of most of
the commands I've defined/redefined in `pset.cls`:
* `\cmark` and `\xmark`: Oftentimes, if I'm writing a proof that I've
  broken into multiple cases, I want to add a checkmark after
  completing each, to show the reader that I've finished. `\cmark`
  accomplishes that quite handily. `\xmark` is for cases when you want
  a...x mark.

* `\ph` inserts a blank character that's precisely as long as the `-`
  symbol in TeX. I use this to align entries in columns of matrices
  containing negative signs. To see what I mean, put the following
  into a `.tex` file of class `pset`, and compare how they look:
  ```latex
  \[
    \begin{bmatrix}
      -1 & 0 & \ph 0 \\
      \ph 0 & 1 & -2 \\
      -3 & 2 & \ph 3
    \end{bmatrix}
    \quad \text{vs} \quad
    \begin{bmatrix}
      -1 & 0 & 0 \\
      0 & 1 & -2 \\
      -3 & 2 & 3
    \end{bmatrix}
  \]
  ```
  yes, it's not perfect, but it gets the job done.

* `\qed` places a qed box at the right margin of the page, to signify
  that you've finished a proof.

* The following commands are all paired delimiters that'll adjust to
  fit whatever argument you pass them, if that's what you'd like them
  to do. Essentially, that means things like set braces, parentheses,
  etc. I was tired of having to use `\left( \right)` to get
  parentheses that'd automatically scale to whatever I put inside
  them, and also thought it was a pain to find the corresponding
  `\left(` to a `\right)` whenever I decided I really wanted brackets.
  These commands solve these problems, more or less. *HOWEVER*, you
  should also note that if you know for sure you'd like `\big\{
  <content> \big\}`, then you can actually just do
  `\set[big]{<content>}`, and thanks
  to [this](https://tex.stackexchange.com/a/1744) stackexchange hero,
  it'll work! And if you'd just like normal sized braces no matter how
  large the inside argument is, then you do `\set*{<content>}`. Pretty
  amazing! Anyways, the commands themselves are
  - `\set{}` --- wraps the argument you pass it in braces, according
    to the rules above.
  - `\abs{}` --- does the same, but with vertical rules.
  - `\norm{}` --- ibid, but with double vertical rules.
  - `\pn{}` --- parens
  - `\bk{}` --- brackets
  - `\ip{}` --- for angeled brackets, e.g. for an inner product, or an
    operator.
  - `\MID` --- this one is not like the others. If you put it inside
    of something like `\set{}`, then this will make a vertical rule
    that scales to the size of the `\set{}` braces. Useful for set
    comprehension.

* I've defined three shortcuts for changing the math font face: `\mrm`
  for `\mathrm`, `\mc` for `\mathcal`, and `\mb` for `\mathbf`. Now
  that I'm writing this out, I'm thinking maybe I should change `\mrm`
  to `\mr`. Hmm.

* `\st` is for typesetting "st" (such that) in math mode without
  having to write out `\mrm{\ st\ }` every time. Note, the `\ `'s are
  there to get the spacing right.

* `\lub` for lub (least upper bound), `\glb` for glb (greatest lower
  bound), and `\lcm` for lcm (least common multiple). Surprisingly,
  LaTeX doesn't have these by default.

* `\CC, \RR, \QQ, \ZZ,` and `\NN` typeset the symbols for the Complex
  Numbers, Real Numbers, Rational Numbers, Integers, and Natural
  Numbers, respectively.

* `\pdd` and `\dd` typeset partial and total differentials,
  respectively.

* `\pd` typesets a partial derivative. Here's how it works:
  `pd[4]{f}{t}` will typeset the fourth partial derivative of `f` with
  respect to `t`. Note that you put the order in the square brackets,
  then the numerator and denominator in braces.

* `\od` works similarly.

* `\series[<initial_value>]` typesets
  `\sum_{n=<initial_value>}^{\infty}`, where `<initial_value>` gives
  the first index of the sum. Defaults to `0` if not provided.

* `\multichoose{n}{k}` will typeset, you guessed it, the symbol for n
  multichoose k.

* In addition, there are a few handy environments. `theorem`,
  `corollary`, and `lemma`. You do these like
  ```latex
  \begin{theorem}[Pythagorean Theorem]
    For a right triangle with hypotenuse $c$, and legs $a$ and $b$,
    then we have $a^2 + b^2 = c^2$.
  \end{theorem}
  ```
  which will yield something like "Theorem 1.4 (Pythagorean Theorem)",
  if this is the 4th theorem you've added to your document in
  section/problem 1. If you add a corollary sometime later (but before
  the next theorem), it will be labeled as "Corollary 1.4.1" --- the
  corollary counter (the third number in 1.4.1) resets each time you
  create a new theorem or lemma. Nifty, right?
