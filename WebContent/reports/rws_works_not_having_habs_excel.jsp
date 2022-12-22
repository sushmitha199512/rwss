<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null;
    String qry="";
	String dname=(String)session.getAttribute("dname");

    int sno=1;
String qry8="",qry9="";
	
	String dcode=(String)session.getAttribute("district");
      
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Works Not Having Habitaions   - Report</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td class=btext>District:<font color=red><%=dname%></font></font></td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap align=center>Sl.No</td>
    <td class=btext  nowrap align=center>District</td>
	<td class=btext  nowrap align=center>Work_ID</td>
    <td class=btext  nowrap align=center>Work Name</td>
	<td class=btext  nowrap align=center>Santioned Date</td>
	<td class=btext  nowrap align=center>Santion Amount</td>
	<td class=btext  nowrap align=center>NO Of Habs</td>
	<td class=btext  nowrap align=center>Programme</td>
    	<td class=btext  nowrap align=center>Sub Programme</td>

	
	</tr>
<%
try
{
	    
stmt8=conn.createStatement();

if(dcode.equals("ALL"))
{
qry8="select dis.dname,work_id ,work_name,to_char(ADMIN_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT, nvl(NO_OF_HABS,'0'),p.programme_name,sp.subprogramme_name from rws_work_admn_tbl,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_district_tbl dis where work_id  not in(select work_id from rws_admn_hab_lnk_tbl ) and WORK_CANCEL_DT is null and substr(work_id,7,2)<>11 and  substr(work_id,7,2)<>12 and substr(work_id,1,2)=p.programme_code and p.programme_code=sp.programme_code and substr(work_id,3,2)=sp.subprogramme_code and  substr(work_id,5,2)=dis.dcode";
}
else
{
qry8="select dis.dname,work_id ,work_name,to_char(ADMIN_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT, nvl(NO_OF_HABS,'0'),p.programme_name,sp.subprogramme_name from rws_work_admn_tbl,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_district_tbl dis where work_id  not in(select work_id from rws_admn_hab_lnk_tbl ) and WORK_CANCEL_DT is null and substr(work_id,7,2)<>11 and  substr(work_id,7,2)<>12 and substr(work_id,1,2)=p.programme_code and p.programme_code=sp.programme_code and substr(work_id,3,2)=sp.subprogramme_code and  substr(work_id,5,2)=dis.dcode and dis.dcode='"+dcode+"'";
}

System.out.println("qry8:"+qry8);

 ResultSet rrs=stmt8.executeQuery(qry8);
  
while(rrs.next()){
  %>

	<tr>
    <td class="rptValue"><%=sno++%></td>
        <td class="rptValue" align=left><%=rrs.getString(1) %></td>
    <td class="rptValue" align=left><%=rrs.getString(2) %></td>
 <td class="rptValue" align=left><%=rrs.getString(3) %></td>  
    <td class="rptValue" align=left><%=rrs.getString(4) %></td>
    <td class="rptValue" align=right><%=rrs.getString(5) %></td>  
<td class="rptValue" align=left><%=rrs.getString(6) %></td>
    <td class="rptValue" align=left><%=rrs.getString(7) %></td>  
<td class="rptValue" align=left><%=rrs.getString(8) %></td>

    </tr>

<% 
	}
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
try
{
if(stmt8 != null)
{
stmt8.close();
}

if( conn != null )
{
conn.close();
}
}
catch(SQLException p)
{
p.printStackTrace();
}
}
%>
     

</table>

  
