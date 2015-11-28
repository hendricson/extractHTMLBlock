#Extract HTML Block
I quick handy Perl subroutine I wrote a while ago to extract contents of HTML blocks identified by opening tags:

```
<tag>BLOCK BODY or BLOCK CONTENTS</tag>
```

If there're multiple instances of the <tag> inside the HTML, only the first instance will be treated.

##USAGE##
**my ($block, $html_processed) = extractHtmlBlock ($html, $opening_tag_html, $inner, $debug);**

##ARGUMENTS##
**$html** - contains original HTML to be processed
**$opening_tag_html** - contains opening tag of a block inside $html
**$inner** - a flag of 1 or 0.
**$debug** - a flag of 1 or 0.

##RETURNING VALUES##
*$inner == 1*
**$block** - contains contents of the block identified by $opening_tag_html
**$html_processed** - contains $html with the body of the block removed

*$inner == 0*
**$block** - contains contents of the block identified by $opening_tag_html, along with the opening and closing tags
**$html_processed** - contains $html with the body, and opening/closing tags of the block removed


##EXAMPLE A##
```
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
my ($html, $source) = extractHtmlBlock ($html0, '<span class="one1">', 1, 0);
```

yields

```
html=[BLOCK 1]
source=[
<table>
<tr>
<td>
<div class="wrapper">
 <div class="one">
    <span class="one1"></span>
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
]
```


##EXAMPLE B##
```
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
```

yields

```
html=[<span class="one1">BLOCK 1</span>]
source=[
<table>
<tr>
<td>
<div class="wrapper">
 <div class="one">

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
]
```
