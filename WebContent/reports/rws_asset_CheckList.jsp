<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<jsp:include flush="true" page="./rws_asset_CheckList_Script.jsp"></jsp:include>
 
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


  var httpRequest; 
  var combo;
  var district;
  var mandals;
  var divisions;
  var subdivision;

  
 function getvalues(selected)
 {
   //alert("gfgffgfhj: "+selected);
  var url=selected;
  if(selected=='circles')
  {
    // alert(" in circle");
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
              //  (data);
              // alert(combo);
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
                 // alert(data);
                 var allData=data.split('<///>');
                 // alert(allData);
                 var counts=allData[1].split('<>');
                 // alert("111111111111");
                 document.getElementById('pwsCount').value=counts[0];
                 document.getElementById('mpwsCount').value=counts[1];
                 document.getElementById('cpwsCount').value=counts[2];
                 document.getElementById('handPumpCount').value=counts[3];
                 document.getElementById('shalHpCount').value=counts[4];
                 document.getElementById('wellsCount').value=counts[5];
                 document.getElementById('pondsCount').value=counts[6];
				 document.getElementById('dpCount').value=counts[7];
                
                // alert("222222222222");
                var arr1=allData[0].split('<//>');
               
                var div=arr1[0];
                // alert(div);
                // alert(dist);
                // alert(man);
                
                var dist=arr1[1];
                var man=arr1[2];
                if(arr1[2]==null)
                {
                man='';
                }
               //alert("gggg:"+div);
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
                // alert(" in district ");
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
             //  alert(" in div count");
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
              // alert(" in div count1");
               // alert(data);
               var allData=data.split('<///>');
                 var counts=allData[1].split('<>');
                 document.getElementById('pwsCount').value=counts[0];
                 document.getElementById('mpwsCount').value=counts[1];
                 document.getElementById('cpwsCount').value=counts[2];
                 document.getElementById('handPumpCount').value=counts[3];
                 document.getElementById('shalHpCount').value=counts[4];
                 document.getElementById('wellsCount').value=counts[5];
                 document.getElementById('pondsCount').value=counts[6];
				 document.getElementById('dpCount').value=counts[7];
                 //alert(" aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");  
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
                 // alert(" ffffffffffffffffffffffff");
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
                  combo='';
                 document.getElementById('load').innerHTML='';
                 // alert("ddddddddddd");
               }
               else if(combo=='subDiv')
              {
                 document.getElementById('mandalName').options.length=0;
                 if(document.getElementById('mandalName').options.length==0)
                 {
                 document.getElementById('mandalName').options[0]=new Option("SELECT..","");
                 }
                 // alert("data"+data);
                 var allData=data.split('<///>');
                 var counts=allData[1].split('<>');
                 document.getElementById('pwsCount').value=counts[0];
                 document.getElementById('mpwsCount').value=counts[1];
                 document.getElementById('cpwsCount').value=counts[2];
                 document.getElementById('handPumpCount').value=counts[3];
                 document.getElementById('shalHpCount').value=counts[4];
                 document.getElementById('wellsCount').value=counts[5];
                 document.getElementById('pondsCount').value=counts[6];
				 document.getElementById('dpCount').value=counts[7];
                
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
                 combo='';
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
                 
                 var allData=data.split('<///>');
                 var counts=allData[1].split('<>');
                 document.getElementById('pwsCount').value=counts[0];
                 document.getElementById('mpwsCount').value=counts[1];
                 document.getElementById('cpwsCount').value=counts[2];
                 document.getElementById('handPumpCount').value=counts[3];
                 document.getElementById('shalHpCount').value=counts[4];
                 document.getElementById('wellsCount').value=counts[5];
                 document.getElementById('pondsCount').value=counts[6];
				 document.getElementById('dpCount').value=counts[7];
                
                 
                 var pan1=allData[0].split('</>');
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
                 combo='';
               document.getElementById('load').innerHTML='';
              }
               else if(combo=='village')
              { 
                 document.getElementById('villageName').options.length=0;
                 if(document.getElementById('villageName').options.length==0)
                 {
                 document.getElementById('villageName').options[0]=new Option("SELECT..","");
                 }
                 
                 var allData=data.split('<///>');
                 var counts=allData[1].split('<>');
                 document.getElementById('pwsCount').value=counts[0];
                 document.getElementById('mpwsCount').value=counts[1];
                 document.getElementById('cpwsCount').value=counts[2];
                 document.getElementById('handPumpCount').value=counts[3];
                 document.getElementById('shalHpCount').value=counts[4];
                 document.getElementById('wellsCount').value=counts[5];
                 document.getElementById('pondsCount').value=counts[6];
				 document.getElementById('dpCount').value=counts[7];
                
                 var pan1=allData[0].split('</>');
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
                 
                  var allData=data.split('<///>');
                 var counts=allData[1].split('<>');
                 document.getElementById('pwsCount').value=counts[0];
                 document.getElementById('mpwsCount').value=counts[1];
                 document.getElementById('cpwsCount').value=counts[2];
                 document.getElementById('handPumpCount').value=counts[3];
                 document.getElementById('shalHpCount').value=counts[4];
                 document.getElementById('wellsCount').value=counts[5];
                 document.getElementById('pondsCount').value=counts[6];
				 document.getElementById('dpCount').value=counts[7];
                 var pan1=allData[0].split('</>');
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
              ///1)if any radio button  is addded we need to   verify here also
		     if(document.getElementById('pws').checked||document.getElementById('cpws').checked||
		      document.getElementById('mpws').checked||document.getElementById('handPump').checked
		      ||document.getElementById('shallowHandPumps').checked||document.getElementById('openWells').checked
		      ||document.getElementById('ponds').checked || document.getElementById('dp').checked ) 
		      {
		       getsubcomps('');
		      }
		      
	    } 
            else 
            { 
                //  alert("Error loading page\n"+ httpRequest.status +":"+ httpRequest.statusText); 
            } 
        } 
    }           
 </script>   
 <script type="text/javascript"> 
 
 function hidetables()
{
                       document.getElementById('subCompsCpws').style.display='none';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsHP').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
}
var val=0;
function getsubcomps(Asset)
{
var ccode=document.getElementById('circleName').value;
var divcode=document.getElementById('divisionName').value;
var subcode=document.getElementById('subdivName').value;
var mcode=document.getElementById('mandalName').value;
var pcode=document.getElementById('panchayatName').value;
var vcode=document.getElementById('villageName').value;
var hcode=document.getElementById('habitationName').value;

if(Asset=='')
{
       
		if(document.getElementById('pws').checked)
		{
		Asset='pws';
		
		}

		if(document.getElementById('mpws').checked)
		{
		Asset='mpws';
		
		}

		if(document.getElementById('cpws').checked)
		{
		Asset='cpws';
		
		}
		if(document.getElementById('handPump').checked)
		{
		Asset='hp';
		
		}
		if(document.getElementById('shallowHandPumps').checked)
		{
		 Asset='swhp';
		
		}
		if(document.getElementById('openWells').checked)
		{
		 Asset='opnWel';
		
		}
		if(document.getElementById('ponds').checked)
		{
		Asset='Ponds';
		
		}
		if(document.getElementById('dp').checked)
		{
		// alert("in dp checked");
		Asset='dp';
		
		}
		 
}
var url="";
var AssetType="";
var httpRequest2;

//alert("c:  "+ccode+"  div: "+divcode+" s: "+subcode+" m: "+mcode+"  P: "+pcode+" V: "+vcode+" H : "+hcode);
//alert("asset:"+Asset);
if(Asset=='pws')
{
AssetType=document.getElementById('pws').value;
document.getElementById('cpws').checked=false;	
document.getElementById('mpws').checked=false;
document.getElementById('handPump').checked=false;	
document.getElementById('shallowHandPumps').checked=false;	
document.getElementById('openWells').checked=false;	
document.getElementById('ponds').checked=false;
document.getElementById('dp').checked=false;		
}	
if(Asset=='mpws')
{

AssetType=document.getElementById('mpws').value;
document.getElementById('cpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('handPump').checked=false;	
document.getElementById('shallowHandPumps').checked=false;	
document.getElementById('openWells').checked=false;	
document.getElementById('ponds').checked=false;
document.getElementById('dp').checked=false;		
}	
if(Asset=='cpws')
{

AssetType=document.getElementById('cpws').value;
document.getElementById('mpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('handPump').checked=false;
document.getElementById('shallowHandPumps').checked=false;	
document.getElementById('openWells').checked=false;	
document.getElementById('ponds').checked=false;
document.getElementById('dp').checked=false;		
}	
if(Asset=='hp')
{
AssetType=document.getElementById('handPump').value;
document.getElementById('cpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('mpws').checked=false;
document.getElementById('shallowHandPumps').checked=false;	
document.getElementById('openWells').checked=false;	
document.getElementById('ponds').checked=false;
document.getElementById('dp').checked=false;		
}
if(Asset=='swhp')
{  
AssetType=document.getElementById('shallowHandPumps').value;
document.getElementById('cpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('mpws').checked=false;
document.getElementById('handPump').checked=false;
document.getElementById('openWells').checked=false;	
document.getElementById('ponds').checked=false;
document.getElementById('dp').checked=false;		
}
if(Asset=='opnWel')
{
AssetType=document.getElementById('openWells').value;
document.getElementById('cpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('mpws').checked=false;
document.getElementById('handPump').checked=false;
document.getElementById('shallowHandPumps').checked=false;	
document.getElementById('ponds').checked=false;		
document.getElementById('dp').checked=false;		
}
if(Asset=='Ponds')
{
AssetType=document.getElementById('ponds').value;
document.getElementById('cpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('mpws').checked=false;
document.getElementById('handPump').checked=false;
document.getElementById('shallowHandPumps').checked=false;
document.getElementById('openWells').checked=false;	
document.getElementById('dp').checked=false;		
}	
if(Asset=='dp')
{
//alert("dp val:"+document.getElementById('dp').value);
AssetType=document.getElementById('dp').value;
document.getElementById('cpws').checked=false;	
document.getElementById('pws').checked=false;
document.getElementById('mpws').checked=false;
document.getElementById('handPump').checked=false;
document.getElementById('shallowHandPumps').checked=false;
document.getElementById('openWells').checked=false;	
document.getElementById('ponds').checked=false;		
}	

url="/pred/reports/CheckList.do?mode=counts&circleCode="+ccode+"&divisionCode="+divcode+"&subdivisionCode="+subcode+"&mandalCode="+mcode+"&panchayatCode="+pcode+"&villageCode="+vcode+"&habitationCode="+hcode+"&assetCode="+AssetType;

///alert("Url:::"+url);
    
if (window.ActiveXObject) 
        { //IE
            httpRequest2 = new ActiveXObject("Microsoft.XMLHTTP"); 
        } 
        else if (window.XMLHttpRequest) 
        { //other browsers
            httpRequest2 = new XMLHttpRequest(); 
        } 
         
        httpRequest2.open("GET", url, true); 
        httpRequest2.onreadystatechange = function() {processNewRequest(); } ; 
        httpRequest2.send(null); 
        function processNewRequest() 
       { 
          if(httpRequest2.readyState== 1)
          {
           var img="images\ajax-loader.gif"
           document.getElementById('load').innerHTML="<img src='images/ajax-loader3.gif'style='position:absolute; left:410px; top:100px' ALT='Please wait..'></img>";
          }
        if (httpRequest2.readyState == 4) 
        { 
            if(httpRequest2.status == 200) 
            { 
              var data=httpRequest2.responseText;
                //alert("1:"+data);
				//code to be added here ............ 
				
				 var allData=data.split('<///>');
				  // alert("2:"+allData);
                 var counts=allData[1].split('<>');
                   // alert("3:"+counts);
                 //document.getElementById('pwsCount').value=counts[0];
                 // document.getElementById('mpwsCount').value=counts[1];
                 // document.getElementById('cpwsCount').value=counts[2];
                 // document.getElementById('handPumpCount').value=counts[3];
                 // document.getElementById('shalHpCount').value=counts[4];
                 // document.getElementById('wellsCount').value=counts[5];
                 // document.getElementById('pondsCount').value=counts[6];
              
                   //alert("alldata"+allData);          
					// document.getElementById('dpCount').value=counts[7];
					 //alert("counts[7]:"+counts[7]);
               var sub=allData[0].split('<//>');
                  // alert("4:"+sub);
               var source=sub[0];
               //  alert(source);
               var head=sub[1];
               var pipe=sub[2];
                if(Asset=='dp')
				{
				  var other=sub[3];
				  var dp=sub[4];
				}else{
			   var resrvoirs=sub[3];
               var other=sub[4];
				}
				//alert("dirpump:"+dp);
                if(Asset=='')
		        {document.getElementById('load').innerHTML='';}
             
                    if(Asset=='cpws')
                    {  
                      for(var j=0;j<=5;j++)
                     {
                     var len=document.getElementById('subCompsCpws').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes.length;
	                 if(len>1)
	                 {
	                  for(var i=0;i<=len-2;i++)
	                  {
	                  document.getElementById('subCompsCpws').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].deleteRow(1);
	                  } 
	                 }
	                }
                      
                       document.getElementById('subCompsCpws').style.display='inline'; 
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsHP').style.display ='none';
                       
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                    }
                    if(Asset=='pws')
                    {   
                       
                     for(var j=0;j<=5;j++)
                     {
                     var len=document.getElementById('subCompsPws').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes.length;
	                 if(len>1)
	                 {
	                  for(var i=0;i<=len-2;i++)
	                  {
	                  document.getElementById('subCompsPws').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].deleteRow(1);
	                  } 
	                 }
	                }
                       document.getElementById('subCompsPws').style.display='inline';
                       document.getElementById('subCompsCpws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsHP').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                    }
                    if(Asset=='mpws')
                    { 
						//alert("remove others");
                       for(var j=0;j<=5;j++)
                     {
                     var len=document.getElementById('subCompsMpws').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes.length;
	                 if(len>1)
	                 {
	                  for(var i=0;i<=len-2;i++)
	                  {
	                  document.getElementById('subCompsMpws').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].deleteRow(1);
	                  } 
	                 }
	                }
                       document.getElementById('subCompsMpws').style.display='inline';
                       document.getElementById('subCompsCpws').style.display ='none';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsHP').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                    }
                    if(Asset=='hp')
                    {   
                     
                       document.getElementById('subCompsHP').style.display='inline';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsCpws').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                     }
                     if(Asset=='swhp')
                    {   
                     
                       document.getElementById('subCompsShalo').style.display ='inline';
                       document.getElementById('subCompsHP').style.display='none';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsCpws').style.display ='none';
                        document.getElementById('subCompsopnWels').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                     }
                     if(Asset=='opnWel')
                    {     
                       document.getElementById('subCompsopnWels').style.display ='inline';
                       document.getElementById('subCompsHP').style.display='none';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsCpws').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsPonds').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                     }
                     if(Asset=='Ponds')
                    {    
                       document.getElementById('subCompsPonds').style.display ='inline';
                       document.getElementById('subCompsHP').style.display='none';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsCpws').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
					   document.getElementById('subCompsDp').style.display ='none';
                     }
					  if(Asset=='dp')
                    {
						 // alert("remove dp");
					  for(var j=0;j<=4;j++)
                     {
                     var len=document.getElementById('subCompsDp').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].childNodes.length;
	                 if(len>1)
	                 {
	                  for(var i=0;i<=len-2;i++)
	                  {
	                  document.getElementById('subCompsDp').childNodes[1].childNodes[0].childNodes[j].childNodes[0].childNodes[0].deleteRow(1);
	                  } 
	                 }
	                } 

                       document.getElementById('subCompsDp').style.display ='inline';
					   document.getElementById('subCompsHP').style.display='none';
                       document.getElementById('subCompsPws').style.display ='none';
                       document.getElementById('subCompsMpws').style.display ='none';
                       document.getElementById('subCompsCpws').style.display ='none';
                       document.getElementById('subCompsShalo').style.display ='none';
                       document.getElementById('subCompsopnWels').style.display ='none';
					    document.getElementById('subCompsPonds').style.display ='none';
					   
                     }
                  //alert("source:"+source)
				  var sr= source.split('</>');
                  
                   var sr1= source.split('</>');
                    // alert("6:"+sr1);
           if(!((Asset=='hp')||(Asset=='swhp')||(Asset=='opnWel')||(Asset=='Ponds') || (Asset=='dp')) )
               { 
                		// alert("in not DP");
				               for(var i=0;i<sr.length-1;i++)
				                  { 
				                   //alert("8:"+sr);
									if(i<2){
										 var values=sr[i].split('<>');
										 
										 for(var j=0;j<values.length-2;j++)
										 { 
										 var code="01";
										 var rec=document.createElement("<tr>");
										 var name=document.createElement("<td>");
										 if(values[2] >0)
										{
										 name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
										}else
										 {
										name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font>";
										 }
										 var count=document.createElement("<td>");
										 count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
										 rec.appendChild(name);
										 rec.appendChild(count);
										 document.getElementById('source'+Asset).childNodes[0].appendChild(rec); 
										 }  
									 } else {
									  var values=sr[i].split('<>');
									   //alert("10"+values)
									 for(var j=0;j<values.length-2;j++)
									 { 
										 var code="01";
										 var rec=document.createElement("<tr>");
										 var name=document.createElement("<td>");
										 if(values[2]>0){
										 name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
										 }else {
											  name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
										 }
										 var count=document.createElement("<td>");
										 count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
										 rec.appendChild(name);
										 rec.appendChild(count);
										 document.getElementById('pumpsets'+Asset).childNodes[0].appendChild(rec);  
									 }  
									 }
			                 }
			                  
			                 //alert("hworks:"+head);
			                 var hworks= head.split('</>');
			                 // alert(hworks.length);
			                 for(var i=0;i<hworks.length-1;i++)
			                 { 
			                 //alert("1");	
			                  var values=hworks[i].split('<>');
			                  // alert(values);
			                    for(var j=0;j<values.length-2;j++)
			                     {  
			                     var code="02";
			                     var rec=document.createElement("<tr>");
					             var name=document.createElement("<td>");
					             //alert("aaaaaaa:"+values[1]);
					            //  alert("bbbbbbb:"+code+","+values[1]);
					             if(values[0]=='MICRO FILTER')
					             {
					               // alert( " in microfilter");
					                if(values[2]>0)
									 {
								       name.innerHTML="<a href='#1' onclick='subComponentClicked1("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font>";;
									 }else
									 {
										name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
									 }
					             }
					             else if(values[0]=='ROPLANTS')
					             {
					               // alert( " in  Ro Plants ");
					             if(values[2]>0)
									 {
										name.innerHTML="<a href='#1' onclick='subComponentClicked2("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font>";;
									 }else
									 {
										 name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
									 }
					              
					             }
					             else
					             {
									if(values[2]>0)
									 {
										name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
									 }else{
										name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
									 }
					             }
					              var count=document.createElement("<td>");
					             count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					             rec.appendChild(name);
					             rec.appendChild(count);
					             document.getElementById('hw'+Asset).childNodes[0].appendChild(rec);    
					            }
			                 }
			                 
			                  var pipes= pipe.split('</>');
			                for(var i=0;i<pipes.length-1;i++)
			                 { 
			                  var values=pipes[i].split('<>');
			                   for(var j=0;j<values.length-2;j++)
			                    { 
			                     var code="03";
			                     var rec=document.createElement("<tr>");
					             var name=document.createElement("<td>");
					             if(values[2]>0){
								 name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
								 }else{
								  name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								 }
				            	 var count=document.createElement("<td>");
					             count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					             rec.appendChild(name);
					             rec.appendChild(count);
					             document.getElementById('pipeline'+Asset).childNodes[0].appendChild(rec);  
			                  } 
			                 }
			                  var RV= resrvoirs.split('</>');
			                for(var i=0;i<RV.length-1;i++)
			                 { 
			                  var values=RV[i].split('<>');
			                    for(var j=0;j<values.length-2;j++)
			                    { 
			                     var code="04";
			                     var rec=document.createElement("<tr>");
					             var name=document.createElement("<td>");
					             if(values[2]>0){
								 name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
								 }else{
								  name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								 }
				            	 var count=document.createElement("<td>");
					             count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					             rec.appendChild(name);
					             rec.appendChild(count);
					             document.getElementById('resrvoirs'+Asset).childNodes[0].appendChild(rec); 
					             }
			                 }
			                  var ot= other.split('</>');
			                 for(var i=0;i<ot.length-1;i++)
			                 { 
			                     var values=ot[i].split('<>');
			                      for(var j=0;j<values.length-2;j++)
			                      { 
			                      var code="05";
			                      var rec=document.createElement("<tr>");
					              var name=document.createElement("<td>");
					           	  if(values[2]>0){
								  name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
								  }else{
								  name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								  }
					              var count=document.createElement("<td>");
					              count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					              rec.appendChild(name);
					              rec.appendChild(count);
					              document.getElementById('others'+Asset).childNodes[0].appendChild(rec); 
			                     }   
			                 }
			            }
			        if(Asset=='dp')
					{
						//alert("direct pumping");
						 for(var i=0;i<sr.length-1;i++)
				                  { 
				                  // alert("8:"+sr);
			                    if(i<2){
			                     var values=sr[i].split('<>');
			                       //alert("9:"+values);
								  for(var j=0;j<values.length-2;j++)
			                     { 
			                      var code="01";
			                      var rec=document.createElement("<tr>");
					              var name=document.createElement("<td>");
								  if(values[2]>0){
								  name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
								  }
								  else{
								  name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								 }
								 var count=document.createElement("<td>");
				            	 count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					             rec.appendChild(name);
					             rec.appendChild(count);
					             document.getElementById('source'+Asset).childNodes[0].appendChild(rec); 
					               
					             }  
					             } else {
					              var values=sr[i].split('<>');
			                       //alert("10"+values)
			                       for(var j=0;j<values.length-2;j++)
			                     { 
			                      var code="01";
			                     var rec=document.createElement("<tr>");
					             var name=document.createElement("<td>");
					              if(values[2]>0){
								  name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
								  }else{
								  name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								 }
				            	 var count=document.createElement("<td>");
					            "<font size='1' face='verdana'>"+values[2]+"</font>";
					             rec.appendChild(name);
					             rec.appendChild(count);
					             document.getElementById('pumpsets'+Asset).childNodes[0].appendChild(rec);  
					             }  
					             }
			                 }
			                  
			                // alert("hworks:"+head);
			                 var hworks= head.split('</>');
			                  //alert(hworks.length);
			                 for(var i=0;i<hworks.length-1;i++)
			                 { 
			                // alert("1");	
			                  var values=hworks[i].split('<>');
			                  //alert(values);
			                    for(var j=0;j<values.length-2;j++)
			                     {  
			                     var code="02";
			                     var rec=document.createElement("<tr>");
					             var name=document.createElement("<td>");
					             //alert("aaaaaaa:"+values[1]);
					            //  alert("bbbbbbb:"+code+","+values[1]);
					             if(values[0]=='MICRO FILTER')
					             {
					                //alert( " in microfilter");
					                if(values[2]>0){
									  name.innerHTML="<a href='#1' onclick='subComponentClicked1("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font>";;
									  }else{
								       name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								     }
					             }
					             else if(values[0]=='ROPLANTS')
					             {
					               // alert( " in  Ro Plants ");
					               if(values[2]>0){
								  name.innerHTML="<a href='#1' onclick='subComponentClicked2("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font>";;
					               }else{
								     name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								   }
					             }
					             else
					             {
								   if(values[2]>0){
  					                 name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
								   }else{
								     name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								   }
					             }
					              var count=document.createElement("<td>");
					             count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					             rec.appendChild(name);
					             rec.appendChild(count);
					             document.getElementById('hw'+Asset).childNodes[0].appendChild(rec);    
					            }
			                 }
			                // alert("pipe:"+pipe);
			               
							 var pipes= pipe.split('</>');
			                for(var i=0;i<pipes.length-1;i++)
			                 { 
			                  var values=pipes[i].split('<>');
			                   for(var j=0;j<values.length-2;j++)
			                    { 
									 var code="03";
									 var rec=document.createElement("<tr>");
									 var name=document.createElement("<td>");
									  if(values[2]>0){					
									 name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
									 }else{
										 name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
									   }
									 var count=document.createElement("<td>");
									 count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
									 rec.appendChild(name);
									 rec.appendChild(count);
									 document.getElementById('pipeline'+Asset).childNodes[0].appendChild(rec);  
			                  } 
			                 }
			                 var ot= other.split('</>');
			                 for(var i=0;i<ot.length-1;i++)
			                 { 
			                     var values=ot[i].split('<>');
			                      for(var j=0;j<values.length-2;j++)
			                      { 
			                      var code="05";
			                      var rec=document.createElement("<tr>");
					              var name=document.createElement("<td>");
					              if(values[2]>0){
								   name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+values[1]+")'><font size='1' color='blue' face='verdana'>"+values[0]+"</font></a>";;
					               }else{
									 name.innerHTML="<font size='1' color='black' face='verdana'>"+values[0]+"</font></a>";
								    }
				            	  var count=document.createElement("<td>");
					              count.innerHTML="<font size='1' face='verdana'>"+values[2]+"</font>";
					              rec.appendChild(name);
					              rec.appendChild(count);
								  // alert("name:"+name);
								  //alert("count:"+count);
					              document.getElementById('others'+Asset).childNodes[0].appendChild(rec); 
			                     }   
			                 }

						 var dirp=dp.split('</>');
						 //alert("dirp:"+dirp);
						 for(var i=0;i<dirp.length-1;i++)
						{
						 var value=dirp[i].split('<>');
						 for(var j=0;j<value.length-2;j++)
			            	{
							     var code="06";
								 //alert("value[0]:"+value[0]);
								 //alert("value[1]:"+value[1]);
								 //alert("value[1]:"+value[2]);
			                      var rec=document.createElement("<tr>");
					              var name=document.createElement("<td>");
					              if(value[2]>0){
								  name.innerHTML="<a href='#1'onclick='subComponentClicked("+code+","+value[1]+")'><font size='1' color='blue' face='verdana'>"+value[0]+"</font></a>";;
					              }else{
								  name.innerHTML="<font size='1' color='black' face='verdana'>"+value[0]+"</font></a>";
								  }
								  var count=document.createElement("<td>");
					              count.innerHTML="<font size='1' face='verdana'>"+value[2]+"</font>";
					              rec.appendChild(name);
					              rec.appendChild(count);
								 // alert("name:"+name);
								  //alert("count:"+count);
					              document.getElementById('pumpsets'+Asset).childNodes[0].appendChild(rec); 
							}
						}
					}
					 if(Asset=='hp')
                     {
                        //alert("sr:"+document.getElementById('HPCOUNT').innerHTML);
						document.getElementById('HPCOUNT').innerHTML=sr;
						}
                     if(Asset=='swhp')
                     {  // alert("ddddd:"+sr);
                      document.getElementById('shloCnt').innerHTML=sr;
                     }
                     if(Asset=='opnWel')
                     {
                       // alert("555555555555");
					   
                      document.getElementById('openwlsCnt').innerHTML=sr;
						
                     }
                     if(Asset=='Ponds')
                     { 
                      document.getElementById('PondsCnt').innerHTML=sr;
                     }
                     
                     document.getElementById('load').innerHTML='';
                     val++;  
            }
            document.getElementById('load').innerHTML='';
        }
         else 
            { 
                // alert("Error loading page\n"+ httpRequest2.status +":"+ httpRequest2.statusText); 
            }   
       }              
}
</script>
 
<body onload="hidetables()">
 
 
<html:form  method="post" action="CheckList.do?mode=data" enctype="multipart/form-data">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Check List" />
	<jsp:param name="TWidth" value="750" />
</jsp:include>
 
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="785" border=1 style="border-collapse:collapse;">
	 
		<tr>
		<td class="bwborder">
		<fieldset >
		<legend>
		<B>Asset Type</B>
		</legend>
		<label>
	
	     <table cellpadding="0"  cellspacing="0" border="0" width="780" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;">
			   <tr  colspan=6>
			    <td class="textborder" >
			    <html:radio property="pws" value="01"  onclick="getsubcomps('pws')" title="select to view PWS subcomponents"/>
			     PWS :</td>
			    <td >	
			    <html:text property="pwsCount"   size="10" readonly="true"/>
			    </td>
				<td class="textborder" >
			    <html:radio property="handPump" value="04" onclick="getsubcomps('hp')" title="select to view HAND PUMP'S subcomponents"/>
			    Hand Pumps :</td>
			    <td>	
			    <html:text property="handPumpCount"  size="10" readonly="true"/>
			    </td>
                <td class="textborder" >
				 <html:radio property="dp" value="09"  onclick="getsubcomps('dp')" title="select to view  Dirtect Pumping subcomponents"/>Direct Pumping:</td>
				 <td><html:text property="dpCount"   size="10" readonly="true"/>
				</td>
				 </tr>
				 <tr colspan=6>
				 <td class="textborder">
			    <html:radio property="mpws" value="02" onclick="getsubcomps('mpws')" title="select to view MPWS subcomponents"/>
			    MPWS :</td>
			    <td>	
			    <html:text property="mpwsCount"  size="10" readonly="true"/>
			     </td>
				<td class="textborder">
				 <html:radio property="openWells" value="06"  onclick="getsubcomps('opnWel')" title="select to view  Open well's subcomponents"/>
				 Open Wells:</td>
				 <td><html:text property="wellsCount"   size="10" readonly="true"/></td>
				 <td class="textborder">
				<html:radio property="shallowHandPumps" value="05"  onclick="getsubcomps('swhp')" title="select to view   Shallow HandPump's subcomponents"/>
				Shallow Hand Pumps :</td><td><html:text property="shalHpCount"   size="10" readonly="true"/>
			    </td>
				 </tr>
				<tr colspan=6>
				 <td class="textborder">
			    <html:radio property="cpws" value="03" onclick="getsubcomps('cpws')" title="select to view CPWS subcomponents"/>
			     CPWS :</td>
			    <td>	
			    <html:text property="cpwsCount" size="10" readonly="true"/>
			    </td>
				<td class="textborder"><html:radio property="ponds" value="07"  onclick="getsubcomps('Ponds')" title="select to view  Pond's subcomponents"/> Ponds:</td>
				<td><html:text property="pondsCount"   size="10" readonly="true"/></td> 
				
             	</tr>
          </table>
	    </label>
	    </fieldset>
	   	<fieldset >
		<legend>
		<B>Office Details</B>
		</legend>
		<label >
		
	     <table cellpadding="0" cellspacing="0" border="0" width="780" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
			    <tr >
			    <td class="textborder">Circles :</td>
			    <td>	
			    <html:select property="circleName" styleClass="mycombo" style="width:145px" onchange="getvalues('circles')">
				<html:option value="">SELECT...</html:option>
				<html:options collection="CirclesList" name="CirclesList" 
								  property="circleCode" labelProperty="circleName"/>
			    </html:select> 
			    </td>
			    <td class="textborder">Divisions :</td>
			    <td>	
			    <html:select property="divisionName" styleClass="mycombo" style="width:145px" onchange="getvalues('divisions')" >
			     <html:option value="">SELECT...</html:option>
			    </html:select> 
			    </td>
			    <td class="textborder">Sub Divisions :</td>
			    <td>	
			    <html:select property="subdivName" styleClass="mycombo" style="width:145px" onchange="getvalues('subdivisions')">
			       
				 <html:option value="">SELECT...</html:option>
			    </html:select> 
			    </td>
		       </tr> 
        </table>
       
	   </label>
	   </fieldset>
	   <fieldset>
		<legend>
		<B>Habitation  Details</B>
		</legend>
		<label>
	     <table cellpadding="0" cellspacing="0" border="0" width="780" height="50"
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			    <tr >
			    <td class="textborder">District :</td>
			    <td>	
			    <html:text property="districtName" value="" readonly="true"/>
				
			    </td>
			    
			    
			    
			    <td class="textborder">Mandals :</td>
			    <td>	
			    <html:select property="mandalName" styleClass="mycombo" style="width:145px" onchange="getvalues('mandals')">
			    <html:option value="">SELECT...</html:option>
				
			    </html:select> 
			    </td>
			    <td class="textborder">Panchayats :</td>
			    <td>	
			    <html:select property="panchayatName" styleClass="mycombo" style="width:145px" onchange="getvalues('panchayats')">
			    <html:option value="">SELECT...</html:option>
				
			    </html:select> 
			    </td>
		        </tr> 
		        <tr>
		        <td class="textborder">Villages :</td>
			    <td>	
			    <html:select property="villageName" styleClass="mycombo" style="width:145px" onchange="getvalues('villages')">
			    <html:option value="">SELECT...</html:option>
				
			    </html:select> 
			    </td>
			    <td class="textborder">Habitations :</td>
			    <td>	
			    <html:select property="habitationName" styleClass="mycombo" style="width:145px" onchange="getsubcomps('')">
			    <html:option value="">SELECT...</html:option>
				
			    </html:select> 
			    </td>
		       </tr> 
        </table>
	   </label>
	   </fieldset>
 </table>

	<table id="subCompsCpws" cellpadding="0" cellspacing="0" border="1" width="750"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
			<th>HEADWORKS</th>
			<th>PIPELINE</th>
			<th>SR.RESERVOIRS</th>
			<th>OTHERS</th>
			<th>PUMPING</th>
		</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="sourcecpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<TBODY>
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				</TBODY>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="hwcpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<TBODY>
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					
				</tr>
				</TBODY>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pipelinecpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.&nbsp; Length.</td>
					
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="resrvoirscpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="otherscpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pumpsetscpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<table id="subCompsPws" cellpadding="0" cellspacing="0" border="1" width="500"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
			<th>HEADWORKS</th>
			<th>PIPELINE</th>
			<th>SR.RESERVOIRS</th>
			<th>OTHERS</th>
            <th>PUMPING</th>
		</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="sourcepws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td id="ddd"></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="hwpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pipelinepws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="resrvoirspws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="otherspws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pumpsetspws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td> </td>
					<td> </td>
				</tr>
			 </table>
			</td>
		  </tr>
	</table>
	<table id="subCompsMpws" cellpadding="0" cellspacing="0" border="1" width="750"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
			<th>HEADWORKS</th>
			<th>PIPELINE</th>
			<th>SR.RESERVOIRS</th>
			<th>OTHERS</th>
			<th>PUMPING</th>
			</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="sourcempws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="hwmpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pipelinempws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="resrvoirsmpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="othersmpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pumpsetsmpws" width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<table id="subCompsHP" cellpadding="0" cellspacing="0" border="1" width="780"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<TH>SOURCE</TH>
		</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="borehp" width="785" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
				    <td><a href="#1" onclick='subComponentClicked("1","1")'><font size='2' color='blue' face='verdana'>BoreWells</font></a></td>
					<td id="HPCOUNT"></td>
				</tr>
			</table>		
		</td>
		</tr>
	</table>
	
	<table id="subCompsShalo" cellpadding="0" cellspacing="0" border="1" width="780"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
		</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="borehp" width="785" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td><a href="#1" onclick='subComponentClicked("1","1")'><font size='2' color='blue' face='verdana'>Shallow Handpumps </font></a></td>
					<td id="shloCnt"></td>
				</tr>
			</table>		
		</td>
		</tr>
	</table>
	<table id="subCompsopnWels" cellpadding="0" cellspacing="0" border="1" width="780"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
		</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="borehp" width="785" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td><a href="#1" onclick='subComponentClicked("1","1")'><font size='2' color='blue' face='verdana'>Open Wells</font></a></td>
					<td id="openwlsCnt"></td>
				</tr>
			</table>		
		</td>
		</tr>
	</table>
	<table id="subCompsPonds" cellpadding="0" cellspacing="0" border="1" width="780"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
		</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="borehp" width="785" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td><a href="#1" onclick='subComponentClicked("1","1")'><font size='2' color='blue' face='verdana'>Ponds</font></a></td>
					<td id="PondsCnt"></td>
				</tr>
			</table>		
		</td>
		</tr>
	</table>

<!-- code added by sri for DP-->
<table id="subCompsDp" cellpadding="0" cellspacing="0" border="1" width="790"
		bordercolor="black" style="border-collapse:collapse;">
		<THEAD align=center bgcolor="#8A9FCD" class="textborder">
			<th>SOURCE</th>
			<th>HEADWORKS</th>
			<th>PIPELINE</th>
			<th>OTHERS</th>
			<th>PUMPING</th>
			</THEAD>
		<tr>
			<td align="center" valign="top">
			<table  id="sourcedp" width="155" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="hwdp" width="155" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pipelinedp" width="155" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="othersdp" width="155" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
			<td align="center" valign="top">
			<table  id="pumpsetsdp" width="155" border="1" bordercolor="black"
				style="border-collapse:collapse;">
				<tr class="mystyle1">
					<td>Name</td>
					<td>No.</td>
				</tr>
				<tr id="srctr" class="mystyle1">
					<td></td>
					<td></td>
				</tr>
			</table>
			</td>
		</tr>
	</table> 

 <!-- code end-->
	<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="750"/>
</jsp:include>
<font color="red" face="verdana" size="2">Note: Assets Which are having components are displayed</font>
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
 
