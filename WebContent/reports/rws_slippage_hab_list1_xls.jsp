<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%

String dcode=(String)session.getAttribute("dcode");
	
String mandal=(String)session.getAttribute("mandal");

String dname=(String)
session.getAttribute("dname");

String mname=(String)
session.getAttribute("mname");

String fyear=(String)
session.getAttribute("fyear");

String tyear=(String)
session.getAttribute("tyear");

String qry="";

String qry1="";
WorksData1 wd = new WorksData1();
int cur_year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
int cur_year=cur_year1;
int fyear1=Integer.parseInt(fyear);
int tyear1=Integer.parseInt(tyear);
%>
<form>
<p align="center"><font face=verdana size=2><b>Status Of Habitations From: <%=fyear%>&nbsp;To: <%=tyear%></b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%></font>&nbsp; 
<font color="blue" face=verdana size=2>Mandal:</font><font color="black" face=verdana size=2><%=mname%></font>&nbsp; </p>
<p align="left">
<font face=verdana size=2><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note:***</font><font face=verdana size=2 color="red"> Pink Colored Rows represents Slipped Back Habitation</b></p>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext ><b>S.No</b></font></td>
<td class=btext ><b>Habitation Code</b></font></td>
<td class=btext><b>Habitation Name</b></font></td>
<%for (int y = cur_year;y>=fyear1;y--)
{
%>
	<td class=btext><b><%=y%></b></font></td>
<%
}
%>
<%
int count=1;
	qry1="select panch_code,panch_name,mname,PREVIOUS_YR_STATUS,COVERAGE_STATUS from RWS_COMPLETE_HAB_VIEW  where dcode='"+dcode+"'  and mcode='"+mandal+"'"; 
	//System.out.println("............."+qry1);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry1);

	while(rs.next())
	{
		int cuur_stat1=0;
		int prev_status1=0;
		String cuur_stat = rs.getString("COVERAGE_STATUS");
		String prev_status = rs.getString("PREVIOUS_YR_STATUS");
		if(cuur_stat==null)cuur_stat="-";
		if(prev_status==null)prev_status="-";
		if(cuur_stat.equals("FC"))
		  cuur_stat1=1;
		if(cuur_stat.equals("PC4"))
		  cuur_stat1=2;
		if(cuur_stat.equals("PC3"))
		  cuur_stat1=3;
		if(cuur_stat.equals("PC2"))
		  cuur_stat1=4;
		if(cuur_stat.equals("PC1"))
		  cuur_stat1=5;
		if(cuur_stat.equals("NC"))
		  cuur_stat1=6;
		if(cuur_stat.equals("NSS"))
		  cuur_stat1=7;
			  
		if(prev_status.equals("FC"))
		  prev_status1=1;
		if(prev_status.equals("PC4"))
		  prev_status1=2;
		if(prev_status.equals("PC3"))
		  prev_status1=3;
		if(prev_status.equals("PC2"))
		  prev_status1=4;
		if(prev_status.equals("PC1"))
		  prev_status1=5;
		if(prev_status.equals("NC"))
		  prev_status1=6;
		if(prev_status.equals("NSS"))
		  prev_status1=7;  

  qry = "select(select COVERAGE_STATUS from RWS_HABITATION_DIRECTORY_TBL where hab_code='"+rs.getString(1)+"')current_yr,(select COVERAGE_STATUS from RWS_HABITATION_DIr_his_TBL where hab_code='"+rs.getString(1)+"')last ";
	for (int y = cur_year-2;y>=2006;y--)
	{
		qry += ",(select COVERAGE_STATUS from RWS_HABITATION_DIr_his"+y+"_TBL where hab_code='"+rs.getString(1)+"')a"+y;	
	}
	qry += " from dual";
	//System.out.println(qry);
	
	stmt=conn.createStatement();
	ResultSet rs1=stmt.executeQuery(qry);
	if(rs1.next())
	{
			if(prev_status1 < cuur_stat1){
			%>
				<tr bgcolor="pink">
			<%
			}else{
			%>
			<tr>
			<%}%>
			<td class=rptvalue ><%=count++%></td>
			<td class=rptvalue nowrap><%=rs.getString(1)%></td>
			<td class=rptvalue  nowrap><%=rs.getString(2)%></td>
			<%
			int j = 0;
			for (int y = cur_year;y>=fyear1;y--)
			{
				j++;
				if(y==cur_year)
					{    
			%>        
					<td class=rptValue>
					<%if(rs1.getString(j)!=null && !rs1.getString(j).equals("")){
							out.println(rs1.getString(j));
					}else 
					out.println("<font color=blue><b>Not Exists</font>");%>
					</td><%}
				else if(y==cur_year-1){%>
					<td class=rptValue>
					<%if(rs1.getString(j)!=null && !rs1.getString(j).equals(""))
					out.println(rs1.getString(j));
					else 
					out.println("<font color=blue><b>Not Exists</font>");%>
					</td>
					<%}
				else if(y==cur_year-2){%>
					<td class=rptValue>
					<%if(rs1.getString(j)!=null && !rs1.getString(j).equals(""))
					out.println(rs1.getString(j));
					else 
					out.println("<font color=blue><b>Not Exists</font>");%>
					</td>
					<%}
				else if(y==cur_year-3){%>
					<td class=rptValue>
					<%if(rs1.getString(j)!=null && !rs1.getString(j).equals(""))
					out.println(rs1.getString(j));
					else 
					out.println("<font color=blue><b>Not Exists</font>");%>
					</td>
					<%}
					else if(y==cur_year-4){%>
					<td class=rptValue width="90px">
					<%if(rs1.getString(j)!=null && !rs1.getString(j).equals(""))
					out.println(rs1.getString(j));
					else 
					out.println("<font color=blue><b>Not Exists</font>");%>
					</td>
					<%}
				}%>
		<%}}%>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

