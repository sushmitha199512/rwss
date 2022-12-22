<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<%
String drill = request.getParameter("drill");
if(drill!=null){
session.setAttribute("drill",drill);
}
DecimalFormat ndf=new DecimalFormat("####.00");
String repType = request.getParameter("repType");
String havingCond = "";
if(repType!=null && repType.equals("Single")){havingCond = " having count(*)=1 ";}
else if(repType!=null && repType.equals("Multiple"))havingCond = " having count(*)>1 ";
String district = request.getParameter("dcode");
String division = request.getParameter("divcode");
String subdivision = request.getParameter("subdivcode");

%>
<head>
<title></title>

 </head>
<body bgcolor="#edf2f8">
<form action="rws_work_abstract_all_rpt.jsp">
<%if(repType==null)
{
%>
<BR>
<BR>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="40%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">List of Habitations covered in ongoing works</font></td>		
		</tr>
		<tr align="center">
			<td class = btext colspan="2">
				<font color=navy><b>Type Of Report</b> </font>
				<font color=red><b>*</b> </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select name="repType" style="width:150px" class="mycombo">
					<option value="Single">Single Hab Works</option>
					<option value="Multiple">Multiple Hab Works</option>				
<!-- 					<option value="MultipleMandal">Multiple Hab Works - Mandal Wise</option> -->
				</select>
			</td>
		</tr>
		<tr align="center">
			<td colspan=2 align=center>
				<input type=submit value="View Report" class = btext>
		</td>
		</tr>
		</table>
<%
}
else if(repType.equals("Single"))
{
	int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col9=0,col12=0,col15=0,col18=0,col19=0,col20=0,col23=0,col26=0,col29=0,col30=0,col31=0,col34=0,col37=0;
	double col5=0.0,col6=0.0,col10=0.0,col11=0.0,col13=0.0,col14=0.0,col16=0.0,col17=0.0,col21=0.0,col22=0.0,col24=0.0,col25=0.0,col27=0.0,col28=0.0,col32=0.0,col33=0.0,col35=0.0,col36=0.0,col38=0.0,col39=0.0;
%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=42><font style="text-transform: uppercase;">List of Habitations covered in ongoing works Having <%=repType%> Habitations</font></td>		
	</tr>
<%
////////System.out.println("Drill:"+drill);
if(drill==null)drill="null";
if(drill.equals("null"))
{ %>
	<tr  align="center">
		<td align="center" class="btext" colspan="42" >District: All &nbsp; &nbsp;</td>
	</tr>	
	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext rowspan = 3>Total Habs</td>
		<td class=btext rowspan = 3>Total Population</td>
		<td class=btext colspan=2>Total Works</td>
		<td class=btext rowspan = 3>Total Est. Cost</td>
		<td class=btext rowspan = 3>Total Exp Incurred</td>
		<td  colspan=11 align="center" class="rptHeading" bgcolor="#8A9FCD">SC Hab Sub Type</td>
		<td  colspan=11 class="rptHeading" bgcolor="#8A9FAD" align="center">ST Hab Sub Type</td>
		<td  colspan=11 class="rptHeading" bgcolor="#8A9FCD" align="center">PLAIN Hab Sub Type</td>
	</tr>
	
	<tr>
		<td rowspan=2 colspan=1 class=btext align="center">No Of HP's</td>	
		<td rowspan=2 colspan=1 class=btext align="center">No. of schemes</td>	
		
		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>


		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>

		
	</tr>
	<tr>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
	</tr>
	<%
	String getDnameQuery = "select dcode,dname from rws_district_tbl where  dcode  <> '16' order by dcode";
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno=1;
		Statement col1st = conn.createStatement();
		Statement col2st  = conn.createStatement();
		Statement col3st  = conn.createStatement();
		Statement col4st  = conn.createStatement();
		ResultSet col1rs = null,col2rs = null,col3rs = null,col4rs = null;
		while(rs2.next())
		{ 
				
			%>
				<tr>
						<td class=rptValue><%=sno++%></td>
						<td class="rptValue"><%=rs2.getString(2)%></td>
		    <%
				String habSubType = "";
				int workcount=0;
				int schabcount=0,sthabcount=0,plainhabcount=0;
				int schabscpop=0,schabstpop=0,schabplainpop=0;
				int sthabscpop=0,sthabstpop=0,sthabplainpop=0;
				int plainhabscpop=0,plainhabstpop=0,plainhabplainpop=0;
				double totEstCost=0;double totExp = 0.0;
				String q1 = "select distinct hab_code,habitation_sub_type,census_sc_popu,census_st_popu,census_plain_popu from rws_work_hab_view where work_id in (select work_id from rws_work_habcount_view where habcount=1 and substr(work_id,5,2) ='"+rs2.getString(1)+"')";
				////System.out.println("q111:"+q1);
				col1rs = col1st.executeQuery(q1);
				while(col1rs.next())
				{
					if(col1rs.getString(2).equals("SC"))
					{
						schabcount++;
						schabscpop += col1rs.getInt(3);
						schabstpop += col1rs.getInt(4);
						schabplainpop += col1rs.getInt(5);
					}
					else if(col1rs.getString(2).equals("ST"))
					{
						sthabcount++;
						sthabscpop += col1rs.getInt(3);
						sthabstpop += col1rs.getInt(4);
						sthabplainpop += col1rs.getInt(5);
					}
					else if(col1rs.getString(2).equals("PLAIN"))
					{
						plainhabcount++;
						plainhabscpop += col1rs.getInt(3);
						plainhabstpop += col1rs.getInt(4);
						plainhabplainpop += col1rs.getInt(5);
					}
			   }
			   col1 += schabcount+sthabcount+plainhabcount;
			   col2 += schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop;
			   %>
				   <td class=rptValue><%=schabcount+sthabcount+plainhabcount%></td>
				   <td class=rptValue><%=schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop%></td>
			   <%   
				   String q2 = "select work_id,SANCTION_AMOUNT from rws_work_admn_tbl where work_id in (select work_id from rws_work_habcount_view where habcount=1 and substr(work_id,5,2) ='"+rs2.getString(1)+"') and substr(work_id,7,2)='04'";
				   //System.out.println("q2:"+q2);
				   col2rs = col2st.executeQuery(q2);
				   				   //System.out.println("aaaaaaa");
					while(col2rs.next()){workcount++;totEstCost+=col2rs.getDouble(2);}
									   //System.out.println("bbbbbbbbb");
					col3+=workcount;
									   //System.out.println("ccccccc");
					%><td class=rptValue><%=workcount%></td><%
					workcount = 0;
					String q3 = "select work_id,SANCTION_AMOUNT from rws_work_admn_tbl where work_id in (select work_id from rws_work_habcount_view where habcount=1 and substr(work_id,5,2) ='"+rs2.getString(1)+"') and substr(work_id,7,2)<>'04'";
									   //System.out.println("q3:"+q3);
					col3rs = col3st.executeQuery(q3);
					while(col3rs.next()){workcount++;totEstCost+=col3rs.getDouble(2);}
					col4+=workcount;
					col5+=totEstCost;
					%>
						<td class=rptValue><%=workcount%></td>
						<td class=rptValue><%=ndf.format(totEstCost)%></td>
					<%
					String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select work_id from rws_work_habcount_view where habcount=1 and substr(work_id,5,2) ='"+rs2.getString(1)+"')";
									   //System.out.println("q4:"+q4);
					col4rs = col4st.executeQuery(q4);
					while(col4rs.next()){if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp+=col4rs.getDouble(1);}
					col6+=totExp;
					col7+=schabcount;
					col8 += schabscpop+schabstpop+schabplainpop;
					col9 += schabscpop;
					col10 += (schabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col11 += (schabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col12 += schabstpop;
					col13 += (schabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col14 += (schabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col15 += schabplainpop;
					col16 += (schabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col17 += (schabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);

					col18 += sthabcount;
					col19 += sthabscpop+sthabstpop+sthabplainpop;
					col20 += sthabscpop;
					col21 += (sthabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col22 += (sthabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col23 += sthabstpop;
					col24 += (sthabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col25 += (sthabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col26 += sthabplainpop;
					col27 += (sthabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col28 += (sthabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);

					col29 += plainhabcount;
					col30 += plainhabscpop+plainhabstpop+plainhabplainpop;
					col31 += plainhabscpop;
					col32 += (plainhabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col33 += (plainhabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col34 += plainhabstpop;
					col35 += (plainhabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col36 += (plainhabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col37 += plainhabplainpop;
					col38 += (plainhabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col39 += (plainhabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					%>
						<td class=rptValue><%=totExp%></td>

						<td class=rptValue><%=schabcount%></td>
						<td class=rptValue><%=schabscpop+schabstpop+schabplainpop%></td>
						<td class=rptValue><%=schabscpop%></td>
						<td class=rptValue><%=ndf.format((schabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=schabstpop%></td>
						<td class=rptValue><%=ndf.format((schabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=schabplainpop%></td>
						<td class=rptValue><%=ndf.format((schabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>

						<td class=rptValue><%=sthabcount%></td>
						<td class=rptValue><%=sthabscpop+sthabstpop+sthabplainpop%></td>
						<td class=rptValue><%=sthabscpop%></td>
						<td class=rptValue><%=ndf.format((sthabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=sthabstpop%></td>
						<td class=rptValue><%=ndf.format((sthabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=sthabplainpop%></td>
						<td class=rptValue><%=ndf.format((sthabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>

						<td class=rptValue><%=plainhabcount%></td>
						<td class=rptValue><%=plainhabscpop+plainhabstpop+plainhabplainpop%></td>
						<td class=rptValue><%=plainhabscpop%></td>
						<td class=rptValue><%=ndf.format((plainhabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=plainhabstpop%></td>
						<td class=rptValue><%=ndf.format((plainhabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=plainhabplainpop%></td>
						<td class=rptValue><%=ndf.format((plainhabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
<%	    }
		col4rs.close();
		col3rs.close();
		col2rs.close();
		col1rs.close();
%></TR><%
	}
%>
<tr>
<td class=btext align="center" colspan=2>Total</td>
<td class=btext><%=col1%></td>
<td class=btext><%=col2%></td>
<td class=btext><%=col3%></td>
<td class=btext><%=col4%></td>
<td class=btext><%=ndf.format(col5)%></td>
<td class=btext><%=ndf.format(col6)%></td>
<td class=btext><%=col7%></td>
<td class=btext><%=col8%></td>
<td class=btext><%=col9%></td>
<td class=btext><%=ndf.format(col10)%></td>
<td class=btext><%=ndf.format(col11)%></td>
<td class=btext><%=col12%></td>
<td class=btext><%=ndf.format(col13)%></td>
<td class=btext><%=ndf.format(col14)%></td>
<td class=btext><%=col15%></td>
<td class=btext><%=ndf.format(col16)%></td>
<td class=btext><%=ndf.format(col17)%></td>
<td class=btext><%=col18%></td>
<td class=btext><%=col19%></td>
<td class=btext><%=col20%></td>
<td class=btext><%=ndf.format(col21)%></td>
<td class=btext><%=ndf.format(col22)%></td>
<td class=btext><%=col23%></td>
<td class=btext><%=ndf.format(col24)%></td>
<td class=btext><%=ndf.format(col25)%></td>
<td class=btext><%=col26%></td>
<td class=btext><%=ndf.format(col27)%></td>
<td class=btext><%=ndf.format(col28)%></td>
<td class=btext><%=col29%></td>
<td class=btext><%=col30%></td>
<td class=btext><%=ndf.format(col31)%></td>
<td class=btext><%=ndf.format(col32)%></td>
<td class=btext><%=ndf.format(col33)%></td>
<td class=btext><%=col34%></td>
<td class=btext><%=ndf.format(col35)%></td>
<td class=btext><%=ndf.format(col36)%></td>
<td class=btext><%=col37%></td>
<td class=btext><%=ndf.format(col38)%></td>
<td class=btext><%=ndf.format(col39)%></td>
</tr>
</table>
<p align="left"><font face="verdana" size="2">Note:</font>&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<font face="verdana" size="2" color="red"><B>1. Amount In Rs.Lakhs
<br>
2. SC Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on SC Population<br>
3. ST Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on ST Population<br>
4. PLAIN Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on SC/ST/PLAIN Population respectively
</B></font>
</p>
<%}
else  if(repType.equals("Multiple"))
{
	int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col9=0,col12=0,col15=0,col18=0,col19=0,col20=0,col23=0,col26=0,col29=0,col30=0,col31=0,col34=0,col37=0;
	double col5=0.0,col6=0.0,col10=0.0,col11=0.0,col13=0.0,col14=0.0,col16=0.0,col17=0.0,col21=0.0,col22=0.0,col24=0.0,col25=0.0,col27=0.0,col28=0.0,col32=0.0,col33=0.0,col35=0.0,col36=0.0,col38=0.0,col39=0.0;
%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=42><font style="text-transform: uppercase;">List of Habitations covered in ongoing works Having <%=repType%> Habitations</font></td>		
	</tr>
<%
////////System.out.println("Drill:"+drill);
if(drill==null)drill="null";
if(drill.equals("null"))
{ %>
	<tr  align="center">
		<td align="center" class="btext" colspan="42" >District: All &nbsp; &nbsp;</td>
	</tr>	
	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext rowspan = 3>Total Habs</td>
		<td class=btext rowspan = 3>Total Population</td>
		<td class=btext colspan=2>Total Works</td>
		<td class=btext rowspan = 3>Total Est. Cost</td>
		<td class=btext rowspan = 3>Total Exp Incurred</td>
		<td  colspan=11 align="center" class="rptHeading" bgcolor="#8A9FCD">SC Hab Sub Type</td>
		<td  colspan=11 class="rptHeading" bgcolor="#8A9FAD" align="center">ST Hab Sub Type</td>
		<td  colspan=11 class="rptHeading" bgcolor="#8A9FCD" align="center">PLAIN Hab Sub Type</td>
	</tr>
	
	<tr>
		<td rowspan=2 colspan=1 class=btext align="center">No Of HP's</td>	
		<td rowspan=2 colspan=1 class=btext align="center">No. of schemes</td>	
		
		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>


		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>

		
	</tr>
	<tr>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
	</tr>
	<%
	String getDnameQuery = "select dcode,dname from rws_district_tbl where  dcode  <> '16' order by dcode";
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno=1;
		Statement col1st = conn.createStatement();
		Statement col2st  = conn.createStatement();
		Statement col3st  = conn.createStatement();
		Statement col4st  = conn.createStatement();
		ResultSet col1rs = null,col2rs = null,col3rs = null,col4rs = null;
		while(rs2.next())
		{ 
				
			%>
				<tr>
						<td class=rptValue><%=sno++%></td>
						<td class="rptValue"><%=rs2.getString(2)%></td>
		    <%
				String habSubType = "";
				int workcount=0;
				int schabcount=0,sthabcount=0,plainhabcount=0;
				int schabscpop=0,schabstpop=0,schabplainpop=0;
				int sthabscpop=0,sthabstpop=0,sthabplainpop=0;
				int plainhabscpop=0,plainhabstpop=0,plainhabplainpop=0;
				double totEstCost=0;double totExp = 0.0;
				String q1 = "select distinct hab_code,habitation_sub_type,census_sc_popu,census_st_popu,census_plain_popu from rws_work_hab_view where work_id in (select work_id from rws_work_habcount_view where habcount>1 and substr(work_id,5,2) ='"+rs2.getString(1)+"')";
				////System.out.println("q111:"+q1);
				col1rs = col1st.executeQuery(q1);
				while(col1rs.next())
				{
					if(col1rs.getString(2).equals("SC"))
					{
						schabcount++;
						schabscpop += col1rs.getInt(3);
						schabstpop += col1rs.getInt(4);
						schabplainpop += col1rs.getInt(5);
					}
					else if(col1rs.getString(2).equals("ST"))
					{
						sthabcount++;
						sthabscpop += col1rs.getInt(3);
						sthabstpop += col1rs.getInt(4);
						sthabplainpop += col1rs.getInt(5);
					}
					else if(col1rs.getString(2).equals("PLAIN"))
					{
						plainhabcount++;
						plainhabscpop += col1rs.getInt(3);
						plainhabstpop += col1rs.getInt(4);
						plainhabplainpop += col1rs.getInt(5);
					}
			   }
			   col1 += schabcount+sthabcount+plainhabcount;
			   col2 += schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop;
			   %>
				   <td class=rptValue><%=schabcount+sthabcount+plainhabcount%></td>
				   <td class=rptValue><%=schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop%></td>
			   <%   
				   String q2 = "select work_id,SANCTION_AMOUNT from rws_work_admn_tbl where work_id in (select work_id from rws_work_habcount_view where habcount>1 and substr(work_id,5,2) ='"+rs2.getString(1)+"') and substr(work_id,7,2)='04'";
				   //System.out.println("q2:"+q2);
				   col2rs = col2st.executeQuery(q2);
				   				   //System.out.println("aaaaaaa");
					while(col2rs.next()){workcount++;totEstCost+=col2rs.getDouble(2);}
									   //System.out.println("bbbbbbbbb");
					col3+=workcount;
									   //System.out.println("ccccccc");
					%><td class=rptValue><%=workcount%></td><%
					workcount = 0;
					String q3 = "select work_id,SANCTION_AMOUNT from rws_work_admn_tbl where work_id in (select work_id from rws_work_habcount_view where habcount>1 and substr(work_id,5,2) ='"+rs2.getString(1)+"') and substr(work_id,7,2)<>'04'";
									   //System.out.println("q3:"+q3);
					col3rs = col3st.executeQuery(q3);
					while(col3rs.next()){workcount++;totEstCost+=col3rs.getDouble(2);}
					col4+=workcount;
					col5+=totEstCost;
					%>
						<td class=rptValue><%=workcount%></td>
						<td class=rptValue><%=ndf.format(totEstCost)%></td>
					<%
					String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select work_id from rws_work_habcount_view where habcount>1 and substr(work_id,5,2) ='"+rs2.getString(1)+"')";
									   //System.out.println("q4:"+q4);
					col4rs = col4st.executeQuery(q4);
					while(col4rs.next()){if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp+=col4rs.getDouble(1);}
					col6+=totExp;
					col7+=schabcount;
					col8 += schabscpop+schabstpop+schabplainpop;
					col9 += schabscpop;
					col10 += (schabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col11 += (schabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col12 += schabstpop;
					col13 += (schabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col14 += (schabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col15 += schabplainpop;
					col16 += (schabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col17 += (schabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);

					col18 += sthabcount;
					col19 += sthabscpop+sthabstpop+sthabplainpop;
					col20 += sthabscpop;
					col21 += (sthabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col22 += (sthabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col23 += sthabstpop;
					col24 += (sthabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col25 += (sthabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col26 += sthabplainpop;
					col27 += (sthabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col28 += (sthabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);

					col29 += plainhabcount;
					col30 += plainhabscpop+plainhabstpop+plainhabplainpop;
					col31 += plainhabscpop;
					col32 += (plainhabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col33 += (plainhabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col34 += plainhabstpop;
					col35 += (plainhabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col36 += (plainhabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col37 += plainhabplainpop;
					col38 += (plainhabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					col39 += (plainhabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop);
					%>
						<td class=rptValue><%=totExp%></td>

						<td class=rptValue><%=schabcount%></td>
						<td class=rptValue><%=schabscpop+schabstpop+schabplainpop%></td>
						<td class=rptValue><%=schabscpop%></td>
						<td class=rptValue><%=ndf.format((schabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=schabstpop%></td>
						<td class=rptValue><%=ndf.format((schabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=schabplainpop%></td>
						<td class=rptValue><%=ndf.format((schabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>

						<td class=rptValue><%=sthabcount%></td>
						<td class=rptValue><%=sthabscpop+sthabstpop+sthabplainpop%></td>
						<td class=rptValue><%=sthabscpop%></td>
						<td class=rptValue><%=ndf.format((sthabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=sthabstpop%></td>
						<td class=rptValue><%=ndf.format((sthabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=sthabplainpop%></td>
						<td class=rptValue><%=ndf.format((sthabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>

						<td class=rptValue><%=plainhabcount%></td>
						<td class=rptValue><%=plainhabscpop+plainhabstpop+plainhabplainpop%></td>
						<td class=rptValue><%=plainhabscpop%></td>
						<td class=rptValue><%=ndf.format((plainhabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=plainhabstpop%></td>
						<td class=rptValue><%=ndf.format((plainhabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=plainhabplainpop%></td>
						<td class=rptValue><%=ndf.format((plainhabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
<%	    }
		col4rs.close();
		col3rs.close();
		col2rs.close();
		col1rs.close();
%></TR><%
	}
%>
<tr>
<td class=btext align="center" colspan=2>Total</td>
<td class=btext><%=col1%></td>
<td class=btext><%=col2%></td>
<td class=btext><%=col3%></td>
<td class=btext><%=col4%></td>
<td class=btext><%=ndf.format(col5)%></td>
<td class=btext><%=ndf.format(col6)%></td>
<td class=btext><%=col7%></td>
<td class=btext><%=col8%></td>
<td class=btext><%=col9%></td>
<td class=btext><%=ndf.format(col10)%></td>
<td class=btext><%=ndf.format(col11)%></td>
<td class=btext><%=col12%></td>
<td class=btext><%=ndf.format(col13)%></td>
<td class=btext><%=ndf.format(col14)%></td>
<td class=btext><%=col15%></td>
<td class=btext><%=ndf.format(col16)%></td>
<td class=btext><%=ndf.format(col17)%></td>
<td class=btext><%=col18%></td>
<td class=btext><%=col19%></td>
<td class=btext><%=col20%></td>
<td class=btext><%=ndf.format(col21)%></td>
<td class=btext><%=ndf.format(col22)%></td>
<td class=btext><%=col23%></td>
<td class=btext><%=ndf.format(col24)%></td>
<td class=btext><%=ndf.format(col25)%></td>
<td class=btext><%=col26%></td>
<td class=btext><%=ndf.format(col27)%></td>
<td class=btext><%=ndf.format(col28)%></td>
<td class=btext><%=col29%></td>
<td class=btext><%=col30%></td>
<td class=btext><%=ndf.format(col31)%></td>
<td class=btext><%=ndf.format(col32)%></td>
<td class=btext><%=ndf.format(col33)%></td>
<td class=btext><%=col34%></td>
<td class=btext><%=ndf.format(col35)%></td>
<td class=btext><%=ndf.format(col36)%></td>
<td class=btext><%=col37%></td>
<td class=btext><%=ndf.format(col38)%></td>
<td class=btext><%=ndf.format(col39)%></td>
</tr>
</table>
<p align="left"><font face="verdana" size="2">Note:</font>&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<font face="verdana" size="2" color="red"><B>1. Amount In Rs.Lakhs
<br>
2. SC Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on SC Population<br>
3. ST Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on ST Population<br>
4. PLAIN Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on SC/ST/PLAIN Population respectively
</B></font>
</p>
<%}
else  if(repType.equals("MultipleMandal"))
{
	int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col9=0,col12=0,col15=0,col18=0,col19=0,col20=0,col23=0,col26=0,col29=0,col30=0,col31=0,col34=0,col37=0;
double col5=0.0,col6=0.0,col10=0.0,col11=0.0,col13=0.0,col14=0.0,col16=0.0,col17=0.0,col21=0.0,col22=0.0,col24=0.0,col25=0.0,col27=0.0,col28=0.0,col32=0.0,col33=0.0,col35=0.0,col36=0.0,col38=0.0,col39=0.0;
	////System.out.println("in MultipleMandal");
%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=42><font style="text-transform: uppercase;">List of Habitations covered in ongoing works Having <%=repType%> Habitations</font></td>		
	</tr>
<%
////////System.out.println("Drill:"+drill);
if(drill==null)drill="null";
if(drill.equals("null"))
{ %>
	<tr  align="center">
		<td align="center" class="btext" colspan="42" >District: All &nbsp; &nbsp;Mandal : All</td>
	</tr>	
	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext rowspan = 3>Total Habs</td>
		<td class=btext rowspan = 3>Total Population</td>
		<td class=btext colspan=2>Total Works</td>
		<td class=btext rowspan = 3>Total Est. Cost</td>
		<td class=btext rowspan = 3>Total Exp Incurred</td>
		<td  colspan=11 align="center" class="rptHeading" bgcolor="#8A9FCD">SC Hab Sub Type</td>
		<td  colspan=11 class="rptHeading" bgcolor="#8A9FAD" align="center">ST Hab Sub Type</td>
		<td  colspan=11 class="rptHeading" bgcolor="#8A9FCD" align="center">PLAIN Hab Sub Type</td>
	</tr>
	
	<tr>
		<td rowspan=2 colspan=1 class=btext align="center">No Of HP's</td>	
		<td rowspan=2 colspan=1 class=btext align="center">No. of schemes</td>	
		
		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>


		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Hab Pop</td>	
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">SC</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">ST</td>
		<td colspan=3 class="rptHeading" bgcolor="#8A9FAD" align="center">PLAIN</td>

		
	</tr>
	<tr>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">Population</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>
	</tr>
	<%
	String getDnameQuery = "select distinct d.dcode,d.dname,m.mcode,m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='04' order by d.dcode,m.mcode";
					////System.out.println("in dname qry"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno=1;
		Statement col1st = conn.createStatement();
		Statement col2st  = conn.createStatement();
		Statement col3st  = conn.createStatement();
		Statement col4st  = conn.createStatement();
		ResultSet col1rs = null,col2rs = null,col3rs = null,col4rs = null;
		while(rs2.next())
		{ 
			%>
				<tr>
						<td class=rptValue><%=sno++%></td>
						<td class="rptValue"><%=rs2.getString(1)%></td>
						<td class="rptValue"><%=rs2.getString(2)%></td>
						<td class="rptValue"><%=rs2.getString(3)%></td>
						<td class="rptValue"><%=rs2.getString(4)%></td>
		    <%
				String habSubType = "";
				int workcount=0;
				int schabcount=0,sthabcount=0,plainhabcount=0;
				int schabscpop=0,schabstpop=0,schabplainpop=0;
				int sthabscpop=0,sthabstpop=0,sthabplainpop=0;
				int plainhabscpop=0,plainhabstpop=0,plainhabplainpop=0;
				double totEstCost=0;double totExp = 0.0;
				String q1 = "select distinct hab_code,habitation_sub_type,census_sc_popu,census_st_popu,census_plain_popu from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and substr(hab_code,6,2)='"+rs2.getString(3)+"'";
				//////System.out.println("q111:"+q1);
				col1rs = col1st.executeQuery(q1);
				while(col1rs.next())
				{
					if(col1rs.getString(2).equals("SC"))
					{
						schabcount++;
						schabscpop += col1rs.getInt(3);
						schabstpop += col1rs.getInt(4);
						schabplainpop += col1rs.getInt(5);
					}
					else if(col1rs.getString(2).equals("ST"))
					{
						sthabcount++;
						sthabscpop += col1rs.getInt(3);
						sthabstpop += col1rs.getInt(4);
						sthabplainpop += col1rs.getInt(5);
					}
					else if(col1rs.getString(2).equals("PLAIN"))
					{
						plainhabcount++;
						plainhabscpop += col1rs.getInt(3);
						plainhabstpop += col1rs.getInt(4);
						plainhabplainpop += col1rs.getInt(5);
					}
			   }
			   %>
				   <td class=rptValue><%=schabcount+sthabcount+plainhabcount%></td>
				   <td class=rptValue><%=schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop%></td>
			   <%   
				   String q2 = "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"'  and substr(hab_code,6,2)='"+rs2.getString(3)+"' and substr (work_id,7,2) = '04' group by WORK_ID,SANCTION_AMOUNT having count(*)>1";
				   col2rs = col2st.executeQuery(q2);
					while(col2rs.next()){workcount++;totEstCost+=col2rs.getDouble(3);}
					%><td class=rptValue><%=workcount%></td><%
					workcount = 0;
					String q3 = "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"'  and substr(hab_code,6,2)='"+rs2.getString(3)+"' and substr (work_id,7,2) <> '04' group by WORK_ID,SANCTION_AMOUNT having count(*)>1";
					col3rs = col3st.executeQuery(q3);
					while(col3rs.next()){workcount++;totEstCost+=col3rs.getDouble(3);}
					%>
						<td class=rptValue><%=workcount%></td>
						<td class=rptValue><%=totEstCost%></td>
					<%
					String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+rs2.getString(1)+"'  and substr(hab_code,6,2)='"+rs2.getString(3)+"' group by WORK_ID having count(*)>1)";
					col4rs = col4st.executeQuery(q4);
					while(col4rs.next()){if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp+=col4rs.getDouble(1);}
					%>
						<td class=rptValue><%=totExp%></td>

						<td class=rptValue><%=schabcount%></td>
						<td class=rptValue><%=schabscpop+schabstpop+schabplainpop%></td>
						<td class=rptValue><%=schabscpop%></td>
						<td class=rptValue><%=ndf.format((schabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=schabstpop%></td>
						<td class=rptValue><%=ndf.format((schabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=schabplainpop%></td>
						<td class=rptValue><%=ndf.format((schabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((schabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>

						<td class=rptValue><%=sthabcount%></td>
						<td class=rptValue><%=sthabscpop+sthabstpop+sthabplainpop%></td>
						<td class=rptValue><%=sthabscpop%></td>
						<td class=rptValue><%=ndf.format((sthabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=sthabstpop%></td>
						<td class=rptValue><%=ndf.format((sthabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=sthabplainpop%></td>
						<td class=rptValue><%=ndf.format((sthabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((sthabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>

						<td class=rptValue><%=plainhabcount%></td>
						<td class=rptValue><%=plainhabscpop+plainhabstpop+plainhabplainpop%></td>
						<td class=rptValue><%=plainhabscpop%></td>
						<td class=rptValue><%=ndf.format((plainhabscpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabscpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=plainhabstpop%></td>
						<td class=rptValue><%=ndf.format((plainhabstpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabstpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=plainhabplainpop%></td>
						<td class=rptValue><%=ndf.format((plainhabplainpop*totEstCost)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
						<td class=rptValue><%=ndf.format((plainhabplainpop*totExp)/(schabscpop+schabstpop+schabplainpop+sthabscpop+sthabstpop+sthabplainpop+plainhabscpop+plainhabstpop+plainhabplainpop))%></td>
<%	    }
		//col4rs.close();
		//col2rs.close();
		col1rs.close();
%></TR><%
	}
%>
<tr>
<td class=btext align="center" colspan=2>Total</td>
<td class=btext><%=col1%></td>
<td class=btext><%=col2%></td>
<td class=btext><%=col3%></td>
<td class=btext><%=col4%></td>
<td class=btext><%=ndf.format(col5)%></td>
<td class=btext><%=ndf.format(col6)%></td>
<td class=btext><%=col7%></td>
<td class=btext><%=col8%></td>
<td class=btext><%=col9%></td>
<td class=btext><%=ndf.format(col10)%></td>
<td class=btext><%=ndf.format(col11)%></td>
<td class=btext><%=col12%></td>
<td class=btext><%=ndf.format(col13)%></td>
<td class=btext><%=ndf.format(col14)%></td>
<td class=btext><%=col15%></td>
<td class=btext><%=ndf.format(col16)%></td>
<td class=btext><%=ndf.format(col17)%></td>
<td class=btext><%=col18%></td>
<td class=btext><%=col19%></td>
<td class=btext><%=col20%></td>
<td class=btext><%=ndf.format(col21)%></td>
<td class=btext><%=ndf.format(col22)%></td>
<td class=btext><%=col23%></td>
<td class=btext><%=ndf.format(col24)%></td>
<td class=btext><%=ndf.format(col25)%></td>
<td class=btext><%=col26%></td>
<td class=btext><%=ndf.format(col27)%></td>
<td class=btext><%=ndf.format(col28)%></td>
<td class=btext><%=col29%></td>
<td class=btext><%=col30%></td>
<td class=btext><%=ndf.format(col31)%></td>
<td class=btext><%=ndf.format(col32)%></td>
<td class=btext><%=ndf.format(col33)%></td>
<td class=btext><%=col34%></td>
<td class=btext><%=ndf.format(col35)%></td>
<td class=btext><%=ndf.format(col36)%></td>
<td class=btext><%=col37%></td>
<td class=btext><%=ndf.format(col38)%></td>
<td class=btext><%=ndf.format(col39)%></td>
</tr>
</table>
<p align="left"><font face="verdana" size="2">Note:</font>&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<font face="verdana" size="2" color="red"><B>1. Amount In Rs.Lakhs
<br>
2. SC Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on SC Population<br>
3. ST Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on ST Population<br>
4. PLAIN Multiple Hab Works - Estimate Cost and Expenditure Incurred is based on SC/ST/PLAIN Population respectively
</B></font>
</p>
<%}%>
<p  align="center">
<%@ include file="footer.jsp" %>
</p>
</form>
</BODY>
</HTML>


