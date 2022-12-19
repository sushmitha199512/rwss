	<%@ include file="/commons/rws_header1.jsp" %>
	<html:javascript formName="assetForm" />
	<%//System.out.println("in pumpset jsp"); %>
<% 
String componentName = (String)session.getAttribute("assetsubCompParams");
int totRecords = 0;
if(request.getAttribute("totalRecords")!=null)
{
	totRecords = Integer.parseInt((String)request.getAttribute("totalRecords"));
}
else
{
	totRecords=0;
}
session.setAttribute("totRecords",""+totRecords);
%>

	<SCRIPT LANGUAGE="JavaScript">
	var newWindow;
	
	<c:if test="${sessionScope.assetsubCompParams!='HandPumps'}">
	
	
	function fnPickHabitations(index){
	var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	var subCompCodeTemp= document.getElementById("subCompCode").value;
	var subCompCode1=(document.getElementById(subCompCodeTemp).value);
	   var dcode ="<%=request.getParameter("dcode")%>";
	   var district ="<%=request.getParameter("district")%>";
   	   var mandal ="<%=request.getParameter("mandal")%>";
	   var habCode ="<%=request.getParameter("habCode")%>";
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&subCompCode1="+subCompCode1
				+ "&dcode="+dcode
				+ "&district="+district+"&mandal="+mandal+"&habCode="+document.getElementById("habCode").value;
				//alert(url);
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
</c:if>

<% if(((String)session.getAttribute("assetsubCompParams")).equals("Distribution"))
{
%>
	function calBalanceNeeded()
	{
		if( document.forms[0].disTotalLengthNeeded.value =="" && document.forms[0].disTotalLengthProvided.value =="")
		{
		
		}
		else
		{
		var totalLengthNeeded=document.forms[0].disTotalLengthNeeded.value;
		var totalLengthProvided=document.forms[0].disTotalLengthProvided.value;
		document.forms[0].disBalanceNeeded.value=totalLengthNeeded-totalLengthProvided;
		
		}
	}

<%}%>


/*
function closeFunc()
{
//code to refresh the parent window
opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=ShowHabsBenfit";
opener.document.forms[0].submit();
self.close();
//var url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&pumpCode="+assetForm.pumpCode.value+"&dcode="+assetForm.dcode.value+"&mandal="+mandal+"&district="+assetForm.district.value;
return true;
}
*/

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



	function fnPickPipeMat(index)
	{
	//alert("finction fnPickPipeMat called");
	var noofpipes="";
	var index="0";
	var subCompCodeTemp= document.getElementById("subCompCode").value;
	var subCompCode1=(document.getElementById(subCompCodeTemp).value);
	//var code=document.forms[0].pmCode.value;
	var code=subCompCode1;
	
		
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=pickpipemat"
				+ "&code="+code+ "&index="+index;
		
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
			 
		//if( !newWindow || newWindow.closed)
		//{
			//alert("opening new window");
			newWindow = window.open(url, "", properties);
		//}
		/*else
		{	alert("in else");
			newWindow.focus();
		}*/
	//}
	/*else
	{
		alert("Please Enter Required Pipe Materials...");
		document.getElementById("ASSETPIPELINE_LIST["+index+"].disNoOfPipes").focus();

	}*/
	}
	
	function fnPickNewHabitations()
{
	var assetType="<%=request.getParameter("assetTypeCode")%>";
	var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	var assetCode="<%=request.getParameter("assetCode")%>"; 
	if(assetType=="04")
	{
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab&assetCode="+assetCode;
	   	document.forms[0].action=url;
	   	document.forms[0].submit();
	}
	else if((assetType=="01"||assetType=="02"||assetType=="03"||assetType=="09")&&assetCompType=="01"&&assetSubCompType=="003")
	{
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab&assetCode="+assetCode;
	   	document.forms[0].action=url;
	   	document.forms[0].submit();
	}
	else if((assetType=="01"||assetType=="02"||assetType=="03"||assetType=="09")&&assetCompType=="06"&&assetSubCompType=="001")
	{
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab&assetCode="+assetCode;
	   	document.forms[0].action=url;
	   	document.forms[0].submit();
	}
	else
	{
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab&assetCode="+assetCode;
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
}

	function init()
	{
		
		var nextNotExists ="<%=request.getAttribute("nextNotExists")%>";
		var previousNotExists ="<%=request.getAttribute("previousNotExists")%>";
		var addNewExists ="<%=request.getAttribute("addNewExists")%>";
		var isNewHab ="<%=request.getAttribute("isNewSubComp")%>";
		var compName = '<%=componentName%>';
		if(compName!="HandPumps")
		{
			if(addNewExists!=null && addNewExists=="true")
			 {
			 	document.forms[0].add.disabled=true;
			 	
		 	 }
			 else
			 {
				 document.forms[0].add.disabled=false;
				 
			 }
		
			if(nextNotExists!=null && nextNotExists=="true")
			 {
			 	document.forms[0].next.disabled=true;
			 	document.forms[0].last.disabled=true;
		 	 }
			 else
			 {
				 document.forms[0].next.disabled=false;
				 document.forms[0].last.disabled=false;
			 }
		 
		 	if(previousNotExists!=null && previousNotExists=="true")
		 	{
			 	document.forms[0].previous.disabled=true;
			 	document.forms[0].first.disabled=true;
		 	}
			 else
			 {
				 	
			 	document.forms[0].previous.disabled=false;
			 	document.forms[0].first.disabled=false;
		 	}
		 	
		 	if(isNewHab!=null && isNewHab=="true")
			{
				
				document.forms[0].first.disabled=true;
				document.forms[0].previous.disabled=true;
				document.forms[0].next.disabled=true;
				document.forms[0].last.disabled=true;
				document.forms[0].add.disabled=true;
				
			}
		}
	 	<% if(session.getAttribute("assetsubCompParams").equals("HandPumps"))
	 	{
	 	%>
	 	if(document.forms[0].qualityAffected.value=="Y")
	 	{
	 	qualityAffect();
	 	}
	 	<%}%>
	}
	
	function first1()
	{
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   if(assetcode==null || assetcode=="")
		    {
		  	    assetcode = "<%=request.getAttribute("assetCode")%>";
		    }
		   var habcode = "<%=request.getParameter("habCode")%>";
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		  
		   if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="06" && assetSubCompType=="001" )
	   		{
			       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&opType=first&assetCode="+assetcode;
			       document.forms[0].submit();
	   		} 
	   		if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="03" && (assetSubCompType=="001" || assetSubCompType=="002" || assetSubCompType=="003") )
	   		{
			       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&opType=first&assetCode="+assetcode;
			       document.forms[0].submit();
	   		}   
	   		
	}
	function last1()
	{
		   var habcode = "<%=request.getParameter("habCode")%>";
		     var assetcode = "<%=request.getParameter("assetCode")%>";
		     if(assetcode==null || assetcode=="")
		    {
		  	    assetcode = "<%=request.getAttribute("assetCode")%>";
		    }
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="06" && assetSubCompType=="001" )
	   		{
			       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&opType=last&assetCode="+assetcode;
			       document.forms[0].submit();
	   		}   
	   		if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="03" && (assetSubCompType=="001" ||assetSubCompType=="002" ||assetSubCompType=="003" ))
	   		{
			       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&opType=last&assetCode="+assetcode;
			       document.forms[0].submit();
	   		}   
	}
	
	function firstfunc()
	{
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   var habcode = "<%=request.getParameter("habCode")%>";
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var pumCode ="<%=request.getParameter("pumpCode")%>";
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=firstHP&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode;
	       document.forms[0].submit();
	}
	function lastfunc()
	{
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   var habcode = "<%=request.getParameter("habCode")%>";
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var pumCode ="<%=request.getParameter("pumpCode")%>";
		 
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=lastHP&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode;
	       document.forms[0].submit();
	}
	function otherfn(that)
	{
		
		if(document.getElementById("casing").value=="OTHERS")
		{
			document.getElementById("otherspecify").disabled=false;
		}
		else
		{
			document.getElementById("otherspecify").disabled=true;
			document.getElementById("otherspecify").value="";
		}
	}

	function drainCond(that)
	{
		
		if(document.getElementById("drain").value=="E")
		{
			
			document.getElementById("drainCondition").disabled=false;
		}
		else
		{	
			document.getElementById("drainCondition").disabled=true;
			document.getElementById("drainCondition").value="";
		}

	}
	function platformCond(that)
	{
		
		if(document.getElementById("pcond").value=="Y")
		{
			document.getElementById("platformCondition").disabled=false;
			
		}
		else
		{	
			document.getElementById("platformCondition").disabled=true;
			document.getElementById("platformCondition").value="";
		}

	}
	function qualityAffect()
	{
	if(document.getElementById("qualityAffected").value == "Y")
	{
		document.getElementById('conti').style.display='block'
		
		}
	else
	{
		document.getElementById('conti').style.display='none'
		}
	}
	
