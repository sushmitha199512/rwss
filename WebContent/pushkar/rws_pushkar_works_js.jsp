<%String pagetype="";
session.setAttribute("pagetype",pagetype);
//System.out.println("pagetype.............."+pagetype);

%>
<script>
function getProgrammes()
{

	document.forms[0].action="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=programmes";
	document.forms[0].submit();
}
function fnGetSubprogrammes(elem)
{	
	document.forms[0].action="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=subprogrammes";
	document.forms[0].submit();
}
function fnGetSubprogrammes1(elem)
{
	document.forms[0].action="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=subprogrammes1";
	document.forms[0].submit();	
}
function fnGetOffices(that)
{  // alert("hai");
	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
			+ "&mode=subdivisions";
	else
		if(field == 'subdivisionOfficeCode')	
			url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
					+ "&mode=mandals";	
			
	else
	  if(field == 'mandalCode')	
		url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
			+ "&mode=panchayts";
		else
			  if(field == 'panchayatCode')	
				url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
					+ "&mode=habitations";
		
		
		
			
    frm.action = url;
	frm.submit();

}

</script>

<script language="JavaScript">



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
		document.forms[0].action="switch.do?prefix=/pushkar&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
		document.forms[0].submit();
	}
	<%
	}
	else if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("N"))
	{
    %>
    document.getElementById('save').disabled=true;
   	document.forms[0].action="switch.do?prefix=/pushkar&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
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
	var url = "switch.do?prefix=/pushkar&page=/PushkarWork.do";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

function fnAddWork()
{
	var url = "switch.do?prefix=/pushkar&page=/PushkarWork.do&mode=Add";
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
		
			var url = "switch.do?prefix=/pushkar&page=/PushkarWork.do"
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


function fnMandals()
{
	//alert("111");
	document.forms[0].action="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=mandals";
	document.forms[0].submit();


}

function fnPanchayats()
{
	//alert("123333");
	document.forms[0].action="switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=Panchayats";
	document.forms[0].submit();


}





var newWindow;
function fnPickHabitations(index)
{
    // alert("hai i am in picking habs"+index);
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	var subdivisionOfficeCode = document.getElementById("subdivisionOfficeCode").value;

	 

	if(coc == '')
		alert("Please select circle.");
	 	
	else
	{			
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		
		var width = 1000;
		var height = 375;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/pushkar&page=/PushkarWork.do&mode=pickhab"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId
				+ "&index="+index+"&All=yes&subdivisionOfficeCode="+subdivisionOfficeCode+"&coc="+coc;
		
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=no";
        alert("hai i am in picking haps"+url);
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


	function fnUpdate()
{
		
		         				
	document.forms[0].action = "switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=update";
	             				
	 document.forms[0].submit();
				 
		
	}


           			
            			
function fnSave(that){

//alert(11);
	var selectedHab="";
	 var len=document.forms[0].workCount.value;
	var path;
	// alert("len"+len);
		
	    var yes=0;    
	    var n=0;
		for( var i=0;i<len;i++)
		{    // alert("ggh");
				if(document.getElementById("WORK["+i+"].checks").checked==true)
				 {
					selectedHab=selectedHab+","+document.getElementById("WORK["+i+"].habs").value;
					path=document.getElementById("WORK["+i+"].scannedCopy").value;
					n++;
			     }
				//alert(n);
		}
		  if(selectedHab=="")
		   {
			 alert("Select atleast one check box to save");
	       }
		  else{

                if(validateWorks()){
                	
             				//alert("path"+path);
             				
             				
	document.forms[0].action = "switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=save";
	
	 document.forms[0].submit();
			 
             				
	
			 } 
                else{
               	 
                    return false;
                }

                    
		  }
}




function validateWorks()
{ 
var len=document.forms[0].workCount.value;


	len = len;
   var yes=0;    
   var n=0;
	for( var i=0;i<len;i++)
	{     
			if(document.getElementById("WORK["+i+"].checks").checked==true)
			 {
				
				
				n++;
		     }
	}
	 		
        				if(n<1){	
        				
        					alert("Select atleast one check box to save");
        					 return false;
        				}
        				else if(n>1){
        					
        					alert("At a time we can  save only one record Please select only one check box");
        					 return false;
        				}

		 
          


        				var len=document.forms[0].workCount.value;
        				len = len;
        			    var yes=0;    
        			    
        				for( var i=0;i<len;i++)
        				{     
        						if(document.getElementById("WORK["+i+"].checks").checked==true)
        						 {
        							        						
        							 if(document.getElementById("WORK["+i+"].habs").value==""){
        								 alert("Please Select Habitation Code");
        								 document.getElementById("WORK["+i+"].habs").focus();
        										 return false;
        							 }
        							 if(document.getElementById("WORK["+i+"].proposalName").value==""){
        								 alert("Please Enter Work Name");
        								 document.getElementById("WORK["+i+"].proposalName").focus();
        										 return false;
        							 }
        							 
        							 if(document.getElementById("WORK["+i+"].workType").value==""){
        								 alert("Please Select Work Type ");
        								 document.getElementById("WORK["+i+"].workType").focus();
        										 return false;
        							 }
        							
        							 if(document.getElementById("WORK["+i+"].pushkarCode").value==""){
        								 alert("Please Select pushkarCode");
        								 document.getElementById("WORK["+i+"].pushkarCode").focus();
        										 return false;
        							 }
        							 
        							 if(document.getElementById("WORK["+i+"].sanctionAmout").value==""){
        								 alert("Please Select Sanction Amount");
        								 document.getElementById("WORK["+i+"].sanctionAmout").focus();
        										 return false;
        							 }
        							 
        							 if(document.getElementById("WORK["+i+"].adminiStrativeNum").value==""){
        								 alert("Please Select Adminstrative Number");
        								 document.getElementById("WORK["+i+"].adminiStrativeNum").focus();
        										 return false;
        							 }
        							 
        							 if(document.getElementById("WORK["+i+"].adminiStrativeDate").value==""){
        								 alert("Please Select Adminstrative Number");
        								 document.getElementById("WORK["+i+"].adminiStrativeDate").focus();
        										 return false;
        							 }
        							 
        							
        									
        									
        									 if(document.getElementById("WORK["+i+"].completeddate").value!="" && document.getElementById("WORK["+i+"].scannedCopy").value=="")
        								 {
        								 alert("Please Select Work Image");
        								 document.getElementById("WORK["+i+"].scannedCopy").focus();
        										 return false;
        								 
        								 }
        									 
        									 
        							 //} 
        							
        						 }
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
		document.forms[0].action = "switch.do?prefix=/pushkar&page=/PushkarWork.do?mode=pushkarview";
			
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



function init()
{

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
{   alert("hai i am in add work");
    var coc = document.getElementById("circleOfficeCode").value;
    if(coc == '')
		{
          alert("Please select circle.");
          return false;
         }
else
{
	var url = "switch.do?prefix=/pushkar&page=/PushkarWork.do&mode=Add&mode=divisions";
	var frm = document.forms["PushkarWorkForm"];
	frm.action = url;
     alert("url.............."+url);
	frm.submit();
    // fnGetOffices(this);
}
}

 
//
</script>