xquery version "1.0";
 
let $Listings := fn:doc("AllListings.xml")
return

(: The html tag :)
<html>
  
  <!-- head tag -->
  <head>
  
    <!-- The meta tag -->
    <meta http-equiv="Content-Type" content="text/html charset=utf-8" />

    <!-- Link the stylesheet -->
    <link rel="stylesheet" type="text/css" href="TvGuide.css" />

    
    <!-- title tag -->
    <title>Tv Guide</title>
    
  </head>
  
  <!-- body tag -->
  <body>
    {
      
      (: Iterate through the channels :)
      for $Channel in $Listings/Listings/Channels/Channel
      
      (: return a table containing programme data :)
      return
      <table>
      <caption>{$Channel/Name/text()}</caption>
        <tr>
          <th>Start Time</th>
          <th>Stop Time</th>
          <th>Title</th>
        </tr>
        
        {
          
          (: Iterate through the programmes in the current channel:)
          for $Programme in $Listings/Listings/Programmes/Programme
          where ($Programme/Channel/text() = $Channel/Name/text())
          order by $Programme/Start ascending
          
          (: Variables holding the start and stop time strings:)
          let $StartString := $Programme/Start/text()
          let $StopString := $Programme/Start/text()
          
          (: Get the years:)
          let $StartYear := fn:substring($Programme/Start/text(), 1, 4)
          let $StopYear := fn:substring($Programme/Stop/text(), 1, 4)         
          
          (: Get the months:)
          let $StartMonth := fn:substring($Programme/Start/text(), 5, 2)
          let $StopMonth := fn:substring($Programme/Stop/text(), 5, 2)       
          
          (: Get the days:)
          let $StartDay := fn:substring($Programme/Start/text(), 7, 2)
          let $StopDay := fn:substring($Programme/Stop/text(), 7, 2)          
          
          (: Get the hours:)
          let $StartHour := fn:substring($Programme/Start/text(), 9, 2)
          let $StopHour := fn:substring($Programme/Stop/text(), 9, 2)
          
          (: Get the minutes:)
          let $StartMinute := fn:substring($Programme/Start/text(), 11, 2)
          let $StopMinute := fn:substring($Programme/Stop/text(), 11, 2)
          
          (: return a row in the table containing data for a programme:)
          return
          <tr>
            <td>{$StartYear}-{$StartMonth}-{$StartDay}, {
              $StartHour}:{$StartMinute}</td>
              
            <td>{$StopYear}-{$StopMonth}-{$StopDay}, {
              $StopHour}:{$StopMinute}</td>
              
              
            <td class="Title">{$Programme/Title/text()}</td>
          </tr>
        }
      </table>
    } 
  </body>
</html>