function getContam(that)
{	
	
	var optype = that.value;
	var option1 = assetForm.flouride.value;
	var option2 = assetForm.brakish.value;
	var option3 = assetForm.iron.value;
	var option4 = assetForm.others.value;
	
	if(that.value == "FLOURIDE" || option1 != "0.0")
			document.getElementById('FLOURIDE').style.display='block'
	/*else
			document.getElementById('FLOURIDE').style.display='none'*/

	if(that.value == "BRAKISH" || option2  != "0.0" )
			document.getElementById('BRAKISH').style.display='block'
/*	else
			document.getElementById('BRAKISH').style.display='none'*/
	if(that.value == "IRON" || option3 != "0.0" )
		document.getElementById('IRON').style.display='block'
		
	if(that.value == "OTHERS" || option4 != "0.0" )
		document.getElementById('OTHERS').style.display='block'
/*	else
		document.getElementById('IRON').style.display='none'
	/*else
	{	//alert("sadiq");
		document.getElementById('FLOURIDE').style.display='none'
		document.getElementById('BRAKISH').style.display='none'
		document.getElementById('IRON').style.display='none'
	}*/
	
}
	function addnew()
	{
		var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	  
	   
		//alert(assetSubCompType);
	 /*  if((typeOfAsset=="01" && assetCompType=="05" && assetSubCompType=="001")
	   {  
			//alert("addnew");
	      var count = document.getElementById("count").value;
 	      var message ="";
 	     /* for(var i=0; i<count; i++)
		  {  message ="";
		    if(document.getElementById("ASSETRESERVIOR_LIST["+i+"].glsrCode").value=="")
	    	   message=message + "Glsr Code is required\n";
	      } 
	      if(message=="" || count==0)
    	  {    
    	  
    	   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	       document.forms[0].submit();
	      }  
    	  else
	      { 
	        //alert(message);
    	  } 
	   }
		  else */
if(typeOfAsset=="04" && assetCompType=="01" && assetSubCompType=="001")
		   {
			  //alert("addnew");
			document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	       document.forms[0].submit();
		   }
		   else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="03" && ( assetSubCompType=="001" ||  assetSubCompType=="002" || assetSubCompType=="003" ) ) 
		   {
			  //alert("addnew");			
			  document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }
		   else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="05" &&  assetSubCompType=="001" )  
		   {
			  //alert("addnew");			
			  document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }
		   else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="01" &&  assetSubCompType=="003" )  
		   {
			  //alert("addnew");			
			  document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }
 	}
	 function nextfunc()
	{
//		   alert("in next");
		   var pumpCode="";
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   if(assetcode==null || assetcode=="")
		    {
		  	    assetcode = "<%=request.getAttribute("assetCode")%>";
		    }
		   var habcode = "<%=request.getParameter("habCode")%>";
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   if(assetCompType=="03" && assetSubCompType=="001")
		   pumpCode ="<%=request.getParameter("pmCode")%>";
		 
		   //alert(typeOfAsset);
		   //alert(assetCompType);
		   //alert(assetSubCompType);
			//alert(pumCode);
				 			   
	
	if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="01" && assetSubCompType=="003" )
	   {
		//alert("next");
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=next";
	       document.forms[0].submit();
	   }   
	 if(typeOfAsset=="04" &&  assetCompType=="01" && assetSubCompType=="001" )
	   {

	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextBw&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=next";
	       document.forms[0].submit();
	   }   
	   if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="03" && (assetSubCompType=="001"||assetSubCompType=="002"||assetSubCompType=="003") )
	   {
		//alert("next");
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=next";
	       document.forms[0].submit();
	   } 
	   if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="06" && assetSubCompType=="001")
	   {
		//alert("next");
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=next";
	       document.forms[0].submit();
	   } 
	  
   }
	 function prevfunc()
	{
		   var assetcode = "<%=request.getParameter("assetCode")%>";
		   if(assetcode==null || assetcode=="")
		    {
		  	    assetcode = "<%=request.getAttribute("assetCode")%>";
		    }
		   var habcode = "<%=request.getParameter("habCode")%>";
	   	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var pumCode ="<%=request.getParameter("pumpCode")%>";
		
	
	if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="03" && (assetSubCompType=="001" || assetSubCompType=="002" || assetSubCompType=="003") )
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=previous";
	       document.forms[0].submit();
	   }	
	if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") &&  assetCompType=="06" && assetSubCompType=="001" )
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextSubComponent&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=previous";
	       document.forms[0].submit();
	   }			 			   
	 if(typeOfAsset=="01" &&  assetCompType=="03" && assetSubCompType=="003" )
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=previouspump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	       document.forms[0].submit();
	   }   
	 if(typeOfAsset=="04" &&  assetCompType=="01" && assetSubCompType=="001" )
	   {

	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=getNextBw&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetcode+"&opType=previous";
	       document.forms[0].submit();
	   }   
	    if(typeOfAsset=="01" &&  assetCompType=="03" && assetSubCompType=="003" )
	   {
	       document.forms[0].submit();
	   }   
   }
   function savefunc()
	{
	//   alert("hello");
       var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	  var assetCode="<%=request.getParameter("assetCode")%>"; 
	    if(typeOfAsset=="04" && assetCompType=="01" && assetSubCompType=="001")
	   {   
	        var yield=document.forms[0].pyield.value;
	    	var servings=document.forms[0].serhrs.value;
	      if(servings=="" || servings==null){s
	    	alert("No Of Hours Serving per day is Mandatory");
	    	document.forms[0].serhrs.focus();
	    	}
	       else if(yield=="" || yield==null){
	    	alert("Yield is Mandatory");
	    	document.forms[0].pyield.focus();
	    	} 
	       else{
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	       document.forms[0].submit();
	       }
	   }    
	   else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03" || typeOfAsset=="09") && assetCompType=="03" && ( assetSubCompType=="001" ||  assetSubCompType=="002"  ||assetSubCompType=="003" )) 
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	       document.forms[0].submit();
	   }  
	   else if((typeOfAsset=="01" || typeOfAsset=="02" || typeOfAsset=="03" || typeOfAsset=="09") && assetCompType=="06" &&  assetSubCompType=="001" ) 
	   {
	       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
		   //alert("switch.do?prefix=/masters&page=/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode);
	       document.forms[0].submit();
	   }    
	   if(assetCompType=="05" && assetSubCompType=="001")
	   {
	      document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	       document.forms[0].submit();
	   }   
	}    

   function removeSubComp(that)
	{
	var input_box=confirm("Are You Sure to Delete?");
	if (input_box==true)
	{ 
		var totRecords = '<%=totRecords%>';
		   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var assetCode="<%=request.getParameter("assetCode")%>"; 
	if(assetCompType=="06" ||totRecords!=0)
	{
		   var frm = that.form;
		   if(typeOfAsset=="04" && assetCompType=="01" && assetSubCompType=="001")
		   {
		       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }  
		  if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="03" && assetSubCompType=="003")
		   {
		  
		   var code=document.forms[0].disCode.value;
		  
		   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&pmCode="+code+"&opType=delete";
	    	
	       document.forms[0].submit(); 
	       } 
		   if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="03" && assetSubCompType=="001")
		   {
		  
		   var code=document.forms[0].pmCode.value;
		  
		   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&pmCode="+code+"&opType=delete";
	    
	       document.forms[0].submit(); 
	       } 
	       if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="03" && assetSubCompType=="002")
		   {
		  
		   		var code=document.forms[0].gravitymain_code.value;
		  		document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&pmCode="+code+"&opType=delete";
	    		document.forms[0].submit(); 
	       } 
		   if(typeOfAsset=="01" && assetCompType=="03" && assetSubCompType=="003")
		   {
		       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }  
		    if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="05" && assetSubCompType=="001")
		   {
		       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubComps&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }  
		   if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="01" && assetSubCompType=="003")
		   {
		       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removeSubComps&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
		       document.forms[0].submit();
		   }
			if((typeOfAsset=="01"||typeOfAsset=="02"||typeOfAsset=="03"||typeOfAsset=="09") && assetCompType=="06" && assetSubCompType=="001")
		   {
		       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=removePumpset&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
			   //alert("switch.do?prefix=/masters&page=/Asset.do?mode=removePumpset&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode);
		       document.forms[0].submit();
		   }
		}
		else
		{
			alert("No Records to Delete");
		}
		
	    
	     }
	   }    


 function removeSubCompHp(that)
	{
	var input_box=confirm("Are You Sure to Delete?");
	if (input_box==true)
	{ 
		var totRecords = '<%=totRecords%>';
		   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var assetCode="<%=request.getParameter("assetCode")%>"; 
			var habCode="<%=request.getParameter("habCode")%>"; 
			var pumpCode="<%=request.getParameter("pumpCode")%>"; 
		   var frm = that.form;
		   if(typeOfAsset=="04" && assetCompType=="01" && assetSubCompType=="001")
		   {
		       document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=Submit&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&habCode="+habCode+"&pumpCode="+pumpCode;
		       document.forms[0].submit();
		   }  
	     }
	   }

	function showGenerator()
	{
		var compName = '<%=componentName%>';
		if(compName=="Pumpsets")
		{
			var generatorExisting = assetForm.generatorExisting.value;
				if(generatorExisting == 'Y')
				{
					document.getElementById('generator').style.display='block';
				}
				else
				{
					document.getElementById('generator').style.display='none';
					assetForm.generatorCapacity.value='';
					assetForm.generatorWorking.value='';
				}
		}
	}
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
	</SCRIPT>

	</head>
		
	<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" onload="init();showGenerator()">	
	<%String assetCode=request.getParameter("assetTypeCode");
	String assetName="";
	
	if(assetCode!=null)
	{
	if(assetCode.equals("01"))
	assetName="PWS";
	else if(assetCode.equals("02"))
	assetName="MPWS";
	else if(assetCode.equals("03"))
	assetName="CPWS";
	else if(assetCode.equals("03"))
	assetName="DIRECT PUMPING";
	}	

	
	%>
	<% try {
	%>
	<table  bordercolor= "#8A9FCD"  border="0" rules="none" style="border-collapse:collapse;" width="100%"  >
	<thead class="gridLabel" align="center">
    <tr bgcolor="#8A9FCD">
    <td colspan=4 align=left><b>Asset SubComponent Parameter Details </b>
    </td>
    </tr>
 	</thead>

	
<c:if test="${sessionScope.assetsubCompParams=='HandPumps'}">
 	<html:form action="Asset.do?mode=Submit">
	
  	 <nested:iterate id="ASSETSUBCOMPONENTS_LIST" property="assetSubComponents" indexId="ndx">
		<tr bgcolor="#8A9FCD" class="gridLabel" >
         <td colspan=4 align=left ><b>Component Name:&nbsp;HAND PUMPS-SOURCE-BORE WELL</b>
         </td>
         </tr>
		 <tr >
		 	<td align=left class="textborder"><bean:message key="app.pumpCode"/> 
			</td>
			 <td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="hpCode" maxlength="5"  styleClass="mytext" style="width:160px" readonly="true" />
			</td>
		</tr>
		<tr>
			<td align=left class="textborder"><bean:message key="app.location"/> 
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="location" maxlength="30" styleClass="mytext" style="width:150px" onkeypress="return upperOnly()"/>
			</td>
		</tr>
		<tr>
		<td align=left class="textborder">Diameter(mm)
			</td>
			<td  class="textborder" align=center >
			<html:select name="ASSETSUBCOMPONENTS_LIST" property="diameter" styleClass="mycombo" style="width:150px" >
				<html:option value="">SELECT...</html:option>
				<html:option value="112">112</html:option>
				<html:option value="150">150</html:option>
				<html:option value="163">163</html:option>
				</html:select>
			</td>
			<td align=left class="textborder"><bean:message key="app.depth" />
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="depth" styleClass="mytext" style="width:150px"  onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder"><bean:message key="app.casing"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="casing" styleClass="mycombo" style="width:150px" onchange="javaScript:otherfn(this)">
				<html:option value="">SELECT...</html:option>
				<html:option value="PVC">PVC</html:option>
				<html:option value="MS">MS</html:option>
				<html:option value="OTHERS">OTHERS</html:option>
				</html:select>
			</td>
			
			<td align=left class="textborder"><!-- <bean:message key="app.ifother"/>  -->
			</td>
			<td  class="textborder" align=center >
				<nested:hidden name="ASSETSUBCOMPONENTS_LIST" property="otherspecify"  styleClass="mytext" />
			</td>
			</tr>
		<tr>
		<td align=left class="textborder"><bean:message key="app.gino"/> 
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="gino" maxlength="3"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			<td align=left class="textborder"> Total Length of Pipes(in Mts.)
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="pipeLength" maxlength="3"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		</tr>
		<tr>
		
			<td align=left class="textborder"><bean:message key="app.genCondition"/> 
			</td>
			
			<td  class="textborder" align=center >
 			 <html:select name="ASSETSUBCOMPONENTS_LIST" property="genCondition" styleClass="mycombo" style="width:150px">
				<html:option value="">SELECT...</html:option>
				<html:option value="G">GOOD</html:option>
				<html:option value="B">BAD</html:option>
             </html:select>
			</td>			
		<td align=left class="textborder"><bean:message key="app.staticWaterLevel"/> 
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="staticWaterLevel" styleClass="mytext" style="width:150px" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
		</tr>
		<tr>
		<td align=left class="textborder"><bean:message key="app.summerWaterLevel"/>(From Ground)
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="summerWaterLevel" styleClass="mytext" style="width:150px" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			 <td align=left class="textborder"><bean:message key="app.serhrs"/><span class="mandatory">*</span>  
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="serhrs" styleClass="mytext" style="width:150px" onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			
		</tr>
		<tr>
<td align=left class="textborder"><bean:message key="app.serno"/> 
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="serno" maxlength="5"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder"><bean:message key="app.painted"/> 
			</td>
			<td  class="textborder" align=center >
			<html:select name="ASSETSUBCOMPONENTS_LIST" property="painted" styleClass="mycombo" style="width:150px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
            </html:select>
			</td>
			<td align=left class="textborder"><bean:message key="app.repairs"/> 
			</td>
			<td  class="textborder" align=center >
				<!-- <nested:text name="ASSETSUBCOMPONENTS_LIST" property="repairs" maxlength="10" styleClass="mytext" style="width:150px"  onkeypress="upperOnly()"/> -->
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="repairs" styleClass="mycombo" style="width:150px"> 
				<html:option value="">SELECT...</html:option>
				<html:option value="ONCE">ONCE</html:option>
				<html:option value="TWICE">TWICE</html:option>
				<html:option value="MORE">MORE</html:option>
				
            </html:select>
			</td>			
		</tr>
		<tr >
			
			<td align=left class="textborder"><bean:message key="app.pcond"/> 
			</td>
			<td  class="textborder" align=center >
			<html:select name="ASSETSUBCOMPONENTS_LIST" property="pcond" styleClass="mycombo" style="width:150px" onchange="javaScript:platformCond(this)">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
            </html:select>
			</td>
				
			<td align=left class="textborder"><bean:message key="app.platformCondition"/> 
			</td>
			<td  class="textborder" align=center >
			<html:select name="ASSETSUBCOMPONENTS_LIST" property="platformCondition" styleClass="mycombo" style="width:150px" >
				<html:option value="">SELECT...</html:option>
				<html:option value="G">GOOD</html:option>
				<html:option value="B">BAD</html:option>
            </html:select>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder"><bean:message key="app.drain"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST"  property="drain" styleClass="mycombo" style="width:150px"  onchange="javaScript:drainCond(this)">
				<html:option value="">SELECT...</html:option>
				<html:option value="E">EXISTING</html:option>
				<html:option value="N">NOT EXISTING</html:option>
                </html:select>
			</td>
			<td align=left class="textborder"><bean:message key="app.drainCondition"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="drainCondition" styleClass="mycombo" style="width:150px">
				<html:option value="">SELECT...</html:option>
				<html:option value="G">GOOD</html:option>
				<html:option value="B">BAD</html:option>
            </html:select>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder"><bean:message key="app.drainsd"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="drainsd" styleClass="mycombo" style="width:150px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
	            </html:select>
			</td>
			<td align=left class="textborder"><bean:message key="app.drainlp"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="drainlp" styleClass="mycombo" style="width:150px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">Existing</html:option>
				<html:option value="N">NO</html:option>
	            </html:select>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder"><bean:message key="app.hygiene"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="hygiene" styleClass="mycombo" style="width:150px">
				<html:option value="">SELECT...</html:option>
				<html:option value="G">GOOD</html:option>
				<html:option value="B">BAD</html:option>
	            </html:select>
			</td>
			<nested:hidden name="ASSETSUBCOMPONENTS_LIST" property="avgtime"/>
		</tr>
		<tr>
			<td align=left class="textborder"><bean:message key="app.pyieldlocal"/> 
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="pyieldLocal" styleClass="mycombo" style="width:150px" >
				<html:option value="">SELECT...</html:option>
				<html:option value="Intermittent">Intermittent</html:option>
				<html:option value="Continuous">Continuous</html:option>
	            </html:select> 
			</td>		 
			<td align=left class="textborder"><bean:message key="app.pyield"/><span class="mandatory">*</span>  
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="pyield" maxlength="5"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>		
		</tr> 
		<tr >
			<td align=left class="textborder"><bean:message key="app.waterquality"/>  
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETSUBCOMPONENTS_LIST" property="qualityAffected" styleClass="mycombo" style="width:150px" onchange="javaScript:qualityAffect()">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">NSS</html:option>
				<html:option value="N">Safe Source</html:option>
	            </html:select>
			</td>
			<td>
		<nested:text name="ASSETSUBCOMPONENTS_LIST"  property="assetCode" styleClass="mytext" 
		style="width:0px" />
		
		</td>
		</tr>
		<tr>
		<td class="textborder">Image</td>
		
		<td  align=center >
			<nested:equal name="ASSETSUBCOMPONENTS_LIST"  property="imageStatus"  value="Yes" >
				<a href="#" onclick="openFile('<bean:write name="ASSETSUBCOMPONENTS_LIST" property="hpCode"/>')">View</a>&nbsp;
			</nested:equal> 
			<nested:notEqual name="ASSETSUBCOMPONENTS_LIST"  property="imageStatus"  value="Yes" >
				<p styleClass="mytext" style="width:150px">Image not Exist</p>
			</nested:notEqual> 
		</td>
		</tr>
		<tr>
		<td class="textborder">Latitude-N</td>
			 <td   align=center >
			<nested:text  name="ASSETSUBCOMPONENTS_LIST"  property="latitude"  style="width:150px"
						styleClass="mytext"  maxlength="10" onkeypress="decimalsOnly()"/> 
			</td>
			<td  class="textborder">Longitude-E</td>
			 <td   align=center >
			<nested:text  name="ASSETSUBCOMPONENTS_LIST" property="longitude"  style="width:150px"
						styleClass="mytext"  maxlength="10" onkeypress="decimalsOnly()" /> 
			</td>
					</tr>
					<tr>
					<td  class="textborder">Elevation</td>
			 <td  align=center>
			<nested:text  name="ASSETSUBCOMPONENTS_LIST" property="elevation"  style="width:150px"
						styleClass="mytext"  maxlength="10"  onkeypress="decimalsOnly()"/> 
			</td>
			<td  class="textborder">Waypoint</td>
			 <td  align=center >
			<nested:text  name="ASSETSUBCOMPONENTS_LIST" property="waypoint"  style="width:150px"
						styleClass="mytext"  maxlength="4" onkeypress="decimalsOnly()"/> 
			</td>
					</tr>
	</nested:iterate>
		
	</table>

	<div id="conti" style="position:relative;overflow-n:auto;left:0;height:34;width:500;top:0;display:none">
		
		<fieldset>
		<legend>Contamination Details</legend>
			<label>
			<table bordercolor= "#000000" border="1" style="border-collapse:collapse;" width="100%" align=center >
			
			<tbody bgcolor="#FFFFFF">
			<td class="bwborder">
				    <input type="radio" name="opType1"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="FLOURIDE" /><font size="1" face="verdana"><b>&nbsp;Flouride</b></font> &nbsp;&nbsp;
 				    <input type="radio" name="opType2"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="BRAKISH" /><font size="1" face="verdana"><b>&nbsp;Brakish</b></font>  &nbsp;&nbsp;
				    <input type="radio" name="opType3"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="IRON" /><font size="1" face="verdana"><b>&nbsp;Iron</b></font> 	 &nbsp;&nbsp;
				    <input type="radio" name="opType4"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="OTHERS" /><font size="1" face="verdana"><b>&nbsp;Others</b></font> 				        			        
		        </td> 
			</tbody>
			</table>
			</label>
		</fieldset>
		
		<div id="FLOURIDE" style="position:relative;overflow-y:auto;left:0;height:34;width:500;top:0;display:none">
		<fieldset>
		<!-- <legend>Contamination Details</legend> -->
		<label>
			<table bordercolor= "#000000" border="1" style="border-collapse:collapse;" width="100%" align=center >
			
			<tbody bgcolor="#FFFFFF">
				 <nested:iterate id="ASSETSUBCOMPONENTS_LIST" property="assetSubComponents" indexId="ndx">
			<td align=left width="140" class="textborder"><bean:message key="app.flouride"/> 
			</td>
			 <td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="flouride" styleClass="mytext" style="width:150px" onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>%
				</nested:iterate>
			</tbody>
			</tbody>
			</table>
			</label>
		</fieldset>
		</div>
		<div id="BRAKISH" style="position:relative;overflow-y:auto;left:0;height:34;width:500;top:0;display:none">
		<fieldset>
		<label>
			<table bordercolor= "#000000" border="1" style="border-collapse:collapse;" width="100%" align=center >
			
			<tbody bgcolor="#FFFFFF">
				 <nested:iterate id="ASSETSUBCOMPONENTS_LIST" property="assetSubComponents" indexId="ndx">
			<td align=left width="140" class="textborder"><bean:message key="app.brakish"/> 
			</td>
			 <td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="brakish" styleClass="mytext" style="width:150px" onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>%
				</nested:iterate>
			</tbody>
			</tbody>
			</table>
			</label>
		</fieldset>
		</div>
			<tr>
		<div id="IRON" style="position:relative;overflow-y:auto;left:0;height:34;width:500;top:0;display:none">
		<fieldset>
		<label>
			<table bordercolor= "#000000" border="1" style="border-collapse:collapse;" width="100%" align=center >
			<tbody bgcolor="#FFFFFF">
				 <nested:iterate id="ASSETSUBCOMPONENTS_LIST" property="assetSubComponents" indexId="ndx">
			<td align=left width="140" class="textborder"><bean:message key="app.iron"/> 
			</td>
			 <td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="iron" styleClass="mytext" style="width:150px" onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>%
				</nested:iterate>
			</tbody>
			</tbody>
			</table>
			</label>
		</fieldset>
		</div>
		</tr>
		
		<tr>
		<div id="OTHERS" style="position:relative;overflow-y:auto;left:0;height:45;width:500;top:0;display:none">
		<fieldset>
		<legend>Please Specify Other Contamination Type</legend>
		<label>
			<table bordercolor= "#000000" border="1" style="border-collapse:collapse;" width="100%"  align=center >
			
			<tbody bgcolor="#FFFFFF">
				 <nested:iterate id="ASSETSUBCOMPONENTS_LIST" property="assetSubComponents" indexId="ndx">
			<td align=left width="140" class="textborder"><nested:text name="ASSETSUBCOMPONENTS_LIST" property="othersType" styleClass="gridText" style="width:90px"/>
				
			</td>
			 <td  class="textborder" align=center >
				<nested:text name="ASSETSUBCOMPONENTS_LIST" property="others" styleClass="mytext"  style="width:150px" onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>%
				</nested:iterate>
			</tbody>
			</tbody>
			</table>
			</label>
		</fieldset>
		</div>
		</tr>
		</div>
		  <tr align="center">
			<td  align="center" colspan=2 >
				<table  class="row" bordercolor= "#8A9FCD"  border="0"  rules="none" style="border-collapse:collapse;" width="100%" >
				<tr>
				<td colspan=7 align="center">		
				<%if(request.getAttribute("currentRow")!=null && (request.getAttribute("currentRow").equals("0") || request.getAttribute("currentRow").equals("1"))){%>
				<html:button property="previous" title="Previous Asset" styleClass="btext" value="Prev" onclick="prevfunc()" disabled="true"/>
				<%}else {%>
				<html:button property="previous" title="Previous Asset" styleClass="btext" value="Prev" onclick="prevfunc()"/><%}%>
				<%if(request.getAttribute("totalRecords")!=null && request.getAttribute("totalRecords").equals(request.getAttribute("currentRow"))){%>
				<html:button property="next" title="Next Asset" styleClass="btext" value="Next" onclick="nextfunc()" disabled="true"/>
				<%}else{%>
				<html:button property="next" title="Next Asset" styleClass="btext" value="Next" onclick="nextfunc()"/>
				<%}%>
			</td>
			<% if(request.getAttribute("currentRow")!=null && request.getAttribute("totalRecords")!=null && !request.getAttribute("currentRow").equals("null") && !request.getAttribute("totalRecords").equals("null"))
			{%>
			<td  align="center" colspan=2 style="btext"><font color="#8A9FCD">
				Page:<%= request.getAttribute("currentRow") %>
				/<%= request.getAttribute("totalRecords") %></font>
				
			</td>
			<%} %>
			<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
		
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<td  align="center" colspan=6>
				  <html:button property="delete" title="Delete the Fields" styleClass="btext" 
				  value="Remove" onclick="removeSubCompHp(this)"/>
			    <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="savefunc()"/>
	    		<html:reset title="Close the Window" styleClass="btext" value="Close" onclick="closeFunc()"/>	    
				</td>
				</tr>
				</table>
			</td>
	</tr>	
<input type="hidden" name="subCompCode" value="hpCode">
 </html:form>
  </c:if>






<c:if test="${sessionScope.assetsubCompParams=='PwsPumpingMain' || sessionScope.assetsubCompParams=='CpwsPumpingMain'}">

    	 
    	 <tr bgcolor="#8A9FCD" class="gridLabel" >
        <td colspan=4 align=left ><b>Component Name:&nbsp;<%=assetName%>-PIPELINE-PUMPINGMAIN</b>
        </td>
        </tr>
		
        <html:form action="Asset.do?mode=Submit">
	 <nested:iterate id="ASSETPIPELINE_LIST" property="assetPipeLine" indexId="ndx">
	  <tr >
			<td align=left class="textborder"><bean:message key="app.pmCode"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="pmCode" maxlength="24" styleClass="mytext" style="width:160px" readonly="true"/>
				
				<nested:text name="ASSETPIPELINE_LIST"  property="assetCode" styleClass="mytext" 
				style="width:0px" />
				<nested:hidden name="ASSETPIPELINE_LIST" property="pmLocation"/>
				<nested:hidden name="ASSETPIPELINE_LIST" property="habCode"/>  
			</td>
			<td align=left class="textborder"><bean:message key="app.nopipe"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="noOfPipes" styleClass="mytext" maxlength="4" style="width:130px" onkeypress="return decimalsOnly()"  readonly="true"/>
				<html:button  property="addMat" value="..." styleClass="btext"
					 onclick='<%= "javascript: fnPickPipeMat(\" + ndx +\")"%>' />
			</td>
		  </tr>
			
		<tr >
			<td align=left class="textborder"><bean:message key="app.pmAvNo"/>&nbsp;&nbsp;
			</td>
				<td  class="textborder" align=center >
				<html:text name="ASSETPIPELINE_LIST" property="pmAvNo" styleClass="mytext"  maxlength="5" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			<td align=left class="textborder"><bean:message key="app.pmSvNo"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
					<nested:text name="ASSETPIPELINE_LIST" property="pmSvNo" maxlength="3" styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		</tr>
		
		<tr >
			<td align=left class="textborder"><bean:message key="app.pmScrvNo"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="pmScrvNo" maxlength="3" styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			
			
			<td align=left class="textborder"><bean:message key="app.pmRvNo"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="pmRvNo" maxlength="4" styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder"><bean:message key="app.pmZeroVelocityValve"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="pmZeroVelocityValve" maxlength="7" styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		
			<td align=left class="textborder"><bean:message key="app.pmAirCusionValve"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="pmAirCusionValve" maxlength="7" styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		</tr>
		<tr >
			<td align=left class="textborder">Non Return Valves&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="pmNonReturnValve" maxlength="7" styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		</tr>
			
       </table>
	   </nested:iterate>
	   </td></tr>
	   
	   <tr><td colspan="4" height="30px" valign="bottom">&nbsp;</td></tr>
	 
		<tr  class="gridLabel" ><td colspan="4" ><hr color="#8A9FCD"></td></tr>
	
	    <tr align="center">
			<td  align="left" colspan=2 >
				<table  class="row" bordercolor= "#8A9FCD"  border="0"  rules="none" style="border-collapse:collapse;" width="100%" >
				<tr>
				<td>			
				<html:button property="first" title="First Asset" styleClass="btext" value="First" onclick="first1()"/>		
				<html:button property="previous" title="Previous Asset" styleClass="btext" value="Prev" onclick="prevfunc()"/>
				<html:button property="next" title="Next Asset" styleClass="btext" value="Next" onclick="nextfunc()"/>
				<html:button property="last" title="Last Asset" styleClass="btext" value="Last" onclick="last1()"/>
				
			</td>
			
			<% if(request.getAttribute("currentRow")!=null && request.getAttribute("totalRecords")!=null && !request.getAttribute("currentRow").equals("null") && !request.getAttribute("totalRecords").equals("null"))
			{%>
			<td  align="center" colspan=2 style="btext"><font color="#8A9FCD">
				Page:<%= request.getAttribute("currentRow") %>
				/<%= request.getAttribute("totalRecords") %></font>
				
			</td>
			<%} %>
			<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<td  align="right" colspan=2>
				 <html:button property="add" title="Add the Fields" styleClass="btext" value="Add New" 
				 onclick="javascript: fnPickNewHabitations()"/>
				  <html:button property="delete" title="Delete the Fields" styleClass="btext" 
				  value="Remove" onclick="removeSubComp(this)" ></html:button>
					
				<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="savefunc()"/>
	    		<html:reset title="Close the Window" styleClass="btext" value="Close" onclick="closeFunc()"/>	    
				</td>
				</tr>
				</table>
			</td>
	</tr>	
	  <input type="hidden" name="subCompCode" value="pmCode">
         </html:form>
          </c:if>
 <c:if test="${sessionScope.assetsubCompParams=='GravityMain'}">
        <tr bgcolor="#8A9FCD" class="gridLabel" >
        <td colspan=4 align=left ><b>Component Name:&nbsp;<%=assetName%>-PIPELINE-GRAVITY MAIN</b>
        </td>
        </tr>
     
 	<html:form action="Asset.do?mode=Submit">

  		 <nested:iterate id="ASSETPIPELINE_LIST" property="assetPipeLine" indexId="ndx">
		
          <tr>
		 <td align=left class="textborder"><bean:message key="app.gravitymain_code"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
			<nested:text name="ASSETPIPELINE_LIST"  property="assetCode" styleClass="mytext" 
				style="width:0px" />
				<nested:text name="ASSETPIPELINE_LIST"  property="gravitymain_code"   styleClass="mytext" style="width:160px" readonly="true"/>
			</td>
			</tr>
			<tr>
		<nested:hidden name="ASSETPIPELINE_LIST" property="habCode"/>
		 	 <td align=left class="textborder"><bean:message key="app.airvalve_no"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="airvalve_no" maxlength="5"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		 	
			<td align=left class="textborder"><bean:message key="app.nopipe"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="noOfPipes" styleClass="mytext" maxlength="4" style="width:130px" onkeypress="return decimalsOnly()" readonly="true"/>
				<html:button  property="addMat" value="..." styleClass="btext"
					 onclick='<%= "javascript: fnPickPipeMat(\" + ndx +\")"%>' />
			</td>
			</tr>
			<tr>
			 <td align=left class="textborder"><bean:message key="app.scourevalve"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="scourevalve" maxlength="3"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
		
			 <td align=left class="textborder"><bean:message key="app.lengths"/>&nbsp;&nbsp;
			</td>
			
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="lengths" maxlength="8"  styleClass="mytext" style="width:150px"/>
			</td>
			 </tr>
			<tr>
			<td align=left class="textborder"><bean:message key="app.reflexvalve"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="reflexvalve" maxlength="4"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			<nested:hidden name="ASSETPIPELINE_LIST"  property="gravitymain_location"/>
			<td align=left class="textborder"><bean:message key="app.sluicevalve"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="sluicevalve" maxlength="4"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			 
			</tr>
			<tr>
			<td align=left class="textborder">No of Zero Velocity Valves&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="zeroVelocityValve" maxlength="4"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			<td align=left class="textborder">No of Air Cushion Valves&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="airCushionValve" maxlength="4"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
			<tr>
			<td align=left class="textborder">No of Non Return Valves&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="nonReturnValve" maxlength="4"  styleClass="mytext" style="width:150px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
			
</nested:iterate>
	
	</td>
	</tr>
	
	<tr><td colspan="4" height="30px" valign="bottom">&nbsp;</td></tr>
	 
	<tr  class="gridLabel" ><td colspan="4" ><hr color="#8A9FCD"></td></tr>
	
	<tr>
				<td  align="left" colspan="2">
				<html:button property="first" title="First Asset" styleClass="btext" value="First" onclick="first1()"/>		
				<html:button property="previous" title="Previous Asset" styleClass="btext" value="Prev" onclick="prevfunc()"/>
				<html:button property="next" title="Next Asset" styleClass="btext" value="Next" onclick="nextfunc()"/>
				<html:button property="last" title="Last Asset" styleClass="btext" value="Last" onclick="last1()"/>
				
			</td>
			
			<% if(request.getAttribute("currentRow")!=null && request.getAttribute("totalRecords")!=null && !request.getAttribute("currentRow").equals("null") && !request.getAttribute("totalRecords").equals("null"))
			{%>
			<td  align="center" ><font color="#8A9FCD">
				Page:<%= request.getAttribute("currentRow") %>
				/<%= request.getAttribute("totalRecords") %></font>
				
			</td>
			<%} %>
			<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<td  align="right" colspan="2">
				 <html:button property="add" title="Add the Fields" styleClass="btext" value="Add New" onclick="javascript: fnPickNewHabitations()"/>
				  <html:button property="delete" title="Delete the Fields" styleClass="btext" 
				  value="Remove" onclick="removeSubComp(this)"/>
			    <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="savefunc(this)"/>
	    		<html:reset title="Close the Window" styleClass="btext" value="Close" onclick="closeFunc()"/>
				</td>
	   </tr>
	
   </table>
   <input type="hidden" name="subCompCode" value="gravitymain_code">
   </html:form>
  </c:if>
   <%
	}
	catch(Exception e)
   {
	   System.out.println("Exception  is "+e);
   }
   %>
   <c:if test="${sessionScope.assetsubCompParams=='Pumpsets'}">
    <tr bgcolor="#8A9FCD" class="gridLabel" >
        <td colspan=4 align=left ><b>Component Name:&nbsp;<%=assetName%>-SOURCE-PUMPSETS</b>
        </td>
    </tr>	
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="5">
        <html:form action="Asset.do?mode=Submit">
	 	<nested:iterate id="ASSETPUMPSET_LIST" property="assetPumpSets" indexId="ndx">
		<nested:hidden name="ASSETPUMPSET_LIST"  property="assetCode" />
	 <tr>
	 	<td align=left class="textborder" ><bean:message key="app.pumpCode"/>&nbsp;&nbsp;
		</td>
		<td  class="textborder" align=left >
				<nested:text name="ASSETPUMPSET_LIST" property="pumpCode" maxlength="24" styleClass="mytext" style="width:160px" readonly="true"/>
		</td>
	 </tr>
			<tr>
			<nested:hidden name="ASSETPUMPSET_LIST" property="habCode"/>
			<td align=left class="textborder" >
			<bean:message key="app.pumpLocation"/>&nbsp;&nbsp;
			</td>
			<td>
			<html:text name="ASSETPUMPSET_LIST" property="pumpLocation" styleClass="mytext"  maxlength="50" style="width:160px" onkeypress="return upperOnly()"/>
			</td>
		</tr>
		<tr>		
			<td align=left class="textborder" >
			<bean:message key="app.pumpMake"/>&nbsp;&nbsp;
			</td>
			<td>
			<html:text name="ASSETPUMPSET_LIST" property="pumpMake" styleClass="mytext"  maxlength="25" style="width:160px" onkeypress="return upperOnly()"/>
			</td>
			<td align=left class="textborder" >
			<bean:message key="app.pumpType"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="pumpType"  styleClass="mytext" style="width:160px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Centrifugal">Centrifugal</html:option>
				<html:option value="Submersible">Submersible</html:option>
				<html:option value="EjectTo">EjectTo</html:option>
				<html:option value="VerticalTurbine">Vertical Turbine</html:option>
				<html:option value="Folder">Folder</html:option>
				<html:option value="Others">Others</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<td align=left class="textborder" >
			<bean:message key="app.pumpCapacity"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpCapacity"  styleClass="mytext" style="width:160px" readonly="false" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			<td align=left class="textborder" >
			<bean:message key="app.pumpYearOfCommissioning"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpYearOfCommissioning" maxlength="4" styleClass="mytext" style="width:160px" readonly="false" onkeypress="numeralsOnly()"/>
			</td>
		</tr>
		<tr>
			<td align=left class="textborder" >
			<bean:message key="app.pumpHoursRunningPerDay"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpHoursRunningPerDay" maxlength="2" styleClass="mytext" style="width:160px" readonly="false" onkeypress="return numeralsOnly()"/>
			</td>
			<td align=left class="textborder" >
			<bean:message key="app.pumpUsage"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="pumpUsage"  styleClass="mytext" style="width:160px">
				<html:option value="">SELECT...</html:option>
				<html:option value="S">Stand By</html:option>
				<html:option value="R">Regular</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<td align=left class="textborder" >
			<bean:message key="app.pumpDesignedHead"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpDesignedHead"  styleClass="mytext" style="width:160px" readonly="false" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			<td align=left class="textborder" >
			<bean:message key="app.pumpDesignedLpm"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpDesignedLpm"  styleClass="mytext" style="width:160px" readonly="false" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			
		</tr>
		<tr>
		<html:hidden name="ASSETPUMPSET_LIST" property="pumpControlPanel"/>
			<!-- <td align=left class="textborder" >
			<bean:message key="app.pumpControlPanel"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="pumpControlPanel"  styleClass="mytext" style="width:160px">
				<html:option value="">SELECT...</html:option>
				<html:option value="YES">YES</html:option>
				<html:option value="NO">NO</html:option>
				</html:select>
			</td>
		
				 -->
			
			<td align=left class="textborder" ><bean:message key="app.pumpFeeder"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="pumpFeeder"  styleClass="mytext" style="width:160px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Rural">Rural</html:option>
				<html:option value="Urban">Urban</html:option>
				<html:option value="Dedicated">Dedicated</html:option>
				</html:select>
			</td>
		
			
			<td align=left class="textborder" >
			<bean:message key="app.pumpHoursOfPowerAvailability"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpHoursOfPowerAvailability"  styleClass="mytext" style="width:160px" readonly="false" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			
			
			
		</tr>
		<tr>
			<html:hidden name="ASSETPUMPSET_LIST" property="pumpFeasiblityOfGettingUrbanLine"/>
			<html:hidden name="ASSETPUMPSET_LIST" property="pumpAppCostOfUrbanFeeder"/>
			<html:hidden name="ASSETPUMPSET_LIST" property="pumpDistanceFromWhereUrbanLineCanBeHad"/>						
			<!-- <td align=left class="textborder" >
			<bean:message key="app.pumpFeasiblityOfGettingUrbanLine"/>&nbsp;&nbsp;
			</td>
			<!--  
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpFeasiblityOfGettingUrbanLine" maxlength="24" styleClass="mytext" style="width:160px" readonly="false"/>
			</td>
			
			-->
			<!--  
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="pumpFeasiblityOfGettingUrbanLine"  styleClass="mytext" style="width:160px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
				</html:select>
			</td>
			
			<td align=left class="textborder" >
			<bean:message key="app.pumpAppCostOfUrbanFeeder"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpAppCostOfUrbanFeeder"  styleClass="mytext" style="width:160px" readonly="false" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			
		</tr>
		<tr>
			<td align=left class="textborder" >
			<bean:message key="app.pumpDistanceFromWhereUrbanLineCanBeHad"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpDistanceFromWhereUrbanLineCanBeHad"  styleClass="mytext" style="width:160px" readonly="false" onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
			
			 -->
			<td align=left class="textborder" ><bean:message key="app.pumpLowVoltabeProblems"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="pumpLowVoltageProblems" styleClass="mytext"  style="width:160px" onkeypress="upperOnly()">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">Yes</html:option>
				<html:option value="N">No</html:option>
				</html:select>
			</td>
		
			
			<td align=left class="textborder" >
			<bean:message key="app.pumpRemarks"/>&nbsp;&nbsp;
			</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="pumpSuggestions" maxlength="50" styleClass="mytext" style="width:160px" readonly="false" onkeypress="upperOnly()"/>
			</td>
			
		
		</tr>
		<tr>
		<td align=left class="textborder" >Generator Existing&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="generatorExisting" styleClass="mytext"  style="width:160px" onkeypress="upperOnly()" onchange="showGenerator()">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">Yes</html:option>
				<html:option value="N">No</html:option>
				</html:select>
			</td>
		</tr>

			<tr>
		<!-- added by swapna on 20-01-2012 -->
		<td width="100" class="textborder">Latitude-N</td>
			 <td   >
			<nested:text  name="ASSETPUMPSET_LIST"  property="latitude" style="width:160px" 
						styleClass="mytext"  maxlength="10" onkeypress="decimalsOnly()"/> 
			</td>
			<td width="100" class="textborder">Longitude-E</td>
			 <td   >
			<nested:text  name="ASSETPUMPSET_LIST" property="longitude" style="width:160px" 
						styleClass="mytext"  maxlength="10" onkeypress="decimalsOnly()" /> 
			</td>
					</tr>
					<tr>
					<td width="100" class="textborder">Elevation</td>
			 <td >
			<nested:text  name="ASSETPUMPSET_LIST" property="elevation" style="width:160px" 
						styleClass="mytext"  maxlength="10"  onkeypress="decimalsOnly()"/> 
			</td>
			<td width="100" class="textborder">Waypoint</td>
			 <td  >
			<nested:text  name="ASSETPUMPSET_LIST" property="waypoint" style="width:160px" 
						styleClass="mytext"  maxlength="4" onkeypress="decimalsOnly()"/> 
			</td>
					</tr>
		<tr>
		<td colspan="4">
		<div id="generator" style="display:none">
		<table width="100%" border="0" cellspacing="5">
		<tr>
			<td align=left class="textborder">Generator Capacity(in KVA)</td>
			<td>
			<nested:text name="ASSETPUMPSET_LIST" property="generatorCapacity" maxlength="50" styleClass="mytext" style="width:160px" readonly="false" onkeypress="return blockNonNumbers(this, event, true, false);"/>
			</td>
		<td align=left class="textborder" >Generator Working
			</td>
			<td  class="textborder" align=left >
				<html:select name="ASSETPUMPSET_LIST" property="generatorWorking" styleClass="mytext"  style="width:160px" onkeypress="upperOnly()">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">Yes</html:option>
				<html:option value="N">No</html:option>
				</html:select>
			</td>
			</tr>
		
			
			
			</table></div>
		</td></tr>
	   </nested:iterate>
	   <input type="hidden" name="subCompCode" value="pumpCode">
	  
	  <tr><td colspan="4" height="30px" valign="bottom">
	       <hr color="#8A9FCD"></td>
	  </tr>
		
	    <tr >
			<td  align="left" colspan=4 >
				<table  class="row" bordercolor= "#8A9FCD"  border="0"  rules="none" style="border-collapse:collapse;" width="100%" >
				<tr>
				<td>			
				<html:button property="first" title="First Asset" styleClass="btext" value="First" disabled="false" onclick="first1()"/>		
				<html:button property="previous" title="Previous Asset" styleClass="btext" value="Prev" onclick="prevfunc()"/>
				<html:button property="next" title="Next Asset" styleClass="btext" value="Next" onclick="nextfunc()"/>
				<html:button property="last" title="Last Asset" styleClass="btext" value="Last" disabled="false" onclick="last1()"/>
				
			</td>
			<% if(request.getAttribute("currentRow")!=null && request.getAttribute("totalRecords")!=null && !request.getAttribute("currentRow").equals("null") && !request.getAttribute("totalRecords").equals("null"))
			{%>
			<td  align="center" colspan=2 style="btext"><font color="#8A9FCD">
				Page:<%= request.getAttribute("currentRow") %>
				/<%= request.getAttribute("totalRecords") %></font>
				
			</td>
			<%} %>
			<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<td  align="right" colspan=2>
				 <html:button property="add" title="Add the Fields" styleClass="btext" value="Add New" 
				 onclick="javascript: fnPickNewHabitations()" />
				  <html:button property="delete" title="Delete the Fields" styleClass="btext" 
				  value="Remove" onclick="removeSubComp(this)"/>
			    <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="savefunc()"/>
	    		<html:reset title="Close the Window" styleClass="btext" value="Close" onclick="closeFunc()"/>	    
				</td>
				</tr>
				</table>
				</td>
				</tr>
				</html:form>
							
				</table>
			</td>
	</tr>	
         
          </c:if>
          
          <c:if test="${sessionScope.assetsubCompParams=='Distribution'}">
       
     <tr bgcolor="#8A9FCD" class="gridLabel" >
        <td colspan=4 align=left ><b>Component Name:&nbsp;<%=assetName%>-PIPELINE-DISTRIBUTION</b>
        </td>
      </tr>
 	<html:form action="Asset.do?mode=Submit">

  		 <nested:iterate id="ASSETPIPELINE_LIST" property="assetPipeLine" indexId="ndx">
		
        <tr>
			 <td align=left class="textborder"><bean:message key="app.disCode"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
			<nested:text name="ASSETPIPELINE_LIST"  property="assetCode" styleClass="mytext" 
				style="width:0px" />
			
				
			
				<nested:text name="ASSETPIPELINE_LIST"  property="disCode"   styleClass="mytext" style="width:160px" readonly="true"/>
			</td>
		</tr>
		<!-- <tr>
			<td align=left class="textborder">
		 	
         		<bean:message key="app.selectHabs"/>
		 	</td>
		  	<td align="center">
		 			<nested:text name="ASSETPIPELINE_LIST" property="habCode"  styleClass="mytext" style="width:130px" readonly="true"/>
					<html:button property="addHab" value="..." styleClass="btext"
							 onclick='<%= "javascript: fnPickHabitations(\" + ndx +\")"%>' />
		 	</td>
		</tr> -->
		<tr>
		<nested:hidden name="ASSETPIPELINE_LIST"  property="disLocation"/>
		<nested:hidden name="ASSETPIPELINE_LIST"  property="habCode"/>
		 <!-- <td align=left class="textborder"><bean:message key="app.disLocation"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disLocation"   maxlength="50" styleClass="mytext" style="width:100px" readonly="false" onkeypress="upperOnly()"/>
			</td>
		</tr>
		<tr> -->	
		<td align=left class="textborder"><bean:message key="app.nopipe"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST" property="noOfPipes" styleClass="mytext" maxlength="4" style="width:130px" onkeypress="return decimalsOnly()" readonly="true"/>
				<html:button  property="addMat" value="..." styleClass="btext"
					 onclick='<%= "javascript: fnPickPipeMat(\" + ndx +\")"%>' />
			</td>
			<td align=left class="textborder"><bean:message key="app.disNoOfAirValves"/>&nbsp;&nbsp;
			</td>
			
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disNoOfAirValves" maxlength="3"  styleClass="mytext" style="width:100px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
			
		<tr>
		 	<td align=left class="textborder"><bean:message key="app.disTotalLengthNeeded"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disTotalLengthNeeded"   styleClass="mytext" style="width:150px" readonly="false" onkeyup="extractNumber2(this,9,3,false);" onkeypress="return blockNonNumbers(this, event, true, false);" onblur="calBalanceNeeded()"/>
			</td>
	
			<td align=left class="textborder"><bean:message key="app.disNoOfSluiceValves"/>&nbsp;&nbsp;
			</td>
			
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disNoOfSluiceValves" maxlength="3"  styleClass="mytext" style="width:100px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
			
		<tr>
		 	<td align=left class="textborder"><bean:message key="app.disTotalLengthProvided" />&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disTotalLengthProvided"   styleClass="mytext" style="width:150px" readonly="false" onkeyup="extractNumber2(this,9,3,false);" onkeypress="return blockNonNumbers(this, event, true, false);" onblur="calBalanceNeeded()"/>
			</td>
		
			<td align=left class="textborder"><bean:message key="app.disNoOfScourValves"/>&nbsp;&nbsp;
			</td>
			
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disNoOfScourValves" maxlength="3"  styleClass="mytext" style="width:100px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
			
		<tr>
		 <td align=left class="textborder"><bean:message key="app.disFullVillagesCovered"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<html:select name="ASSETPIPELINE_LIST"  property="disFullVillagesCovered" styleClass="mycombo" style="width:150px" onkeypress="return decimalsOnly()"> 
				<html:option value="">SELECT...</html:option>
				 <html:option value="Y">YES</html:option>
				 <html:option value="N">NO</html:option>
				</html:select>
			</td>
			
			
			<td align=left class="textborder"><bean:message key="app.disNoOfPrivateHouseConnections"/>&nbsp;&nbsp;
			</td>
			
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disNoOfPrivateHouseConnections" maxlength="4"  styleClass="mytext" style="width:100px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
			
			<tr>
		 	<td align=left class="textborder"><bean:message key="app.disBalanceNeeded"/>&nbsp;&nbsp;
			</td>
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disBalanceNeeded"   styleClass="mytext" style="width:150px" readonly="true" onkeyup="extractNumber2(this,9,3,false);" onkeypress="return blockNonNumbers(this, event, true, false);" />
			</td>
		
			<td align=left class="textborder"><bean:message key="app.disNoOfStandPosts"/>&nbsp;&nbsp;
			</td>
			
			<td  class="textborder" align=center >
				<nested:text name="ASSETPIPELINE_LIST"  property="disNoOfStandPosts" maxlength="3"  styleClass="mytext" style="width:100px" onkeypress="return numeralsOnly()"/>
			</td>
			</tr>
				
			
				
			
				
			
				
		
			</tr>
