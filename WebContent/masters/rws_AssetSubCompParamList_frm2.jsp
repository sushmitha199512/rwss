<%String componentName = (String)session.getAttribute("assetsubCompParams");%>
<script language="javascript">
var newWindow;
 function fnCalTotal1(index)
 {
var a=0;var b=0;var c=0;
if(document.getElementById("ASSETPUMPSET_LIST["+index+"].powerCost").value=="")
{	a = 0;}
else
{	a=parseFloat(document.getElementById("ASSETPUMPSET_LIST["+index+"].powerCost").value);}

if(document.getElementById("ASSETPUMPSET_LIST["+index+"].consumAnnum").value=="")
{	b = 0;}
else
{	b=parseFloat(document.getElementById("ASSETPUMPSET_LIST["+index+"].consumAnnum").value);}

if(document.getElementById("ASSETPUMPSET_LIST["+index+"].wagesAnnum").value=="")
{	c = 0;}
else
{	c =parseFloat(document.getElementById("ASSETPUMPSET_LIST["+index+"].wagesAnnum").value);}
document.getElementById("ASSETPUMPSET_LIST["+index+"].total3").value =Math.round((parseFloat(a+b+c))*Math.pow(10,2))/Math.pow(10,2);
 }
 function fnCalTotal2(index)
 {
	 var a=0;var b=0;var c=0;
	if(document.getElementById("ASSETPUMPSET_LIST["+index+"].tariffMonth").value=="")
	{	a = 0;}
	else
	{	a=parseFloat(document.getElementById("ASSETPUMPSET_LIST["+index+"].tariffMonth").value);}
	
	if(document.getElementById("ASSETPUMPSET_LIST["+index+"].houseConn").value=="")
	{	b = 0;}
	else
	{	b=parseFloat(document.getElementById("ASSETPUMPSET_LIST["+index+"].houseConn").value);}
	
	document.getElementById("ASSETPUMPSET_LIST["+index+"].total2").value = Math.round((parseFloat(a*b*12))*Math.pow(10,2))/Math.pow(10,2);
 }
function fnHabitationLinkage(index)
{
	var assetCompTypeCode="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompTypeCode="<%=request.getParameter("assetSubCompTypeCode")%>";
	var assetTypeCode="<%=request.getParameter("assetTypeCode")%>";
	var subCompCodeTemp= document.getElementById("subCompCode").value;
	//alert("subCompCode is"+subCompCodeTemp);
	var subCompCode1=(document.getElementById("ASSETRESERVIOR_LIST["+index+"]."+subCompCodeTemp).value);
	var assetCode= "<%=request.getParameter("assetCode")%>";
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
 	 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=pickhab"
			+ "&schemeCode="+subCompCode1+ "&assetTypeCode="+assetTypeCode+ "&assetCompTypeCode="+assetCompTypeCode
			+ "&assetSubCompTypeCode="+assetSubCompTypeCode+ "&index="+index+"&assetCode="+assetCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }	 else
	 {
		newWindow.focus();
	 }
}
function fnHabitationLinkage1(index)
{
	var assetCompTypeCode="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompTypeCode="<%=request.getParameter("assetSubCompTypeCode")%>";
	var assetTypeCode="<%=request.getParameter("assetTypeCode")%>";
	var habCode = "<%=request.getParameter("habCode")%>";
	var subCompCodeTemp= document.getElementById("subCompCode").value;
	var assetCode= "<%=request.getParameter("assetCode")%>";
	var subCompCode1=(document.getElementById("ASSETPUMPSET_LIST["+index+"]."+subCompCodeTemp).value);
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
 	 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=pickhab1"
			+ "&schemeCode="+subCompCode1+ "&assetTypeCode="+assetTypeCode+ "&assetCompTypeCode="+assetCompTypeCode
			+ "&assetSubCompTypeCode="+assetSubCompTypeCode+ "&index="+index+"&assetCode="+assetCode+"&habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
}

function powerConsumptionChanged(index)
{
	if(document.getElementById("ASSETHEADWORK_LIST["+index+"].ssTankAdeq").value=="Others")
		{
			document.getElementById("ASSETHEADWORK_LIST["+index+"].powerConnOthers").disabled=false;
		}
		else
		{
			document.getElementById("ASSETHEADWORK_LIST["+index+"].powerConnOthers").value="";
			document.getElementById("ASSETHEADWORK_LIST["+index+"].powerConnOthers").disabled=true;
		}
}
function materialChanged(ndx)
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNewPipeType&materialChanged=yes&index="+ndx;
	document.forms[0].submit();
}
function save()
{
		var indx=<%request.getParameter("index");%>
	   	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNewPipeType";
	    document.forms[0].submit();
	    return true;
}
function closeFunc()
{
//code to refresh the parent window
//opener.document.getElementById('load').innerHTML="<blink><img src='images/ajax-loader3.gif'style='position:absolute; left:410px; top:400px; height=100px; width=300px' ALT='Please wait..'></img><blink>";
//opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=ShowHabsBenfit";
opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data";
opener.document.forms[0].submit();

opener.document.getElementById('docBody').innerHTML="<img align='center'src='./images/ajax-loader3.gif'style='position:absolute; left:350px; top:250px; height=100px; width=300px' ALT='Please wait..' border='0'></img>";
self.close();
//var url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&dcode="+assetForm.dcode.value+"&mandal="+mandal+"&district="+assetForm.district.value;
return true;
}

