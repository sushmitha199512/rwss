
<%@ include file="/commons/rws_head.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@page import="nic.watersoft.commons.Debug"%>

<%//nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//userid = users.getUserId();
	//System.out.println("user id:"+userid);
	
	
String atype="";
if(request.getParameter("assettype")!=null && !request.getParameter("assettype").equals(""))
{
	 atype=request.getParameter("assettype");
	//System.out.println("asset type:"+atype);
	}

	
	%>
<html:html>
<script language="javaScript">
window.onload = function() {init();}
function init()
{
 // alert("init"); 
  // alert(document.forms[0].assettype.value);
 if(document.forms[0].assettype.value!="")
 { // alert("init1"); 
  if(document.forms[0].assettype.value=="01" || document.forms[0].assettype.value=="02" || document.forms[0].assettype.value=="03" )
  { // alert("init2"); 
	if(document.forms[0].creport[0].checked)
	{
  	document.getElementById('sources').style.display="block";
  	document.getElementById('headworks').style.display="none";
  	document.getElementById('pipelines').style.display="none";
  	document.getElementById('sr.reservoirs').style.display="none";
  	document.getElementById('others').style.display="none";
  	document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[1].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="block";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('sr.reservoirs').style.display="none";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[2].checked)
	{
		document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="block";
	  document.getElementById('sr.reservoirs').style.display="none";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[3].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('sr.reservoirs').style.display="block";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[4].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('sr.reservoirs').style.display="none";
	  document.getElementById('others').style.display="block";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[5].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('sr.reservoirs').style.display="none";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="block";
	}

 }else if(document.forms[0].assettype.value=="09")
 {
  // alert("in direct pumping"+document.forms[0].creport.value);
  if(document.forms[0].creport[0].checked)
	{
  	document.getElementById('sources').style.display="block";
  	document.getElementById('headworks').style.display="none";
  	document.getElementById('pipelines').style.display="none";
  	document.getElementById('others').style.display="none";
  	document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[1].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="block";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[2].checked)
	{
		document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="block";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[3].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('others').style.display="block";
	  document.getElementById('pumpings').style.display="none";
	}
	else if(document.forms[0].creport[4].checked)
	{
	  document.getElementById('sources').style.display="none";
	  document.getElementById('headworks').style.display="none";
	  document.getElementById('pipelines').style.display="none";
	  document.getElementById('others').style.display="none";
	  document.getElementById('pumpings').style.display="block";
	}
 }
  
  }
}
function office1()
{
	if(document.forms[0].district.value != "")
	{
		alert("Choose Either Office Selection Criteria OR Location Selection Criteria");
		document.forms[0].offices.value = "";
	}
	else
	{
		fnCircleChanged();
	}
}
function fnCircleChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data";
	document.forms[0].submit();
}

function fnDivisionChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data";
	document.forms[0].submit();
}
function fnSubdivisionChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data";
	document.forms[0].submit();
}

function dist1()
{
	if(document.forms[0].offices.value != "")
	{
		alert("Choose Either Office Selection Criteria OR Location Selection Criteria");
		document.forms[0].district.value = "";
	}
	else
	{
		funcDistrictChanged();
	}
}
function funcDistrictChanged()
{
document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data";
document.forms[0].submit();
}
function fnMandalChanged()
{ 
	document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data";
	document.forms[0].submit();
}
 function fnAssetStatus()
{
 // alert(" some value");
  if(document.forms[0].assetstatus.value != '')
{
   // alert(document.forms[0].commonfields[0]);
	document.forms[0].commonfields[0].disabled = true;
}
  else{
  
   document.forms[0].commonfields[0].disabled =false;
  }
}

function fnAssetType()
{
    document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data";
	document.forms[0].submit();
}



