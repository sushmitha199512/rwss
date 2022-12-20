<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%


	ResultSet rs1=null,rs3=null,rs4=null;
    Statement stmt1=null,stmt4=null,stmt3=null;
    String query = null,query1=null,query3=null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
    
	String programe="",nextyr="";
		String[] program=request.getParameterValues("program");
		ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
//System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
//System.out.println("programe::"+programe);
if(programe!=null)
{
session.setAttribute("programe",programe);
}
}
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
            var loggedUser = '<%=loggedUser%>';
           if(document.f1.district.value=='1')
			{ 

                if(document.f1.program.value=='')
				{
					alert("Please Select program");
					return false;
				}
if(document.f1.scheme.value=='')
				{
					alert("Please Select scheme");
					return false;
				}
 
               /*if(document.f1.fyear.value=='')
				{
					alert("Please Select Year");
					return false;
				}*/

                      
              
              document.f1.prgname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
             //document.f1.finyear.value = document.f1.fyear.options[document.f1.fyear.selectedIndex].text;
             // alert(document.f1.finyear.value);
              //alert(document.f1.prgname.value);
                  
              document.f1.action="./rws_dpr_work_duration_rpt.jsp";
			  document.f1.submit();
			}
           else
           {
 				if(document.f1.district.value=='')
				{
					alert("Please Select District");
					return false;
				}
                if(document.f1.program.value=='')
				{
					alert("Please Select program");
					return false;
				}
			if(document.f1.scheme.value=='')
				{
					alert("Please Select scheme");
					return false;
				}
				     if(loggedUser=="admin"||loggedUser=="100000"||loggedUser=="100000DR")
					{
						document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
						
					}
					else
					{
						document.f1.dname.value = document.f1.district.value;
					}
					document.f1.prgname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
                    //document.f1.finyear.value = document.f1.fyear.options[document.f1.fyear.selectedIndex].text;
					document.f1.action="./rws_dpr_work_duration_rpt.jsp";
					document.f1.submit();
            
					
		   }
    }
		
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width="30%">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width="90%" align="right" bgcolor="#edf2f8">		
					
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5>DPR Works Duration Abstract</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	if(session.getAttribute("district")!=null){
		dcode=(String)session.getAttribute("district");
		
	}
	System.out.println("district:"+dcode);
    int yy=0;
	%>
	<tr  ><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.DROUGHT_USER)||loggedUser.equals(Constants.SEC_USER)||loggedUser.equals(Constants.GUEST)||loggedUser.substring(0,3).equals("col")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<%if(loggedUser.substring(0,3).equals("col")){}else{ %>
			<option value="1">ALL</option>
		<%}
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 ";
			if(dcode!=null && !dcode.equals("")){
				query+=" and dcode='"+dcode+"'";
			}
			query+=" order by dcode";

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
		}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
			
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
	
   <tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"   multiple size="10" class="hightlongcombo">
			<option value="">-select-</option>
			<%
				String progCode="";
				String nrdwpQuery="select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
				Statement statement=conn.createStatement();
				ResultSet  resultSet=statement.executeQuery(nrdwpQuery);
				while(resultSet.next()){
					if(!progCode.equals("")){
					progCode=progCode+","+resultSet.getString(1);
					}
					else{
						progCode=resultSet.getString(1);
					}
				}
				resultSet.close();
				%>
				<%
			if(request.getParameter("program")!=null && request.getParameter("program").equals("01,02,18,23,32,48,49,51,58,72"))
			{
			
			if(!progCode.equals("")){
				%>
				<option value=<%=progCode %>>NRDWP Related</option>	
					<%
					}
					%>
			<%}else{
			if(!progCode.equals("")){
				%>
				<option value=<%=progCode %>>NRDWP Related</option>	
					<%
					}
					%>
			<%}%>
			<%
                       
			stmt3 = conn.createStatement();
			query3="select * from  rws_programme_tbl  where NRDWP_RELATED='N' order by 1";
			rs3 = stmt3.executeQuery(query3);
			while(rs3.next())
			{
			    if(aa.contains(rs3.getString(1)))
			{
			%>
			 <option value="<%=rs3.getString(1)%>" selected><%=rs3.getString(2)%></option> 
			<%
			}
			else
			{
			%>
			  <option value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option> 
			<%
			}
			}
			rs3.close();			
			stmt3.close();
			%></select>
			</td>


 <td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo3" style="width:120px" multiple size=5 class="hightlongcombo" >

				<option value="0">-select-</option>
				
<%
		stmt4 = conn.createStatement();
		String 	qry3="select * from  rws_asset_type_tbl  order by 1";
		 rs4 = stmt4.executeQuery(qry3);
		while(rs4.next())
		{%>
		<option value="<%=rs4.getString(1)%>"><%=rs4.getString(2)%></option> 
		<%}
		rs4.close();
		
	
%>
		</SELECT>
		</td>

</tr> 

<% }
	catch(Exception e)
		{
			e.printStackTrace();
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=5  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="prgname">
<INPUT type="hidden" name="finyear">
</form>
</body>
</html>