function pickpipematCloseFunc()
{
//code to refresh the parent window
opener.document.forms[0].noOfPipes.value=document.forms[0].count.value;
//opener.window.location.reload(true);
self.close();
//var url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&dcode="+assetForm.dcode.value+"&mandal="+mandal+"&district="+assetForm.district.value;
return true;
}

function fnPickPipeMat(index)
{
	var noofpipes="";
	var discode = document.getElementById("ASSETPIPELINE_LIST["+index+"].disCode").value;
	noofpipes = document.getElementById("ASSETPIPELINE_LIST["+index+"].disNoOfPipes").value;
if(noofpipes!="")
	{
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=pickpipemat"
				+ "&discode="+discode
				+ "&index="+index+"&disNoOfPipes="+noofpipes;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	}
	else
	{
		alert("Please Enter Required Pipe Materials...");
		document.getElementById("ASSETPIPELINE_LIST["+index+"].disNoOfPipes").focus();
	}
}

function fnPickHabitations(index)
{
	var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	var assetType="<%=request.getParameter("assetTypeCode")%>";
	 var selectedHabCode="";
	var subCompCodeTemp= document.getElementById("subCompCode").value;
	if(assetCompType=="02")
	{
	var subCompCode1=(document.getElementById("ASSETHEADWORK_LIST["+index+"]."+subCompCodeTemp).value);
	if(document.getElementById("ASSETHEADWORK_LIST["+index+"].habCode"))
	   selectedHabCode=(document.getElementById("ASSETHEADWORK_LIST["+index+"].habCode").value);
	}
	if(assetCompType=="04")
	{
	var subCompCode1=(document.getElementById("ASSETRESERVIOR_LIST["+index+"]."+subCompCodeTemp).value);
	if(document.getElementById("ASSETRESERVIOR_LIST["+index+"].habCode"))
	   selectedHabCode=(document.getElementById("ASSETRESERVIOR_LIST["+index+"].habCode").value);
	}
	if(assetCompType=="05")
	{
	var subCompCode1=(document.getElementById("ASSETPUMPSET_LIST["+index+"]."+subCompCodeTemp).value);
	if(document.getElementById("ASSETPUMPSET_LIST["+index+"].habCode"))
	   selectedHabCode=(document.getElementById("ASSETPUMPSET_LIST["+index+"].habCode").value);
	}
	   var dcode ="<%=request.getParameter("dcode")%>";
	   var district ="<%=request.getParameter("district")%>";
   	   var mandal ="<%=request.getParameter("mandal")%>";
	   var habCode ="<%=request.getParameter("habCode")%>";
	   var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		 var url = "";
		 if(selectedHabCode!="")
		 	url="switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&subCompCode1="+subCompCode1
				+ "&dcode="+dcode
				+ "&district="+district+"&mandal="+mandal+"&habCode="+selectedHabCode;
		 else
		 	url="switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&subCompCode1="+subCompCode1
				+ "&dcode="+dcode
				+ "&district="+district+"&mandal="+mandal;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
}
function fnPickNewHabitations1()
{
	var assetType="<%=request.getParameter("assetTypeCode")%>";
	var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	var dcode ="<%=request.getParameter("dcode")%>";
	var assetCode = "<%=request.getParameter("assetCode")%>";
	var assetName = "<%=request.getParameter("assetName")%>";
	var pumpCode = "<%=request.getParameter("pumpCode")%>";
   var habCode ="<%=request.getParameter("habCode")%>";
   var assetCost = "<%=request.getParameter("costOfAsset")%>";
		document.forms[0].action = "switch.do?prefix=/masters&page=/Asset.do&mode=addNewOandM&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab&dcode="+dcode+"&habCode="+habCode+"&assetCode="+assetCode+"&assetName="+assetName+"&pumpCode="+pumpCode+"&assetCost="+assetCost;
		document.forms[0].submit();
}