/*
function fnYearcreation()
{
  //alert("111111:"+document.forms[0].assetstatus.value);
 if(document.forms[0].assetstatus.value=="")
 {
    alert("Please Select Asset Status");
   //alert(document.forms[0].yrcreation.value);
  document.forms[0].yrcreation.value='';
   
  }
}
function fnAssetcost()
{
 // alert(document.forms[0].yrcreation.value);
 if(document.forms[0].yrcreation.value=="")
 {
  alert("Please Select Year Creation");
  //alert(document.forms[0].costasset.value);
 }
}
function fnNofhabs()
{
 // alert(document.forms[0].costasset.value);
 if(document.forms[0].costasset.value=="")
 {
  alert("Please Select Cost of Asset");
  document.forms[0].nofhab.value='';
 }
}
function fnPopben()
{
 // alert(document.forms[0].nofhab.value);
 if(document.forms[0].popben.value=="")
 {
  alert("Please Select No of Habs Benfeted");
  document.forms[0].popben.value='';
 }
}
*/
function disables(value)
{
     // alert("1:"+value);
	var val = value;
	for(var i=0;i<val.length;i++)
	{
		val[i].checked=false;
	}
}
function disables1(value)
{
    //alert("aaaaaaaaa:"+value);
	var val = value;
	
		val.checked=false;
	
}
function enables(value)
{
	var val = value;
	for(var i=0;i<val.length;i++)
	{
		val[i].checked=true;
		val[i].disabled=false;
	}
}
function enables1(value)
{
    //alert("vlaue"+value);
	var val = value;
	val.checked=true;
	val.disabled=false;
	
}
function enableField1()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="block";
document.getElementById('headworks').style.display="block";
document.getElementById('pipelines').style.display="block";
document.getElementById('others').style.display="block";
document.getElementById('pumpings').style.display="block";

 
}
function enableField()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="block";
document.getElementById('headworks').style.display="block";
document.getElementById('pipelines').style.display="block";
document.getElementById('sr.reservoirs').style.display="block";
document.getElementById('others').style.display="block";
document.getElementById('pumpings').style.display="block";


} 
function disableField()
{
 // alert("sssssssssss");
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="block";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('sr.reservoirs').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false

}
function disableField1()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="block";
document.getElementById('pipelines').style.display="none";
document.getElementById('sr.reservoirs').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField2()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="block";
document.getElementById('sr.reservoirs').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField3()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('sr.reservoirs').style.display="block";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField4()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('sr.reservoirs').style.display="none";
document.getElementById('others').style.display="block";
document.getElementById('pumpings').style.display="none";
document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField5()
{
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].srreservoirsfields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('sr.reservoirs').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="block";
document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}///

function disableFielddp()
{
  // alert("sssssssssss");
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="block";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
// document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField1dp()
{
//alert("2");
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="block";
document.getElementById('pipelines').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
// document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField2dp()
{
//alert("3");
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="block";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="none";
// document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}

function disableField4dp()
{
//alert("4");
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('others').style.display="block";
document.getElementById('pumpings').style.display="none";
// document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false
}
function disableField5dp()
{
// alert("5");
disables(document.forms[0].sourcefields);
disables(document.forms[0].headworksfields);
disables(document.forms[0].pipelinefields);
disables(document.forms[0].othersfields);
disables1(document.forms[0].pumpingfields);
document.getElementById('sources').style.display="none";
document.getElementById('headworks').style.display="none";
document.getElementById('pipelines').style.display="none";
document.getElementById('others').style.display="none";
document.getElementById('pumpings').style.display="block";
// document.forms[0].checkall.checked=false;
document.forms[0].creport1[0].checked=false;
document.forms[0].creport1[1].checked=false

}
function selectAllCheckBoxes2()
{
 
         // alert("1");
		if(!(document.getElementById('sources').style.display == 'none' || document.getElementById('headworks').style.display == 'none' || document.getElementById('pipelines').style.display == 'none' || document.getElementById('sr.reservoirs').style.display == 'none' || document.getElementById('others').style.display == 'none' || document.getElementById('pumpings').style.display == 'none'))
		{
		  //alert("2");
		  //alert("src:"+document.forms[0].sourcefields);
		    // alert("hw"+document.forms[0].headworksfields);
			enables(document.forms[0].sourcefields);
			enables(document.forms[0].headworksfields);
			enables(document.forms[0].pipelinefields);
			enables(document.forms[0].othersfields);
			// alert("pump"+document.forms[0].pumpingfields.value);
			enables1(document.forms[0].pumpingfields);
		}
		
		else if(document.getElementById('sources').style.display == 'block')
		{
			 // alert("3");
			enables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('headworks').style.display == 'block')
		{
		   //alert("4");
			disables(document.forms[0].sourcefields);
			enables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('pipelines').style.display == 'block')
		{
			 // alert("5");
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			enables(document.forms[0].pipelinefields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		
		else if(document.getElementById('others').style.display == 'block')
		{	 // alert("7");	
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			enables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('pumpings').style.display == 'block')
		{   // alert("8");
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].othersfields);
			enables1(document.forms[0].pumpingfields);
		}
		
    
}
///
    function selectAllCheckBoxes1()
    {
         // alert("1");
		if(!(document.getElementById('sources').style.display == 'none' || document.getElementById('headworks').style.display == 'none' || document.getElementById('pipelines').style.display == 'none' || document.getElementById('sr.reservoirs').style.display == 'none' || document.getElementById('others').style.display == 'none' || document.getElementById('pumpings').style.display == 'none'))
		{
		  //alert("2");
		  //alert("src:"+document.forms[0].sourcefields);
		    // alert("hw"+document.forms[0].headworksfields);
			enables(document.forms[0].sourcefields);
			enables(document.forms[0].headworksfields);
			enables(document.forms[0].pipelinefields);
			enables(document.forms[0].srreservoirsfields);
			enables(document.forms[0].othersfields);
			// alert("pump"+document.forms[0].pumpingfields.value);
			enables1(document.forms[0].pumpingfields);
		}
		
		else if(document.getElementById('sources').style.display == 'block')
		{
			 // alert("3");
			enables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].srreservoirsfields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('headworks').style.display == 'block')
		{
		   //alert("4");
			disables(document.forms[0].sourcefields);
			enables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].srreservoirsfields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('pipelines').style.display == 'block')
		{
			 // alert("5");
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			enables(document.forms[0].pipelinefields);
			disables(document.forms[0].srreservoirsfields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('sr.reservoirs').style.display == 'block')
		{	 // alert("6");	
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			enables(document.forms[0].srreservoirsfields);
			disables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('others').style.display == 'block')
		{	 // alert("7");	
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].srreservoirsfields);
			enables(document.forms[0].othersfields);
			disables(document.forms[0].pumpingfields);
		}
		else if(document.getElementById('pumpings').style.display == 'block')
		{    //alert("8");
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].srreservoirsfields);
			disables(document.forms[0].othersfields);
			enables1(document.forms[0].pumpingfields);
		}
		
    }
    
    function uncheckAllCheckBoxes1()
    {
			disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].srreservoirsfields);
			disables(document.forms[0].othersfields);
			disables1(document.forms[0].pumpingfields);
    }
    function uncheckAllCheckBoxes2()
    {
     		disables(document.forms[0].sourcefields);
			disables(document.forms[0].headworksfields);
			disables(document.forms[0].pipelinefields);
			disables(document.forms[0].othersfields);
			disables1(document.forms[0].pumpingfields);
    }
