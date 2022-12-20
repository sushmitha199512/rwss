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
			<td class="btext" colspan="17">AAP works Under the District:<font color="green"><%=dname%></font></td></tr>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>  Work Details  </td>	
		</tr>
	<tr align="center" bgcolor="#ffffff">
			<td class=btext >Sno</td>
			<td class=btext >Division</td>
			<td class=btext >WorkId</td>
			<td class=btext >Work Name</td>
			<td class=btext>Programme Name</td>
			<td class=btext>SubProgramme<br> Name</td>
			<td class=btext >Scheme</td>
			<td class=btext >Admin Date</td>
			<td class=btext >Type</td>
			<td class=btext >Category</td>
			<td class=btext >Estimate Cost</td>
			<td class=btext >Date of Completion</td>
						</tr>
<tr>
			<% stmt = conn.createStatement();
			DecimalFormat ndf = new DecimalFormat("####.00");
	int year = Calendar.getInstance().get(Calendar.YEAR); 
	String yr=Integer.toString(year);
			
			String query="select d.division_office_name ,a.work_id,a.work_name,p.programme_name,sp.subprogramme_name,decode (category_code,1,'PLAN',2,'NON-PLAN') AS plan,decode (category_code,1,'PROJECTS',2,'NORMAL') AS CAT,decode (aug_new_code,1,'MainScheme',2,'Augmentation') AS aug ,to_char(ADMIN_DATE,'dd/mm/yyyy') as adate,SANCTION_AMOUNT,type_of_asset_name,to_char(date_of_completion,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_aap_selected_tbl b,rws_division_office_tbl d,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_asset_type_tbl t,rws_work_completion_tbl c  where a.work_id=b.work_id and d.circle_office_code||d.division_office_code=substr(office_code,2,3) and a.programme_code=sp.programme_code and p.programme_code=sp.programme_code and a.subprogramme_code=sp.subprogramme_code and work_cancel_dt is null  and a.work_id  in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"')) and type_of_asset_code=substr(a.work_id,7,2) and c.work_id(+)=b.work_id  and substr(a.work_id,5,2)='"+dcode+"' ";
			if(ccode!=null && !ccode.equals("0"))
			{
			query+=" and category_code='"+ccode+"'";
			}
			query+=" order by 1";
			//System.out.println("qqqqqqqq:::"+query);
	  rs = stmt.executeQuery(query);
				while(rs.next())
				{ %>
				
			<td class=rptValue align="center"><%=sno++%></td>
			<td class=rptValue ><%=rs.getString(1)%></td>
			<td class=rptValue ><%=rs.getString(2)%></td>
			<td class=rptValue ><%=rs.getString(3)%></td>
			<td class=rptValue ><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<%if(rs.getString("type_of_asset_name")==null){%>
			<td class=rptValue >-</td>
			<%}else{%>
			<td class=rptValue ><%=rs.getString("type_of_asset_name")%></td>
			<%}%>
			<td class=rptValue ><%=rs.getString("adate")%></td>
			<%if(rs.getString(6)==null){%>
			<td class=rptValue >-</td>
			<%}else{%>
			<td class=rptValue nowrap><%=rs.getString(6)%></td>
			<%}%>
			<%if(rs.getString("cat")==null){%>
			<td class=rptValue >-</td>
			<%}else{%>
			<td class=rptValue ><%=rs.getString("cat")%></td>
			<%}%>
			<td class=rptValue align="right"><%=rs.getString(10)%></td>
<%if(rs.getString(12)==null){%>
			<td class=rptValue >-</td>
			<%}else{%>
			<td class=rptValue align="right"><%=rs.getString(12)%></td>
						<%}%>
				
					</tr>		
			<%}%>
			
			</table>
</body>
</html>

