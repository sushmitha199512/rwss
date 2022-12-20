<%String pagetype="";
session.setAttribute("pagetype",pagetype);
//System.out.println("pagetype.............."+pagetype);

%>

<script language="JavaScript">
<!--
var dExist='N';
var newandext;
function getWorkCategory()
{   document.forms[0].action="switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=workCategory";
    // alert("hajjjjjjjjjjjjjj");
	document.forms[0].submit();
}
function showFields()
{
    document.forms[0].plan[0].disabled=true;
   
	if(document.forms[0].wrktype[1].checked)
	{
		document.getElementById('mains2').style.display = 'block';
	}
	else
	{
	 	document.getElementById('mains2').style.display = 'none';
		document.forms[0].augsch.value='';
	}
	if(document.forms[0].typeOfAsset.value=='10')
	{
		document.getElementById('sustainDetails').style.display='block';
	}
	else
	{
		document.getElementById('sustainDetails').style.display='none';
	}
	
<%
if(request.getAttribute("resetForm") == null)
{%>
if(document.forms[0].typeOfAsset.value=="")
	{
	//document.forms[0].workCat.value="";
	}
<%}%>
if (document.forms[0].plan[0].checked)
	{
	document.forms[0].wrktype[0].disabled=true;
	document.forms[0].wrktype[1].disabled=true;
	document.forms[0].wrktype[2].disabled=false;
	document.forms[0].wrktype[2].checked=true;  	
	}
else if (document.forms[0].plan[1].checked)
	{
	document.forms[0].wrktype[0].disabled=true;
	document.forms[0].wrktype[1].disabled=true;
	document.forms[0].wrktype[2].disabled=false;
	document.forms[0].wrktype[2].checked=true;
	}
else
{
    document.forms[0].wrktype[0].disabled=true;
	document.forms[0].wrktype[1].disabled=true;
	document.forms[0].wrktype[2].disabled=true;
}
	<%
	//Debug.println(request.getAttribute("duplicateExist"));
	if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("Y"))
	{
    %>
    if(confirm("WORK EXIST - With Same Plan,Category,\nScheme,Programme,SubProgramme,\nCircle,No.Of Habs,Amount and Date.\nDo You Still Want To Save It ?"))
    {
	   	document.getElementById('save').disabled=true;
		document.forms[0].action="switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
		document.forms[0].submit();
	}
	<%
	}
	else if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("N"))
	{
    %>
    document.getElementById('save').disabled=true;
   	document.forms[0].action="switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
	document.forms[0].submit();
	<%
	}
	%>
}
function checkMe(type)
{
		if(type==0)
		{
		document.forms[0].wrktype[0].checked=true;
		}
		else if(type==1)
		{
		document.forms[0].wrktype[1].checked=true;
	    }
	    
}

function chkAll(len)
{
	for(var i=1;i<=len;i++)
	{
	 	document.getElementById('chk['+i+'].remove').checked=true;
	}
}
function clrAll(len)
{
	for(var i=1;i<=len;i++)
	{
	 	document.getElementById('chk['+i+'].remove').checked=false;
	}
}

