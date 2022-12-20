<!DOCTYPE html>
<html>
   
   <head>
     <script src ="https://maps.googleapis.com/maps/api/js?key=AIzaSyAoGrm9TfuB_-NQlkDyXOYk0gEo3vDUZSY&callback=initMap"></script>  
    <!-- <script src="http://localhost:9090/pred/WebContent/reports/assetReports/googlemap.js?key=AIzaSyAxHnrQpL8wb-4AvMjiIDajTETG8AJA7lU&callback=initMap"></script> --> 
      <%
      String latCode=request.getParameter("latCode");
      String longCode=request.getParameter("longCode");
      String assetName=request.getParameter("assetName");
      String habName=request.getParameter("habName");
      String location=request.getParameter("location");
      //System.out.println("latcode"+latCode+"longCode"+longCode);
      
      String finalTHING=habName+","+location+","+assetName;
      %>
      <script type="text/javascript">
         function loadMap() 
         {
			
           <%--  var mapOptions = {
               //center:new google.maps.LatLng(17.377631, 78.478603),
               center:new google.maps.LatLng('<%=latCode%>', '<%=longCode%>'),
               zoom:8
            }
				
            var map = new google.maps.Map(document.getElementById("sample"),mapOptions);
            
            var marker = new google.maps.Marker({
               position: new google.maps.LatLng('<%=latCode%>', '<%=longCode%>'),
               map: map,
               label: "Andhra Pradesh",
               animation:google.maps.Animation.Drop
            }); --%>
            var mapOptions = {
                    center:new google.maps.LatLng('<%=latCode%>', '<%=longCode%>'),
                    zoom:8
                 }
                 
                 var map = new google.maps.Map(document.getElementById("sample"),mapOptions);
                 
                 var marker = new google.maps.Marker({
                    position: new google.maps.LatLng('<%=latCode%>', '<%=longCode%>'),
                    map: map,
                    draggable:true,
                    animation:google.maps.Animation.Drop
                 });
                 
                 marker.setMap(map);
                 
                 var infowindow = new google.maps.InfoWindow({
                    content:'<%=finalTHING%>'
                 });
     				
                 infowindow.open(map,marker);
         }
      </script>

   </head>
   
   <body onload = "loadMap()">
      <div id = "sample" style = "width:580px; height:400px;"></div>
   </body>
   
</html>