function fnPickNewHabitations()
{
	var assetType="<%=request.getParameter("assetTypeCode")%>";
	var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	var dcode ="<%=request.getParameter("dcode")%>";
	var assetCode="<%=request.getParameter("assetCode")%>";
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab&dcode="+dcode+"&assetCode="+assetCode;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
}
   /*   Asset Types
   
   01-PWS
   02-MPWS
   03-CPWS
   04-HANDPUMPS
   05-DIRECT PUMPING
   
   Asset Component Types
   
   Asset Type-PWS
   01-SOURCE
   03-PIPELINE
   04-RESERVOIRS
   05-PUMPSETS
   
   Asset Type-CPWS
   01-SOURCE
   02-HEADWORKS
   03-PIPELINE
   04-SR.RESERVOIRS
   05-PUMPSETS
   
   Asset Type-HANDPUMPS
   01-SOURCE
   
   Asset Type-MPWS
   
   01-SOURCE
   03-PIPELINE
   04-RESERVOIRS
   05-PUMPSETS
   
   Asset SubComponents
   
   Asset Type-04-HANDPUMPS
   Asset Component-01-SOURCE
   Asset SubComponent-001-BOREWElL
   
   Asset Type-01-PWS 
   Asset Component-01-SOURCE
   Asset SubComponent- 001-BORE WELL   
   
   Asset Type-01-PWS 
   Asset Component-01-SOURCE 
   Asset SubComponent- 002-WATCHMAN QUARTER
   
   Asset Type- 01-PWS
   Asset Component-03-PIPELINE
   Asset SubComponent-001-DISTRIBUTION
   
   ASSET TYPE=01-PWS
   ASSET COMPONENT-03-PIPELINE
   ASSET SUBCOMPONENT-002-STANDPOSTS
   
   ASSET TYPE=01-PWS
   ASSET COMPONENT-03-PIPELINE
   ASSET SUBCOMPONENT-003-PUMPING MAIN
 
   ASSET TYPE=01-PWS
   ASSET COMPONENT-04-RESERVOIRS
   ASSET SUBCOMPONENT-001-OHSR
   
   ASSET TYPE=01-PWS
   ASSET COMPONENT-04-RESERVOIRS
   ASSET SUBCOMPONENT-002-CISTERNS
   
   ASSET TYPE=01-PWS
   ASSET COMPONENT-04-RESERVOIRS
   ASSET SUBCOMPONENT-003-GLSR
   
   ASSET TYPE=01-PWS
   ASSET COMPONENT-05-PUMPSETS
   ASSET SUBCOMPONENT-002-PUMP HOUSE
   
   ASSET TYPE=01-PWS
   ASSET COMPONENT-05-PUMPSETS
   ASSET SUBCOMPONENT-003-CAPACITORS
 
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-01-SOURCE
   ASSET SUBCOMPONENT-001-BOREWELL
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-01-SOURCE
   ASSET SUBCOMPONENT-002-ROTARY BOREWELL
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT- 01-SOURCE
   ASSET SUBCOMPONENT-003- INTAKE WELL
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-01-SOURCE
   ASSET SUBCOMPONENT-004-INFILTRATION WELL
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-01-SOURCE
   ASSET SUBCOMPONENT-005-SOURCE TYPE
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEAD WORKS
   ASSET SUBCOMPONENT-001-RAW WATER COLLECTION WELL
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-002-SS TANK
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-004-SS FILTERS
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-005-RS FILTERS
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-006-SUMP
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-009-FOOT PATH BRIDGE
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-010-PUMP HOUSE
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-011-WATCHMAN QUARTER
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-02-HEADWORKS
   ASSET SUBCOMPONENT-012-CLEAR WATER COLLECTION WELL
    
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-03-PIPELINE
   ASSET SUBCOMPONENT-001-PUMPING MAIN
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-03-PIPELINE
   ASSET SUBCOMPONENT-002-GRAVITY MAIN
 
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-03-PIPELINE
   ASSET SUBCOMPONENT-003-DISTRIBUTION
    
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-04-SR.RESERVOIRS 
   ASSET SUBCOMPONENT-001-OHSR
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-04-SR.RESERVOIRS 
   ASSET SUBCOMPONENT-002-OHBR
    
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-04-SR.RESERVOIRS 
   ASSET SUBCOMPONENT-003-GLSR
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-04-SR.RESERVOIRS 
   ASSET SUBCOMPONENT-004-GLBR
   
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-04-SR.RESERVOIRS 
   ASSET SUBCOMPONENT-005-BPT
    
   ASSET TYPE=03-CPWS
   ASSET COMPONENT-05-PUMPSETS

   ASSET SUBCOMPONENT-001-PUMP DETAILS
   */
   //-->

 function validate(ndx)
 {
	var count = document.getElementById("count").value;
	var message ="";
	
	var material=document.getElementById("ASSETPIPELINE_LIST["+ndx+"].material").value;
	var diameter=document.getElementById("ASSETPIPELINE_LIST["+ndx+"].diameter").value;
	var pclass=document.getElementById("ASSETPIPELINE_LIST["+ndx+"].pclass").value;
	
	var exists=0;
	
		 for(var i=1; i<=count; i++)
		 {	
		   var materialTemp=document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].material").value;
		   var diameterTemp=document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].diameter").value;
		   var pclassTemp=document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].pclass").value;
		 
			if(material==materialTemp && diameter==diameterTemp && ndx!=i-1 && pclass==pclassTemp && diameter!="" && pclass!="")
			{
					exists=1;
			}
		}
		if(exists==1)
		{
			alert("this option already exists");
			document.getElementById("ASSETPIPELINE_LIST[\"+ndx+\"].pclass").value="";
			document.getElementById("ASSETPIPELINE_LIST[\"+ndx+\"].diameter").value="";
		}
 }
 function getData(that)
{
	//alert("getdate");
	var count = document.getElementById("count").value;
	//alert("Count"+count);
/*	alert("count is  "+count);*/
 	var message ="";
	var frm = that.form;
		
	    for(var i=1; i<=count; i++)
		   {	

				var p;
				var rfIds= document.getElementById("RFed"+i+"").name;
			   	var ufIds = document.getElementById("UFed"+i+"").name;
				

				if (document.getElementById("UFed"+i+"").checked)
				{
					p = document.getElementById("UFed"+i+"").value;
					
				}
				else if (!document.getElementById("UFed"+i+"").checked)
				{
					//alert("IN else");
					p = document.getElementById("UFed"+i+"").value;
					//alert(p);
					//alert("rfed is "+document.form.getElementById("RFed"+p+"").disabled)
					document.getElementById("RFed"+p+"").disabled=false;
					
				//	alert("rfed is "+document.getElementById("RFed"+p+"").disabled=false);
					
				}
				
				if (document.getElementById("RFed"+i+"").checked)
				{
					p = document.getElementById("RFed"+i+"").value;
				//	alert(document.getElementById("UFed"+p+"").disabled)
				//	document.getElementById("UFed"+p+"").disabled=false;
					//alert(p);
				}
				else if (!document.getElementById("RFed"+i+"").checked)
				{
					//alert("IN else");
					p = document.getElementById("RFed"+i+"").value;
				
					document.getElementById("UFed"+p+"").disabled=false;
					
				
					
				}

			 if(document.getElementById("UFed"+i+"").checked)
			   {
				 //alert("IN checked");
	     		 document.getElementById("RFed"+p+"").disabled="true";
		         document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].pcUf").value="Y";
                 document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].pcRf").value="N";
     		     	  
			   }
			   else if(document.getElementById("RFed"+i+"").checked)
			   {
				// alert("IN checked");
				 document.getElementById("UFed"+p+"").disabled="true";
		         document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].pcRf").value="Y";
		         document.getElementById("ASSETPIPELINE_LIST["+parseInt(i-1)+"].pcUf").value="N";
			   }
			   

		   }
      
 	for(var i=0; i<count; i++)
	 {     message ="";
		   if(document.getElementById("ASSETPIPELINE_LIST["+i+"].disCovered").value=="")
			      	   message=message + "GLBR Code is required\n";
		   else
		 { 
		var val=document.getElementById("ASSETPIPELINE_LIST["+i+"].disCovered").value
		//   alert(val);
		 }
		 if(val=='N')
		 {
	document.getElementById("ASSETPIPELINE_LIST["+i+"].disTotLength").value="";
	document.getElementById("ASSETPIPELINE_LIST["+i+"].disTotLength").disabled="true";
		 }

	      } 
	 
	
} 

  function removePipeType(that)
	{
		
	   var frm = that.form;
	   var removeIds = frm.elements("remove");
	   if(removeIds)
	   {
		 var len = removeIds.length;
		 var count = 0;
		 if(typeof len != "number")
		   removeIds = [removeIds];
		   for(var i=0; i<len; i++)
		   {
			 if(removeIds[i].checked)
		 	   count++;
		   }
        }
	if(count!="0")
		{
	var input_box=confirm("Are You Sure to Delete?");
	if (input_box==true)
	{ 
	//alert ("You clicked OK"); 
	  	if(count == 0)
				alert("Please select atleast one GLSR to remove!");
			else
			if(count == len)
				alert("You cannot remove all Assets!\nPlease de-select one GLSR.");
			else{	
	            document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removePipeTypes";
	            document.forms[0].submit();
	        }    
	      
      }
	else
	{
	alert ("You clicked cancel");
	}
	}	    
	else
		{
		alert("Please select  Record(s) to remove!");
		}
	}

   
	/////
	function getRemoveCount()
	{
	var count=0;
		for(i=0; i<document.forms[0].elements.length; i++)
		{
			if(document.forms[0].elements[i].type=="checkbox"&&document.forms[0].elements[i].name=="remove")
			{
			count++;
			}
		}
		//alert("count in checkall is "+count);
		return(count);
	}

   
   
   
   ////
   function removeSubComps(that)
	{
	
	//alert("in removesubcomps");
		 var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	   var assetCode="<%=request.getParameter("assetCode")%>"; 
	   var frm = that.form;
	   var removeIds = frm.elements("remove");
	   var cnt = document.getElementById("count").value;
		var assetName = "<%=request.getParameter("assetName")%>";
		var pumpCode = "<%=request.getParameter("pumpCode")%>";
	   var habCode ="<%=request.getParameter("habCode")%>";
	   if(removeIds)
	   {
		 var len = removeIds.length;
		 var formElements=frm.elements;
		
		
		 var count = 0;
		 if(typeof len != "number")
		   removeIds = [removeIds];
		   for(var i=0; i<cnt; i++)
		   {
			 if(removeIds[i].checked)
		 	 {
		 	   count++;
		 	   }
		 	   }
		 	   }
		 	   //alert("Cccccccccccccccc:"+count);
		
       //alert("count is"+count);
	//if(count!="-1")
	if(count!="0")
		{
	var input_box=confirm("Are You Sure to Delete?");
	if (input_box==true)
	{ 
	//alert ("You clicked OK"); 
	
	

      
	  if(typeOfAsset=="04" && assetCompType=="01" && assetSubCompType=="001")
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit";
	       document.forms[0].submit();
	   }    
	   else if(typeOfAsset=="01" && assetCompType=="01" && assetSubCompType=="001")
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addPWSBorewell";
	       document.forms[0].submit();
	  
	   }   
	    

	    else if((typeOfAsset=="01" ||typeOfAsset=="02" || typeOfAsset=="03" || typeOfAsset=="09") && assetCompType=="04")
	   {  
	     
			if(count == 0)
				alert("Please select atleast one component to remove!");
			else
			if(count == len)
				alert("You cannot remove all Assets!\nPlease de-select one Component.");
			else{	
	            document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubComps&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	            document.forms[0].submit();
	        }    
	      
       }  
        else if((typeOfAsset=="01" ||typeOfAsset=="02" || typeOfAsset=="03" || typeOfAsset=="09") && assetCompType=="05")
	   {  
	     
			if(count == 0)
				alert("Please select atleast one Component to remove!");
			else
			if(count == len)
				alert("You cannot remove all Assets!\nPlease de-select one .");
			else{	
			
	            document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubComps&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetName="+assetName+"&habCode="+habCode+"&pumpCode="+pumpCode+"&assetCode="+assetCode;
	            document.forms[0].submit();
	        }    
	      
       }   
	   else if((typeOfAsset=="01" ||typeOfAsset=="02" || typeOfAsset=="03" || typeOfAsset=="09") && assetCompType=="03")
	   {  
	       if(count == 0)
				alert("Please select atleast one Distribution to remove!");
			else
			if(count == len)
				alert("You cannot remove all Assets!\nPlease de-select one Distribution.");
			else{	
	            document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubComps&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	            document.forms[0].submit();
	        }    
	   }     
	    
	    else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03" || typeOfAsset=="09") && assetCompType=="02")
	   { 	   
	        if(count == 0)
				alert("Please select atleast one SS Tank to remove!");
			else
			if(count == len)
				alert("You cannot remove all Assets!\nPlease de-select one SS Tank.");
			else{	
	            document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubComps&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	            document.forms[0].submit();
	        }    
	   }  
	   
	
	   
	   }

	else
	{
	//alert ("You clicked cancel");
	}
	}	    
	else
		{
		alert("Please select  Record(s) to remove!");
		}
	}