function fnSubmit()
{
	var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

function fnAddWork()
{
	var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=Add";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

function fnRemove(that)
{   // alert(" hai i am in remove");
    var proposalId ;
	var frm = that.form;
	var removeIds = frm.elements("remove");
	var workCountt = document.getElementById("workCount").value;
    // alert(" hai i am in remove"+workCountt);
	if(workCountt>0)
	{  //  alert(" hai i am in remove11111");
	  
      for(var j=0;j<workCountt;j++)
       {
       proposalId = document.getElementById("WORK["+j+"].proposalId").value;
       alert("proposalId"+proposalId);
       }
       alert("workCountt"+workCountt);
       proposalId="";
    	for(var i=0; i<workCountt; i++)
			{ 
				if(removeIds[i].checked==true)
                proposalId=proposalId+","+document.getElementById("WORK["+i+"].proposalId").value;
                alert("......"+proposalId);
			 
			}
		
			var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do"
				+ "&mode=Remove&proposalId="+proposalId;
             
			frm.action = url;
            alert(url)
			frm.submit();		  
		}
       else
       {
       alert("Please Select atleast one Work");
       }
   }

function fnGetOffices(that)
{  // alert("hai");
	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do"
			+ "&mode=subdivisions";	
    frm.action = url;
	frm.submit();

}
function getScheme()
{
showFields();
document.forms[0].action="switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=scheme";
document.forms[0].submit();
}

function getProgrammes()
{
	if(document.forms[0].typeOfAsset.value=='10')
	{
		document.forms[0].prooved.value='Sustainability';
		document.getElementById('sustainDetails').style.display='block';
	}
	else
	{
		document.forms[0].prooved.value='';
		document.getElementById('sustainDetails').style.display='none';
	}
	document.forms[0].action="switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=programmes";
	document.forms[0].submit();
}
function fnGetSubprogrammes(elem)
{
	var index = elem.name.substr(5,1);
	var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=subprogrammes"
			+ "&index="+index;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}
function fnGetSubprogrammes1(elem)
{
	var index = elem.name.substr(5,1);
	var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=subprogrammes1"
			+ "&index="+index;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

var newWindow;
function fnPickHabitations(index)
{
    // alert("hai i am in picking habs"+index);
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	var subdivisionOfficeCode = document.getElementById("subdivisionOfficeCode").value;
	var prooved = document.getElementById("prooved").value;
	 

	if(coc == '')
		alert("Please select circle.");
	 	
	else
	{			
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var assetcode=proposalId.substring(6,8);
		//alert(assetcode);
		var width = 1000;
		var height = 375;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/drought&page=/PickAdminHabitation.do&mode=pickhab"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId
				+ "&index="+index+"&assetcode="+assetcode+"&All=yes&subdivisionOfficeCode="+subdivisionOfficeCode+"&prooved="+prooved;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=no";
       //  alert("hai i am in picking haps"+url);
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

function fnPickSources(index)
{
  
	// alert("hai i am in picking sources"+index);
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	var subdivisionOfficeCode = document.getElementById("subdivisionOfficeCode").value;
    var prooved = document.getElementById("prooved").value;
	if(coc == '')
		alert("Please select circle.");
	 	
	else
	{			
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var assetcode=proposalId.substring(6,8);
		//alert(assetcode);
		var width = 1000;
		var height = 375;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=pickSources"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId
				+ "&index="+index+"&assetcode="+assetcode+"&All=yes&subdivisionOfficeCode="+subdivisionOfficeCode+"&prooved="+prooved;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=no";
      //   alert("hai i am in picking haps"+url);
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

function fnShowAugmentationWork(index)
{  //alert("hello aug");
    var workId= document.getElementById("WORK["+index+"].proposalId").value;
    var workName= document.getElementById("WORK["+index+"].proposalName").value;
     if(workId!='')
     {
	var checkField = document.getElementById("WORK["+index+"].augmentation");
	if(checkField.checked)
	{
		
		var proposalId = proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var url = "switch.do?prefix=/drought&page=/AddMoreProgramsForOneWork.do?workId="+workId+"&workName="+workName+"&mode=Add New";
		var properties = "width=648,height=380,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=no";
		newWindow = window.open(url, "", properties);
	}
	}
	else{
	alert("Enter WorkId & Name");
	document.getElementById("WORK["+index+"].augmentation").checked=false;
	return;
	}
}
function validateWorks()
{  //  alert("hailllllllllllllllll");
	var scheme=document.forms[0].typeOfAsset.value;
	var workCount = document.getElementById("workCount").value;
	var workName;
    var workType;
	var noOfHabs;
	var noOfLabs;
	var sancAmt;
	var adminNum;
	var adminDate;
	var estimateCostElem;
	var techsno;
	var techsdate;
	var techsamt;
	var sourcesryr;
	var sourcehabcode;
	var sourcetypecode;
	var subsourcetypecode;
	var sourcecode;
	var sourcename;
	var sourceloc;
	var assetcode;
	var sitehandoverdate;
	var workgrounddate;
	var expenditureupto;
	var expenditureuptodate;
	var valueofnotpaidwork;
	var completiondate;
	var fincompletiondate;
	var commencementdate;
	var message ="";
	for(var i=0; i<workCount; i++)
	{
		workName = document.getElementById("WORK["+i+"].proposalName").value;
        workType = document.getElementById("WORK["+i+"].workType").value;
        alert("workType....."+workType);
		noOfHabs = document.getElementById("WORK["+i+"].noOfHabs").value;
		sancAmt = document.getElementById("WORK["+i+"].sanctionAmout").value;
		adminNum = document.getElementById("WORK["+i+"].adminiStrativeNum").value;
		adminDate = document.getElementById("WORK["+i+"].adminiStrativeDate").value;
		estimateCostElem = document.getElementById("WORK["+i+"].estimateCost");
        techsno = document.getElementById("WORK["+i+"].tsno");
		techsdate = document.getElementById("WORK["+i+"].tsdate");
		techsamt = document.getElementById("WORK["+i+"].tsamt");
		sourcesryr = document.getElementById("WORK["+i+"].ssryr");
		sourcehabcode = document.getElementById("WORK["+i+"].srhabcode ");
		sourcetypecode = document.getElementById("WORK["+i+"].srtypecode");
		subsourcetypecode = document.getElementById("WORK["+i+"].subsrtypecode");
		sourcecode = document.getElementById("WORK["+i+"].scrcode");
		scourcename = document.getElementById("WORK["+i+"].srname");
		sourceloc = document.getElementById("WORK["+i+"].srloc");
		assetcode = document.getElementById("WORK["+i+"].astcode");
		newandext = document.getElementById("WORK["+i+"].newext");
       // alert(newandext.value);
		sitehandoverdate = document.getElementById("WORK["+i+"].sitedate");
		workgrounddate = document.getElementById("WORK["+i+"].grounddate");
		expenditureupto = document.getElementById("WORK["+i+"].expupto");
		expenditureuptodate = document.getElementById("WORK["+i+"].expuptodate");
		valueofnotpaidwork = document.getElementById("WORK["+i+"].notpaidvalue");
		completiondate = document.getElementById("WORK["+i+"].compdate");
		finalcompletiondate = document.getElementById("WORK["+i+"].fincompdate");
		commencementdate = document.getElementById("WORK["+i+"].commdate");

		if(workName.length == 0 || workName == '')
			message+="Work Name with S.No:" + (i+1) + " is required\n"; 
		//message+="Habitation(s) for work with S.No:" + (i+1) + " is required\n"; 
		if(sancAmt.length == 0 || sancAmt == '')
			message+="Sanction Amount with S.No:" + (i+1) + " is required\n"; 
		if(adminNum.length == 0 || adminNum == '')
					message+="Admin.Sanction Number with S.No:" + (i+1) + " is required\n"; 
		if(adminDate.length == 0 || adminDate == '')
					message+="Admin. Sanction Date with S.No:" + (i+1) + " is required\n"; 
   }
  
   var admDate=document.getElementById('WORK[0].adminiStrativeDate').value;
   var dt=admDate.split('/');
   var rdt=dt[1]+'/'+dt[0]+'/'+dt[2];
   var revdt = new Date(rdt);
   var sysdt = new Date();
   if (revdt.getTime() > sysdt.getTime())
 	{
 	 message+="Admin Sanction Date cannont be greater than Current Date.";
 	}
 	if(document.forms[0].wrktype[1].checked)
   	 {
   		if(document.forms[0].typeOfAsset.value!='10')
		{
			if(document.forms[0].augsch.value == null || document.forms[0].augsch.value == "")
	   		{
	   			message +="Please Select Augumentation Scheme";
	   		}
	   	}
	   	else
	   	{
	   		if(document.forms[0].sustainDetails.value=="")
	   		{
	   			message += "Please Select Sustainability Options for Sustainability Scheme";
	   		}
	   	}
   	 }
	if(message.length >0)
	{
		alert(message);
		return false;
	}
   	if(document.forms[0].typeOfAsset.value=='10')
	{
   		if(document.forms[0].sustainDetails.value=="")
   		{
   			message += "Please Select Sustainability Options for Sustainability Scheme";
   		}
   	}
	if(message.length >0)
	{
		alert(message);
		return false;
	}
	  var lengthHabs = '<%=HabName%>';
      // alert("lengthHabs"+lengthHabs);
	if(lengthHabs == "" || lengthHabs == null)
	{
		alert("Please Add Habitation to the Work");
		return false;
	}
  return true;
}
function fnView(that)
{
	var coc = document.getElementById("circleOfficeCode").value;
	if(coc=="")
	{
		alert("Select Circle");
	}
	else
	{
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?mode=view-success";
			document.forms[0].action=url;
			document.forms[0].submit();
	}
}

function showWorks()
{
	 var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=getWorks";
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
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

function getAssetDiv(chk)
{
if(chk.checked==true){
document.getElementById("asttype").value='Y';
 // alert("asttype"+document.getElementById("asttype").value);
}
else{
document.getElementById("asttype").value='N';
// alert("asttype"+document.getElementById("asttype").value);
}

}


function showAssets(index)
{    
 
    //  alert("hai i am in main showAssets"+index+"editvar...."+editvar);
     var op;
     var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
   //   alert("assets proposalId"+proposalId);
     if(document.getElementById("WORK["+index+"].newext").checked==true)
      { op='Y';
      //   alert("op......."+op);
	    document.getElementById("WORK["+index+"].asttype").value=op;
	    // alert("asttypevalue"+document.getElementById("WORK["+index+"].asttype").value);
	      
      }
      else
        document.getElementById("WORK["+index+"].asttype").value='N';
        var hoc = document.getElementById("headOfficeCode").value;
		var coc = document.getElementById("circleOfficeCode").value;
	    if( op=='' ||op == null)
		{
         alert("Please Check the Existing Asset to Proceed.");
		}
  else
  {
	if(coc == '')
		alert("Please select circle.");

	else
	{
     alert("You are going to add existing asset to this Drought work");
	 var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=getAssets&proposalId="+proposalId+"&asstindex="+index;
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
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
 }
}

function fnSave(that)

{    
    var scheme=document.forms[0].typeOfAsset.value;
    var subdiv=document.forms[0].subdivisionOfficeCode.value;
    // alert("subdivisionOfficeCode:"+subdiv);
	var leadradio;                                                     
    var sub=false;
    if(validateAdminstrativeSanctionForm(AdminstrativeSanctionForm))
	{//alert("hellooooooooooo2"+document.forms[0].typeOfAsset.value);
	if(validateWorks())
	 {//alert("hellooooooooooo3"+document.forms[0].typeOfAsset.value);
	  	sub=true;
        
	 }
	}
    // alert("in save..........."+newandext.value);
    if(sub)
	{
	if(dExist == 'N')
	{
		var checkLead = "false";
        for(var i=0; i<workCount; i++)
      {
		var lengthHabs = document.getElementById("WORK["+i+"].noOfHabs").value;
		// alert("lengthHabsZZZZZZZZZZZZZZZZZZZZZz"+lengthHabs+workCount);	
         var asttype=document.getElementById("WORK["+i+"].asttype").value;
        //   alert("save save asttype........"+asttype);
         var sourcecode=document.getElementById("WORK["+i+"].srtypecode").value;
         var subsourcecode=document.getElementById("WORK["+i+"].subsrtypecode").value
	 	
		if(lengthHabs!= null && (document.forms[0].typeOfAsset.value!="11" && document.forms[0].typeOfAsset.value!="12"))
		{    //  alert("Temporarily Freezed111111111");
			
						leadradio = lengthHabs; 
                      //   alert("leadradio"+leadradio);
						checkLead="true";
				
					if(checkLead=="false")
				{
					alert("Select One of the Habitation as a Lead Habitation");
				}
				else
				{
		//			alert("Temporarily Freezed");
					if(document.forms[0].wrktype[0].checked)
					{   
                      //   alert("else Temporarily Freezed2222");
						if(confirm("Attention:\n Make sure you select the Work(s) to Save \nDo you want Save this Work Under Main Scheme \nif this Work is under Augmentation Please Select Augmentation \nOnce it is Saved under MainScheme we can not convert MainScheme to Augmentation \nPress OK to continue or Press CANCEL to change the work type"))
						{
							var url = "switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save&sourcecode="+sourcecode+"&subsourcecode="+subsourcecode+"&asttype="+asttype+"&wcount="+workCount;
							document.forms[0].action=url;
                           //  alert(url);
							document.forms[0].submit();
						}
					}
					else
					{   //  alert("Temporarily Freezed1333331");
						var url = "switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save&sourcecode="+sourcecode+"&subsourcecode="+subsourcecode+"&asttype="+asttype+"&wcount="+workCount;
						document.forms[0].action=url;// alert(url);
						document.forms[0].submit();
					}
				}
		}
		else
		{
		    //  alert("Temporarily Freezed22222222222222222");
			if(document.forms[0].wrktype[0].checked)
			{
				if(confirm("Attention:\nMake sure you select the Work(s) to Save \nDo you want Save this Work Under Main Scheme \nif this Work is under Augmentation Please Select Augmentation \nOnce it is Saved under MainScheme we can not convert MainScheme to Augmentation \nPress OK to continue or Press CANCEL to change the work type"))
				{
					leadradio = document.forms[0].leads.value;
                   //  alert("leadradio"+leadradio);
					var url = "switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save&sourcecode="+sourcecode+"&subsourcecode="+subsourcecode+"&asttype="+asttype +"&wcount="+workCount;
					document.forms[0].action=url; // alert(url);
					document.forms[0].submit();
				}
			}
			else
			{
				leadradio = document.forms[0].leads.value;
				var url = "switch.do?prefix=/drought&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save&sourcecode="+sourcecode+"&subsourcecode="+subsourcecode+"&asttype="+asttype +"&wcount="+workCount;
				document.forms[0].action=url; // alert(url);
				document.forms[0].submit();
			}
		}
		}
    }
 }
}

	


function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
toggleItem('collapse_myTbody1');

 

}

function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}

function toggleItem(id)
{   
	itm = getItem(id);
	if(id=="collapse_myTbody2")
	var im = "onea";
	else if(id=="collapse_myTbody3")
	var im = "onec";
	else
	var im = "oneb";
	if(!itm)
	return false;
	if(itm.style.display == 'none'){
	itm.style.display = '';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/collapse.gif";
	}
	}    
	else{
	itm.style.display = 'none';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/expand.gif";
	}
	}	      
	return false;
	}




function fnAddWork()
{ //  alert("hai i am in add work");
    var coc = document.getElementById("circleOfficeCode").value;
    if(coc == '')
		{
          alert("Please select circle.");
          return false;
         }
else
{
	var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=Add&mode=divisions";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
   //  alert("url.............."+url);
	frm.submit();
    // fnGetOffices(this);
}
}

 
//-->
</script>