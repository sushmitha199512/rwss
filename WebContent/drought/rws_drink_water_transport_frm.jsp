<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>



<%
 String query=null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dcode = request.getParameter("dist");
	String mcode=request.getParameter("mand");
	String pcode=request.getParameter("panchayath");
	//System.out.println("Districtname:"+dcode);
	//System.out.println("mname:"+mcode);
	//System.out.println("pcode:"+pcode);
	
%>

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



<script language="JavaScript">
function openEditWindow(url)
{
	alert(url);
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/drought&page=/PowerTransport.do?mode=get2";
	document.forms[0].submit();
    
     
}



function fnClick()
{
	//alert(1);

	if(document.forms[0].dist.value=="" || document.forms[0].dist.value==null )
	{
		alert("Select District");
		return false;
	}
else if(document.forms[0].mand.value=="" || document.forms[0].mand.value==null)
	{
		alert("Select Mandal");
		return false;
	}
/* else if(document.forms[0].panchayath.value==""  || document.forms[0].panchayath.value==null )
	{
	alert("Select Panchayat");
	return false;
	
	} */


else
	{
	//alert("anupama");
document.forms[0].action="switch.do?prefix=/drought&page=/PowerTransport.do&mode=cview";
document.forms[0].submit();
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
function getData4()
{

document.getElementById('OptionsDiv111').style.display='block';
}
function getDistrict()
{
document.forms[0].dist.value==document.forms[0].dist.value;

  document.forms[0].submit();
}


</script>

<body  onload="javascript:init();">
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/PowerTransport.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Drought Habitations" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="25%" >
<tr>
<td>
   <fieldset>
   <legend></legend>
   <label>
   <table  border=0  width="25%"  align=center  style="margin-bottom:0;margin-top:0">
     <tr><td><font face=verdana size=2>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") || loggedUser.equals("1000DR") )) 
		{
		%>
			<SELECT name="dist" id="combo" class="mycombo" style="width:150px" onchange="getData2()">
			<option value="">-Select-</option>
		<%
			PreparedStatement pst=null;
			//query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dcode";
			
			query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_work_bill_tbl b,rws_work_admn_tbl w  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode and b.work_id=w.work_id   and substr(w.office_code,2,2)=d.dcode order by d.dname";
			 pst = conn.prepareStatement(query);
			rs = pst.executeQuery();
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				}
				rs.close();			
				pst.close();
				}
		else
		{
			//// System.out.println("in selected dist:");
					PreparedStatement pst=null;
		
					query="SELECT dcode,dname from rws_district_tbl where dcode=? ";
					 pst = conn.prepareStatement(query);
					 pst.setString(1, loggedUser.substring(1,3));
			rs = pst.executeQuery();
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="dist" value="<%=rs.getString(1)%>">
	<%
			}
			rs.close();			
			pst.close();
		}
	%>
</tr><tr><td><font face=verdana size=2>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="mand" id="combo" class="mycombo" style="width:150px" onchange="getData2()">
				
				<option value="">-Select-</option>
				
            <%if(dcode!=null && !dcode.equals("")) {
            	
            	PreparedStatement pst=null;
			query="select  distinct mcode,mname from rws_mandal_tbl   where dcode=? order by mcode";
			 pst = conn.prepareStatement(query);
			 pst.setString(1, dcode);
			ResultSet rs2 = pst.executeQuery();
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(mcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
					
	<%}
			}

						if(rs2!=null)rs2.close();
						if(pst!=null)pst.close();
	} %>
    </td>
	</tr>

	<tr><td><font face=verdana size=2>Panchayat&nbsp;&nbsp;<!-- <font color="red">*</font> --></td>
		<td class=btext>
		<SELECT name="panchayath" id="combo" class="mycombo" style="width:150px" >
				
				<option value="">-Select-</option>
            <%if(dcode!=null && !dcode.equals("") && mcode!=null && !mcode.equals("")) {
            	
            	PreparedStatement pst=null;
            	
			
			query="select  distinct pcode,pname from RWS_PANCHAYAT_TBL  where dcode=? and mcode=? order by pcode";
			 pst = conn.prepareStatement(query);
			 pst.setString(1, dcode);
			 pst.setString(2, mcode);
			ResultSet rs2 = pst.executeQuery();
			while(rs2.next())
			{ if(rs2.getString(1).equals(pcode)){
				%>
				 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
<%} else{%>
				 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
				
<%}
			}

						if(rs2!=null)rs2.close();
						if(pst!=null)pst.close();
	} %>
    </td>
	</tr>
		</table>
		</label>
	</fieldset>
	</td>
</tr>

   
 <tr align=center>
	<td>
	<html:button property="save" title="Click to select Habitations"  styleClass="btext" value="Submit"  onclick="fnClick();"/>
	<!--<html:button property="view" title="Click to see View  Habitations"  styleClass="btext" value="View"  onclick="fnView();"/>-->
	<!--<html:button property="save" title="Click to select Habitations"  styleClass="btext" value="Click" onclick="openEditWindow('switch.do?prefix=/drought&page=/PowerTransport.do?mode=cview')" />-->
	
    </td>
    </tr>


</table>

	   
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
Note 1:-Select District->Select Mandal->Select Panchayat->Click submit button</br>
<center>(or)</center>
	Select District->Select Mandal->Click submit button
</p>

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