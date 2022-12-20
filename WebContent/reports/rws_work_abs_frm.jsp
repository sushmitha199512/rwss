<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<%
int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col11=0,col12=0,col13=0,col14=0,col17=0,col18=0,col21=0,col22=0,col23=0,col24=0,col25=0,col26=0,col33=0,col34=0;
double col5=0.0,col6=0.0,col9=0.0,col10=0.0,col15=0.0,col16=0.0,col19=0.0,col20=0.0,col27=0.0,col28=0.0,col29=0.0,col30=0.0,col31=0.0,col32=0.0,col35=0.0,col36=0.0,col37=0.0,col38=0.0,col39=0.0,col40=0.0;
String drill = request.getParameter("drill");
if(drill!=null){
session.setAttribute("drill",drill);
}
DecimalFormat ndf=new DecimalFormat("####.00");
%>
<head>
<title></title>

 </head>
<body bgcolor="#edf2f8">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=42>List of Habitations covered in ongoing works</td>		
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
		<td  colspan=10 align="center" class="rptHeading" bgcolor="#8A9FCD">SC Habs</td>
		<td  colspan=10 class="rptHeading" bgcolor="#8A9FAD" align="center">ST Habs</td>
		<td  colspan=20 class="rptHeading" bgcolor="#8A9FCD" align="center">PLAIN Habs</td>
	</tr>
	
	<tr>
		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">SC Population</td>
		<td colspan=4 class="rptHeading" bgcolor="#8A9FAD" align="center">Single Hab Works</td>
		<td colspan=4 class="rptHeading" bgcolor="#8A9FAD" align="center">Multiple Hab Works</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">ST Population</td>
		<td colspan=4 class="rptHeading" bgcolor="#8A9FCD" align="center">Single Hab Works</td>
		<td colspan=4 class="rptHeading" bgcolor="#8A9FCD" align="center">Multiple Hab Works</td>

		<td rowspan=2 colspan=1 class=btext align="center">No Of Habs</td>	
		<td rowspan=2 colspan=1 class=btext align="center">SC Population</td>
		<td rowspan=2 colspan=1 class=btext align="center">ST Population</td>
		<td rowspan=2 colspan=1 class=btext align="center">PLAIN Population</td>
		<td colspan=8 class="rptHeading" bgcolor="#8A9FAD" align="center">Single Hab Works</td>
		<td colspan=8 class="rptHeading" bgcolor="#8A9FAD" align="center">Multiple Hab Works</td>
		
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
	String getDnameQuery = "select dcode,dname from rws_district_tbl where  dcode <> '16' order by dcode";
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
				double totExp = 0.0;
			%>
				<tr>
						<td class=rptValue><%=sno++%></td>
						<td class="rptValue"><%=rs2.getString(2)%></td>
		    <%
				String habSubType = "";
				int sccount=0,stcount=0,plaincount=0;
				for(int i=0;i<2;i++)
				{
						int habcount=0,habpop=0,workcount=0,habpop1=0;
						double workamount=0;
						if(i==0)habSubType="SC";
						else if(i==1)habSubType="ST";
						else if(i==2)habSubType="PLAIN";
						String q1 = "";
						if(i==0)q1 = "select distinct hab_code,census_sc_popu from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"'";
						if(i==1)q1 = "select distinct hab_code,census_st_popu from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"'";
						if(i==2)q1 = "select distinct hab_code,census_sc_popu,census_st_popu from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"'";
						////System.out.println("q1:"+q1);
						col1rs = col1st.executeQuery(q1);
						if(i!=2)while(col1rs.next()){habcount++;habpop+=col1rs.getInt(2);}
						if(i==2)while(col1rs.next()){habcount++;habpop+=col1rs.getInt(2);habpop1+=col1rs.getInt(3);}						
						if(i==0)col1+=habcount;
						if(i==1)col11+=habcount;						
						if(i==0)col2+=habpop;
						if(i==1)col12+=habpop;						
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
						   <td class=rptValue><%=habpop%></td>
					   <%   
					   }
						//String q2 = "select DISTINCT WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04'";
						String q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04' group by WORK_ID,SANCTION_AMOUNT having count(*)=1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						if(i==0)col3+=workcount;
						if(i==1)col13+=workcount; %>
						   <td class=rptValue><%=workcount%></td><%
					   workcount = 0;
					   q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) <>'04' group by WORK_ID,SANCTION_AMOUNT having count(*)=1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						if(i==0)col4+=workcount;
						if(i==1)col14+=workcount;
						
						if(i==0)col5+=workamount;
						if(i==1)col15+=workamount;%>
						   <td class=rptValue><%=workcount%></td>
						   <td class=rptValue><%=ndf.format(workamount)%></td>
						<%
						String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' group by WORK_ID having count(*)=1)";
						//System.out.println("q4:"+q4);
						col4rs = col4st.executeQuery(q4);
						while(col4rs.next()){
						if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp += col4rs.getDouble(1);}
					  	if(i==0)col6+=totExp;
						if(i==1)col16+=totExp;
						 %>
						   <td class=rptValue><%=ndf.format(totExp)%></td>
						 
					   <% 
						totExp = 0;
						workcount = 0;workamount = 0;
						q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04' group by WORK_ID,SANCTION_AMOUNT having count(*)>1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						if(i==0)col7+=workcount;
						if(i==1)col17+=workcount; %>
						   <td class=rptValue><%=workcount%></td><%
					  	 workcount = 0;
					   q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) <>'04' group by WORK_ID,SANCTION_AMOUNT having count(*)>1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						if(i==0)col8+=workcount;
						if(i==1)col18+=workcount;
						
						if(i==0)col9+=workamount;
						if(i==1)col19+=workamount;%>
						   <td class=rptValue><%=workcount%></td>
						   <td class=rptValue><%=ndf.format(workamount)%></td>
						   <%
						q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' group by WORK_ID having count(*)>1)";
						//System.out.println("q4:"+q4);
						col4rs = col4st.executeQuery(q4);
						while(col4rs.next()){
						if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp += col4rs.getDouble(1);}
						if(i==0)col10+=totExp;
						if(i==1)col20+=totExp;
					   %>
						   <td class=rptValue><%=ndf.format(totExp)%></td>
					   <% 
						}
						// for plian habs
						int habcount=0,habpop=0,workcount=0,habpop1=0,habpop2=0;
						double workamount=0;
						habSubType="PLAIN";
						String q1 = "";
						q1 = "select distinct hab_code,census_sc_popu,census_st_popu,census_plain_popu from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"'";
						////System.out.println("q1:"+q1);
						col1rs = col1st.executeQuery(q1);
						while(col1rs.next()){habcount++;habpop+=col1rs.getInt(2);habpop1+=col1rs.getInt(3);habpop2+=col1rs.getInt(4);}						
						col21+=habcount;
						col22+=habpop;col23+=habpop;col24+=habpop;%>
						   <td class=rptValue><%=habcount%></td>
						   <td class=rptValue><%=habpop%></td>
						   <td class=rptValue><%=habpop1%></td>
						   <td class=rptValue><%=habpop2%></td>
					   <%  
						//String q2 = "select DISTINCT WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04'";
						String q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04' group by WORK_ID,SANCTION_AMOUNT having count(*)=1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						col25+=workcount;
						 %>
						   <td class=rptValue><%=workcount%></td><%
					   workcount = 0;
					   q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) <>'04' group by WORK_ID,SANCTION_AMOUNT having count(*)=1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						col26+=workcount;
						%>
						   <td class=rptValue><%=workcount%></td>
						   
						<%
						String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' group by WORK_ID having count(*)=1)";
						//System.out.println("q4:"+q4);
						col4rs = col4st.executeQuery(q4);
						while(col4rs.next()){
						if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp += col4rs.getDouble(1);}
						col27+=(habpop*workamount)/(habpop+habpop1+habpop2);
						col28+=(habpop*totExp)/(habpop+habpop1+habpop2);
						col29+=(habpop1*workamount)/(habpop+habpop1+habpop2);
						col30+=(habpop1*totExp)/(habpop+habpop1+habpop2);
						col31+=(habpop2*workamount)/(habpop+habpop1+habpop2);
						col32+=(habpop2*totExp)/(habpop+habpop1+habpop2);
					   %>
					   <td class=rptValue><%=ndf.format((habpop*workamount)/(habpop+habpop1+habpop2))%></td>
					   <td class=rptValue><%=ndf.format((habpop*totExp)/(habpop+habpop1+habpop2))%></td>
					   <td class=rptValue><%=ndf.format((habpop1*workamount)/(habpop+habpop1+habpop2))%></td>
					   <td class=rptValue><%=ndf.format((habpop1*totExp)/(habpop+habpop1+habpop2))%></td>					   
					   <td class=rptValue><%=ndf.format((habpop2*workamount)/(habpop+habpop1+habpop2))%></td>					   					   
					   <td class=rptValue><%=ndf.format((habpop2*totExp)/(habpop+habpop1+habpop2))%></td>						 
					   <% 
						totExp = 0;
						workcount = 0;workamount = 0;
						q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) ='04' group by WORK_ID,SANCTION_AMOUNT having count(*)>1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						col33+=workcount;
						%>
						   <td class=rptValue><%=workcount%></td><%
					  	 workcount = 0;
					   q2 =  "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' and substr (work_id,7,2) <>'04' group by WORK_ID,SANCTION_AMOUNT having count(*)>1";
						//System.out.println("q2:"+q2);
						col2rs = col2st.executeQuery(q2);
						while(col2rs.next()){workcount++;workamount+=col2rs.getDouble(3);}
						col34+=workcount;
						%>
						   <td class=rptValue><%=workcount%></td>
						   <%
						q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+rs2.getString(1)+"' and habitation_sub_type='"+habSubType+"' group by WORK_ID having count(*)>1)";
						//System.out.println("q4:"+q4);
						col4rs = col4st.executeQuery(q4);
						while(col4rs.next()){
						if(col4rs.getString(1)!=null && !col4rs.getString(1).equals(""))totExp += col4rs.getDouble(1);}
					   col35+=(habpop*workamount)/(habpop+habpop1+habpop2);
						col36+=(habpop*totExp)/(habpop+habpop1+habpop2);
						col37+=(habpop1*workamount)/(habpop+habpop1+habpop2);
						col38+=(habpop1*totExp)/(habpop+habpop1+habpop2);
						col39+=(habpop2*workamount)/(habpop+habpop1+habpop2);
						col40+=(habpop2*totExp)/(habpop+habpop1+habpop2);%>
						   <td class=rptValue><%=ndf.format((habpop*workamount)/(habpop+habpop1+habpop2))%></td>
					   <td class=rptValue><%=ndf.format((habpop*totExp)/(habpop+habpop1+habpop2))%></td>
					   <td class=rptValue><%=ndf.format((habpop1*workamount)/(habpop+habpop1+habpop2))%></td>
					   <td class=rptValue><%=ndf.format((habpop1*totExp)/(habpop+habpop1+habpop2))%></td>					   
					   <td class=rptValue><%=ndf.format((habpop2*workamount)/(habpop+habpop1+habpop2))%></td>					   					   
					   <td class=rptValue><%=ndf.format((habpop2*totExp)/(habpop+habpop1+habpop2))%></td>
					   <% 
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
<td class=btext><%=ndf.format(col9)%></td>
<td class=btext><%=ndf.format(col10)%></td>
<td class=btext><%=col11%></td>
<td class=btext><%=col12%></td>
<td class=btext><%=col13%></td>
<td class=btext><%=col14%></td>
<td class=btext><%=ndf.format(col15)%></td>
<td class=btext><%=ndf.format(col16)%></td>
<td class=btext><%=col17%></td>
<td class=btext><%=col18%></td>
<td class=btext><%=ndf.format(col19)%></td>
<td class=btext><%=ndf.format(col20)%></td>
<td class=btext><%=col21%></td>
<td class=btext><%=col22%></td>
<td class=btext><%=col23%></td>
<td class=btext><%=col24%></td>
<td class=btext><%=col25%></td>
<td class=btext><%=col26%></td>
<td class=btext><%=ndf.format(col27)%></td>
<td class=btext><%=ndf.format(col28)%></td>
<td class=btext><%=ndf.format(col29)%></td>
<td class=btext><%=ndf.format(col30)%></td>
<td class=btext><%=ndf.format(col31)%></td>
<td class=btext><%=ndf.format(col32)%></td>
<td class=btext><%=col33%></td>
<td class=btext><%=col34%></td>
<td class=btext><%=ndf.format(col35)%></td>
<td class=btext><%=ndf.format(col36)%></td>
<td class=btext><%=ndf.format(col37)%></td>
<td class=btext><%=ndf.format(col38)%></td>
<td class=btext><%=ndf.format(col39)%></td>
<td class=btext><%=ndf.format(col40)%></td>
</tr>
</table>
<p align="left"><font face="verdana" size="2">Note:</font>&nbsp;&nbsp;&nbsp;&nbsp;<font face="verdana" size="2" color="red"><B>Amount In Rs.Lakhs</B></font></p>
<p  align="center">
<%@ include file="footer.jsp" %>

</BODY>
</HTML>


