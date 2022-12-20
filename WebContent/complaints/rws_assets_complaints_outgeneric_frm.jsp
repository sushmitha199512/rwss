<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>

<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<style type="text/css">
.container {
    font-family:verdana,arial,helvetica,sans-serif;
    font-size:0.9em;
    margin:4px 0;
 }
.container img {
    width:16px;
    vertical-align:bottom;
 }
.container span {
    font-weight:bold;
    cursor:pointer;
 }
.off {
    display:none;
}
.on {
    width:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>

<%
Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
 %>

<script language="JavaScript">
    function ValidateFileUpload() {
        var fuData = document.getElementById('uploadGrievance');
        var FileUploadPath = fuData.value;

//To check if user upload any file
        if (FileUploadPath == '') {
            alert("Please Upload Grievance Image");

        } else {
            var Extension = FileUploadPath.substring(
                    FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

//The file uploaded is an image

if (Extension == "gif" || Extension == "png" 
                    || Extension == "jpeg" || Extension == "jpg") {

// To Display
              /*   if (fuData.files && fuData.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function(e) {
                        $('#blah').attr('src', e.target.result);
                    }

                    reader.readAsDataURL(fuData.files[0]);
                } */

            } 

//The file upload is NOT an image
else {
                alert("Upload Grievance only allows file types of GIF, PNG, JPG  and JPEG. ");
                
            }
        }
    }

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=get2";
	document.forms[0].submit();
    
     
}
function testRWS()
{
	/* alert(document.getElementById('grievanceRelatedTo').value); */
   if(document.getElementById('grievanceRelatedTo').value=="Rural Water Supply"){
	   document.getElementById('grievanceCategory').disabled=false;
   }
   else{
	document.getElementById('grievanceCategory').disabled=true;
   }
	    
}



function fnSave()
{
var flag=false;
if(fnSea()==true)
{
var complaintno=document.forms[0].complntno.value;
/* var complaintdate=document.forms[0].complntdt.value;
		
		var description=document.forms[0].complntdesc.value;
		var givenby=document.forms[0].repCode.value;
		var name=document.forms[0].name.value;
		var address=document.forms[0].address.value;
		var phone=document.forms[0].phoneNo.value;
      
        var habitationcode=document.forms[0].habCode.value; */
         document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=save&complntno="+complaintno;

        document.forms[0].submit();  
        
        /* var URL="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=openNew&complntno="+complaintno;
        viewWorks(URL); */
           
		}
}
/* function viewWorks(URL)
{
	
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
} */
/* function fnPrint()
{
	
	var complaintno=document.forms[0].complntno.value;
		
			var url = "switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=openNew&complntno="+complaintno;
			
			 var width = 838;
			 var height = 600;
			 var left = parseInt((screen.availWidth/2)-(width/2));
			 var top = parseInt((screen.availHeight/2)-(height/2));
			 var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=yes,status=yes";
				newWindow = window.open(url, "_blank", properties);
				newWindow.focus(); 
		
} */


	

function fnView()
{

if(document.forms[0].dist.value=="" || document.forms[0].dist.value==null)
{
alert("Select District");

} 
else
{

document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=cview";

document.forms[0].submit();

}
}
function getFromDate1()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=display";
document.forms[0].submit();

}
function change_case()
{
document.forms[0].save.enabled="false";
}


