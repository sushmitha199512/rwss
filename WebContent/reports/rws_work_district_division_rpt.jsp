424<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@ page import="java.util.*"%>
<%
//DecialFormat ndf=new DecimalFormat("####".00);
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
 String dcode=request.getParameter("district");
 String divcode=request.getParameter("division");
 String dname=request.getParameter("disname");
 String divname=request.getParameter("divname");
 
//System.out.println("d*******"+dcode);
//System.out.println("div******"+divcode);
//System.out.println("dname******"+dname);
//System.out.println("divname******"+divname);


int sno=1;
int bill=0;
int wid=0;
int vouno=0;
int voucdt=0;
int adminno=0;
int admindt=0;
int vouamt=0;
int billamt=0;
int sanamt=0;
String billno="";
String contamt="";
%>
<html>
<body>

<table border = 0 align="right">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder" nowrap>
					<a href="javascript:history.go(-1)">Back</a>|<a href="../home.jsp">Home</a>
					</td>
					</tr>
				</table>
		</caption>
		</table>
		
		
		
		
<table align="center">
<tr><td  class=btext><font color=blue> District:&nbsp;&nbsp;<font color=green><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division:&nbsp;<font color=green><%=divname%></font>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"><font color="blue"><b>Amount in Rs. Lakhs</b></font></td>
</tr>
	<tr align=center>
		  <td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Voucher No</td>
			<td class=btext>Voucher Date</td>
			<td class=btext>Admin No</td>	
			<td class=btext>Admin Sanction Date</td>
			<td class=btext>Voucher Amount</td>
			<td class=btext>Sanction Amount</td>
			<td class=btext>Bill Amount</td>
			
			
							
	  </tr>
	  

<%
try{

     

      //  String qry="select a.work_id,work_name,c.bill_no ,a.VOUCHER_NO, to_char(a.VOUCHER_DT,'dd/mm/yyyy'),admin_no,to_char(admin_date,'dd/mm/yyyy'),nvl(sum(VOUCHER_AMT),0),nvl(sum(BILL_AMT_CONTRACTOR),0),sanction_amount*100000 from RWS_WORK_BILL_TBL c ,rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and a.work_id=c.work_id and substr(office_code,2,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"' group by a.work_id,a.VOUCHER_NO, a.VOUCHER_DT,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,c.bill_no";
        String qry="select distinct nvl((a.work_id),'-'),work_name,nvl((a.voucher_no),'-'),nvl((to_char(a.VOUCHER_DT,'dd/mm/yyyy')),'-'),nvl((a.VOUCHER_AMT),0),ADMIN_NO,to_char(admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT from rws_work_exp_voucher_tbl a , rws_work_admn_tbl b   where a.work_id(+)=b.work_id and substr(office_code,2,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"'";
        System.out.println("rry****"+qry);
        stmt1=conn.createStatement();
    	rs1=stmt1.executeQuery(qry);
    		boolean flag=false;
    	while(rs1.next())
    	{
    	 		
    	 		String qry2="select distinct nvl(sum(BILL_AMT_CONTRACTOR),0) from RWS_WORK_BILL_TBL where work_id='"+rs1.getString(1)+"'";
    	 		stmt2=conn.createStatement();
    	     rs2=stmt2.executeQuery(qry2);
       	%>
    	   <tr>
    	         <td class=rptValue ><%=sno++%></td>
				<td class=rptValue ><%=rs1.getString(1)%></td>
				<td class=rptValue ><%=rs1.getString(2)%></td>
				
                
   				<td class=rptValue ><%=rs1.getString(3)%></td>
				<td class=rptValue ><%=rs1.getString(4)%></td>		
				<td class=rptValue ><%=rs1.getString(5)%></td>
				<td class=rptValue ><%=rs1.getString(6)%></td>
				<td class=rptValue ><%=rs1.getString(5)%></td>
				<td class=rptValue ><%=rs1.getString(8)%></td>
		
    	<%
    
    		flag=false;
    	      	while(rs2.next())
    	{
    	   	    	 		
    	   	    	 		         flag=true;          
        %>   
         		
				
				<td class=rptValue ><%= rs2.getString(1) %></td>
				
        <%} if(!flag){%>

				<td class=rptValue >-</td>
			
        <% }%>
        
        
        </tr>
        <% 
        
         }   }  
        
        
       catch(Exception e)
{
	e.printStackTrace();
}
finally
{
} 
        
         %> 


 
 </table>

<%@ include file = "footer.jsp" %>
 </body>
</html>