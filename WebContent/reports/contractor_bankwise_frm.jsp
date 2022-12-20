<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<html>
<script>
function fnSubmit()
{
	if(document.f1.datewise.value=="")
	{
		alert("Please Select Date");
	}
	else{
		document.f1.action="contractor_bankwise_rpt.jsp";
	    document.f1.submit();
	}
}

</script>
<form name=f1 action="<%= request.getRequestURI()%>" method="post">
<table width="40%"><tr><td align="right"><a href="../home.jsp">Home</a></td></tr></table>
	<table><tr><td class=btext>Bill Wise Releases - Contractor </td></tr></table>
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=292>
	
	
     <tr><td class=rptLabel>Date of Transaction:&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
	    <SELECT name="datewise" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()" >
		<option value="">-Select-</option>
		<%try{
			//nic.watersoft.commons.RwsUser user1=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
			 //String loggedUser = user1.getUserId();
			 String sdate = request.getParameter("datewise");
			 String t=request.getParameter("contractor");
	
				
			
		 stmt = conn.createStatement();
	     String  query="select  distinct to_char(FTX_DATE,'dd/mm/yyyy') as f1 from rws_contractor_settlement_tbl order by substr(f1,9,10) desc,substr(f1,4,2) desc, substr(f1,1,2) desc";
		 rs = stmt.executeQuery(query);
		 
		 System.out.println("queryyyy"+sdate);
		 
		 while(rs.next())
		{
			 if(rs.getString(1).equals(sdate))
				{
				%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(1)%></option> 
			<%
				}
				else
				{
			%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> 
			<%
				}
			 
		}		 
			            rs.close();			
                        stmt.close();
		%>
		
		</tr>		
<tr><td class=rptLabel>Contractor Name&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="contractor" id="combo" class="mycombo" style="width:150px" >
			<option value="">-Select-</option>
			<%
			 System.out.println("ppppppppp"+sdate);
			 if(sdate!=null && !sdate.equals(""))
			 {  
				   System.out.println("******"+sdate);
				  stmt=conn.createStatement();
                   String query1="select distinct b.CONTRACTOR_NAME_COMPANY,a.contractor_code from rws_contractor_settlement_tbl a,rws_contractor_tbl b where a.contractor_code=b.contractor_code and to_char(FTX_DATE,'dd/mm/yyyy')='"+sdate+"'";;
                   System.out.println("queryyyy1"+query1);
				    rs=stmt.executeQuery(query1);
                    while(rs.next())
                    {
                    	 if(rs.getString(1).equals(t))
         				{
                    		 
         				%>   
         					 <option value="<%=rs.getString(2)%>" selected><%=rs.getString(1)%></option> 
         			<%     
         				}
         				else
         				{
         			%>
         					 <option value="<%=rs.getString(2)%>"><%=rs.getString(1)%></option> 
         			<%
         				}
         			 
         		    }		 
         			
                    	 
                        rs.close();
                      stmt.close();
			 }
			
			 %>
	</SELECT>
	</td>
  </tr>		  
 
<%		
		}
		catch(Exception e)
		{
			
		}
%>
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		
			
		</td>
	</tr>
</form>
</html>