function playCheckBoxes()
{
  var button=document.forms[0].checkall.checked;
    if (button==true)
    {
      selectAllCheckBoxes1();
     }
     else
     {
       uncheckAllCheckBoxes1();
     }
  }

//
function playCheckBoxes1()
{
 // alert("in dp");
var button=document.forms[0].checkall.checked;
if (button==true)
{
  selectAllCheckBoxes2();
}
else
{
uncheckAllCheckBoxes2();
}
}
function fnYrcreation()
{
	if((document.forms[0].yrcreation.value).length!=4)
	{
		alert("Please enter correct year format");
		document.forms[0].yrcreation.value='';
		document.forms[0].yrcreation.focus();
	}
	else
	{
		var mydate=new Date();
	  	var year=mydate.getYear();
	  	if(document.forms[0].yrcreation.value<1900 || document.forms[0].yrcreation.value >year)
	  	{
	  		alert("Year must be between 1900 and "+year);
	  		document.forms[0].yrcreation.value='';
		document.forms[0].yrcreation.focus();	  		
	  	}
	}
}
function fnSubmit()
{
 
 if(((document.forms[0].offices.value=="") && (document.forms[0].district.value=="")))
 {
  alert("Circle Or District Required....");
 }
 else if(document.forms[0].assettype.value=="")
 {
  alert("Please Select Asset Type");
 }
 else if(document.forms[0].creport1[0].checked==false && document.forms[0].creport1[1].checked==false)
 {
  alert("Report Type Required:Abstract or Detailed ");
 }
 else
 {
  //alert("a:"+document.forms[0].creport1[0].checked);
   // alert("d:"+document.forms[0].creport1[1].checked);
  document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
   document.forms[0].submit();
 }
  
 /*else if(document.forms[0].assettype.value=="01" || document.forms[0].assettype.value=="02" || document.forms[0].assettype.value=="03")
 {
    
  if((!document.forms[0].creport[0].checked && !document.forms[0].creport[1].checked && !document.forms[0].creport[2].checked && !document.forms[0].creport[3].checked && !document.forms[0].creport[4].checked && !document.forms[0].creport[5].checked && !document.forms[0].creport[6].checked && !document.forms[0].creport[7].checked))
  {
	alert("Report Type Required");
  }
  else
  {
   document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
   document.forms[0].submit();
  }
 }else if(document.forms[0].assettype.value=="09")
  {
    if((!document.forms[0].creport[0].checked && !document.forms[0].creport[1].checked && !document.forms[0].creport[2].checked && !document.forms[0].creport[3].checked && !document.forms[0].creport[4].checked && !document.forms[0].creport[5].checked && !document.forms[0].creport[6].checked))
    {
	 alert("Report Type Required");
    }
  else
   {
   document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
   document.forms[0].submit();
  }
  }
 else if(document.forms[0].assettype.value=="04")
 {
   if(document.forms[0].borewellfields.checked==true)
  {
     document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
  	 document.forms[0].submit();
   }
   else
    {
     alert("Report Type is Required");
    }
  }
  else if(document.forms[0].assettype.value=="05")
  {
    if(document.forms[0].shpfields.checked==true)
    {
   	 document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
  	 document.forms[0].submit();
    }else
    {
     alert("Report Type is Required");
    }
  
  }
  else if(document.forms[0].assettype.value=="06")
  {
   if(document.forms[0].openwellfields.checked==true)
   	{
   	 document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
  	 document.forms[0].submit();
   
    }
   else
    {
     alert("Report Type is Required");
    }
  }
  else if(document.forms[0].assettype.value=="07")
  {
   if(document.forms[0].pondsfields.checked==true)
   {
  	 document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
  	 document.forms[0].submit();
   }else
    {
     alert("Report Type is Required");
    }
  
  }
  else if(document.forms[0].assettype.value=="08")
   {
    var ocheck=document.forms[0].othercheckfields.checked;
    if(ocheck==true)
    {
      document.forms[0].action="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=report";
  	  document.forms[0].submit();
    }
    else{
         alert("Report Type is Required");
 	     } 

  }*/
  
  
  
  }
