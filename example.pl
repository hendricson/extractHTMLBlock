#!/usr/bin/perl
require "extractHTMLBlock.pl";

$html0 = '
<table>
<tr>
<td>
<div class="wrapper">
 <div class="one">
    <span class="one1">BLOCK 1</span>
 </div>
 <div class="one">
    <span class="one2">BLOCK 2</span>
 </div>
 <div class="one">BLOCK 3</div>
 </div>
</div>
</td>
</tr>
</table>
';
my ($html, $source) = extractHtmlBlock ($html0, '<span class="one1">', 0, 0);

print STDOUT "html0=[", $html0,"]\n";
print STDOUT "html=[", $html,"]\n";
print STDOUT "source=[", $source,"]\n";

