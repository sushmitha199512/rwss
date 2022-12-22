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
   /*if(document.f1.type.value=="")
	{
		alert("Please Select type");
	}
	if(document.f1.number.value=="")
	{
		alert("Please Select File Number");
	}
	*/
	else{
		document.f1.action="bank_contractor_rpt.jsp";
	    document.f1.submit();
	}
}

</script>
<form name=f1 action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=292>
 <caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=75% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=2>Contractor Details</td>	
	</tr>
	
	
     <tr><td class=rptLabel>Date of Transaction:&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
	    <SELECT name="datewise" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()" >
		<option value="">-Select-</option>
		<%try{
			//nic.watersoft.commons.RwsUser user1=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
			 //String loggedUser = user1.getUserId();
			 String sdate = request.getParameter("datewise");
			 String t=request.getParameter("type");
			String num=request.getParameter("number");
				
			
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
<tr><td class=rptLabel>Type&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="type" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
			<%
			 System.out.println("ppppppppp"+sdate);
			 if(sdate!=null && !sdate.equals(""))
			 {  
				   System.out.println("******"+sdate);
				  stmt=conn.createStatement();
                   String query1="select distinct NEFT_RTGS_INTR from rws_contractor_settlement_tbl where to_char(FTX_DATE,'dd/mm/yyyy')='"+sdate+"' order by NEFT_RTGS_INTR ";
                   System.out.println("queryyyy1"+query1);
				    rs=stmt.executeQuery(query1);
                    while(rs.next())
                    {
                    	 if(rs.getString(1).equals(t))
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
			 }
			
			 %>
	</SELECT>
	</td>
  </tr>		
  <tr><td class=rptLabel>File Number&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="number" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
			<%
			 if(t!=null && !t.equals(""))
			 {  
				 stmt=conn.createStatement();
                   String query2=" select distinct  FILE_NUMBER  from rws_contractor_settlement_tbl where NEFT_RTGS_INTR='"+t+"' order by FILE_NUMBER";
			        
					rs=stmt.executeQuery(query2);
					System.out.println("queryyyy"+query2);
                    while(rs.next())
                    {
                    	 if(rs.getString(1).equals(num))
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
</table>

</form>
</html>
