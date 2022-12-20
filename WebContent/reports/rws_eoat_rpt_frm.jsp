<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%		try{
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	String query=null;
%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">
window.history.forward(1);
function unview()
{
    var a=document.getElementById('circ1').value;
	
	if(a=="-1")
	{
       document.getElementById('circ').disabled=true;
	}
	 
}

function fnSubmit()
	{
		if(document.f1.district.selectedIndex == "")
		{
			alert("SELECT DISTRICT...");
			return false;
		}
		if(document.f1.program.selectedIndex == "")
		{
			alert("SELECT PROGRAM...");
			return false;
		}
		
		document.f1.action="./rws_eoat_rpt.jsp";
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
<body bgcolor="#edf2f8" onLoad="unview()">

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
				<font color="#FFFFFF">EOAT Status Report</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String rProg = null;
	String rsProg = null;
	String Month = null;
	String Year = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String aType = null;
	String aCode = null;
	
	rDist = request.getParameter("district");
	//out.println(rDist);
	rMand = request.getParameter("mandal");
	//out.println(rMand);
	rPanch = request.getParameter("panchayat");
	//out.println(rPanch);
	rProg = request.getParameter("program");
	//out.println(rProg);
	
	
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
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", null);
				
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("circleCode",rDist);
                session.setAttribute("circleName","ALL");
				//session.setAttribute("dName",distName);
				//session.setAttribute("mName",mandalName);
				//session.setAttribute("pName",panchName);
                 
		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
					session.setAttribute("circleCode", rDist);
			}
				stmt = conn.createStatement();
				
				 query = "SELECT distinct c.circle_office_code,c.circle_OFFICE_NAME from rws_eoat_tbl ph,RWS_CIRCLE_OFFICE_TBL c where ph.circle_office_code=c.CIRCLE_OFFICE_CODE";
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

<%

	
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{	
			//System.out.println("IN division STARTING...");
%>
	<tr>
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled>
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("divCode", null);
				session.setAttribute("divName", null);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//System.out.println("IN MANDAL ALL...");
%>			
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<!--<option value="-1">SELECT...</option>-->	
				<option value="-1">ALL</option>
	
<%              
	         session.setAttribute("divName","ALL");
				//if(rMand != null && rMand.equals("00"))
				//{
%>
				<!--<option value="00" SELECTED>ALL</option>-->
<%
				//}
				//else
					//{
%>
				<!--<option value="00">ALL</option>-->
<%
					//}
					stmt1 = conn.createStatement();
					 query ="SELECT distinct d.division_office_code,d.division_OFFICE_NAME from rws_eoat_tbl ph,RWS_division_OFFICE_TBL d where ph.circle_office_code=d.circle_OFFICE_CODE and ph.division_office_code=d.division_OFFICE_CODE and d.circle_office_code='" + rDist +"' order by d.division_office_code";

					rs1 = stmt1.executeQuery(query);
					while(rs1.next())
					{
						if(rMand != null && rMand.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("divName",rs1.getString(2));
						session.setAttribute("divCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					session.setAttribute("divCode",rMand);
					rs1.close();
					stmt1.close();
			}			
								


%>
			</select>
		</td>
	</tr>
	<tr>
<%

		if(rDist == null || rDist.equals("-1") || rDist.equals("00") || rMand == null || rMand.equals("-1") || rMand.equals("00"))
		{
			//System.out.println("IN subdivision STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" disabled>
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("subdivName",null);
				session.setAttribute("subdivCode",null);
		}
		
		else if(rDist != null || !rDist.equals("-1") || rMand != null)
			{
				//System.out.println("IN PANCHAYAT ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo">
				<!--<option value="-1">SELECT...</option>-->
				<option value="-1">ALL</option>
<%
					session.setAttribute("subdivName","ALL");
				//if(rPanch != null && rPanch.equals("00"))
				//{					
%>
				<!--<option value="00" SELECTED>ALL</option>-->

<%
					//session.setAttribute("panchayatName", null);
					//session.setAttribute("panchayatCode", rPanch);		
				//}
				//else
				//{					
%>
				<!--<option value="00">ALL</option>-->
<%
				//}
				stmt2 = conn.createStatement();
				query = "SELECT distinct sd.subdivision_office_code,sd.subdivision_OFFICE_NAME from rws_eoat_tbl ph,RWS_subdivision_OFFICE_TBL sd where ph.subdivision_office_code=sd.subdivision_OFFICE_CODE AND ph.division_office_code=sd.division_office_code and ph.circle_office_code=sd.circle_office_code and sd.circle_office_code='" + rDist + "' and sd.division_office_code='" + rMand +"'  order by sd.subdivision_OFFICE_code";
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(rPanch != null && rPanch.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("subdivName", rs2.getString(2));
					session.setAttribute("subdivCode", rPanch);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("subdivCode",rPanch);
					}
				}
				rs2.close();
				stmt2.close();
			}
			

%>
			</select>
		</td>
	</tr>

<!--*************************************************************************************************-->
<tr>
<%
		
	
		if(rDist == null || rDist.equals("-1"))
		{
			//ystem.out.println("IN program STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Program</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="program" id="circ1" style="width:150px" class="mycombo">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("prName",null);
				session.setAttribute("prCode",null);
		}
	
		else if(rDist != null && !rDist.equals("-1") && rDist.equals("00"))
			{
				//out.println("IN dist ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Program</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="program" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(rProg != null && rProg.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("prName","ALL");
					session.setAttribute("prCode", rProg);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct p.programme_code,p.programme_name from rws_eoat_tbl e,rws_programme_tbl p where p.programme_code=e.programme_code order by p.programme_code";
				/* query = " select distinct f.programme_code,p.programme_name from rws_financial_progress_tbl f,rws_programme_tbl p where p.programme_code=f.programme_code  order by f.programme_code";*/
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(rProg != null && rProg.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prName", rs2.getString(2));
					session.setAttribute("prCode", rProg);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prCode",rProg);
					}
				}
				rs2.close();
				stmt2.close();
			}
			//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		else if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//out.println("IN dist sel...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Program</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="program" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(rProg != null && rProg.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("prName","ALL");
					session.setAttribute("prCode", rProg);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = " select distinct p.programme_code,p.programme_name from rws_eoat_tbl e,rws_programme_tbl p where p.programme_code=e.programme_code and e.circle_office_code='" + rDist +"' order by p.programme_code";
				/* query = " select distinct f.programme_code,p.programme_name from rws_financial_progress_tbl f,rws_programme_tbl p where p.programme_code=f.programme_code  order by f.programme_code";*/
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(rProg != null && rProg.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prName", rs2.getString(2));
					session.setAttribute("prCode", rProg);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("prCode",rProg);
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

