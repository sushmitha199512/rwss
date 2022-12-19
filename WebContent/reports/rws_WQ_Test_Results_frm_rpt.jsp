<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	
%>
<html>
<head>

<script language="JavaScript">

<%
if(request.getParameter("flag")!=null)
{
	String flag = request.getParameter("flag");
	if(flag.equals("0"))
	{
		%>
		 alert("Problem while creating MDB file, please try again");
		<%
	}
}
%>


	function fnSubmit()
	{		
	      //alert("heellooooooooo");	
		   // var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.financialYear.value==''){
				alert("Please Select Financial Year");
				return false;
			}
			
			else
			{
				
				
					
					document.f1.action="rws_generate_test_report.jsp";
					document.f1.submit();
				
								
				
			}	
	}
		</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>WQ Test Results For Financial Year </td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
			<option value="">-Select-</option>

		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
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
				stmt.close();
				
		
	%></tr>
	<tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="financialYear" id="combo" class="mycombo" style="width:150px">
			<option value="" selected="selected">-Select Year-</option>
			<!-- <option value="01-Apr-15/31-Mar-16/2015-2016">2015-2016</option> -->
			<!-- <option value="01-Apr-14/31-Mar-15/2014-2015">2014-2015</option>
			<option value="01-Apr-13/31-Mar-14/2013-2014">2013-2014</option>
			<option value="01-Apr-12/31-Mar-13/2012-2013">2012-2013</option>
			<option value="01-Apr-11/31-Mar-12/2011-2012">2011-2012</option>
			<option value="01-Apr-10/31-Mar-11/2010-2011" >2010-2011</option>
			 -->
			<%
			
			try{
				stmt = conn.createStatement();
				query = "select distinct to_char(PREPARED_ON,'yyyy') from rws_wq_test_results_tbl order by to_char(PREPARED_ON,'yyyy') desc";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					int year1=Integer.parseInt(rs.getString(1));
					
					
					   int year2=year1+1;
					   int y1=Integer.parseInt(rs.getString(1).substring(2,4));
					   int y2=y1+1;
					  
				
			%>
			<option value="01-Apr-<%= y1%>/31-Mar-<%= y2%>/<%= year1 %>-<%= year2 %>" ><%= year1 %>-<%= year2 %>
			<%
			
				}
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					if(conn!=null){
						conn.close();
						stmt.close();
						rs.close();
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
			%>
			
			
			
			</SELECT>
			</td>
			</tr>
<%
	
	
}
	catch(Exception e)
		{
		e.printStackTrace();
 System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">



</form>
</body>
</html>