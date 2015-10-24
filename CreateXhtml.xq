xquery version "1.0";
 
let $source_doc := fn:doc("AllListings.xml")
return

(: The html tag :)
<html>
   <head>
     <title>Tv Guide</title>
   </head>
  
  <body>
    {
      for $b in $source_doc/Listings/Channels/Channel
      return
      <p>{$b/Name/text()}</p>
    } 
  </body>
</html>