</script>
<body>
<center>

<html:form action="/AssetFreeFormat.do?">
<table width="80%">
	<caption align="right" class="staticLabel"><b>(Amount in Rs. lakhs)</b></caption>
</table>


<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" ><tr>
		<tr><td class="mycborder">
		<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value=" Asset Free Format Report"/>
<jsp:param name="TWidth" value="780"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>
		<fieldset>
		<legend>Habitation Details</legend>
		 <table  border=0  width="100%">
<tr>
 <td><font color="#000000" face=verdana size=2><B>District</B></font></td>
		<td><html:select property="district" style="width:135px"   onchange="javascript:dist1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		  <logic:present name="districts">
		 <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>

<td><font color="#000000" face=verdana size=2><B>Mandal</B></font></td>
<td><html:select property="mandal" style="width:135px"    styleClass="mycombo" onchange="fnMandalChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
	<logic:present name="mandals">
	<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>

 	<td><font color="#000000" face=verdana size=2><B>Panchayat</B></font></td>
  <td><html:select property="panchayat" style="width:135px"    styleClass="mycombo" onchange="fnMandalChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
	<logic:present name="panchayats">
	<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</td>
</tr>
<tr>
  <td><font color="#000000" face=verdana size=2><B>Village</B></font></td>
	<td><html:select property="village" style="width:135px"    styleClass="mycombo" onchange="fnMandalChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
	<logic:present name="villages">
	<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
</td>
<%//System.out.println("in jsp 1"); %>
<td><font color="#000000" face=verdana size=2><B>HabCode</B></font></td>
		<td><html:select property="habCode" style="width:200px"   styleClass="mycombo" >
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:present name="habitations">
	 <html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	</logic:present>
    	 </html:select>
</td> 
</tr>	 
</table>
</fieldset> 
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" ><tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Office Details</legend>
		 <table  border=0  width="100%">
		 <tr><td><font color="#000000" face=verdana size=2><B>Circle</B></font></td>
		<td> <html:select property="offices" style="width:135px"   onchange="javascript:office1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <%//if(userid.equals("admin") || userid.equals("100000")){%>
			 	<html:option value="all">ALL</html:option> 
<%
//}
 %>		
		 <logic:present name="circles">
		 <html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
<td><font color="#000000" face=verdana size=2><B>Division</B></font></td>
<td><html:select property="division" style="width:135px"    styleClass="mycombo" onchange="fnDivisionChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="divisions">
	<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
<td><font color="#000000" face=verdana size=2><B>Sub Division</B></font></td>
<td><html:select property="subdivision" style="width:135px" styleClass="mycombo" onchange="fnSubdivisionChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="subdivisions">
	<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
</tr>
</TABLE>
</fieldset> 