function removefunc()
{
	 var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	  
		//alert(typeOfAsset);
		//alert(assetCompType);
		//alert(assetSubCompType);
	 if(typeOfAsset=="01" && assetCompType=="01" && assetSubCompType=="001")
	   { 	   
	      document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubCompss&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	      document.forms[0].submit();
	    }   

}

	
	function addnew()
	{
	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		//alert("typeOfAsset="+typeOfAsset+" assetCompType="+assetCompType+" assetSubCompType="+assetSubCompType);
      
		//asset type=pws or cpws
      	//asset comptype=reservoirs
      	//subcomponent = ohsr
	     if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03") && assetCompType=="04" )
	    {  
	      var count = document.getElementById("count").value;
 	      var message ="";
 	    /*  for(var i=0; i<count; i++)
		  {  message ="";
		    if(document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrNo").value=="")
	    	   message=message + "OHSR Code is required\n";
	      } */
	      if(message==""  || count==0)
    	  {    
    	   	//alert("sadiqali9999999999"); 
    	   	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	        document.forms[0].submit();
	      }  
    	  else
	      { 
	        alert(message);
    	  }    
	    } 
 	   else if(typeOfAsset=="01" && (assetCompType=="01" || assetCompType=="05" )&& (assetSubCompType=="001" ||assetSubCompType=="003"))
	   {
	   		//alert("sadiqali9999999999");
	         document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	       	 document.forms[0].submit();
	    }    
	    
	   
	    //asset type=pws or cpws
      	//asset comptype=pipeline
      	//subcomponent = pumpingmain or distribution
	     else if((typeOfAsset=="01" || typeOfAsset=="03") && assetCompType=="03" && (assetSubCompType=="001" || assetSubCompType=="003"))
	    {  
	      var count = document.getElementById("count").value;
 	      var message ="";
 
 	      for(var i=0; i<count; i++)
		  {  message ="";
		    if(document.getElementById("ASSETPIPELINE_LIST["+i+"].disCode").value=="")
	    	   message=message + "Pipe Code is required\n";
	      } 
	      if(message=="" || count==0)
    	  {    
    	    document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	        document.forms[0].submit();
	      }  
    	  else
	      { 
	        alert(message);
    	  }    
	    }     
	    
	    //asset type=pws
      	//asset comptype=pipeline
      	//subcomponent = missing in database
	    else if(typeOfAsset=="01" && assetCompType=="03" && assetSubCompType=="002")
	    {  
	      var count = document.getElementById("count").value;
 	      var message ="";
 	       //alert("count"+count);
    	    document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	        document.forms[0].submit();
	     
	    }     
	    
	    //asset type=cpws
      	//asset comptype=headworks
      	//subcomponent = ssTank
	  else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03") && assetCompType=="02" )
	    {  
	      var count = document.getElementById("count").value;
 	      var message ="";

 	   /*   for(var i=0; i<count; i++)
		  {  message ="";
		    if(document.getElementById("ASSETHEADWORK_LIST["+i+"].collectionWellCode").value=="")
	    	   message=message + "Collection Well Code is required\n";
	      } */
	      if(message=="" || count==0)
    	  {    //alert("sadiq");
		   
	   var dcode ="<%=request.getParameter("dcode")%>";
	   var district ="<%=request.getParameter("district")%>";
   	   var mandal ="<%=request.getParameter("mandal")%>";
	    var habCode ="<%=request.getParameter("habCode")%>";
	 

		/*   url = "switch.do?prefix=/masters&page=/Asset.do&mode=hab&dcode="+dcode+"&district="+district+"&habCode="+habCode+"&assetTypeCode="+typeOfAsset+"&mandal="+mandal;
		   window.open(url,"","width=600,height=400,left=100,top=100,scrollbars=1");*/
    	    document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	        document.forms[0].submit();
	      }  
    	  else
	      { 
	        alert(message);
    	  }    
	    }          
	    //asset type=pws
      	//asset comptype=source or 'others'
      	//subcomponent = borewell or watchman quarter
      	        
	   else if(typeOfAsset=="01" && (assetCompType=="01" || assetCompType=="05") && (assetSubCompType=="001" || assetSubCompType=="005" ))
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	     document.forms[0].submit();
	   }
	   //asset type=cpws
      	//asset comptype=pipeline
      	//subcomponent = gravity main
	   else if(typeOfAsset=="03" && assetCompType=="03" && assetSubCompType=="002" )
	   {
	      document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	     document.forms[0].submit();
	   }
	   //asset type=cpws
      	//asset comptype=others
      	//subcomponent = pump details
	    else if(typeOfAsset=="03" && assetCompType=="05" && assetSubCompType=="001" )
	   {
   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	     document.forms[0].submit();
	   }
	}
 ///@author santosh code added on 221106
