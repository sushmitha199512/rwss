<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp"%>
<%
String dcode=request.getParameter("dcode");
String dname=request.getParameter("dname");
String ccode="";
if(request.getParameter("cat")!=null)
{
ccode=request.getParameter("cat");
}
//System.out.println("ccode::"+ccode);

//System.out.println("dcode::"+dcode);

int sno=1;
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr>
			<td class="btext" colspan="17">AAP Habitation Under the District:<font color="green"><%=dname%></font></td></tr>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>  Habitation Coverage Status Details  </td>	
		</tr>
	<tr align="center" bgcolor="#ffffff">
			<td class=btext >Sno</td>
			<td class=btext >Hab Code</td>
			<td class=btext >Hab Name</td>
			<td class=btext >CoverageStatus</td>
			
						</tr>
<tr>
			<% 
try{
    stmt = conn.createStatement();
			DecimalFormat ndf = new DecimalFormat("####.00");
	int year = Calendar.getInstance().get(Calendar.YEAR); 
	String yr=Integer.toString(year);
			String query="";




//updated by jyothi on 17-03-12 for correction
	    query=" SELECT distinct w.hab_code,h.coverage_status,ch.panch_name FROM  RWS_WORK_COMP_HAB_LNK_TBL  W,rws_aap_selected_tbl b ,rws_work_admn_tbl c,rws_habitation_directory_tbl h,rws_complete_hab_view ch where w.work_id=b.work_id and w.hab_code=h.hab_code and ch.panch_code=h.hab_code  and substr(b.work_id,5,2)='"+dcode+"' and c.work_id=b.work_id and b.work_id  in(select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))";
		if(ccode!=null && !ccode.equals("0"))
			{
			query+=" and category_code='"+ccode+"'";
			}
			query+=" order by 2,3";
			System.out.println("detailed qry:::"+query);
	         rs = stmt.executeQuery(query);
				while(rs.next())
				{ %>
				
			<td class=rptValue align="center"><%=sno++%></td>
			<td class=rptValue ><%=rs.getString(1)%></td>
			<td class=rptValue ><%=rs.getString(3)%></td>
			<td class=rptValue ><%=rs.getString(2)%></td>
			
					</tr>		
			<%}

}catch(SQLException e)
{e.printStackTrace();}%>
			
			</table>
</body>
</html>