<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" ><tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Asset Details</legend>
		 <table  border=0  width="100%">
	  <tr>
	  <%//System.out.println("in jsp 2"); %>
	 <td><font color="#000000" face=verdana size=2><B>Asset Type</B></font><FONT COLOR="RED">*</FONT></td>
	 <td><html:select property="assettype" style="width:135px"  onchange="fnAssetType()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		  <logic:present name="assettype">
		 <html:options collection="assettype" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
	</td>
	<%//System.out.println("in jsp 3"); %>
	<td><font color="#000000" face=verdana size=2><B>Asset Name</B></font></td>
	 <td>  <html:text property="assetname" style="width:100px" ></html:text>
	</td>	
	 <td><font color="#000000" face=verdana size=2><B>Year Of Creation(yyyy)</B></font></td>
	 <td><html:select property="yrcreationcond" style="width:50px" onchange="fnYearcreation()" styleClass="mycombo">
	       	<html:option value="&gt;=">&gt;=</html:option>
			<html:option value="&lt;=">&lt;=</html:option>
			<html:option value="=">=</html:option>
			<html:option value="&gt;">&gt;</html:option>
			<html:option value="&lt;">&lt;</html:option>
		   </html:select></td><td>
          <html:text property="yrcreation" style="width:75px" onkeypress="return numeralsOnly()" onchange="fnYrcreation()" maxlength="4"></html:text>
	</td>		 
	
	<td><font color="#000000" face=verdana size=2><B>Cost Of Asset</B></font></td>
	 <td><html:select property="costassetcond" style="width:50px"  styleClass="mycombo">
		 <html:option value="&gt;=">&gt;=</html:option>
		 <html:option value="&lt;=">&lt;=</html:option>
		 <html:option value="=">=</html:option>
		 <html:option value="&gt;">&gt;</html:option>
		 <html:option value="&lt;">&lt;</html:option>
    	 </html:select></td>
    <td>
     <html:text property="costasset"  style="width:75px" onkeypress="return numeralsOnly();" maxlength="5" ></html:text>
	</td>	
	</tr>
	<tr> 	
	 
	
	<td><font color="#000000" face=verdana size=2><B>Asset Status</B></font></td>
	<%if(atype!=null && !atype.equals("")&& atype.equals("01") || atype.equals("02") || atype.equals("03") || atype.equals("09")) {%>
	<td><html:select property="assetstatus" style="width:135px" onchange="fnAssetStatus()"  styleClass="mycombo">
	       	<html:option value="">SELECT...</html:option>
	       	<html:option value="1">WORKING</html:option>
			<html:option value="2">NOT WORKING</html:option>
			<html:option value="3">DRIED</html:option>
			<html:option value="4">SEASONAL</html:option>
			<html:option value="5">CONDEMED</html:option>
    	 </html:select>	 
   
	</td><%} else if(atype!=null && !atype.equals("")&& atype.equals("04") || atype.equals("05") || atype.equals("06") || atype.equals("07") || atype.equals("08")){ %>
	    <td><html:select property="assetstatus" style="width:135px" onchange="fnAssetStatus()"  styleClass="mycombo">
	       	<html:option value="">SELECT...</html:option>
	       	<html:option value="1">WORKING</html:option>
			<html:option value="2">NOT WORKING</html:option>
			</html:select>	</td>
	<%} else {%>
	
	    <td><html:select property="assetstatus" style="width:135px" onchange="fnAssetStatus()"  styleClass="mycombo">
	       	<html:option value="">SELECT...</html:option>
	       	</html:select></td>
	 
	<%} %>
	  <td><font color="#000000" face=verdana size=2><B>Location</B></font></td>
	   <td> <html:text property="location" style="width:100px" ></html:text>
	</td>	
	
    <td><font color="#000000" face=verdana size=2><B>No Of Habs benefited</B></font></td>
	 <td> <html:select property="nofhabcond" style="width:50px"   styleClass="mycombo">
		    <html:option value="&gt;=">&gt;=</html:option>
			<html:option value="&lt;=">&lt;=</html:option>
			<html:option value="=">=</html:option>
			<html:option value="&gt;">&gt;</html:option>
			<html:option value="&lt;">&lt;</html:option>
    	 </html:select>
    	 </td>
    	 <td>
     <html:text property="nofhab" size="2" style="width:75px" onkeypress="return numeralsOnly()" maxlength="4"></html:text>
	</td>	
	 	
	<td><font color="#000000" face=verdana size=2><B>Population benefited</B></font></td>
	 <td> <html:select property="popbencond" style="width:50px"    styleClass="mycombo">
		 	<html:option value="&gt;=">&gt;=</html:option>
			<html:option value="&lt;=">&lt;=</html:option>
			<html:option value="=">=</html:option>
			<html:option value="&gt;">&gt;</html:option>
			<html:option value="&lt;">&lt;</html:option>
    	 </html:select>
    	 </td>
    	 <td>
     <html:text property="nofhab" size="2" style="width:75px" onkeypress="return numeralsOnly()" maxlength="6"></html:text>
	</td>	
   </tr>
	</table>
	</fieldset>

