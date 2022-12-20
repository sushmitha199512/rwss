<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		
	PreparedStatement stmt1 = null,stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">


	function fnSubmit()
	{
	
		//document.f1.action="./rws_dist_asset_status_no_rpt.jsp";
		document.f1.action="./rws_dist_asst.jsp";
		document.f1.submit();
	}


function fnMandSubmit()
	{ 
		//document.f1.action="./rws_mand_asset_status_no_rpt.jsp";
		document.f1.action="./rws_mand_asst.jsp";
		document.f1.submit();
	}
	function fnPanchSubmit()
	{ 
		//document.f1.action="./rws_panch_asset_status_no_rpt.jsp";
		document.f1.action="./rws_panch_asst.jsp";
		document.f1.submit();
	}
	
	function fnHabSubmit()
	{ 
		//document.f1.action="./rws_hab_asset_status_no_rpt.jsp";
		document.f1.action="./rws_hab_asst.jsp";
		document.f1.submit();
	}
	function valSubmit()
	{ 
		alert("Please SELECT District");
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

<form name=f1 action="<%= request.getRequestURI()%>">

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
				<font color="#FFFFFF">Sources in Habitation </font>
			</td>	
		</tr>
		<%

	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String rVill = null;
     String rHab = null;
	//String distName=null;
	//String mandalName=null;
	//String panchName=null;
	
	
	try
	{
	%>
<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<td class = btext><font color=navy><b>District</b> </font>
		<font color="red">*</font></td>
		<td class = btext><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>	
<%
			rDist = request.getParameter("district");

			out.println("Rdist"+rDist);

		if (rDist == null || !rDist.equals("-1"))
		{
%>	
		<option value="-1">ALL</option>
<%
		}
	
	 ps=conn.prepareStatement("SELECT distinct d.dcode,d.dname from rws_district_tbl d, RWS_ASSET_MAST_TBL M where d.dCODE = substr(M.hab_code,1,2) order by d.dcode");
	
	 rs=ps.executeQuery();

	
	if (rDist != null && rDist.equals("-1"))
	{
		session.setAttribute("dName","ALL");
		session.setAttribute("dCode",null);	
%>
		<option value="-1" selected>ALL</option>
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
	}// END OF IF
	
		else
		{
%>
				<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%
		}
		
	}// END OF While
	
	
	%>
		</td></tr>
		<%try
			{
		if(rDist == null || rDist.equals("-1") || rDist.equals("0"))
		{	
			System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>

		<%
	            
				session.setAttribute("mCode", null);
				session.setAttribute("mName", null);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("0"))
			{
				System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>				
	
<%               
	            rMand = request.getParameter("mandal");
				if(rMand != null && rMand.equals("-1"))
				{
				session.setAttribute("mCode",rMand);
%>
				<option value="-1" SELECTED>ALL</option>
<%
				}
				else
					{
%>
				<option value="-1">ALL</option>
<%
					}
					
					String query1 = "SELECT distinct m.mcode,m.mNAME FROM RWS_mandal_TBL m, RWS_ASSET_MAST_TBL M where m.dCODE = substr(M.hab_code,1,2) AND m.mcode = substr(M.hab_code,6,2) and m.dCODE=? order by m.mcode";
                     
					stmt1 = conn.prepareStatement(query1);
					stmt1.setString(1,rDist);
                    rs1 = stmt1.executeQuery();
					
					while(rs1.next())
					{
						if(rMand != null && rMand.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("mName",rs1.getString(2));
						session.setAttribute("mCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					
					rs1.close();
					stmt1.close();
			}			
				
}
catch(Exception e)
{
	System.out.println("The ERROR IN MANDAL..." + e);
}

%>
</SELECT></td>
</tr>

<tr>
<%
try
{
	   
		
		if(rDist == null || rDist.equals("-1")|| rDist.equals("0")|| rMand == null ||  rMand.equals("-1") ||rMand.equals("0"))
		{
			//System.out.println("IN PANCHAYAT STARTING...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>


<%               
	            
				session.setAttribute("pName",null);
				session.setAttribute("pCode",null);
		}
		else
			
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("0") && rMand != null && !rMand.equals("0")&& !rMand.equals("-1"))
			{
				System.out.println("IN PANCHAYAT ALL...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>
<%
	            rPanch = request.getParameter("panchayat");

				if(rPanch != null && rPanch.equals("-1"))
				{					
                   session.setAttribute("pCode", rPanch);
%>             
				<option value="-1" SELECTED>ALL</option>

<%                  
	             }
				else
				{					
%>
				<option value="-1">ALL</option>
<%
				}
				//stmt2 = conn.createStatement();
				String query2 = "SELECT distinct p.pcode,p.PNAME FROM RWS_panchayat_TBL p, RWS_ASSET_MAST_TBL M  where  p.dCODE = substr(M.hab_code,1,2) AND p.mcode = substr(M.hab_code,6,2) and p.pcode = substr(M.hab_code,13,2) and p.dCODE=? AND p.mcode =? order by p.PNAME";

				stmt2 = conn.prepareStatement(query2);
                stmt2.setString(1,rDist);
				stmt2.setString(2,rMand);
				//rs2 = stmt2.executeQuery(query2);	
				rs2 = stmt2.executeQuery();	
				
				while(rs2.next())
				{					
					if(rPanch != null && rPanch.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("pName", rs2.getString(2));
					session.setAttribute("pCode", rPanch);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					//session.setAttribute("pCode",rPanch);
					}
				}
				rs2.close();
				stmt2.close();
			}
}
catch(Exception e)
{
	System.out.println("THE ERROR IN PANCHAYAT... " +e);
}
%>
			</select>
		</td>
	</tr>
<tr>
<%
try
{
	if(rDist == null || rDist.equals("-1")|| rDist.equals("0")|| rMand == null ||  rMand.equals("-1") ||rMand.equals("0")|| rPanch == null || rPanch.equals("0")|| rPanch.equals("-1"))
		{
			System.out.println("IN Hab STARTING...");
%>
		<td class=rptLabel>Habitation</td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>

<%
	           
				session.setAttribute("hName",null);
				session.setAttribute("hCode",null);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("0") && rMand != null && !rMand.equals("0")&&!rMand.equals("-1")&& rPanch != null && !rPanch.equals("-1") && !rPanch.equals("0"))
			{
				System.out.println("IN Habitation ALL...");
%>
		<td class=rptLabel>Habitation</td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>
<%            
			    rHab = request.getParameter("habitation");

               if(rHab != null && rHab.equals("-1"))
				{	
				  session.setAttribute("hCode", rHab);		
%>
				<option value="-1" SELECTED>ALL</option>

<%               }
				else
				{					
%>
				<option value="-1">ALL</option>
<%
				}
				//stmt2 = conn.createStatement();
				String query2 = "SELECT distinct P.panch_code,P.panch_name from RWS_ASSET_MAST_TBL M,rws_panchayat_raj_tbl P where P.panch_code = M.hab_code and substr(M.hab_code,1,2)=? AND substr(M.hab_code,6,2) = ? AND substr(M.hab_code,13,2) =?  order by P.panch_name";

				stmt2 = conn.prepareStatement(query2);
                stmt2.setString(1,rDist);
				stmt2.setString(2,rMand);
				stmt2.setString(3,rPanch);
                //stmt2.setString(4,rVill);
                
				rs2 = stmt2.executeQuery();	
				//rs2 = stmt2.executeQuery(query2);	
				
				
				while(rs2.next())
				{					
					if(rHab != null && rHab.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("hName", rs2.getString(2));
					session.setAttribute("hCode", rHab);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					//session.setAttribute("vCode",rVill);
					}
				}
				rs2.close();
				stmt2.close();
			}
}
catch(Exception e)
{
	System.out.println("THE ERROR IN Habitation... " +e);
}
%>
			</select>
		</td>
	</tr>
</table>
</TD>
<TR>	
<TD colspan=2 align=center valign=top>	

<% if(rDist!=null && rDist.equals("-1")) {%>

<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%} else if(rDist!=null && !rDist.equals("0") && !rDist.equals("-1") && (rMand.equals("0") || rMand.equals("-1"))){ %>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnMandSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%} else if(rDist!=null && !rDist.equals("0") && !rDist.equals("-1") && rMand!=null && !rMand.equals("0") && !rMand.equals("-1") && (rPanch.equals("0") || rPanch.equals("-1"))){ %>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnPanchSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%} 
 else if(rDist!=null && !rDist.equals("0") && !rDist.equals("-1") && rMand!=null && !rMand.equals("0") && !rMand.equals("-1") && rPanch!=null && !rPanch.equals("0") && !rPanch.equals("-1")&&(rHab!=null||rHab.equals("0") || rHab.equals("-1"))){ %>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnHabSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%} else  {%>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="valSubmit()" value="View Report" class = btext></td>
        </tr>
</table>
<% } %>
</TD></TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
		out.println("connclose");
	}%>