</td></tr></table>
				
</nested:iterate>
	</td>
	</tr>
	
	<tr><td colspan="4" height="30px" valign="bottom">&nbsp;</td></tr>
	 
	<tr  class="gridLabel" ><td colspan="4" ><hr color="#8A9FCD"></td></tr>
	
	
	<tr >
			<td  align="left" colspan=4 >
				<table  class="row" bordercolor= "#8A9FCD"  border="0"  rules="none" style="border-collapse:collapse;" width="100%" >
				<tr>
				<td>			
				<html:button property="first" title="First Asset" styleClass="btext" value="First" disabled="false" onclick="first1()"/>		
				<html:button property="previous" title="Previous Asset" styleClass="btext" value="Prev" onclick="prevfunc()"/>
				<html:button property="next" title="Next Asset" styleClass="btext" value="Next" onclick="nextfunc()"/>
				<html:button property="last" title="Last Asset" styleClass="btext" value="Last" disabled="false" onclick="last1()"/>
				
			</td>
			
			<% if(request.getAttribute("currentRow")!=null && request.getAttribute("totalRecords")!=null && !request.getAttribute("currentRow").equals("null") && !request.getAttribute("totalRecords").equals("null"))
			{%>
			<td  align="center" colspan=2 style="btext"><font color="#8A9FCD">
				Page:<%= request.getAttribute("currentRow") %>
				/<%= request.getAttribute("totalRecords") %></font>
				
			</td>
			<%} %>
			
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<td  align="right" colspan=2>
				 <html:button property="add" title="Add the Fields" styleClass="btext" value="Add New" 
				 onclick="javascript: fnPickNewHabitations()" />
				  <html:button property="delete" title="Delete the Fields" styleClass="btext" 
				  value="Remove" onclick="removeSubComp(this)"/>
			    <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="savefunc()"/>
	    		<html:reset title="Close the Window" styleClass="btext" value="Close" onclick="closeFunc()"/>	    
				</td>
				</tr>
	
   </table>
   <input type="hidden" name="subCompCode" value="disCode">
   </html:form>
  </c:if>
  
   <%@ include file="closeWithMessage2.jsp"%>



