<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "conn.jsp" %>
<%
	String habtype = request.getParameter("habtype");
	String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	Statement stmt1=null,stmt2=null;
	ResultSet rs1=null,rs2=null;
	String rDist= null;
	rDist = request.getParameter("district1");
	String mcode = request.getParameter("mandal");
%>
<html>
<head>
<script language="JavaScript">
function checkDisableEnable()
{
	var habType = '<%=habtype%>';
	if(habType=="1" || habType=="null")
	{
		document.forms[0].astwrk.disabled=false;
	}
	else if(habType=="2" || habType=="3")
	{
		document.forms[0].astwrk.disabled=true;
	}
}
function makeEnable()
{
	document.forms[0].astwrk.disabled=false;
}
function makeDisable()
{
	document.forms[0].astwrk.disabled=true;
}
	function fnSubmit()
	{
		 var dist=document.forms[0].district1.value;
		 var mandal=document.forms[0].mandal.value;
		 var ast=document.forms[0].astwrk.value;
		 if(document.forms[0].district1.value!="" && document.forms[0].district1.value!="-1")
		 {
			document.forms[0].dName.value = document.forms[0].district1.options[document.forms[0].district1.selectedIndex].text;
			}
			if(document.forms[0].mandal.value!="" && document.forms[0].mandal.value!="-1")
		    {
			document.forms[0].mname.value = document.forms[0].mandal.options[document.forms[0].mandal.selectedIndex].text;
			}
	   		 if(dist!=null &&  dist!="" && dist =="0")
			{
				 alert("Please Select District");
				 return  false; 
			}
			
			else if(ast!=null && ast!="" && ast=="-1" && document.forms[0].habtype[0].checked)
			{
				 alert(" Please Select  Asset / Work ");
				  return  false; 
			}
		  
		else{
				 if(document.forms[0].habtype[0].checked)
				 {
					 document.forms[0].dName.value = document.forms[0].district1.options[document.forms[0].district1.selectedIndex].text;
			document.forms[0].mname.value = document.forms[0].mandal.options[document.forms[0].mandal.selectedIndex].text;
		
					 document.forms[0].action="./rws_school_asset_rpt1.jsp";
					  document.forms[0].submit(); 
				  }
				  if(document.forms[0].habtype[1].checked)
				 {
					  document.forms[0].dName.value = document.forms[0].district1.options[document.forms[0].district1.selectedIndex].text;
			document.forms[0].mname.value = document.forms[0].mandal.options[document.forms[0].mandal.selectedIndex].text;
		
					document.forms[0].action="./rws_school_asset_rpt2.jsp";
					 document.forms[0].submit(); 
				  }
				  if(document.forms[0].habtype[2].checked)
				 {
		document.forms[0].dName.value = document.forms[0].district1.options[document.forms[0].district1.selectedIndex].text;
			document.forms[0].mname.value = document.forms[0].mandal.options[document.forms[0].mandal.selectedIndex].text;
					document.forms[0].action="./rws_school_asset_rpt3.jsp";
					 document.forms[0].submit(); 
				  }
		  }
	}
</script>
</head>
<body bgcolor="#edf2f8" onload="checkDisableEnable()">
<form method=post >
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>School Asset/Work Linkage Report</td>	
	</tr>
	<%
try
{
%>
 <tr><td class=rptLabel colspan="2">
 <%if(habtype!=null && habtype.equals("1")){
%>
<input type="radio" value="1" name="habtype" checked onclick="makeEnable()">School Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="2" name="habtype" onclick="makeDisable()">School Not Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="3" name="habtype" onclick="makeDisable()">All School Asset/Work Details &nbsp;&nbsp;
<%}
if(habtype!=null && habtype.equals("2")){
%>
<input type="radio" value="1" name="habtype"  onclick="makeEnable()">School Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="2" name="habtype" checked onclick="makeDisable()">School Not Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="3" name="habtype" onclick="makeDisable()">All School Asset/Work Details &nbsp;&nbsp;
<%}if(habtype!=null && habtype.equals("3")){
%>
<input type="radio" value="1" name="habtype"  onclick="makeEnable()">School Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="2" name="habtype" onclick="makeDisable()">School Not Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="3" name="habtype" checked onclick="makeDisable()">All School Asset/Work Details &nbsp;&nbsp;
<%}
else if(habtype==null)
{
%>
<input type="radio" value="1" name="habtype"  onclick="makeEnable()">School Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="2" name="habtype" onclick="makeDisable()">School Not Linked to Asset/Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" value="3" name="habtype" onclick="makeDisable()">All School Asset/Work Details &nbsp;&nbsp;
<%}%>
</td>
</tr>
<tr>
	<td colspan=2>
	
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
<tr>
		<td class = btext><font color=navy><b>District</b> </font>
		<font color="red">*</font></td>
		<td class = btext><SELECT name="district1" style="width:150px" class="mycombo" onChange="this.form.submit()" >
		<option value="0">SELECT...</option>	
<%			rDist = request.getParameter("district1");
		if (rDist == null || !rDist.equals("-1"))
		{
%>	
	<%
		}
		 ps=conn.prepareStatement("SELECT distinct d.dcode,d.dname from rws_district_tbl d, RWS_ASSET_MAST_TBL M where d.dCODE = substr(M.hab_code,1,2) order by d.dname");
		 rs=ps.executeQuery();
	if (rDist != null && rDist.equals("-1"))
	{
		session.setAttribute("dName","ALL");
		session.setAttribute("dCode",null);	
%>
	<!-- 	<option value="-1" selected>ALL</option> -->
<%
	}
	while(rs.next())
	{
			if(rDist != null && !rDist.equals("-1") && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
<% 			
	session.setAttribute("dName", rs.getString(2));
	session.setAttribute("dCode",rDist);	
	}
	else
		{
%>
				<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%
		}
			}
			%>
		</td>
	 	</tr>
	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="mandal" id="combo" class="mycombo" style="width:150px" >
			<option value="">-Select-</option>
			<%
			 if(rDist!=null && !rDist.equals(""))
			 {
                   query=" select mcode,mname from rws_mandal_tbl where dcode='"+rDist+"' order by mname ";
			        stmt=conn.createStatement();
					rs.close();
					rs=stmt.executeQuery(query);
                    while(rs.next())
				{
                  if(rs.getString(1).equals(mcode))
				{
	%>	 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%				}
				else
				{
	%>					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
	<%
				}
				}
			 }%>
    </td>
	</tr>
<tr>
		<td class=rptLabel>Asset/Work<font color="red">*</font></td>
		<td class=btext><SELECT name="astwrk"  class="mycombo" style="width:150px" >
		<option value="-1">SELECT..</option>
		<option value="1">Asset</option>
		<option value="2">Work</option>
		</select>
		</td>
  </tr>
		 <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button  onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
</table>
</table>
<%
} catch(Exception e)
{
 	// System.out.println("Exception in school Asset  report:" +e);
 }
%>
<%@ include file = "footer.jsp" %>
<input type="hidden" name="dName"/>
<input type="hidden" name="mname"/>
</form>
</body>
</html>