function savePipeType(that)
	{
//alert("save");
var code="<%=session.getAttribute("code")%>";
//alert(code);

	   var frm = that.form;
	   var removeIds = frm.elements("remove");
		var cnt = document.getElementById("count").value;
	
	 
	  
	   if(removeIds)
	   {
		 var len = removeIds.length;
		 var formElements=frm.elements;
		
		
		 var count = 0;
		 if(typeof len != "number")
		   removeIds = [removeIds];
		   for(var i=0; i<cnt; i++)
		   {
			 if(removeIds[i].checked)
		 	   count++;
		   }
        }



	if(count!="0")
		{
		//if(validateAssetForm1(assetForm1))
	     {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubCompPipeType";
	       document.forms[0].submit();
	     }
	 }
	else
	{
		alert("Select Record(s) to Save!");
	}
   }

 ///end @author
 function mandatory(that)
 {
 		var typeOfAsset1="<%=request.getParameter("assetTypeCode")%>";
		//alert(typeOfAsset1);
	   var assetCompType1="<%=request.getParameter("assetCompTypeCode")%>";
	  // alert(assetCompType1);
	   var assetSubCompType1="<%=request.getParameter("assetSubCompTypeCode")%>";
	  // alert(assetSubCompType1);
	   var assetCode1="<%=request.getParameter("assetCode")%>"; 
	  // alert(assetCode1);
	 //  alert("0.1");
	   var frm = that.form;
	  // alert("0.2");
	   var removeIds = frm.elements("remove");
	  // alert("1");
	   var cnt = document.getElementById("count").value;
	   //alert("2:"+cnt);	   
	   if(removeIds)
	   {
	   //	   alert("3");
		 var len = removeIds.length;
		 var formElements=frm.elements;
		
		
		 var counts = 0;
		 if(typeof len != "number")
		   removeIds = [removeIds];
		   for(var i=0; i<cnt; i++)
		   {
			 if(removeIds[i].checked)
			 {
		 	   counts++;
		 	   //alert("4:"+counts);
		 	   var subCompCode1=(document.getElementById("ASSETRESERVIOR_LIST[0]."+ohsrLocation).value);
		 	   //alert("5:"+subCompCode1);
		 	  }
		   }
        }
        //alert("finallyy:"+counts);
	   if(typeOfAsset1=="03" && assetCompType1=="04" && assetSubCompType1=="001")
	   {
	   		//alert("sfstdrjrteytwgeghtedetger");
	   }
	   	
	   
 }
	function savefunc(that)
	{
	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	   var assetCode="<%=request.getParameter("assetCode")%>"; 
	   var frm = that.form;
	   var removeIds = frm.elements("remove");
		var cnt = document.getElementById("count").value;
		 var capCheck = "yes";
	  var compName = '<%=componentName%>';
	  //alert(compName);
	   if(removeIds)
	   {
		 var len = removeIds.length;
		 var formElements=frm.elements;
		
		
		 var count = 0;
		 if(typeof len != "number")
		   removeIds = [removeIds];
		   for(var i=0; i<cnt; i++)
		   {
			 if(removeIds[i].checked)
		 	 {
		 	   count++;
		 	   if(compName=="RawWaterCollectionWell" && (document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value=="" || document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value=="0" || document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value=="0.0"))
		 	   {
		 	   		alert("Please Enter Capacity");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value='';
		 	   		document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").focus();
		 	   }

		 	   if(compName=="Sump" && (document.getElementById("ASSETHEADWORK_LIST["+i+"].sumpCapacity").value=="" || document.getElementById("ASSETHEADWORK_LIST["+i+"].sumpCapacity").value=="0" || document.getElementById("ASSETHEADWORK_LIST["+i+"].sumpCapacity").value=="0.0"))
		 	   {
		 	   		alert("Please Enter Capacity");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETHEADWORK_LIST["+i+"].sumpCapacity").value='';
		 	   		document.getElementById("ASSETHEADWORK_LIST["+i+"].sumpCapacity").focus();
		 	   }
		 	   if(compName=="ClearWaterCollectionWell" && (document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value=="" || document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value=="0" || document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value=="0.0"))
		 	   {
		 	   		alert("Please Enter Capacity");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").value='';
		 	   		document.getElementById("ASSETHEADWORK_LIST["+i+"].rwCapacity").focus();
		 	   }
		 	  // if(compName=="Ohsr" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfHab").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrCapacityLts").value=="0" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfHab").value=="0"))
		 	  // {
		 	 //  		alert("Please Link atleast one habitation");
		 	 //  		capCheck="no";
		 	  // 		document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfHab").value='';
		 	  // 		document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfHab").focus();
		 	  // }
		 	  // else
		 	   if(compName=="Ohsr" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrCapacityLts").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrCapacityLts").value=="0" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrCapacityLts").value=="0.0"))
		 	   {
		 	   		alert("Please Enter OHSR Capacity");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrCapacityLts").value='';
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].ohsrCapacityLts").focus();
		 	   }
		 	   else if(compName=="Ohsr" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfFillings").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfFillings").value=="0" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfFillings").value=="0.0"))
		 	   {
		 	   		alert("Please Enter No Of Fillings/Day");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfFillings").value='';
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfFillings").focus();
		 	   }
		 	   else if(compName=="OandM" && (document.getElementById("ASSETPUMPSET_LIST["+i+"].agencyCode").value==""))
		 	   {
		 	   		alert("Please Select Agency Code");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETPUMPSET_LIST["+i+"].agencyCode").focus();
		 	   }
		 	   else if(compName=="OandM" && (document.getElementById("ASSETPUMPSET_LIST["+i+"].total3").value=="" || document.getElementById("ASSETPUMPSET_LIST["+i+"].total3").value=="0"))
		 	   {
		 	   		alert("Please Enter Power Cost (or) Consumables (or) Wages&Others");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETPUMPSET_LIST["+i+"].powerCost").focus();
		 	   }
		 	   else if(compName=="Cisterns" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].cisCapLts").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].cisCapLts").value=="0"))
		 	   {
		 	   		alert("Please Enter Capacity");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].cisCapLts").focus();
		 	   }
		 	   else if(compName=="Cisterns" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].cisHr").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].cisHr").value=="0"))
		 	   {
		 	   		alert("Please No Of Fillings/Day");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].cisHr").focus();
		 	   }
		 	  else if(compName=="SPosts" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].standPostName").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].standPostName").value==null))
		 	   {
		 	   		alert("Please Enter Stand post name");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].standPostName").focus();
		 	   }
		 	 else if(compName=="SPosts" && (document.getElementById("ASSETRESERVIOR_LIST["+i+"].spLocation").value=="" || document.getElementById("ASSETRESERVIOR_LIST["+i+"].spLocation").value==null))
		 	   {
		 	   		alert("Please Enter Stand post location");
		 	   		capCheck="no";
		 	   		document.getElementById("ASSETRESERVIOR_LIST["+i+"].spLocation").focus();
		 	   }
		 	 }
		   }
        }



	if(count!="0")
		{
		if(capCheck!="no")
		{
 	   if(typeOfAsset=="04" && assetCompType=="01" && assetSubCompType=="001")
	   {
	    /*  if(validateAssetForm1(assetForm1))
	     { */
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit";
	       document.forms[0].submit();
	   /*   } */
	   }    
	   else if(typeOfAsset=="01" && assetCompType=="03" && (assetSubCompType=="001" || assetSubCompType=="002"))
	   {  
	      document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubComp&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	       	 document.forms[0].submit();
	    }     
	   else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03"  || typeOfAsset=="09") && assetCompType=="02" )
		{
		   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubComp&assetCode="+assetCode+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetTypeCode="+typeOfAsset;
	    	   document.forms[0].submit();
		}
	   else if(typeOfAsset=="08" && assetCompType=="01" )
		{
		   //alert("inside ntr")
		   //alert(assetSubCompType);
		   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubComp&assetCode="+assetCode+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetTypeCode="+typeOfAsset;
	    	   document.forms[0].submit();
		}
	 else if(typeOfAsset=="03" && assetCompType=="03" && assetSubCompType=="003")
		{
		   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubComp&assetCode="+assetCode+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetTypeCode="+typeOfAsset;
	       document.forms[0].submit();
		}


	else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03"  || typeOfAsset=="09") && assetCompType=="04" )
	   {  
	     //alert("sadiq aali"); 
	     document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubComp&assetCode="+assetCode+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetTypeCode="+typeOfAsset;
	     document.forms[0].submit();
	   }     
	else if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"  || typeOfAsset=="09") && (assetCompType=="05" )&& (assetSubCompType=="001" || assetSubCompType=="002" || assetSubCompType=="003"))
	   {
	   		//alert("sadiqali9999999999");
	         document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubComp&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	       	 document.forms[0].submit();
	    }    
	    }
	}
	else
	{
		alert("Select Record(s) to Save!");
	}
   }
   function nextfunc()
	{
		   //alert("PPP");
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   var habcode = "<%=request.getParameter("habCode")%>";
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var pumCode ="<%=request.getParameter("pumpCode")%>";
		 
		   //alert(typeOfAsset);
		   //alert(assetCompType);
		   //alert(assetSubCompType);
		  
		 			   
	 if(typeOfAsset=="01" && (assetCompType=="01" || assetCompType=="05" )&& (assetSubCompType=="001" ||assetSubCompType=="003"))
	   {

	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=next&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	       document.forms[0].submit();
	   }    
	   			   
	 	   
   }
