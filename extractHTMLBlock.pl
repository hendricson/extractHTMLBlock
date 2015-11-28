#!/usr/bin/perl

use HTML::Entities;

sub writeLog  # write the same message to the screen and to a log file
{ while ($arg=shift)
    {  print STDOUT $arg."\n";
       #print LOG $arg."\n";
    }
}

sub trim {
    my($string)=@_;
    for ($string) {
        s/^\s+//;
        s/\s+$//;
        }
    return $string;
}

sub extractHtmlBlock {

   $source = $_[0]; #source string ()
   $block = $_[1]; #the opening tag of a block
   $inner = $_[2]; #if 1 - just grab what's inside the block;
                   #the block and its contents disappear from the source string.
                   #If set to 0, the block is left out empty
   $debug = $_[3];

   $debugMsg = '<h3>ExtractHtmlBlock: '.encode_entities($block)."</h3>\n";
   $startpos = index($source, $block);
   if($startpos==-1) {
       $debugMsg .= '- Cant find block';
       if ($debug) {writeLog "\t $debugMsg";}
       return;
   }

   $tagend = $startpos + length($block);

   $depth = 1;
   $tab = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
   while ($depth > 0 && $depth < 500 && $tagend > $startpos) {
           $debugMsg .=  "<br/>".($tab x $depth);
           $tagstart = index($source, '<', $tagend)+1;
           $newtagend = index($source, '>', $tagstart);

           if ($newtagend > $tagend) {
                $tagend = $newtagend;
           } else {
                last;
           }

           $tag = trim(substr($source,$tagstart,$tagend-$tagstart));

           if(substr($tag,0,1) eq '/') {
                $depth--;
                $debugMsg .= '___| -Closing tag:';
           } elsif (substr($tag, 0, 3) eq '!--') {
                $tagend = index(lc $source, '-->',lc $tagstart);
                $debugMsg .= $tab.'| =Comment';
           } elsif (lc(substr($tag, 0, 6)) eq 'script') {
                $tagend = index($source, 'script>',$tagstart);
                $debugMsg .= $tab.'| =Script:';
           } elsif (substr($tag,length($tag)-1,1) eq '/') {
                $debugMsg .= $tab.'| =Neutral:';
           } else {
                $depth++;
                $debugMsg .= $tab."|___+Opening tag:";
           }
           $debugMsg.= encode_entities('<'.$tag.'>') ." Depth: $depth\n";
        }

        $startpos = ($inner) ? $startpos + length($block):$startpos;
        $endpos = ($inner) ? $tagstart-1:$tagend+1;
        $html = substr($source, $startpos, $endpos-$startpos);
        $source_new = substr($source, 0,$startpos).substr($source, $endpos);
        $debugMsg .= "<h3>Done! Startpos: $startpos Endpos: $endpos </h3>\n";
        if($debug) {writeLog "\t $debugMsg";}
        return ($html, $source_new);
}

1;
