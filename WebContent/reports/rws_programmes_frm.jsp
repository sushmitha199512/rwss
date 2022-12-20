<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file ="conn.jsp"%>

<%		try{
	
	//Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	//ResultSet rs1 = null;
	//Statement st3 = null;
	//ResultSet rs3 = null;
	//Statement st4 = null;
	//ResultSet rs4 = null;
	//Statement st5=null;
	//ResultSet rs5=null;	
    String query=null;
%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">

/*function unview()
{
    var a=document.getElementById('circ1').value;
	
	if(a=="-1")
	{
       document.getElementById('circ').disabled=true;
	}
	 
}*/

function fnSubmit()
	{   
	    if(document.f1.district.selectedIndex=="")
		{
	    alert("Please Select District...");
		return false;
		}
		if(document.f1.lab.selectedIndex=="")
		{
	    alert("Please Select Programme...");
		return false;
		}
	document.f1.action="./rws_programmes_rept.jsp";
	document.f1.submit();
	}
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post" action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Programme Wise-Works Report</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String lab = null;
	
	
	rDist = request.getParameter("district");
	//out.println("district"+rDist);
	lab = request.getParameter("lab");
	//out.println("lab issss"+lab);
	
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		
<%
	
	if(rDist == null || rDist.equals("-1"))
	{
		//System.out.println("IN Circle STARTING...");

%>

	<tr>
		<td class = btext> 
				<font color=navy><b>District</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="0">All</option>
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", null);
				
	}
		
	
	else
		if(rDist != null || rDist.equals("0"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class = btext> 
				<font color=navy><b>District</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="0" SELECTED>All</option>
<% 
				session.setAttribute("circleCode",rDist);
                session.setAttribute("circleName","ALL");
				
		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>District</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="0">All</option>
<%
					session.setAttribute("circleCode",rDist);
			}
				stmt = conn.createStatement();
				
				 query = "SELECT distinct d.dcode,d.dname FROM RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_district_tbl d WHERE P.HAB_CODE=E.HAB_CODE and substr(P.hab_code,1,2)=d.dcode  order by d.dcode";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						session.setAttribute("circleName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();

%>
			</select>
		</td>
	</tr>
<tr>
<%
		
	
		if(rDist == null || rDist.equals("-1"))
		{
			//ystem.out.println("IN program STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Programme</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="lab" id="circ1" style="width:150px" class="mycombo">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("prName",null);
				session.setAttribute("prCode",null);
		}
	
		else if(rDist != null && !rDist.equals("-1") && rDist.equals("0"))
			{
				//out.println("IN dist ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Programme</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="lab" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(lab!= null && lab.equals("0"))
				{					
%>
				<option value="0" SELECTED>All</option>

<%
					session.setAttribute("prName","ALL");
					session.setAttribute("prCode",lab);
					
				}
				else 
				{					
%>
				<option value="0">All</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct pr.programme_code,p.programme_name FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_PROGRAMME_tbl p where pr.programme_code=p.programme_code AND pr.HAB_CODE=E.HAB_CODE  order by pr.programme_code";
				/* query = " select distinct f.programme_code,p.programme_name wfrom rws_financial_progress_tbl f,rws_programme_tbl p where p.programme_code=f.programme_code  order by f.programme_code";*/
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(lab != null && lab.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prName", rs2.getString(2));
					session.setAttribute("prCode", lab);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prCode",lab);
					}
				}
				rs2.close();
				stmt2.close();
			}
			//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		else if(rDist != null && !rDist.equals("-1") && !rDist.equals("0"))
			{
				//out.println("IN dist sel...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Programme</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="lab" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(lab != null && lab.equals("0"))
				{					
%>
				<option value="0" SELECTED>All</option>

<%
					session.setAttribute("prName","ALL");
					session.setAttribute("prCode",lab);		
				}
				else 
				{					
%>
				<option value="0">All</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct pr.programme_code,p.programme_name FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_PROGRAMME_tbl p where pr.programme_code=p.programme_code AND pr.HAB_CODE=E.HAB_CODE AND substr(pr.hab_code,1,2)= '" + rDist +"' order by pr.programme_code";
				/* query = " select distinct f.programme_code,p.programme_name from rws_financial_progress_tbl f,rws_programme_tbl p where p.programme_code=f.programme_code  order by f.programme_code";*/
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(lab!= null && lab.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prName", rs2.getString(2));
					session.setAttribute("prCode", lab);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prCode",lab);
					}
				}
				rs2.close();
				stmt2.close();
			}
    
%>
			</select>
		</td>
	</tr>
	
</table>
</TD>
	<TR>
<TD colspan=2 align=center valign=top>
	

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
<% 

 } catch(Exception e){ 
	 e.printStackTrace();
	 }
 finally
	{
 conn.close(); 
	}
 %>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>

