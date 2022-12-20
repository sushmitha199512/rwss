<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp"%>
<%
String dcode=request.getParameter("dcode");
String mcode=request.getParameter("mcode");
String pcode=request.getParameter("pcode");
String scode=request.getParameter("schoolcode");
//System.out.println("dcode::"+dcode);
//System.out.println("mcode::"+mcode);
//System.out.println("pcode::"+pcode);
//System.out.println("schoolcode::"+scode);
int sno=1;
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>  School Details </td>	
		</tr>
	<tr align="center" bgcolor="#ffffff">
			<td class=btext >Sno</td>
			<td class=btext >Hab Name</td>
			<td class=btext >School Code</td>
			<td class=btext >School Name</td>
			<td class=btext>School Category Name</td>
			<td class=btext >School Clasification</td>
			<td class=btext >No.of Students</td>
			<td class=btext >Facilities Available</td>
			<td class=btext >Separate Toilet <br>for Boys&Girls</td>
			<td class=btext>Separate Urinal <br>for Boys&Girls</td>
			</tr>
<tr>
			<% stmt = conn.createStatement();
			String query="select panch_name, SCHOOL_CODE ,SCHOOL_NAME ,SCHOOL_CATEGORY_name,SCHOOL_CLASSIFICATION,NO_OF_STUDENTS,FACILITIES_AVAILABLE,SEPARATE_TOILET_GIRLS_BOYS,SEPARATE_URINAL_GIRLS_BOYS from rws_school_master_tbl a,rws_school_category_tbl b,rws_complete_hab_view c   where   substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  and substr(hab_code,13,2)='"+pcode+"'  and a.School_category_code='"+scode+"' and a.SCHOOL_CATEGORY_CODE=b.SCHOOL_CATEGORY_CODE and a.hab_code=c.panch_code";
			//System.out.println("qqqqqqqq:::"+query);
	        ResultSet rs = stmt.executeQuery(query);
				while(rs.next())
				{ %>
				
			<td class=rptValue align="right"><%=sno++%></td>
			<td class=rptValue align="right"><%=rs.getString(1)%></td>
			<td class=rptValue align="right"><%=rs.getString(2)%></td>
			<td class=rptValue align="right"><%=rs.getString(3)%></td>
			<td class=rptValue align="right"><%=rs.getString(4)%></td>
			<td class=rptValue align="right"><%=rs.getString(5)%></td>
			<td class=rptValue align="right"><%=rs.getString(6)%></td>
			<td class=rptValue align="right"><%=rs.getString(7)%></td>
			<td class=rptValue align="right"><%=rs.getString(8)%></td>
			<td class=rptValue align="right"><%=rs.getString(9)%></td>
			</tr>		
			<%}%>
			
			</table>
</body>
</html>