function getData1()
{
	   var habitationcode=document.forms[0].habCode.value;
	  // alert("habitationcode"+habitationcode);
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=view&habitationcode="+habitationcode;
document.forms[0].submit();

}
function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
toggleItem('collapse_myTbody1');
document.getElementById('text').style.display = 'block';
 

}
function hide()
{

	document.getElementById('text').style.display ='none';

}
function fnSea()
{
	
	var email =document.forms[0].emailId.value;
	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var fuData = document.getElementById('uploadGrievance');
    var FileUploadPath = fuData.value;

 /*    if (FileUploadPath == '') {
        alert("Please Upload Grievance Image");

    } else {
        var Extension = FileUploadPath.substring(
                FileUploadPath.lastIndexOf('.') + 1).toLowerCase();


	if (Extension == "gif" || Extension == "png" 
	                || Extension == "jpeg" || Extension == "jpg") {
	
	
	        } 
	else {
	            alert("Upload Grievance only allows file types of GIF, PNG, JPG  and JPEG. ");
	            return false;
	        }
    } */
    if(document.forms[0].dist.value== "" || document.forms[0].dist.value==null)
    {
    alert("Select District");
    return false;
    }
   else if(document.forms[0].mand.value== "" || document.forms[0].mand.value==null)
   {
   alert("Select Mandal");
   return false;
   }
   else if(document.forms[0].panch.value== "" || document.forms[0].panch.value==null)
   {
   alert("Select Panchayat");
   return false;
   }
   else if(document.forms[0].habCode.value== "" || document.forms[0].habCode.value==null)
   {
   alert("Select Habitation");
   return false;
   }
   
     else if(document.forms[0].complntdesc.value == "" || document.forms[0].complntdesc.value==null)
     {
     alert("Enter Grievance Description");
     return false;
     }
     else if(document.forms[0].repCode.value== "0" || document.forms[0].repCode.value==null)
     {
     alert("Select Complaint Given By");
     return false;
     }
     else if(document.forms[0].grievanceRelatedTo.value== "0" || document.forms[0].grievanceRelatedTo.value==null)
     {
     alert("Select Grievance Related To");
     return false;
     }
     else if(document.forms[0].grievanceEntryCategory.value== "0" || document.forms[0].grievanceEntryCategory.value==null)
     {
     alert("Select Grievance Entry Category");
     return false;
     }
    
     else if(document.forms[0].name.value == "" || document.forms[0].name.value==null)
     {
     alert("Enter Name");
     return false;
     }
     else if(document.forms[0].address.value == "" || document.forms[0].address.value==null)
     {
     alert("Enter Address");
     return false;
     }
	 else if(document.forms[0].phoneNo.value == "" || document.forms[0].phoneNo.value==null)
     {
     alert("Enter Phone No");
     return false;
     }
	/*  else if(document.forms[0].emailId.value== "" || document.forms[0].emailId.value==null)
     {
     alert("Enter Email Id");
     return false;
     } */
/* 	 else if (!filter.test(email) && email!="") {
		    alert('Please provide a valid email address');
		    document.forms[0].mpdoEmailId.focus;
		    return false;
	}
	 else if(document.forms[0].uploadGrievance.value== "" || document.forms[0].uploadGrievance.value==null)
     {
     alert("Select Upload Grievance");
     return false;
     } */
     else
     {
     return true;
     }
     
     }

