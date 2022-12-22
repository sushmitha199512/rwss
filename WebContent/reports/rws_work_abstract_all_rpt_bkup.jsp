<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<%
int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col9=0,col10=0,col13=0,col14=0,col15=0,col16=0,col17=0,col18=0;
double col5=0.0,col6=0.0,col11=0.0,col12=0.0,col19=0.0,col20=0.0,col21=0.0,col22=0.0,col23=0.0,col24=0.0;
String drill = request.getParameter("drill");
if(drill!=null){
session.setAttribute("drill",drill);
}
DecimalFormat ndf=new DecimalFormat("####.00");
String repType = request.getParameter("repType");
String havingCond = "";
if(repType!=null && repType.equals("Single")){havingCond = " having count(*)=1 ";}
else if(repType!=null && repType.equals("Multiple"))havingCond = " having count(*)>1 ";

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
else
{
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
////System.out.println("Drill:"+drill);
if(drill==null)drill="null";
if(drill.equals("null"))
{ %>
	<tr  align="center">
		<td align="center" class="btext" colspan="42" >District: All &nbsp; &nbsp;</td>
	</tr>	
	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td  colspan=6 align="center" class="rptHeading" bgcolor="#8A9FCD">SC Habs</td>
		<td  colspan=6 class="rptHeading" bgcolor="#8A9FAD" align="center">ST Habs</td>
		<td  colspan=12 class="rptHeading" bgcolor="#8A9FCD" align="center">PLAIN Habs</td>
	</tr>
	
	<tr>
		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">SC Population</td>
		<td colspan=4 class="rptHeading" bgcolor="#8A9FAD" align="center"><%=repType%> Hab Works</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">ST Population</td>
		<td colspan=4 class="rptHeading" bgcolor="#8A9FCD" align="center"><%=repType%> Hab Works</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">SC Population</td>
		<td rowspan=2 colspan=1 class=btext align="center">ST Population</td>
		<td rowspan=2 colspan=1 class=btext align="center">PLAIN Population</td>
		<td colspan=8 class="rptHeading" bgcolor="#8A9FAD" align="center"><%=repType%> Hab Works</td>
		
	</tr>
	<tr>
		<td rowspan=1 colspan=1 class=btext align="center">No of HP's</td>
		<td rowspan=1 colspan=1 class=btext align="center">No. of schemes</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>


		<td rowspan=1 colspan=1 class=btext align="center">No of HP's</td>
		<td rowspan=1 colspan=1 class=btext align="center">No. of schemes</td>
		<td rowspan=1 colspan=1 class=btext align="center">Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Expenditure Incurred</td>

		<td rowspan=1 colspan=1 class=btext align="center">No of HP's</td>
		<td rowspan=1 colspan=1 class=btext align="center">No. of schemes</td>
		<td rowspan=1 colspan=1 class=btext align="center">SC Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">SC Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">ST Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">ST Expenditure Incurred</td>
		<td rowspan=1 colspan=1 class=btext align="center">PLAIN Est.Cost</td>		
		<td rowspan=1 colspan=1 class=btext align="center">PLAIN Expenditure Incurred</td>
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
				int sccount=0,stcount=0,plaincount=0;
				for(int i=0;i<3;i++)
				{
						int habcount=0,habpop=0,workcount=0,habpop1=0,habpop2=0;
						double workamount=0;double totExp = 0.0;
						if(i==0)habSubType="SC";
						else if(i==1)habSubType="ST";
						else if(i==2)habSubType="PLAIN";
						String q1 = "";
						q1 = "select distinct hab_code,census_sc_popu,census_st_popu,census_plain_popu from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"'";
						//System.out.println("q111:"+q1);
						col1rs = col1st.executeQuery(q1);
						while(col1rs.next()){habcount++;habpop+=col1rs.getInt(2);habpop1+=col1rs.getInt(3);habpop2+=col1rs.getInt(4);}
						if(i==0)col1+=habcount;
						if(i==1)col7+=habcount;
						if(i==2)col13+=habcount;
						
						if(i==0)col2+=habpop;
						if(i==1)col8+=habpop1;		
						if(i==2)col14+=habpop;
						if(i==2)col15+=habpop1;						
						if(i==2)col16+=habpop2;						
					   %>
						   <td class=rptValue><%=habcount%></td>
					   <%
						   if(i==0){
						%>
						   <td class=rptValue><%=habpop%></td>
					   <%   
					   }
						else if(i==1){
							%>
						   <td class=rptValue><%=habpop1%></td>
					   <%   
					   }
					   else if(i==2){
							%>
						   <td class=rptValue><%=habpop%></td>
						   <td class=rptValue><%=habpop1%></td>
						   <td class=rptValue><%=habpop2%></td>
					   <%   
					   }
						//String q2 = "select DISTINCT WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04'";
						String q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04' group by WORK_ID,SANCTION_AMOUNT "+havingCond;
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						if(i==0)col3+=workcount;
						if(i==1)col9+=workcount;
						if(i==2)col17+=workcount; %>
						   <td class=rptValue><%=workcount%></td><%
					   workcount = 0;
					   q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) <>'04' group by WORK_ID,SANCTION_AMOUNT "+havingCond;
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						if(i==0)col4+=workcount;
						if(i==1)col10+=workcount;
						if(i==2)col18+=workcount;
						
						if(i==0)col5+=(habpop*workamount)/(habpop+habpop1+habpop2);
						if(i==1)col11+=(habpop1*workamount)/(habpop+habpop1+habpop2);
						if(i==2)
						{
							col19+=(habpop*workamount)/(habpop+habpop1+habpop2);
							col21+=(habpop1*workamount)/(habpop+habpop1+habpop2);
							col23+=(habpop2*workamount)/(habpop+habpop1+habpop2);
						}%>						
						<td class=rptValue><%=workcount%></td>
						<%
						if(i==0){
						%>
						   
						<%
						}
						else if(i==1){
						%>
						 
						<%
						}
						else if(i==2){
						%>
						
						<%
						}
						System.out.println("work amount:"+workamount);
						String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' group by WORK_ID  "+havingCond+")";
						////System.out.println("q4:"+q4);
						col4rs = col4st.executeQuery(q4);
						while(col4rs.next()){
						if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp += col4rs.getDouble(1);}
					  	
						if(i==0)col6+=(habpop*totExp)/(habpop+habpop1+habpop2);
						if(i==1)col12+=(habpop1*totExp)/(habpop+habpop1+habpop2);
						if(i==2)
						{
							col20+=(habpop*totExp)/(habpop+habpop1+habpop2);
							col22+=(habpop1*totExp)/(habpop+habpop1+habpop2);
							col24+=(habpop2*totExp)/(habpop+habpop1+habpop2);
						}
						if(i==0){
						%>
						   <td class=rptValue><%=ndf.format((habpop*workamount)/(habpop+habpop1+habpop2))%></td>
						   <td class=rptValue><%=ndf.format((habpop*totExp)/(habpop+habpop1+habpop2))%></td>
						<%
						}
						else if(i==1){
						%>
						 <td class=rptValue><%=ndf.format((habpop1*workamount)/(habpop+habpop1+habpop2))%></td>
						 <td class=rptValue><%=ndf.format((habpop1*totExp)/(habpop+habpop1+habpop2))%></td>
						<%
						}
						else if(i==2){
						%>
						<td class=rptValue><%=ndf.format((habpop*workamount)/(habpop+habpop1+habpop2))%></td>
						 <td class=rptValue><%=ndf.format((habpop*totExp)/(habpop+habpop1+habpop2))%></td>
						 <td class=rptValue><%=ndf.format((habpop1*workamount)/(habpop+habpop1+habpop2))%></td>
						 <td class=rptValue><%=ndf.format((habpop1*totExp)/(habpop+habpop1+habpop2))%></td>
						 <td class=rptValue><%=ndf.format((habpop2*workamount)/(habpop+habpop1+habpop2))%></td>
 						 <td class=rptValue><%=ndf.format((habpop2*totExp)/(habpop+habpop1+habpop2))%></td>
						<%
						}
						}
						col4rs.close();
						col2rs.close();
						col1rs.close();
				%></TR><%
	}
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
<td class=btext><%=col10%></td>
<td class=btext><%=ndf.format(col11)%></td>
<td class=btext><%=ndf.format(col12)%></td>
<td class=btext><%=col13%></td>
<td class=btext><%=col14%></td>
<td class=btext><%=col15%></td>
<td class=btext><%=col16%></td>
<td class=btext><%=col17%></td>
<td class=btext><%=col18%></td>
<td class=btext><%=ndf.format(col19)%></td>
<td class=btext><%=ndf.format(col20)%></td>
<td class=btext><%=ndf.format(col21)%></td>
<td class=btext><%=ndf.format(col22)%></td>
<td class=btext><%=ndf.format(col23)%></td>
<td class=btext><%=ndf.format(col24)%></td>
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
<%} %>
<p  align="center">
<%@ include file="footer.jsp" %>
</p>
</form>
</BODY>
</HTML>


