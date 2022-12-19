<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="conn.jsp"%>

<%		try{
	
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	Statement stmt5 = null;
	Statement stmt6 = null;
	ResultSet rs5 = null;
	ResultSet rs6 = null;
	ResultSet rs1 = null;
		
    String query=null;
%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">
function fnSubmit()
	{   
	    if(document.f1.district.selectedIndex=="")
		{
	    alert("Please Select Circle...");
		return false;
		}
		if(document.f1.assetType.selectedIndex=="")
		{
		alert("Please Select SourceType...");		
		return false;
		}
	    if(document.f1.fromdate.selectedIndex=="")
		{
		alert("Please Select Year..");		
		return false;
		}
		/*if(document.f1.todate.selectedIndex=="")
		{
		alert("Please Select ToDate...");		
		return false;
		}*/
		
	document.f1.action="./rws_wq_test_status1.jsp";
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
				<font color="#FFFFFF">Lab Status Report</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String aType = null;
	String lab = null;
	String year = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	
	String aCode = null;
	
	rDist = request.getParameter("district");
	//out.println("district"+rDist);
	rMand = request.getParameter("mandal");
	//out.println("mandal"+rMand);
	rPanch = request.getParameter("panchayat");
	//out.println("panchayat"+rPanch);
	lab = request.getParameter("lab");
	aType = request.getParameter("assetType");
	//out.println("asset"+aType);
	//year = request.getParameter("year");
	//out.println("yearrrrr"+year);
	String fromDate = request.getParameter("fromdate");
	
	String toDate = request.getParameter("todate");
	
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
					session.setAttribute("circleCode",rDist);
			}
				stmt = conn.createStatement();
				
				/* query = "SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_water_sample_collect_tbl sc  where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE  order by c.circle_OFFICE_code";*/

				/*query = "SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_water_sample_collect_tbl sc,RWS_WQ_GEOLOGIST_TEST_TBL D  where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE AND sc.circle_OFFICE_CODE=SUBSTR(D.OFFICE_CODE,2,2) order by c.circle_OFFICE_code";*/
                 
                 query = "SELECT distinct sc.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_water_sample_collect_tbl sc where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE order by sc.circle_OFFICE_code";

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
					 query ="SELECT distinct sc.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d, rws_water_sample_collect_tbl sc  where d.circle_OFFICE_CODE = sc.circle_office_code and sc.division_office_code=d.division_office_code and d.CIRCLE_OFFICE_CODE= '"+ rDist + "' order by sc.division_OFFICE_code";

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
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled >
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
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
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
				query = "SELECT distinct sc.subdivision_office_code,sd.subdivision_OFFICE_NAME FROM  rws_water_sample_collect_tbl sc,  RWS_subdivision_OFFICE_TBL sd where sd.circle_office_code=sc.circle_office_code and sd.division_office_code= sc.division_office_code and sd.subdivision_office_code=sc.subdivision_office_code and sd.circle_office_code='"+rDist+"' and sd.division_office_code='"+rMand+"' order by sc.subdivision_OFFICE_code";
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
	<tr>
	<%
	if(rDist == null || rDist.equals("-1"))
		{
			//ystem.out.println("IN program STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("sName",null);
				session.setAttribute("sCode",null);
		}
	
		else if(rDist != null && !rDist.equals("-1") && rDist.equals("00"))
			{
				//out.println("IN dist ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(aType!= null && aType.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("sName","ALL");
					session.setAttribute("sCode",aType);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct sc.source_type,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS')from rws_water_sample_collect_tbl sc order by sc.source_type";

				// RWS_WQ_GEOLOGIST_TEST_TBL C WHERE SC.TEST_ID=C.TEST_ID
				//,rws_source_tbl s where sc.source_code=s.source_code";

				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(aType!= null && aType.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sName", rs2.getString(2));
					session.setAttribute("sCode", aType);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sCode",aType);
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
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(aType != null && aType.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("sName","ALL");
					session.setAttribute("sCode",aType);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 /*query = " select distinct sc.source_type,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS')from rws_water_sample_collect_tbl sc,rws_source_tbl s where sc.source_code=s.source_code and  sc.circle_office_code='"+rDist+"' AND sc. LAB_CODE='"+lab+"' order by sc.source_type";*/
                 query = "select distinct sc.source_type,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS')from rws_water_sample_collect_tbl sc  where sc.circle_office_code='"+rDist+"'order by sc.source_type";
				
                 // ,RWS_WQ_GEOLOGIST_TEST_TBL C AND SC.TEST_ID=C.TEST_ID 
				 // ,rws_source_tbl s where sc.source_code=s.source_code and 
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(aType != null && aType.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sName", rs2.getString(2));
					session.setAttribute("sCode", aType);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sCode",aType);
					}
				}
				rs2.close();
				stmt2.close();
			}
    
%>
			</select>
		</td>
	</tr>
      
	<tr>
		<td class=btext><font color=navy><b>Year</b></font><font color=red><b>*</b></font></td>
		<td class=btext>
			<SELECT name="fromdate" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
<%		
		stmt5 = conn.createStatement();
		
		/*String st4="select distinct to_char(Assigned_on, 'DD-MON-YY') as samp_date,Assigned_on from RWS_WATER_SAMPLE_COLLECT_TBL order by Assigned_on";*/

        /*String st4="select distinct Assigned_on as samp_date From RWS_WATER_SAMPLE_COLLECT_TBL";*/

		String st4="select distinct to_char(assigned_on,'YYYY') from rws_water_sample_collect_tbl order by to_char(assigned_on,'YYYY')";
		rs5 =stmt5.executeQuery(st4);
		
		while(rs5.next())
		{			
		if(fromDate != null && fromDate.equals(rs5.getString(1)))
			{
%>
			<option value="<%=rs5.getString(1)%>" SELECTED><%=rs5.getString(1)%></option>
<%
			}
			else
			{
%>
			<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%></option>
<%
			}
             session.setAttribute("FDATE",fromDate);
			
		}
%>
			</select>
		</td>
	</tr>
		
	<% 
	    
		}	
		catch(Exception e)
		{
			//System.out.println("sri"+e);
		}	
		 finally
	{
 conn.close(); 
	}
	
%>
			
	</table>
</TD>
	<TR>
<TD colspan=2 align=center valign=top>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button  onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>