function show()
{

if(document.forms[0].habCode.value == null || document.forms[0].habCode.value == "")
{
	document.getElementById('text').style.display ='none';
	
   

}
else 
{
	document.getElementById('text').style.display = 'block';

}

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
function rest()
{

document.forms[0].save.disabled=false;
}


</script>

<body  onload="javascript:init();">
<%@ include file="/commons/rws_header4.jsp" %>
<html:form action="/Complaintsoutgeneric.do" method="post" enctype="multipart/form-data">
<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Generic Grievance Entry " />
	<jsp:param name="TWidth" value="96.9%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="75%" >
<tr>
<td>
   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
   <table  border=0  width="80%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2();hide();" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
        </logic:present >
		</html:select>
		</td>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:150px" onchange="javascript:getData2();hide();">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
            </logic:present >
			</html:select>
	</td>
	</tr>
	<tr>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2();hide();">
		<html:option value="">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
        </logic:present >
		</html:select>
	</td>
	
		
		
		<td class="textborder" width="100">
	<bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="vill" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2();hide();">
		<html:option value="">SELECT...</html:option>
        <logic:present name="villages">
		<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
        </logic:present >
		</html:select>
	</td>
	</tr>
	<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getData1();show();">
		<html:option value="">SELECT...</html:option>
        <logic:present name="habitations">
  	<html:options collection="habitations" name="rwsLocationBean" property="habCode" labelProperty="habName" />
  	
    </logic:present >
		</html:select>
	</td>
	</tr>
		</table>
		</label>
	</fieldset>
	</td>
</tr>
<%
String numb=(String)session.getAttribute("compnos");
System.out.println("numb:"+numb);
if(numb!=null && !numb.equals("")){%>


   <tr>
    <td class="textborder">

    
     <div id="text" style="display:none;">
    <TABLE align=center>
    <tr >
    <td class="textborder" >
       Complaint No<font color="#FF6666">*</font></td><td><html:text property="complntno" value="<%=numb%>" styleClass="mytext" style="width:100px" readonly="true"  size="14" maxlength="14" onkeypress="return numeralsOnly(event)" />
       </td>
       
     <%--  <td class="textborder" >
      Date <font color="#FF6666">*</font></td><td><html:text property="complntdt" value="<%=transdate%>" styleClass="mytext" style="width:100px" readonly="true"/></td>
 --%>    
 <td class="textborder" >
      Date<font color="#FF6666">*</font></td>
 <td><html:text  property="complntdt"  value="<%=transdate%>" onkeypress="return decimalsOnly(event)" style="width: 70px" />
		<a href="javascript: showCalendar(document.forms[0].complntdt);">
        <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
 
	<td class="textborder" >
	 Grievance Description</td><td><html:textarea property="complntdesc" rows="5" cols="30"  /></td>
<tr>
		<td class="textborder">
					Complaint&nbsp;Given&nbsp;By<span class="mandatory">*</span>
				</td>
				<td class="column2">
					
						<html:select property="repCode" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="representatives">
							<html:options collection="representatives" name="labelValueBean" property="value" labelProperty="label" />
							</logic:present>
						</html:select>
				</td>
				<td class="textborder">
					Grievance&nbsp;Related&nbsp;To<span class="mandatory">*</span>
				</td>
				<td class="column2">
					
						<html:select property="grievanceRelatedTo" styleClass="mycombo" style="width:125px" onchange="testRWS()">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="Rural Water Supply">Rural Water Supply</html:option>
							<html:option value="Rural Sanitation">Rural Sanitation</html:option>
						</html:select>
				</td>

				   <td class="textborder">
					Grievance&nbsp;Category 
				</td>
				<td class="column2">
					
						<html:select property="grievanceCategory" styleClass="mycombo" style="width:125px" disabled="true">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="Water Availability">Water Availability</html:option>
							<html:option value="Water Quality Related">Water Quality Related</html:option>
							<html:option value="Both">Both</html:option>
						</html:select>
				</td> 
       
</tr>
<tr>
 <td class="textborder">
					Grievance&nbsp;Entry&nbsp;Category<font color="#FF6666">*</font> 
				</td>
				<td class="column2">
					
						<html:select property="grievanceEntryCategory" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="Toll Free Number">Toll Free Number</html:option>
							<html:option value="Others">Others</html:option>
						</html:select>
				</td> 
<td class="textborder" width="100">
       Name  <font color="#FF6666">*</font></td><td><html:text property="name" styleClass="mytext" style="width:125px"  size="25" maxlength="25"  onkeypress="return alpha(event)"  />
       </td>
	<%
     
       String hab=request.getParameter("habCode");
      
       
      String habname=(String)request.getAttribute("habitation");
       if(habname==null){
    	   habname="";
       }
      
       %>
       
  <td class="textborder" width="100">Address <font color="#FF6666">*</font></td><td>
	 <input type="text" value='<%=habname%>' name="address"  >
	 
	
 </tr>
 <tr>
 <td class="textborder" width="100">
	 Phone No<font color="#FF6666">*</font> </td><td><html:text property="phoneNo" maxlength="10"  size="10"  onkeypress="return numeralsOnly(event)" onchange="javascript:rest();"   /></td>
<td class="textborder" width="100">
       EmailId  </td><td><html:text property="emailId" styleClass="mytext" style="width:125px"/>
       </td>
	
 <%--     <td class="textborder" width="100">
	 Upload&nbsp;Grievance<font color="#FF6666">*</font> </td><td><html:file property="uploadGrievance" styleClass="mytext" style="width:150px" onchange="javascript:rest();javascript:ValidateFileUpload();" /></td>
 --%>  
 
 
   <td class="textborder" width="100">
	 Upload&nbsp;Grievance </td><td><html:file property="uploadGrievance" styleClass="mytext" style="width:150px" /></td>
  
 </tr>
 </TABLE>
</div>
    

   </td>
  
  </tr>
<%} %>
   
  
   
 <tr align=center>
	<td>
	<html:button property="save" title="Save the Fields"  styleClass="btext" value="Save" disabled="true" onclick="fnSave();"/>
	<html:button property="view" title="View the Results" styleClass="btext" value="View" onclick="fnView()"/>
    </td>
    </tr>


</table>

	   
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="96.9%"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>