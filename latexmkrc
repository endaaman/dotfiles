#!/usr/bin/env perl

$bibtex           = 'upbibtex %O %B';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$latex            = 'uplatex -shell-escape -synctex=1 -halt-on-error';
$latex_silent     = 'uplatex -shell-escape -synctex=1 -halt-on-error -interaction=batchmode';
$makeindex        = 'upmendex %O -o %D %S';
$max_repeat       = 5;
$pdf_mode         = 3;
$pdf_previewer    = "xdg-open %S";
