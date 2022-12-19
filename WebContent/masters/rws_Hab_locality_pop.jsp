<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="/reports/conn.jsp"%>
<%int sno=0;
String type=request.getParameter("type");
String pop=request.getParameter("pop");
String hab=request.getParameter("hab");
Statement stmt1=null;
ResultSet rs1=null;
String astcode=request.getParameter("assetcode");
%>
<script>
function fncheck(index)
{
   if(document.getElementById("popser"+index).value=="")
{
  alert("Before Select checkbox Please Provide  Population value ");
  document.getElementById('check['+index+']').checked=false;
}
}
function fnSave(index)
{
var count=0;
var checkchoice=0;
var pop='<%=pop%>';

		for(var i=1;i<=index;i++)
		{
			if(document.getElementById("popser"+i).value!=""){
			 count+=parseInt(document.getElementById("popser"+i).value);
			}
			if(document.getElementById('check['+i+']').checked)
			{
			checkchoice++;
			}
		}
		if(checkchoice==0)  
		{
		alert("Please Select At least One Checkbox");
		return false;
		}
		
		if(count > parseInt(pop))
	   {
			alert("Population served Should be less than or equal to <%=type%> Populaion("+pop+")");
	   }
		else
		{
		 document.forms[0].action="switch.do?prefix=/masters&page=/HabSCST.do?mode=assetSave";
		 document.forms[0].submit();  
		}
}
</script>
<form method="post">
	<table ALIGN="CENTER">
		<tr>
			<td class=btext>Asset Code:<%=astcode%></td>
		</tr>
		<% String type1="";
  if(type.equals("MT")){type1="PLAIN" ;} else {type1=type;}
%>
		<tr>
			<td class=btext>Total <%=type1%> Population : <%=pop%></td>
		</tr>
	</table>
	<table border=0 cellspacing=0 cellpadding=0 bordercolor=#000000
		bgcolor="#ffffff" ALIGN="CENTER">

		<table id="t1" border=1 cellspacing=0 cellpadding=0
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" ALIGN="CENTER">

			<thead>
				<tr>
					<td bgcolor="#8A9FCD" colspan=10><font face=verdana
						color="#000000" size="2"><B>Asset Localties List</B></font></td>
				</tr>
				<tr>
					<td class=btext>Sl.No</td>
					<td class=btext>Select</td>
					<td class=btext>Locality Code</td>
					<td class=btext>Locality Name</td>
					<td class=btext>Population <br>Served
					</td>
				</tr>
			</thead>
			<tbody>

				<%
String qry="select  locality_code,locality_name from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=?  and substr(locality_code,1,2)=? order by locality_code";
ps=conn.prepareStatement(qry);
ps.setString(1, hab);
ps.setString(2, type);
rs=ps.executeQuery();
//// System.out.println("qry:"+qry);
while(rs.next())
{%>
				<tr>
					<td class=rptvalue><%=++sno%></td>
					<td class=rptvalue><input type=checkbox name="check[<%=sno%>]"
						value='<%=hab%>' onclick="fncheck(<%=sno%>)" /></td>
					<td class=rptvalue><input type="text" name="code<%=sno%>"
						readonly=true size="10" value='<%=rs.getString(1)%>' /></td>
					<td class=rptvalue><input type="text" name="name<%=sno%>"
						readonly=true size="15" value='<%=rs.getString(2)%>' /></td>
					<%String qry1="select population_served from RWS_ASSET_LOCALITY_SERVE_TBL  where asset_code=? and locality_code=? ";
ps=conn.prepareStatement(qry1);
ps.setString(1, astcode);
ps.setString(2, rs.getString(1));
rs1=ps.executeQuery();
if(rs1.next()){%>
					<td><input type="text" name="popser<%=sno%>" size="15"
						maxlength=5 value='<%=rs1.getString(1)%>' /></td>
					<%}else{%>
					<td><input type="text" name="popser<%=sno%>" size="15"
						maxlength=5 /></td>
					<%}%>
				</tr>
				<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
				<html:hidden property="token" styleClass="mytext"
					value="${sessionScope.csrfToken}" />
				<%}
if(sno>0){%>
				<tr>
					<td colspan=5 align="center"><input type="button" name="save"
						value="Save" onclick="fnSave(<%=sno%>)"></td>
				</tr>
				<%}
else{%>
				<tr>
					<td colspan=5 align="center"><input type="button" name="save"
						value="Save" onclick="fnSave(<%=sno%>)" disabled></td>
				</tr>
				<%
}

%>
			
		</table>

		<input type="hidden" name="sno" value="<%=sno%>">
		<input type="hidden" name="astcode" value="<%=astcode%>">
		</form>

		<script>

</script>

		</html>