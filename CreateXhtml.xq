xquery version "1.0";
 
let $Listings := fn:doc("AllListings.xml")
return

(: The html tag :)
<html>
   <head>
     <title>Tv Guide</title>
   </head>
  
  <body>
    { 
      for $Channel in $Listings/Listings/Channels/Channel
      return
      <table>
        <tr>
          <th>{$Channel/Name/text()}</th>
        </tr>
        {
          for $Programme in $Listings/Listings/Programmes/Programme
          where ($Programme/Channel/text() = $Channel/Name/text())
          order by $Programme/Start ascending
          return
          <tr>
            <td>{$Programme/Title/text()}</td>
          </tr>
          
        }
      
      </table>
    } 
  </body>
</html>