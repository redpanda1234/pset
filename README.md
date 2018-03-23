# Pset!
`pset.cls` is a "small" LaTeX class file for typesetting a cover sheet
for my problem sets, in addition to typesetting some common commands
and such. If you'd like to use it, you have a few options:
1. If you'd like to use this to typeset _all_ of your homeworks, then
   you should probably install the file to your local `texmf/` folder
   tree directory what-have-you thing. Instructions
   [here](https://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te).
   Once you're in `texmf/tex/latex`, you can `git clone` the
   repository there, and everything should be hunky-dory. On my
   computer, the full path to `pset.cls` is
   ```zsh
   /Users/forestkobayashi/Library/texmf/tex/latex/pset/pset.cls
   ```

2. If you'd like to just take this for a test spin and not use it
   permanently (lame), then just download `pset.cls`, and place it in
   the same directory as whatever `.tex` file you'd like to typeset
   using it.

Then, all you'll need is a `\documentclass{pset}` at the top of your
file, followed by something like
```latex
% Substitute your name here!
\name{Forest Kobayashi}

% ...and the class this pset is for!
\class{Math 80}

% Self-explanatory.
\prof{Pippenger}
\assignment{1}
\duedate{3/27/2018}

% Takes (m/M)onday, (t/T)uesday, (w/W)ednesday, (t/T)hursday, or
% (f/F)riday as its argument. Whatever day is passed will be circled
% on the coversheet.
\dueday{Friday}

% To input the problems you were assigned, you can just enter them
% separated by commas. The table will automagically resize ---
% although, I can't guarantee that it'll look pretty if you have too
% many problems to fit on one coversheet. File an issue report if you
% are ever unfortunate enough to be assigned that many problems.

% Note that if you have something like `2(a, b)` and you don't want
% the `(a,b)` to be split apart, you can put {2(a,b)} into the list,
% and the braces will keep LaTeX from splitting on the comma.
\problems{1, 2, 3, 4}

% Similarly here
\acknowledgements{{}, {}, {}, {}}

% This takes as argument either 0, 1, or 2. 0 will place an X mark in
% the "on time" box, 1 in the "late, without deduction" (e.g. if you
% have a note from the Dean of Students), and 2 in the "late, with
% deduction" box.
\onTime{0}

% This is just here so that I can pust stuff like "Spring 2018" for
% whatever semester this is. Again, if TeX weren't unbearable, I'd
% automate this. But eh.
\season{Spring}

% Display the full date in the bottom left of the footer.
% Realistically, I could probably automate this (the only part that's
% not trivial is getting the date superscript right), but idk how to
% do RegEx in TeX, and in general, programming in TeX is unbearable.
\lfoot{Due Tuesday, March 27th 2018}
```

# "I have no idea how any of this works"
If you're not familiar with the structure of `.cls` files and/or
defining TeX commands, don't worry! Here is an explanation of most of
the commands I've defined/redefined in `pset.cls`:
* `\ref` --- In LaTeX, you can put a label (e.g.,
  `\label{eq:<equation_name>}`) on things like numbered equations and
  figures, allowing you to reference the equation number later in your
  document with `\ref{eq:<equation_name>}`. This is convenient,
  because if you insert an equation above `<equation_name>`, then you
  don't have to manually renumber it in your `.tex` file when its
  number increases. I have redefined `\ref` to just put parentheses
  around the equation number you get from `\ref`, so that your
  document reads "plugging (1) into (2)", and not "plugging 1 into 2".

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
  fit whatever argument you pass them. Essentially, that means things
  like set braces, parentheses, etc. I was tired of having to use
  `\left( \right)` to get parentheses that'd automatically scale to
  whatever I put inside them, and also thought it was a pain to find
  the corresponding `\left(` to a `\right)** whenever I decided I
  really wanted brackets. These commands solve these problems, more or
  less.
  - `\set{}` wraps the argument you pass it in large,
    automatically-scaled braces.
  - `\pn` does the same for parentheses
  - `\bk` for brackets
  - `\ip` for angeled brackets (e.g., for expected value of an
    operator), but _does not scale_ automatically. In case you're
    wondering, it gets its name from the _inner product_.
  - `\lip` is for _large inner product_, and is the same thing as
    `\ip` but it scales automatically to fit whatever you put inside.

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