<%
if(atype!=null && atype.equals("01") || atype.equals("02") || atype.equals("03"))
{
  %>
	<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components

<table>
<tr><td><input type="radio" name="creport" value="source" onclick="disableField()"><font color="#000000" face=verdana size=2>SOURCE</td></tr>
<tr><td><input type="radio" name="creport" value="headworks" onclick="disableField1()"><font color="#000000" face=verdana size=2>HEAD WORKS</td></tr>
<tr><td><input type="radio" name="creport" value="pipelines" onclick="disableField2()"><font color="#000000" face=verdana size=2>PIPELINES</td></tr>
<tr><td><input type="radio" name="creport" value="srreservoirs" onclick="disableField3()"><font color="#000000" face=verdana size=2>SR.RESERVOIRS</td></tr>
<tr><td><input type="radio" name="creport" value="others" onclick="disableField4()"><font color="#000000" face=verdana size=2>OTHERS</td></tr>
<tr><td><input type="radio" name="creport" value="pumping" onclick="disableField5()"><font color="#000000" face=verdana size=2>PUMPING</td></tr>
</table>
</td>    
<td rowspan="3">
<table>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" disabled="true" checked><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" disabled="true" checked><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" disabled="true" checked><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>

<tr>
<td class="mycborder" colspan="3">
<div id="sources">
	<INPUT type="checkbox" name="sourcefields" value="subsurface" ><font color="#000000" face=verdana size=1>SubSurface Source</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="surface" ><font color="#000000" face=verdana size=1>Surface Source</font>
	
</div>

<div id="headworks">
	<INPUT type="checkbox" name="headworksfields" value="rwc" ><font color="#000000" face=verdana size=1>Raw Water Collection Well</font>&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="sstank" ><font color="#000000" face=verdana size=1>SS Tank</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="ssfilter" ><font color="#000000" face=verdana size=1>SS Filters</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="headworksfields" value="rsfilter" ><font color="#000000" face=verdana size=1>RS Filters</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="sump" ><font color="#000000" face=verdana size=1>Sump</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="ftp" ><font color="#000000" face=verdana size=1>Foot Path Bridge</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="pumphouse" ><font color="#000000" face=verdana size=1>Pump House</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="watchman" ><font color="#000000" face=verdana size=1>Watch Man Quarter</font>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="headworksfields" value="cwc" ><font color="#000000" face=verdana size=1>Clear Water Collection Well</font>&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="mfilter" ><font color="#000000" face=verdana size=1>Micro Filter</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="roplants" ><font color="#000000" face=verdana size=1>Ro Plants</B></font>&nbsp;&nbsp;

</div>
<div id="pipelines">
	<INPUT type="checkbox" name="pipelinefields" value="pumpingmain" ><font color="#000000" face=verdana size=1>Pumping Main</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="pipelinefields" value="gravitymain" ><font color="#000000" face=verdana size=1>Gravity Main</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="pipelinefields" value="distribution" ><font color="#000000" face=verdana size=1>Distribution</font>&nbsp;&nbsp;
</div>
<div id="sr.reservoirs">
	<INPUT type="checkbox" name="srreservoirsfields" value="ohsr" ><font color="#000000" face=verdana size=1>Ohsr</font>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="srreservoirsfields" value="ohbr" ><font color="#000000" face=verdana size=1>Ohbr</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<INPUT type="checkbox" name="srreservoirsfields" value="glsr" ><font color="#000000" face=verdana size=1>Glsr</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="srreservoirsfields" value="glbr" ><font color="#000000" face=verdana size=1>Glbr</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="srreservoirsfields" value="bpt" ><font color="#000000" face=verdana size=1>Bpt</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="srreservoirsfields" value="cisterns" ><font color="#000000" face=verdana size=1>Cisterns</font>&nbsp;&nbsp;
</div>
<div id="others">
	<INPUT type="checkbox" name="othersfields" value="miscellaneous" ><font color="#000000" face=verdana size=1>Miscellaneous</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="othersfields" value="chlorination" ><font color="#000000" face=verdana size=1>Chlorination</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="othersfields" value="oandm" ><font color="#000000" face=verdana size=1>OandM</font>&nbsp;&nbsp;
</div>
<div id="pumpings">
	<INPUT type="checkbox" name="pumpingfields" value="pumpsets" ><font color="#000000" face=verdana size=1>Pumpsets</font>&nbsp;&nbsp;
</div>

</td></tr>

<td colspan="3" align="center">
		 <%// if(userid.equals("admin") || userid.equals("100000")){%>
	<INPUT type="checkbox" name="checkall" value="true" onclick="playCheckBoxes()"><font color="indigo" face="verdana" size=2><B>Check All</B></font></td>
<tr>
<td><input type="radio" name="creport1" value="abstract" ><B><font color="#000000" face=verdana size=2>Abstract Report</font></B></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>


<%
//}
 %>

</table>
<tr><td >
<table>
<tr><td><input type="radio" name="creport" value="detailed" onclick="enableField()"><font color="#000000" face=verdana size=2>Subcomponents List</font></td></tr>
</table></td>

</tr></table>

</fieldset>
</td></tr></table>
<%  }

