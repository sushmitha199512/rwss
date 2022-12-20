<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<jsp:useBean id="cList" class="nic.watersoft.commons.CommonLists" scope="request"/>
<%@page import="nic.watersoft.commons.LabelValueBean" %>

<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs2=null,rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	int sno=0;
	int total1=0,total2=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0;
    String[] popRange = {"SC","ST","PLAIN"};
	String per = request.getParameter("per");
	String prog = request.getParameter("prog");
	String type = request.getParameter("type");
	if(per==null)per="1";
	if(prog==null)prog="ALL";
	if(type==null)type="1";
	ArrayList a = cList.getProgrammes();
	////System.out.println(a.size());
	String progSelection =" ";
	if(!prog.equals("ALL"))
		progSelection = " and a.programme_code='"+prog+"'";
%>
<html>
<title> WaterSoft </title>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table width="880" align="center">
<tr>
<td class="bwborder"><a href="../home.jsp">Home</a></td>
</tr>
</table>
<table border = 0 cellspacing = 0 cellpadding = 0 width=30% bordercolor=#000000 style="border-collapse:collapse">

	<tr>
		<td class="textborder" align="center" colspan="8">Category&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="per" onchange="this.form.submit()">
			<%if(per!=null && per.equals("1")){%>
			<option value="1" selected>Projects</option>
			<option value="2">Normal</option>
			<%}
			else if(per!=null && per.equals("2")){%>
				<option value="1">Projects</option>
				<option value="2" selected>Normal</option>
			<%}
			else
			{
			%>
				<option value="1">Projects</option>
				<option value="2">Normal</option>
			<%
			}
			%>
		</select>
		</font></td>
	</tr>
<tr>
<td>&nbsp;</td></tr>
	<tr>
		<td class="textborder" align="center" colspan="8">Program&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="prog" onchange="this.form.submit()">
				<option value="ALL">ALL</option>
				<%
			
			for(int i=0;i<a.size();i++)
			{
				LabelValueBean labelValueBean = (LabelValueBean)a.get(i);
				if(labelValueBean.getValue().equals(prog))
				{
					%>
				<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabel()%></option>
				<%}
				else
				{
						%>
				<option value="<%=labelValueBean.getValue()%>" ><%=labelValueBean.getLabel()%></option>
				<%
				}
			}
			%>
		</select>
		</font></td>
	</tr>
	<td>&nbsp;</td></tr>
	<tr>
		<td class="textborder" align="center" colspan="8">Selection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="type" onchange="this.form.submit()">
			<%if(type!=null && type.equals("1")){%>
				<option value="1" selected>>20/MAY/2010</option>
				<option value="2">Spill Over</option>
			<%}
			else if(type!=null && type.equals("2")){%>
				<option value="1">>20/MAY/2010</option>
				<option value="2" selected>Spill Over</option>
			<%}
			else
			{
			%>
				<option value="1">>20/MAY/2010</option>
				<option value="2">Spill Over</option>
			<%
			}
			%>
		</select>
		</font></td>
	</tr>
