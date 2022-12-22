<!DOCTYPE html>
<html>   
   <head>
     <script src ="https://maps.googleapis.com/maps/api/js?key=AIzaSyAoGrm9TfuB_-NQlkDyXOYk0gEo3vDUZSY&callback=initMap"></script>  
     <%
	      String latCode = request.getParameter("latCode");
	      String longCode = request.getParameter("longCode");
	      String Comp_latCode = request.getParameter("comp_LatCode");
	      String Comp_longCode = request.getParameter("comp_LongCode");
	      String location = request.getParameter("location");
	      String Comp_Location = request.getParameter("comp_Location") != "--" ? request.getParameter("comp_Location") : "--";
	    //System.out.println("latcode"+latCode+"longCode"+longCode+"Comp_latCode"+request.getParameter("comp_LatCode")+"Comp_longCode"+request.getParameter("comp_LongCode"));
	      String finalTHING = location ;	      
      %>
      <script type="text/javascript">        
         function loadMap() {
        	 <%if(latCode != null && longCode != null){%>
	        		var broadway = {
	        			info: '<strong>Tested Location :- <%=location%></strong><br>\
	        						Latitude = <%=latCode%><br>\
	        						Longitude = <%=longCode%>',
	        			lat: <%=latCode%>,
	        			long: <%=longCode%>
	        		};
        	<%}else{%>
	        		var broadway = {
	        			info: '<strong><%=location%></strong><br>\
	        						Latitude = <%=Comp_latCode%><br>\
	        						Longitude = <%=Comp_latCode%>>',
	        			lat: <%=Comp_latCode%>,
	        			long: <%=Comp_latCode%>
	        		};
        	<%}%>
        	<%if(!Comp_latCode.equals("0") && !Comp_longCode.equals("0")){%>
	        		var belmont = {
	        			info: '<strong><%=Comp_Location%></strong><br>\
			        				Latitude = <%=Comp_latCode%><br>\
									Longitude = <%=Comp_longCode%>',								
	        			lat: <%=Comp_latCode%>,
	        			long: <%=Comp_longCode%>
	        		};
        	<%}else{%>
	        		var belmont = {
	        				info: '<strong><%=location%></strong><br>\
	    						Latitude = <%=latCode%><br>\
	    						Longitude = <%=longCode%>',
	    			lat: <%=latCode%>,
	    			long: <%=longCode%>
        		};
        	<%}%>

        		var locations = [
        	      [broadway.info, broadway.lat, broadway.long, 0],
        	      [belmont.info, belmont.lat, belmont.long, 1]
        	    ];

        		var map = new google.maps.Map(document.getElementById('sample'), {
        			zoom: 8,
        			center: new google.maps.LatLng(<%=latCode%>, <%=longCode%>),
        			mapTypeId: google.maps.MapTypeId.ROADMAP
        		});

        		var infowindow = new google.maps.InfoWindow({});

        		var marker, i;

        		for (i = 0; i < locations.length; i++) {
        			marker = new google.maps.Marker({
        				position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        				map: map
        			});

        			google.maps.event.addListener(marker, 'click', (function (marker, i) {
        				return function () {
        					infowindow.setContent(locations[i][0]);
        					infowindow.open(map, marker);
        				}
        			})(marker, i));
        			
        			var infowindow = new google.maps.InfoWindow({
                        content: locations[i][0]
                     });
         				
        			infowindow.open(map,marker);
        			
        		}
        	}
      </script>
   </head>   
   <body onload = "loadMap()">
      <div id = "sample" style = "width:100%; height:700px;"></div>
   </body>   
</html>