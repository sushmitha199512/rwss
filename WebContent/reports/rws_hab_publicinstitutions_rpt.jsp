<%@ include file="/commons/rws_header1.jsp" %>
 
 
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>

<script type="text/javascript"> 
function hidecombos()
{
   document.getElementById('divisionName').style.display='none';
   document.getElementById('subdivName').style.display='none';
   document.getElementById('districtName').style.display='none';
   
}

  var httpRequest; 
  var combo;
  var district;
  var mandals;
  var divisions;
  var subdivision;

  
 function getvalues(selected)
 {
  var url=selected;
  if(selected=='circles')
  {
    
   url= "/pred/reports/CheckList.do?mode=div&circleCode="+document.getElementById('circleName').value;
   combo='circles';
   district='district';
   mandals='mandals';
   divisions='divisions';
   
  }
  else
  {
         if(selected=='divisions')
          {
           
           url= "/pred/reports/CheckList.do?mode=subDiv&divisionCode="+document.getElementById('divisionName').value+"&circleCode="+document.getElementById('circleName').value;
           combo="divs";
          
          }
          else 
          {
          if(selected=='subdivisions')
          {
           url= "/pred/reports/CheckList.do?mode=mandals&divisionCode="+document.getElementById('divisionName').value+"&circleCode="+document.getElementById('circleName').value+"&subdivisionCode="+document.getElementById('subdivName').value;
           combo='subDiv';
          }
          
          else{ 
          if(selected=='mandals')
          {
           url= "/pred/reports/CheckList.do?mode=panchayats&mandalCode="+document.getElementById('mandalName').value+"&circleCode="+document.getElementById('circleName').value;
            combo='panchayat';
          } 
          else {
          if(selected=='panchayats')
          {
          url= "/pred/reports/CheckList.do?mode=village&panchayatCode="+document.getElementById('panchayatName').value+"&mandalCode="+document.getElementById('mandalName').value+"&circleCode="+document.getElementById('circleName').value;
          combo='village';
          }   
          else {
          if(selected=='villages')
          {
          url= "/pred/reports/CheckList.do?mode=habitation&villageCode="+document.getElementById('villageName').value+"&mandalCode="+document.getElementById('mandalName').value+"&circleCode="+document.getElementById('circleName').value+"&panchayatCode="+document.getElementById('panchayatName').value;
          combo='habitation';
          }  
   }}}}}
        if (window.ActiveXObject) 
        { //IE
            httpRequest = new ActiveXObject("Microsoft.XMLHTTP"); 
        } 
        else if (window.XMLHttpRequest) 
        { //other browsers
            httpRequest = new XMLHttpRequest(); 
        } 
         
        httpRequest.open("GET", url, true); 
        httpRequest.onreadystatechange = function() {processRequest(); } ; 
        httpRequest.send(null); 
   } 
    function processRequest() 
    { 
        if(httpRequest.readyState== 1)
         {
          var img=" images\ajax-loader.gif"
           document.getElementById('load').innerHTML="<img src='images/ajax-loader3.gif'style='position:absolute; left:410px; top:100px' ALT='Please wait..'></img>";
         }
        if (httpRequest.readyState == 4) 
        { 
            if(httpRequest.status == 200) 
            { 
              
              var data=httpRequest.responseText;
              
              if( combo=='circles')
              { 
                 document.getElementById('load').innerHTML='';
                 document.getElementById('districtName').value='';
                 document.getElementById('subdivName').options.length=0;
                 if(document.getElementById('subdivName').options.length==0)
                 {
                 document.getElementById('subdivName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('mandalName').options.length=0;
                 if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('panchayatName').options.length=0;
                 if(document.getElementById('panchayatName').options.length==0)
                 {
                 document.getElementById('panchayatName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('villageName').options.length=0;
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('habitationName').options.length=0;
                 if(document.getElementById('habitationName').options.length==0)
                 {
                 document.getElementById('habitationName').options[0]=new Option("SELECT..","");
                 }
                var arr1=data.split('<//>');
               
                var div=arr1[0];
                var dist=arr1[1];
                var man=arr1[2];
                if(arr1[2]==null)
                {
                man='';
                }
               
                arr=div.split('</>');
                if(divisions=='divisions')
                {
                
                 document.getElementById('divisionName').options.length=0;
                 
                 for(var i=0;i<arr.length-1;i++)
                 { 
                  var values=arr[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('divisionName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('divisionName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('divisionName').options.length==0)
                 {
                 document.getElementById('divisionName').options[0]=new Option("SELECT..","");
                 }
                 divisions='';
               }
               arr='';
               arr=dist.split('</>');
            
              if(district=='district')
              {
               
               for(var i=0;i<arr.length-1;i++)
               { 
                var values=arr[i].split('<>');
                document.getElementById('districtName').value=values[0]; 
                document.getElementById('districtName').name=values[1]; 
               }
               district='';
              }
              arr='';
              arr=man.split('</>');
              if(mandals=='mandals')
              {
               document.getElementById('mandalName').options.length=0;
               
               for(var i=0;i<arr.length-1;i++)
               { 
                var values=arr[i].split('<>');
                if(i==0)
                  {
                  document.getElementById('mandalName').options[i]=new Option("SELECT..",""); 
                  }
                document.getElementById('mandalName').options[i+1]=new Option(values[0],values[1]); 
               }
                if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
               mandals='';
              }
                combo='';
                document.getElementById('load').innerHTML='';
            }  
            else if(combo=='divs')
            {
              document.getElementById('load').innerHTML='';
              document.getElementById('mandalName').options.length=0;
              if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
                  document.getElementById('panchayatName').options.length=0;
                 if(document.getElementById('panchayatName').options.length==0)
                 {
                 document.getElementById('panchayatName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('villageName').options.length=0;
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('habitationName').options.length=0;
                 if(document.getElementById('habitationName').options.length==0)
                 {
                 document.getElementById('habitationName').options[0]=new Option("SELECT..","");
                 }
               document.getElementById('subdivName').options.length=0;
              
              
               var arr=data.split('<//>');
             
               var sub=arr[0];
               var md=arr[1];
                if(arr[1]==null)
                {
                md='';
                }
               var sub1=sub.split('</>');
               
                 for(var i=0;i<sub1.length-1;i++)
                 { 
                  var values=sub1[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('subdivName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('subdivName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('subdivName').options.length==0)
                 {
                 document.getElementById('subdivName').options[0]=new Option("SELECT..","");
                 }
                 divisions='';
                 
                  var md1=md.split('</>');
                 for(var i=0;i<md1.length-1;i++)
                 { 
                  var values=md1[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('mandalName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('mandalName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('load').innerHTML='';
               }
               else if(combo=='subDiv')
              {
                 document.getElementById('mandalName').options.length=0;
                 if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
                 var md1=data.split('</>');
                 for(var i=0;i<md1.length-1;i++)
                 { 
                  var values=md1[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('mandalName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('mandalName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
                 //code added
                 document.getElementById('panchayatName').options.length=0;
                 if(document.getElementById('panchayatName').options.length==0)
                 {
                 document.getElementById('panchayatName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('villageName').options.length=0;
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('habitationName').options.length=0;
                 if(document.getElementById('habitationName').options.length==0)
                 {
                 document.getElementById('habitationName').options[0]=new Option("SELECT..","");
                 }
                 /////////
               document.getElementById('load').innerHTML='';
              }
               else if(combo=='panchayat')
              { 
                 document.getElementById('villageName').options.length=0;
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('habitationName').options.length=0;
                 if(document.getElementById('habitationName').options.length==0)
                 {
                 document.getElementById('habitationName').options[0]=new Option("SELECT..","");
                 }
                 document.getElementById('panchayatName').options.length=0;
                 if(document.getElementById('panchayatName').options.length==0)
                 {
                 document.getElementById('panchayatName').options[0]=new Option("SELECT..","");
                 }
                 var pan1=data.split('</>');
                 for(var i=0;i<pan1.length-1;i++)
                 { 
                  var values=pan1[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('panchayatName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('panchayatName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('panchayatName').options.length==0)
                 {
                 document.getElementById('panchayatName').options[0]=new Option("SELECT..","");
                 }
               document.getElementById('load').innerHTML='';
              }
               else if(combo=='village')
              { 
                 document.getElementById('villageName').options.length=0;
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                 var pan1=data.split('</>');
                 for(var i=0;i<pan1.length-1;i++)
                 { 
                  var values=pan1[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('villageName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('villageName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                      document.getElementById('load').innerHTML='';
	                  combo='habitation';
                }
               if(combo=='habitation')
              { 
                 document.getElementById('habitationName').options.length=0;
                 if(document.getElementById('habitationName').options.length==0)
                 {
                 document.getElementById('habitationName').options[0]=new Option("SELECT..","");
                 }
                 var pan1=data.split('</>');
                 for(var i=0;i<pan1.length-1;i++)
                 { 
                  var values=pan1[i].split('<>');
                  if(i==0)
                  {
                  document.getElementById('habitationName').options[i]=new Option("SELECT..",""); 
                  }
                  document.getElementById('habitationName').options[i+1]=new Option(values[0],values[1]); 
                 }
                 if(document.getElementById('habitationName').options.length==0)
                 {
                 document.getElementById('habitationName').options[0]=new Option("SELECT..","");
                 }
               document.getElementById('load').innerHTML='';
              }
             
		      
	    } 
            else 
            { 
                alert("Error loading page\n"+ httpRequest.status +":"+ httpRequest.statusText); 
            } 
        } 
    }      
    
function viewReport()
{
var dcode=document.getElementById('circleName').value;
 
var mcode=document.getElementById('mandalName').value;
var pcode=document.getElementById('panchayatName').value;
var vcode=document.getElementById('villageName').value;
var hcode=document.getElementById('habitationName').value;

// alert("c:  "+dcode+"   m: "+mcode+"  P: "+pcode+" V: "+vcode+" H : "+hcode);
 
 var URL="./reports/PublicInst.do?mode=view&dcode="+dcode+"&mcode="+mcode+"&vcode="+vcode+"&hcode="+hcode+"&pcode="+pcode;
 window.open(URL,'',"top=100,left=0,height="+screen.availHeight/2+",width="+screen.availWidth+",location=0,scrollbars=1,directories=0,toolbar=yes,resizable=1,status=1");
}  
 </script>   

 <%@ include file="/commons/rws_header2.jsp" %>
<body onload="hidecombos()">
 
 
<html:form  method="post" action="CheckList.do?mode=data" enctype="multipart/form-data">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Public Institutions Report" />
	<jsp:param name="TWidth" value="350" />
</jsp:include>
 
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="375" border=1 style="border-collapse:collapse;">
	 
		<tr>
		<td class="bwborder">
		
		<fieldset >
		<legend>
		<B>Office Details</B>
		</legend>
		<label >
		
	     <table cellpadding="0" cellspacing="0" border="0" width="381" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
			    <tr >
			    <td class="textborder">Districts :</td>
			    <td>	
			    <html:select property="circleName" styleClass="mycombo" style="width:145px" onchange="getvalues('circles')">
				<html:option value="">ALL</html:option>
				<html:options collection="CirclesList" name="CirclesList" 
								  property="circleCode" labelProperty="circleName"/>
			    </html:select> 
			    </tr>
			    <tr>
			    </td>
			     
			    <td>	
			    <html:select property="divisionName" styleClass="mycombo" style="width:145px" onchange="getvalues('divisions')" >
			     <html:option value="">All</html:option>
			    </html:select> 
			    </td>
			    </tr>
			    <tr>
			     
			    <td>	
			    <html:select property="subdivName" styleClass="mycombo" style="width:145px" onchange="getvalues('subdivisions')">
			       
				 <html:option value="">All</html:option>
			    </html:select> 
			    </td>
		        </tr> 
                <tr >
			    <td>	
			    <html:text property="districtName" value="" readonly="true"/>
			    </td>
			    </tr>
			    <tr>
			    <td class="textborder">Mandals :</td>
			    <td>	
			    <html:select property="mandalName" styleClass="mycombo" style="width:145px" onchange="getvalues('mandals')">
			    <html:option value="">ALL</html:option>
				
			    </html:select> 
			    </tr>
			    <tr>
			    </td>
			    <td class="textborder">Panchayats :</td>
			    <td>	
			    <html:select property="panchayatName" styleClass="mycombo" style="width:145px" onchange="getvalues('panchayats')">
			    <html:option value="">ALL</html:option>
				
			    </html:select> 
			    </tr>
			    <tr>
			     
		        <tr>
		        </td>
			    <td class="textborder">Villages :</td>
			    <td>	
			    <html:select property="villageName" styleClass="mycombo" style="width:145px" onchange="getvalues('villages')">
			    <html:option value="">ALL</html:option>
				
			    </html:select> 
			    </td>
			    </tr>
			    <td class="textborder">Habitations :</td>
			    <td>	
			    <html:select property="habitationName" styleClass="mycombo" style="width:145px" onchange="getsubcomps('')">
			    <html:option value="">ALL</html:option>
				
			    </html:select> 
			    </td>
		       </tr> 
		       
        </table>
	   </label>
	   </fieldset>
	   <fieldset >
	   <table cellpadding="0" cellspacing="0" border="0" width="381" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
	           <tr>
	 	       <td class="textborder" align="center">
		       <input type="button" name="view" value="View Report" onclick="viewReport()"/>
		       </td>
		       </tr>
		 </table>
		 </fieldset>
 </table>
 	<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="351"/>
</jsp:include>
<table border ="0" cellspacing="20" >
<td align="right">
<b><b><b><b>
<div id="load">
</div>
</b></b></b></b>
</td>
</table>

</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
 