</table><BR>
<%if(per!=null && !per.equals("")){
		int percentage = Integer.parseInt(per);
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">District Wise - Status Wise- Works Report </font></td>
	</tr>
<tr><td valign=top>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=38>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Disrict</td>
		<td class=btext>Total</td>
		<td class=btext>FC</td>
		<td class=btext>PC4</td>
		<td class=btext>PC3</td>
		<td class=btext>PC2</td>
		<td class=btext>PC1</td>
		<td class=btext>NC</td>				
		<td class=btext>NSS</td>	
	</tr>
	<%
	try
		{
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2=st2.executeQuery("select distinct d.dcode,d.dname from rws_district_tbl d  where dcode <> '16'  order by d.dcode,d.dname");
int tot=0,fc=0,pc4=0,pc3=0,pc2=0,pc1=0,nc=0,nss=0;
int total=0,fctot=0,pc4tot=0,pc3tot=0,pc2tot=0,pc1tot=0,nctot=0,nsstot=0;
while(rs2.next())
{
	tot=0;fc=0;pc4=0;pc3=0;pc2=0;pc1=0;nc=0;nss=0;
	////System.out.println("Type:"+type);
	if(type.equals("1"))
		query3 = "select distinct a.work_id,a.work_name,sanction_amount,b.hab_code,census_sc_popu+census_st_popu+census_plain_popu+FLOAT_POP as tot, exist_water_level,unsafe_lpcd,HPS_OTH_SUPPLY_UNSAFE,PWS_UNSAFE_SUPPLY,MPWS_UNSAFE_SUPPLY,COVERAGE_STATUS from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c, rws_hab_supply_status_tbl d where a.work_id=b.work_id and a.category_code='"+per+"' and b.hab_code=c.hab_code and c.hab_code=d.hab_code and b.hab_code=d.hab_code and category_code<> '03' "+progSelection+" and prepared_on>='20/MAY/2010'  and substr(a.work_id,5,2)='"+rs2.getString(1)+"' and work_cancel_dt is null";
	else if(type.equals("2"))
		query3 = "select distinct a.work_id,a.work_name,sanction_amount,b.hab_code,census_sc_popu+census_st_popu+census_plain_popu+FLOAT_POP as tot, exist_water_level,unsafe_lpcd,HPS_OTH_SUPPLY_UNSAFE,PWS_UNSAFE_SUPPLY,MPWS_UNSAFE_SUPPLY,COVERAGE_STATUS from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c, rws_hab_supply_status_tbl d where a.work_id=b.work_id and a.category_code='"+per+"' and b.hab_code=c.hab_code and c.hab_code=d.hab_code and b.hab_code=d.hab_code and category_code<> '03' "+progSelection+"  and (a.ADMIN_DATE < '01-Apr-2010' or a.ADMIN_DATE >= '01-Apr-2010') and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2010')) and substr(a.work_id,5,2)='"+rs2.getString(1)+"'  and work_cancel_dt is null ";
	//query3 = "SELECT work_id,office_code,no_of_habs FROM RWS_WORK_ADMN_TBL W where w.category_code='1' and w.ADMIN_DATE < '01-Apr-2010' and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2010'))";
	////System.out.println("qry:"+query3);
	try
	{
	st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs3 = st3.executeQuery(query3);
	while(rs3.next())
	{
		tot++;
		/* int supply = rs3.getInt("HPS_OTH_SUPPLY_UNSAFE")+rs3.getInt("PWS_UNSAFE_SUPPLY")+rs3.getInt("MPWS_UNSAFE_SUPPLY");
		double lpcd = (rs3.getInt("HPS_OTH_SUPPLY_UNSAFE")+rs3.getInt("PWS_UNSAFE_SUPPLY")+rs3.getInt("MPWS_UNSAFE_SUPPLY"))/(rs3.getInt("tot")*Math.pow(1.01,9));
		double safeUnsafepartlyLpcd = rs3.getDouble("EXIST_WATER_LEVEL")+lpcd;*/
		String calCoverageStatus = "";
		/*//System.out.println("1:"+supply);
		//System.out.println("2:"+lpcd);
		//System.out.println("3:"+rs3.getDouble("EXIST_WATER_LEVEL"));
		//System.out.println("4:"+rs3.getString("unsafe_lpcd"));
		//System.out.println("5:"+safeUnsafepartlyLpcd);
		//System.out.println("6:"+rs3.getString("hab_code"));*/
		/*if(rs3.getDouble("unsafe_lpcd")==0.0 && rs3.getDouble("EXIST_WATER_LEVEL")==0.0)
		{
			calCoverageStatus = "NC";
		}
		else if(safeUnsafepartlyLpcd==0.0 && ((rs3.getDouble("unsafe_lpcd")+rs3.getDouble("EXIST_WATER_LEVEL"))-safeUnsafepartlyLpcd)!=0.0)
		{
			calCoverageStatus = "NSS";
		}
		else if(safeUnsafepartlyLpcd>0 && safeUnsafepartlyLpcd<10)
		{
				calCoverageStatus = "PC1";
		}
		else if(safeUnsafepartlyLpcd>=10 && safeUnsafepartlyLpcd<20)
		{
				calCoverageStatus = "PC2";
		}
		else if(safeUnsafepartlyLpcd>=20 && safeUnsafepartlyLpcd<30)
		{
				calCoverageStatus = "PC3";
		}
		else if(safeUnsafepartlyLpcd>=30 && safeUnsafepartlyLpcd<40)
		{
				calCoverageStatus = "PC4";
		}
		else if(safeUnsafepartlyLpcd>=40)
		{
				calCoverageStatus = "FC";
		}*/
		calCoverageStatus = rs3.getString("COVERAGE_STATUS");
		if(calCoverageStatus.equals("FC"))
			fc++;
		if(calCoverageStatus.equals("PC4"))
			pc4++;
		if(calCoverageStatus.equals("PC3"))
			pc3++;
		if(calCoverageStatus.equals("PC2"))
			pc2++;
		if(calCoverageStatus.equals("PC1"))
			pc1++;
		if(calCoverageStatus.equals("NC"))
			nc++;
		if(calCoverageStatus.equals("NSS"))
			nss++;
	}
		total+=tot;
		fctot += fc;
		pc4tot += pc4;
		pc3tot += pc3;
		pc2tot += pc2;
		pc1tot += pc1;
		nctot += nc;
		nsstot += nss;
	%>
			<tr>	
		     <td class=rptValue><%=++sno%></td>
		     <td class=rptValue><%=rs2.getString(2)%></td>
			 <td class=btext ALIGN="RIGHT"><font color=red><%=tot%></font></td>
			 <td class=rptValue ALIGN="RIGHT"><%=fc%></td>
			 <td class=rptValue ALIGN="RIGHT"><%=pc4%></td>
			 <td class=rptValue ALIGN="RIGHT"><%=pc3%></td>
			 <td class=rptValue ALIGN="RIGHT"><%=pc2%></td>
			 <td class=rptValue ALIGN="RIGHT"><%=pc1%></td>
			 <td class=rptValue ALIGN="RIGHT"><%=nc%></td>
			 <td class=rptValue ALIGN="RIGHT"><%=nss%></td>
			</tr>
<%
			}
				catch(Exception e)
			{//System.out.println(e.getMessage());
				}
				finally
			{
					if(rs3!=null)rs3.close();
					if(st3!=null)st3.close();
			}
		}
				%>
				<tr>	
					 <td class="btext" colspan="2">Total</td>
					<td class="btext" ALIGN="RIGHT"><font color=red><%=total%></font></td> 
					<td class=rptValue ALIGN="RIGHT"><%=fctot%></td>
					 <td class=rptValue ALIGN="RIGHT"><%=pc4tot%></td>
					 <td class=rptValue ALIGN="RIGHT"><%=pc3tot%></td>
					 <td class=rptValue ALIGN="RIGHT"><%=pc2tot%></td>
					 <td class=rptValue ALIGN="RIGHT"><%=pc1tot%></td>
					 <td class=rptValue ALIGN="RIGHT"><%=nctot%></td>
					 <td class=rptValue ALIGN="RIGHT"><%=nsstot%></td>
			</tr>
				<%
		}
		catch(Exception e)
		{e.printStackTrace();}
		finally
		{
			if(rs2!=null)rs2.close();
			if(st2!=null)st2.close();
			if(conn!=null)conn.close();
		}
	%>
</table>
</table>
<p align=center>
<font face=verdana size=2 color=red><b>
Note:***** District Level Works Not Included
</b>
</font>
</p>
<%}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>