else if(atype!=null && atype.equals("04")) { %>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components</B></font>

<table>
<tr><td><input type="radio" name="creport" value="borewells" ><font color="#000000" face=verdana size=2>BORE WELLS</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" checked disabled="true" ><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" checked disabled="true"><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" checked disabled="true"><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" checked disabled="true"><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" checked disabled="true"><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>
<tr>
<td class="mycborder" colspan="3">
<div id="borewells">
	<INPUT type="checkbox" name="borewellfields" value="borewells" ><font color="#000000" face=verdana size=1>Bore Wells</font>&nbsp;
</div>
</td></tr>
<tr>
<td><input type="radio" name="creport1" value="abstract" ><b><font color="#000000" face=verdana size=2>Abstract Report</font></b></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>
</table>
</td></tr></table>
</td></tr></table>
<%} else if(atype!=null && atype.equals("05")) {%>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components

<table>
<tr><td><input type="radio" name="creport" value="shallowhandpumps" onclick=""><font color="#000000" face=verdana size=2>SHALLOW HANDPUMPS</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" disabled="true" checked><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" disabled="true" checked><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" disabled="true" checked><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>
<tr>
<td class="mycborder" colspan="3">
<div id="sources">
	<INPUT type="checkbox" name="shpfields" value="shallowhandpumps" ><font color="#000000" face=verdana size=1>Shallow Handpumps</font>&nbsp;
</div>
</td></tr>
<tr>
<td><input type="radio" name="creport1" value="abstract" ><b><font color="#000000" face=verdana size=2>Abstract Report</font></b></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>
</table>
</td></tr></table>
</td></tr></table>
<%} else if(atype!=null && atype.equals("06")){%>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components

<table>
<tr><td><input type="radio" name="creport" value="openwells" ><font color="#000000" face=verdana size=2>OPEN WELLS</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" disabled="true" checked><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" disabled="true" checked><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" disabled="true" checked><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>
<tr>
<td class="mycborder" colspan="3">
<div id="sources">
	<INPUT type="checkbox" name="openwellfields" value="openwells" ><font color="#000000" face=verdana size=1>Open Wells</font>&nbsp;
</div>
</td></tr>
<tr>
<td><input type="radio" name="creport1" value="abstract" ><b><font color="#000000" face=verdana size=2>Abstract Report</font></b></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>
</table>
</td></tr></table>
</td></tr></table>


<%} else if(atype!=null && atype.equals("07")){%>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components

<table>
<tr><td><input type="radio" name="creport" value="ponds" onclick=""><font color="#000000" face=verdana size=2>PONDS</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" disabled="true" checked><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" disabled="true" checked><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" disabled="true" checked><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>
<td class="mycborder" colspan="3">
<div id="sources">
	<INPUT type="checkbox" name="pondsfields" value="ponds" ><font color="#000000" face=verdana size=1>Ponds</font>&nbsp;
</div>
</td></tr>
<tr>
<td><input type="radio" name="creport1" value="abstract" ><b><font color="#000000" face=verdana size=2>Abstract Report</font></b></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>
</table>
</td></tr></table>
</td></tr></table>


<%}else if(atype!=null && atype.equals("08")){%>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components

<table>
<tr><td><input type="radio" name="creport" value="otherscheck" ><font color="#000000" face=verdana size=2>OTHERS</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" disabled="true" checked><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" disabled="true" checked><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" disabled="true" checked><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>
<td class="mycborder" colspan="3">
<div id="sources">
	<INPUT type="checkbox" name="othercheckfields" value="otherscheck" ><font color="#000000" face=verdana size=1>Others</font>&nbsp;
</div>
</td></tr>
<tr>
<td><input type="radio" name="creport1" value="abstract" ><b><font color="#000000" face=verdana size=2>Abstract Report</font></b></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>
</table>
</td></tr></table>
</td></tr></table>


<%} else if( atype.equals("09")){ %>
	<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Asset Components

<table>
<tr><td><input type="radio" name="creport" value="source" onclick="disableFielddp()"><font color="#000000" face=verdana size=2>SOURCE</td></tr>
<tr><td><input type="radio" name="creport" value="headworks" onclick="disableField1dp()"><font color="#000000" face=verdana size=2>HEAD WORKS</td></tr>
<tr><td><input type="radio" name="creport" value="pipelines" onclick="disableField2dp()"><font color="#000000" face=verdana size=2>PIPELINES</td></tr>

<tr><td><input type="radio" name="creport" value="others" onclick="disableField4dp()"><font color="#000000" face=verdana size=2>OTHERS</td></tr>
<tr><td><input type="radio" name="creport" value="pumping" onclick="disableField5dp()"><font color="#000000" face=verdana size=2>PUMPING</td></tr>
</table>
</td>
<td rowspan="3">
<table>  
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="AssetStatus" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Status</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="AssetCost" disabled="true" checked><font color="#000000" face=verdana size=1>Asset Cost</font></td>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="YrCreation" disabled="true" checked><font color="#000000" face=verdana size=1>Year Of Creation</font></td>
</tr>
<tr>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="NoofHabs Benefited" disabled="true" checked><font color="#000000" face=verdana size=1>No Of Habs Benefited</font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PopuBenefited" disabled="true" checked><font color="#000000" face=verdana size=1>Population Benefited</font></td>
</tr>
<tr>
<td class="mycborder" colspan="3">
<div id="sources">
	<INPUT type="checkbox" name="sourcefields" value="subsurface" ><font color="#000000" face=verdana size=1>SubSurface Source</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="surface" ><font color="#000000" face=verdana size=1>Surface Source</font>
	
</div>

<div id="headworks">
	<INPUT type="checkbox" name="headworksfields" value="rwc" ><font color="#000000" face=verdana size=1>Raw Water Collection Well</font>&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="sstank" ><font color="#000000" face=verdana size=1>SS Tank</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="ssfilter" ><font color="#000000" face=verdana size=1>SS Filters</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="headworksfields" value="rsfilter" ><font color="#000000" face=verdana size=1>RS Filters</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="sump" ><font color="#000000" face=verdana size=1>Sump</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="ftp" ><font color="#000000" face=verdana size=1>Foot Path Bridge</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="pumphouse" ><font color="#000000" face=verdana size=1>Pump House</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="watchman" ><font color="#000000" face=verdana size=1>Watch Man Quarter</font>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="headworksfields" value="cwc" ><font color="#000000" face=verdana size=1>Clear Water Collection Well</font>&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="mfilter" ><font color="#000000" face=verdana size=1>Micro Filter</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="headworksfields" value="roplants" ><font color="#000000" face=verdana size=1>Ro Plants</B></font>&nbsp;&nbsp;

</div>
<div id="pipelines">
	<INPUT type="checkbox" name="pipelinefields" value="pumpingmain" ><font color="#000000" face=verdana size=1>Pumping Main</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="pipelinefields" value="gravitymain" ><font color="#000000" face=verdana size=1>Gravity Main</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="pipelinefields" value="distribution" ><font color="#000000" face=verdana size=1>Distribution</font>&nbsp;&nbsp;
</div>
<div id="sr.reservoirs">
	
</div>

<div id="others">
	<INPUT type="checkbox" name="othersfields" value="miscellaneous" ><font color="#000000" face=verdana size=1>Miscellaneous</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="othersfields" value="chlorination" ><font color="#000000" face=verdana size=1>Chlorination</font>&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<INPUT type="checkbox" name="othersfields" value="oandm" ><font color="#000000" face=verdana size=1>OandM</font>&nbsp;&nbsp;
</div>
<div id="pumpings">
	<INPUT type="checkbox" name="pumpingfields" value="pumpsets" ><font color="#000000" face=verdana size=1>Pumpsets</font>&nbsp;&nbsp;
</div>
</td></tr>

<td colspan="3" align="center">
		 <%//if(userid.equals("admin") || userid.equals("100000")){%>
	<INPUT type="checkbox" name="checkall" value="true" onclick="playCheckBoxes1()"><font color="indigo" face="verdana" size=2><B>Check All</B></font></td>
<%
//}
 %>
<tr>
<td >
<input type="radio" name="creport1" value="abstract"><b><font color="#000000" face=verdana size=2>Abstract Report</font></b></td>
<td><input type="radio" name="creport1" value="detail"><b><font color="#000000" face=verdana size=2>Detail Report</font></b></td>
</tr>


</table>
<tr><td>
<table>
<tr><td><input type="radio" name="creport" value="detailed" onclick="enableField1()"><font color="#000000" face=verdana size=2>Subcomponents List</font></td></tr>
</table></td>

</tr></table>

</fieldset>
</td></tr></table>
<%}%>
<center> <input type="button" value="Submit" name="Submit" class="btext"
		onclick="fnSubmit()">
		
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <INPUT type="reset" value="Reset"	readonly class="btext">
	</center>


</td></tr></table>
</td></tr></table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="780"/>
	<jsp:param name="Tborder" value="0"/>
</jsp:include>
</td></tr></table>

</html:form>
</center>		
<center><%@ include file="/commons/rws_footer.jsp"%></center>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html:html>
	
	
	