function prevfunc()
	{
		   //alert("PPP");
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   var habcode = "<%=request.getParameter("habCode")%>"
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var pumCode ="<%=request.getParameter("PumpCode")%>";
		    //alert(typeOfAsset);
		   //alert(assetCompType);
		   //alert(assetSubCompType);
		   //alert(habcode);
		   //alert(assetcode);
		   //alert(pumCode);
				   
 if(typeOfAsset=="01" && (assetCompType=="01" || assetCompType=="05" )&& (assetSubCompType=="001" ||assetSubCompType=="003"))
	   {

	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=previous&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&habCode="+habcode+"&assetCode="+assetcode+"&PumpCode="+pumCode;
	       document.forms[0].submit();
	   }    
	   
   }
   //bhagya
function openFile(sourceno){
	 var assetcode = "<%=request.getParameter("assetCode")%>";
	   var habcode = "<%=request.getParameter("habCode")%>"
 	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	   var pumCode ="<%=request.getParameter("PumpCode")%>"; 
		var url="switch.do?prefix=/masters&page=/Asset.do?mode=showCompImage&sourceid="+sourceno+"&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&habCode="+habcode+"&assetCode="+assetcode+"&PumpCode="+pumCode;
		//alert(url);
		var width = 990;
		var height = 450;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=yes,status=yes,left=20,top=20";

		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
		
		
	}
	</script>


