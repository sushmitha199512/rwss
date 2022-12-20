<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
</head>
<body>
<form>

<%
String typeassetcode="";

int sno=1;
int psno=0;
int tot=0;
int total=0;

Statement stmt1=null;
ResultSet rs1=null;
String mandalname="";
String districtname="";

String pname="";
String vname="";


String panchname="";
String panchayatname="";
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs5=null;
ResultSet rs6=null;
ResultSet rs7=null;
ResultSet rs8=null;
ResultSet rs9=null;
ResultSet rs10=null;
ResultSet rs11=null;
ResultSet rs12=null;
ResultSet rs13=null;
ResultSet rs14=null;
ResultSet rs15=null;
ResultSet rs16=null;
ResultSet rs17=null;
ResultSet rs18=null;
ResultSet rs19=null;
ResultSet rs20=null;
ResultSet rs21=null;
ResultSet rs22=null;
ResultSet rs23=null;
ResultSet rs24=null;
ResultSet rs25=null;
ResultSet rs26=null;
ResultSet rset=null;

Statement stmt3=null;
Statement stmt4=null;
Statement stmt5=null;
Statement stmt6=null;
Statement stmt7=null;
Statement stmt8=null;
Statement stmt9=null;
Statement stmt10=null;
Statement stmt11=null;
Statement stmt12=null;
Statement stmt13=null;
Statement stmt14=null;
Statement stmt15=null;
Statement stmt16=null;
Statement stmt17=null;
Statement stmt18=null;
Statement stmt19=null;
Statement stmt20=null;
Statement stmt21=null;
Statement stmt22=null;
Statement stmt23=null;
Statement stmt24=null;
Statement stmt25=null;
Statement stmt26=null;
Statement stmt2=null;
Statement s=null;

ResultSet r=null;
ResultSet r1=null;
ResultSet r2=null;
ResultSet r3=null;
ResultSet r4=null;
ResultSet r5=null;
ResultSet r6=null;
ResultSet r7=null;
ResultSet r8=null;
ResultSet r9=null;
ResultSet r10=null;
ResultSet r11=null;
ResultSet r12=null;
ResultSet r13=null;
ResultSet r14=null;
ResultSet r15=null;
ResultSet r16=null;
ResultSet r17=null;
ResultSet r18=null;
ResultSet r19=null;
ResultSet r20=null;
ResultSet r21=null;
ResultSet r22=null;
ResultSet r23=null;
ResultSet r24=null;
ResultSet r25=null;
ResultSet r26=null;

Statement s1=null;
Statement s2=null;
Statement s3=null;
Statement s4=null;
Statement s5=null;
Statement s6=null;
Statement s7=null;
Statement s8=null;
Statement s9=null;
Statement s10=null;
Statement s11=null;
Statement s12=null;
Statement s13=null;
Statement s14=null;
Statement s15=null;
Statement s16=null;
Statement s17=null;
Statement s18=null;
Statement s19=null;
Statement s20=null;
Statement s21=null;
Statement s22=null;
Statement s23=null;
Statement s24=null;
Statement s25=null;
Statement s26=null;
Statement s27=null;


String villagename="";
String typeassetname="";
typeassetname=request.getParameter("typeassetname");
String assetcode="";
assetcode=request.getParameter("assetcd");
typeassetcode=request.getParameter("type");

int count=0;
int count1=0;
int count2=0;
int count3=0;
int count4=0;
int count5=0;
int count6=0;
int count7=0;
int count8=0;
int count9=0;
int count10=0;
int count11=0;
int count12=0;
int count13=0;
int count14=0;
int count15=0;
int count16=0;
int count17=0;
int count18=0;
int count19=0;
int count20=0;
int count21=0;
int count22=0;
int count23=0;
int count24=0;
int count25=0;
int count26=0;
int count42=0;

Statement stmt42=null;
ResultSet rs42=null;
String panchcode=request.getParameter("panchcode");


String districtcode="";
String mandalcode="";
String panchayatcode="";
String villagecode="";
districtcode=request.getParameter("districtcode");
mandalcode=request.getParameter("mandalcode");
panchayatcode=request.getParameter("panchayatcode");
villagecode=request.getParameter("villagecode");
String habcode="";
habcode=request.getParameter("habcode");
districtname=request.getParameter("districtname");
mandalname=request.getParameter("mandalname");
panchayatname=request.getParameter("panchayatname");
villagename=request.getParameter("villagename");
panchname=request.getParameter("panchname");
%>
<p align=center>
<table border = 1 width=50%
  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_coverage_status_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
</table>
<table border=1 width=50%
  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
 
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="5"> Assets-SubComponents Details Report  </td>
</tr>
<%

try
{
	  s=conn.createStatement();
	 rset=s.executeQuery("select type_of_asset_code,asset_component_code from rws_asset_component_type_tbl where type_of_asset_code='"+typeassetcode+"'");

	 if(typeassetcode.equals("03")) // cpws

		 {
			
			 rset.next();
         if(rset.getString(1).equals("03") && rset.getString(2).equals("01"))
			 {%>
			 <tr class=btext>
			<td class=btext COLSPAN="5"><CENTER>CPWS</CENTER></td>
			</TR>
			<tr class=btext>
			<td class=rptHeading>SOURCE</td>
			<td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
		</tr>
			<%

         stmt23=conn.createStatement();
	/*rs23=stmt23.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1' ");*/

	rs23=stmt23.executeQuery("select nvl(source_code,'-'),nvl(location,'-'),nvl(yield,'-') from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '8%' and source_type_code='1'");
	/*r1=s1.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1'");*/
	%>
	<tr class=btext>
				<td class=rptValue>Sub Surface Source</td>
	</tr>
	<tr>

	
	<% s1=conn.createStatement();
	r1=s1.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '8%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1' ");
	r1.next();
		count23=r1.getInt(1);
		if(count23!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_source1_tbl.jsp?assetcode=<%=assetcode%>&typeassetcode=<%=typeassetcode%>&sourcetypecode=<%='l'%>">
				<%=count23%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count23!=0)
				 {
		while(rs23.next())
		{
		
		%>
		<% if(rs23.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs23.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs23.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		}
				 }else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>

	<% 
	
	stmt24=conn.createStatement();
	rs24=stmt24.executeQuery("select nvl(source_code,'-'),nvl(location,'-'),nvl(yield,'-') from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '8%' and source_type_code='2'  ");%>
	<tr class=btext>
				<td class=rptValue>Surface Source</td>
	</tr>
	 <tr>

	
	<% s2=conn.createStatement();
	r2=s2.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '8%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='2' ");
	r2.next();
		count22=r2.getInt(1);
		if(count22!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_source1_tbl.jsp?assetcode=<%=assetcode%>&typeassetcode=<%=typeassetcode%>&sourcetypecode=<%='2'%>">
				<%=count22%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count22!=0)
				 {
		while(rs24.next())
		{
		
		%>
		<% if(rs24.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs24.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs24.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
<%

		}
				 }else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select nvl(pump_code,'-'),nvl(location,'-'),pump_cpty from RWS_CPWS_SUBCOMP_PARAM_TBL where asset_code= '"+ assetcode+"' ");//pumpsets%> 

<tr class=btext>
				<td class=rptValue>Pumpsets</td>
				</tr>
			
				<tr>	
				<% s3=conn.createStatement();
	r3=s3.executeQuery("select count(*) from RWS_CPWS_SUBCOMP_PARAM_TBL  where asset_code= '"+ assetcode+"' ");
	r3.next();
		count21=r3.getInt(1);
		if(count21!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumpsets1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count21%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count21!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

			} //END OF SOURCE
	//}
	rset.next();

		if(rset.getString(1).equals("03") && rset.getString(2).equals("02"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>HEADWORKS</td>
			
			</tr>
			<%


		 //RWS_CPWS_RW_COLLWELL_PARAM_TBL 
		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select  NVL(rw_collwell_code,'-'),nvl(location,'-'),capacity from rws_cpws_rw_collwell_param_tbl  where asset_code='"+assetcode+"' "); //rawwater%>
			
				
				<tr class="btext">
				<td class=rptValue>Raw Water Collection Well</td>
			   </tr>
<tr>	
				<% s4=conn.createStatement();
	r4=s4.executeQuery("select count(*) from RWS_CPWS_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"' ");
	r4.next();
		count20=r4.getInt(1);
		if(count20!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_rawwater1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count20%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count20!=0)
				 {
		while(rs17.next())
		{
		
		%>
		<% if(rs17.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs17.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs17.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

//RWS_CPWS_SS_SC_PARAM_TBL 
		stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select  NVL(sssc_code,'-'),nvl(location,'-'),capacity_mcum from rws_Cpws_ss_sc_param_tbl where asset_code='" + assetcode + "'" );//sstank%>
			
				
				<tr class="btext">
				<td class=rptValue>SS Tank</td>
			
</tr>
				<tr>	
				<% s5=conn.createStatement();
	r5=s5.executeQuery("select count(*) from RWS_CPWS_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r5.next();
		count19=r5.getInt(1);
		if(count19!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_sstank1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count19!=0)
				 {
		while(rs18.next())
		{
		
		%>
		<% if(rs18.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs18.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs18.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select  NVL(wtpsc_code,'-'),nvl(location,'-'),use_capacitymld from RWS_CPWS_WTP_SC_PARAM_TBL   where substr(wtpsc_code,20,2) like 'S%' and asset_code='" + assetcode + "'");%>
 
			
				<tr class="btext">
				<td class=rptValue>SS Filter</td>
				</tr>
			   
              <tr>	
				<% s6=conn.createStatement();
	r6=s6.executeQuery("select count(*) from RWS_CPWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'   and substr(wtpsc_code,20,2) like 'S%'");
	r6.next();
		count18=r6.getInt(1);
		if(count18!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_wtp1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>&rs=<%="SS"%>"><%=count18%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count18!=0)
				 {
		while(rs42.next())
		{
		
		%>
		<% if(rs42.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs42.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs42.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select  NVL(wtpsc_code,'-'),nvl(location,'-'),use_capacitymld from RWS_CPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='R%'");%>

			
				<tr class="btext">
				<td class=rptValue>RS Filter</td>
				</tr>
				<tr>	
				<% s7=conn.createStatement();
	r7=s7.executeQuery("select count(*) from RWS_CPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='R%'");
	r7.next();
		count17=r7.getInt(1);
		if(count17!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_wtp1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>&rs=<%="RS"%>"><%=count17%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count17!=0)
				 {
		while(rs22.next())
		{
		
		%>
		<% if(rs22.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs22.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs22.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				//RWS_PWS_SUMP_M_SC_PARAM_TBL 
	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select NVL(sumpcode,'-'),nvl(location,'-'),sump_capacity from rws_Cpws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"'"); //sump%> 
			
				<tr class="btext">
				<td class=rptValue>Sump</td>
				</tr>
			 <tr>	
				<% s8=conn.createStatement();
	r8=s8.executeQuery("select count(*) from rws_Cpws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"'");
	r8.next();
		count16=r8.getInt(1);
		if(count16!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_sump1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count16%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count16!=0)
				 {
		while(rs20.next())
		{
		
		%>
		<% if(rs20.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs20.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs20.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%   
					 stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select NVL(bridge_code,'-') from RWS_CPWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"'");%> 
				
				<tr class="btext">
				<td class=rptValue>Foot Path Bridge</td>
			  
			   </tr>
			  <tr>	
				<% s9=conn.createStatement();
	r9=s9.executeQuery("select count(*) from RWS_CPWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"'");
	r9.next();
		count15=r9.getInt(1);
		if(count15!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_footpathbridge1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count15%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count15!=0)
				 {
		while(rs6.next())
		{
		
		%>
		<% if(rs6.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs6.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 <td class=rptValue align=center><%="-"%></td>
		<%%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
			

				//RWS_PWS_PUMPHOUSE_PARAM_TBL
stmt14=conn.createStatement();
rs14=stmt14.executeQuery("select NVL(pumphouse_code,'-'),nvl(location,'-')  from RWS_CPWS_PUMPHOUSE_PARAM_TBL  where asset_code= '"+ assetcode+"'");//pumphouse%> 
			
				
				<tr class="btext">
				<td class=rptValue>Pump House</td>
				</TR>
			 <tr>	
				<% s10=conn.createStatement();
	r10=s10.executeQuery("select count(*) from RWS_CPWS_PUMPHOUSE_PARAM_TBL   where asset_code= '"+ assetcode+"'   ");
	r10.next();
		count14=r10.getInt(1);
		if(count14!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumphouse1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count14%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count14!=0)
				 {
		while(rs14.next())
		{
		
		%>
		<% if(rs14.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs14.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs14.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs14.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		//RWS_PWS_WATCHMAN_PARAM_TBL 
					stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select NVL(watchman_code,'-'),nvl(location,'-') from RWS_CPWS_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'"); //watchman%>
			
				
				<tr class="btext">
				<td class=rptValue>Watchman Quarter</td>
				</tr>
			  
			  <tr>	
				<% s11=conn.createStatement();
	r11=s11.executeQuery("select count(*) from RWS_CPWS_WATCHMAN_PARAM_TBL   where asset_code= '"+ assetcode+"'   ");
	r11.next();
		count13=r11.getInt(1);
		if(count13!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_watchmanquarter1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count13%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count13!=0)
				 {
		while(rs21.next())
		{
		
		%>
		<% if(rs21.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs21.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs21.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs21.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
          <td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select NVL(cw_collwell_code,'-'),nvl(location,'-'),capacity from RWS_CPWS_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"'"); //collwell%>
			<tr class="btext">
				<td class=rptValue>Clear Water Collection Well</td>
				</tr>
			  
            <tr>	
				<% s12=conn.createStatement();
	r12=s12.executeQuery("select count(*) from RWS_CPWS_CW_COLLWELL_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r12.next();
		count12=r12.getInt(1);
		if(count12!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_clearwater1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count12%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count12!=0)
				 {
		while(rs4.next())
		{
		
		%>
		<% if(rs4.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs4.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs4.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		}//END OF HEADWORKS
			 
rset.next();
if(rset.getString(1).equals("03") && rset.getString(2).equals("03"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>PIPELINE</td>
			</tr>
			<%
				//RWS_PWS_PUMPINGMAIN_TB
			stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select NVL(pumpingmain_code,'-'),nvl(location,'-') from RWS_CPWS_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'"); //pumpingmain%>
			<tr class="btext">
				<td class=rptValue>Pumping Main</td>
				</tr>
			  <tr>	
				<% s13=conn.createStatement();
	r13=s13.executeQuery("select count(*) from RWS_CPWS_PUMPINGMAIN_TBl    where asset_code= '"+ assetcode+"'   ");
	r13.next();
		count11=r13.getInt(1);
		if(count11!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumpingmain1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count11%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count11!=0)
				 {
		while(rs15.next())
		{
		
		%>
		<% if(rs15.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs15.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs15.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs15.getString(2)%></td>
		<%} else{%>
           <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		<td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}	
		 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				//RWS_PWS_GRAVITYMAIN_TBL 
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select NVL(gravitymain_code,'-'),nvl(location,'-') from RWS_CPWS_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'");//gravitymain%> 
			
				
					
				<tr class="btext">
				<td class=rptValue>Gravity Main</td>
				</tr>
				<tr>	
				<% s14=conn.createStatement();
	r14=s14.executeQuery("select count(*) from RWS_CPWS_GRAVITYMAIN_TBL    where asset_code= '"+ assetcode+"'   ");
	r14.next();
		count10=r14.getInt(1);
		if(count10!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_gravitymain1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count10%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count10!=0)
				 {
		while(rs9.next())
		{
		
		%>
		<% if(rs9.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs9.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs9.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs9.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		<td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<% stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select NVL(distrisc_code,'-'),nvl(location,'-') from RWS_CPWS_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'"); //distribution%>
			
			

                <tr class="btext">
				<td class=rptValue>Distribution</td>
				</tr>
				 <tr>	
				<% s15=conn.createStatement();
	r15=s15.executeQuery("select count(*) from RWS_CPWS_DISTRI_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'   ");
	r15.next();
		count9=r15.getInt(1);
		if(count9!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_distribution1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count9%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count9!=0)
				 {
		while(rs5.next())
		{
		
		%>
		<% if(rs5.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs5.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs5.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs5.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
}//END OF PIPELINE
			
			 rset.next();
			 if(rset.getString(1).equals("03") && rset.getString(2).equals("04"))
			 {%>
			<tr class="btext">
			<td class=rptHeading>SR.RESERVOIRS</td>
			</tr>
			<%
stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select NVL(ohsr_code,'-'),nvl(ohsr_loc,'-'),ohsr_cap_lts from RWS_CPWS_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'"); //ohsr%>
			
				
				<tr class="btext">
				<td class=rptValue>Ohsr</td>
				</tr>
				<tr>	
				<% s16=conn.createStatement();
	r16=s16.executeQuery("select count(*) from RWS_CPWS_OHSR_SC_PARAM_TBL where asset_code= '"+ assetcode+"'   ");
	r16.next();
		count8=r16.getInt(1);
		if(count8!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ohsr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count8%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count8!=0)
				 {
		while(rs11.next())
		{
		
		%>
		<% if(rs11.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs11.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs11.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%//RWS_CPWS_OHBR_SC_PARAM_TBL 
                stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select NVL(ohbr_code,'-'),nvl(ohbr_loc,'-'),ohbr_cap_lts from RWS_CPWS_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'"); //ohbr%>
			
				<tr class="btext">
				<td class=rptValue>Ohbr</td>
				</tr>
				<tr>	
				<% s17=conn.createStatement();
	r17=s17.executeQuery("select count(*) from RWS_CPWS_OHBR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r17.next();
		count7=r17.getInt(1);
		if(count7!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ohbr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count7%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count7!=0)
				 {
		while(rs10.next())
		{
		
		%>
		<% if(rs10.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs10.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs10.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
								 stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select NVL(glsr_code,'-'),nvl(glsr_loc,'-'),glsr_cap_lts from RWS_CPWS_GLSR_SC_PARAM_TBL  where asset_code= '"+assetcode+"'"); //glsr%>
			
				<tr class="btext">
				<td class=rptValue>Glsr</td>
				</tr>
				<tr>	
				<% s18=conn.createStatement();
	r18=s18.executeQuery("select count(*) from RWS_CPWS_GLSR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r18.next();
		count6=r18.getInt(1);
		if(count6!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_glsr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count6%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count6!=0)
				 {
		while(rs8.next())
		{
		
		%>
		<% if(rs8.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs8.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs8.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getFloat(3)%></td>
		<%} else{%>
            <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%}
		
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select NVL(glbr_code,'-'),nvl(glbr_loc,'-'),glbr_cap_lts from RWS_CPWS_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'"); //glbr%>
			
				<tr class="btext">
				<td class=rptValue>Glbr</td>
				</tr>
				<tr>	
				<% s19=conn.createStatement();
	r19=s19.executeQuery("select count(*) from RWS_CPWS_GLBR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r19.next();
		count5=r19.getInt(1);
		if(count5!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_glbr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count5%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count5!=0)
				 {
		while(rs7.next())
		{
		
		%>
		<% if(rs7.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs7.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs7.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select NVL(bpt_code,'-'),nvl(location,'-'),capacity from rws_Cpws_bpt_param_tbl where asset_code='" + assetcode + "' "); //bpt%>
		<tr class="btext">
				<td class=rptValue>Bpt</td>
				</tr>
				<tr>	
				<% s20=conn.createStatement();
	r20=s20.executeQuery("select count(*) from rws_Cpws_bpt_param_tbl    where asset_code= '"+ assetcode+"'   ");
	r20.next();
		count4=r20.getInt(1);
		if(count4!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_bpt1.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count4%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count4!=0)
				 {
		while(rs1.next())
		{
		
		%>
		<% if(rs1.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				stmt2=conn.createStatement();
				rs2=stmt2.executeQuery("select NVL(CISSC_CODE,'-'),nvl(CIS_LOC,'-'),CIS_CAP_LTS  from RWS_CPWS_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"'"); //cistern%>
			
				<tr class="btext">
				<td class=rptValue>Cisterns</td>
				</tr>
				<TR>
				<% s21=conn.createStatement();
	r21=s21.executeQuery("select count(*) from RWS_CPWS_CIS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r21.next();
		count3=r21.getInt(1);
		if(count3!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_cisterns1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count3%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count3!=0)
				 {
		while(rs2.next())
		{
		
		%>
		<% if(rs2.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs2.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs2.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		}//END OF SR.RESERVOIRS
	
			 rset.next();
			 if(rset.getString(1).equals("03") && rset.getString(2).equals("05"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>Others</td>
			</tr>
			<%
				
//RWS_CPWS_OTHERS_PARAM_TBL 
stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select NVL(OTHER_COMP_CODE,'-'),nvl(COMP_LOCATION,'-') from RWS_CPWS_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'"); //others%>
			
				
				<tr class="btext">
				<td class=rptValue>Miscellaneous</td>
				</tr>
				<TR>
				<% s22=conn.createStatement();
	r22=s22.executeQuery("select count(*) from RWS_CPWS_OTHERS_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r22.next();
		count2=r22.getInt(1);
		if(count2!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_other1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count2%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count2!=0)
				 {
		while(rs12.next())
		{
		
		%>
		<% if(rs12.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs12.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs12.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs12.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				}//END OF OTHERS
		 }

else if(typeassetcode.equals("01")) // pws

		 {
			 rset.next();
         if(rset.getString(1).equals("01") && rset.getString(2).equals("01"))
			 {%>
			 <tr class=btext>
			<td class=btext COLSPAN=5><CENTER>PWS</CENTER></td>
			</TR>
			<tr class=btext>
			<td class=rptHeading>SOURCE</td>
			<td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
			
		</tr>
			<%

         stmt23=conn.createStatement();
	/*rs23=stmt23.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1' ");*/
    /*r1=s1.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1'");*/
	rs23=stmt23.executeQuery("select source_code,nvl(location,'-'),nvl(yield,'-') from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '6%' and source_type_code='1' ");%>
	<tr class=btext>
				<td class=rptValue>Sub Surface Source</td>
				
				</tr>
	
    <tr>

	
	<% s1=conn.createStatement();
	r1=s1.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1' ");
	r1.next();
		count23=r1.getInt(1);
		if(count23!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_source1_tbl.jsp?assetcode=<%=assetcode%>&typeassetcode=<%=typeassetcode%>&sourcetypecode=<%='l'%>">
				<%=count23%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count23!=0)
				 {
		while(rs23.next())
		{
		
		%>
		<% if(rs23.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs23.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs23.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>

	<% 
		stmt24=conn.createStatement();
	rs24=stmt24.executeQuery("select source_code,nvl(location,'-'),nvl(yield,'-') from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '6%' and source_type_code='2' ");%>
	<tr class=btext>
				<td class=rptValue>Surface Source</td>
	</tr>
	 <tr>

	
	<% s2=conn.createStatement();
	r2=s2.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='2' ");
	r2.next();
		count22=r2.getInt(1);
		if(count22!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_source1_tbl.jsp?assetcode=<%=assetcode%>&typeassetcode=<%=typeassetcode%>&sourcetypecode=<%='2'%>">
				<%=count22%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count22!=0)
				 {
		while(rs24.next())
		{
		
		%>
		<% if(rs24.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs24.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs24.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select pump_code,nvl(location,'-'),pump_cpty from RWS_PWS_SUBCOMP_PARAM_TBL where asset_code= '"+ assetcode+"'");//pumpsets%> 

<tr class=btext>
				<td class=rptValue>Pumpsets</td>
				
				</tr>
		<tr>	
				<% s3=conn.createStatement();
	r3=s3.executeQuery("select count(*) from RWS_PWS_SUBCOMP_PARAM_TBL  where asset_code= '"+ assetcode+"' ");
	r3.next();
		count21=r3.getInt(1);
		if(count21!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumpsets1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count21%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count21!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

			} //END OF SOURCE
	//}
	rset.next();

		if(rset.getString(1).equals("01") && rset.getString(2).equals("02"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>HEADWORKS</td>
			
			</tr>
			<%


		 //RWS_CPWS_RW_COLLWELL_PARAM_TBL 
		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select  rw_collwell_code,nvl(location,'-'),capacity  from rws_pws_rw_collwell_param_tbl  where asset_code='"+assetcode+"'"); //rawwater%>
			
				
				<tr class="btext">
				<td class=rptValue>Raw Water Collection Well</td>
			   </tr>
<tr>	
				<% s4=conn.createStatement();
	r4=s4.executeQuery("select count(*) from RWS_PWS_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"' ");
	r4.next();
		count20=r4.getInt(1);
		if(count20!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_rawwater1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count20%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count20!=0)
				 {
		while(rs17.next())
		{
		
		%>
		<% if(rs17.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs17.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs17.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

	
//RWS_CPWS_SS_SC_PARAM_TBL 
		stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select  sssc_code,nvl(location,'-'),capacity_mcum from rws_pws_ss_sc_param_tbl where asset_code='" + assetcode + "'" );//sstank%>
			
				
				<tr class="btext">
				<td class=rptValue>SS Tank</td>
			
</tr>
				<tr>	
				<% s5=conn.createStatement();
	r5=s5.executeQuery("select count(*) from RWS_PWS_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r5.next();
		count19=r5.getInt(1);
		if(count19!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_sstank1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count19!=0)
				 {
		while(rs18.next())
		{
		
		%>
		<% if(rs18.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs18.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs18.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

	//ss filter
stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select  wtpsc_code,nvl(location,'-'),use_capacitymld from RWS_PWS_WTP_SC_PARAM_TBL   where substr(wtpsc_code,20,2) like 'S%' and asset_code='" + assetcode + "'");%>
 
			
				<tr class="btext">
				<td class=rptValue>SS Filter</td>
				</tr>
			  <tr>	
				<% s6=conn.createStatement();
	r6=s6.executeQuery("select count(*) from RWS_PWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'   and substr(wtpsc_code,20,2) like 'S%'");
	r6.next();
		count18=r6.getInt(1);
		if(count18!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_wtp1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>&rs=<%="SS"%>"><%=count18%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count18!=0)
				 {
		while(rs42.next())
		{
		
		%>
		<% if(rs42.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs42.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs42.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select  wtpsc_code,nvl(location,'-'),use_capacitymld from RWS_PWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='R%'");%>

			
				
				<tr class="btext">
				<td class=rptValue>RS Filter</td>
				</tr>
				<tr>	
				<% s7=conn.createStatement();
	r7=s7.executeQuery("select count(*) from RWS_PWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='R%'");
	r7.next();
		count17=r7.getInt(1);
		if(count17!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_wtp1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>&rs=<%="RS"%>"><%=count17%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count17!=0)
				 {
		while(rs22.next())
		{
		
		%>
		<% if(rs22.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs22.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs22.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select sumpcode,nvl(location,'-'),sump_capacity from rws_pws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"'"); //sump%> 
			
				<tr class="btext">
				<td class=rptValue>Sump</td>
				</tr>
			  
			  
			 <tr>	
				<% s8=conn.createStatement();
	r8=s8.executeQuery("select count(*) from rws_pws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"'");
	r8.next();
		count16=r8.getInt(1);
		if(count16!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_sump1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count16%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count16!=0)
				 {
		while(rs20.next())
		{
		
		%>
		<% if(rs20.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs20.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs20.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%   stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select bridge_code from RWS_PWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"'");%> 
				
				<tr class="btext">
				<td class=rptValue>Foot Path Bridge</td>
			    </tr>
			 <tr>	
				<% s9=conn.createStatement();
	r9=s9.executeQuery("select count(*) from RWS_PWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"'");
	r9.next();
		count15=r9.getInt(1);
		if(count15!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_footpathbridge1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count15%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count15!=0)
				 {
		while(rs6.next())
		{
		
		%>
		<% if(rs6.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs6.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				//RWS_PWS_PUMPHOUSE_PARAM_TBL
stmt14=conn.createStatement();
rs14=stmt14.executeQuery("select pumphouse_code,nvl(location,'-')  from RWS_PWS_PUMPHOUSE_PARAM_TBL  where asset_code= '"+ assetcode+"'");//pumphouse%> 
			
				
				<tr class="btext">
				<td class=rptValue>Pump House</td>
				</tr>
			 
			   <tr>	
				<% s10=conn.createStatement();
	r10=s10.executeQuery("select count(*) from RWS_PWS_PUMPHOUSE_PARAM_TBL   where asset_code= '"+ assetcode+"'   ");
	r10.next();
		count14=r10.getInt(1);
		if(count14!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumphouse1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count14%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count14!=0)
				 {
		while(rs14.next())
		{
		
		%>
		<% if(rs14.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs14.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs14.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs14.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		//RWS_PWS_WATCHMAN_PARAM_TBL 
					stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select watchman_code,nvl(location,'-') from RWS_PWS_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'"); //watchman%>
			
				
				<tr class="btext">
				<td class=rptValue>Watchman Quarter</td>
				</tr>
			  
			  <tr>	
				<% s11=conn.createStatement();
	r11=s11.executeQuery("select count(*) from RWS_PWS_WATCHMAN_PARAM_TBL   where asset_code= '"+ assetcode+"'   ");
	r11.next();
		count13=r11.getInt(1);
		if(count13!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_watchmanquarter1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count13%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count13!=0)
				 {
		while(rs21.next())
		{
		
		%>
		<% if(rs21.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs21.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs21.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs21.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
          <td class=rptValue align=center><%="-"%></td>
		  
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select cw_collwell_code,nvl(location,'-'),capacity from RWS_PWS_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"'"); //collwell%>
			<tr class="btext">
				<td class=rptValue>Clear Water Collection Well</td>
				</tr>
			<tr>	
				<% s12=conn.createStatement();
	r12=s12.executeQuery("select count(*) from RWS_PWS_CW_COLLWELL_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r12.next();
		count12=r12.getInt(1);
		if(count12!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_clearwater1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count12%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count12!=0)
				 {
		while(rs4.next())
		{
		
		%>
		<% if(rs4.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs4.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs4.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		}//END OF HEADWORKS
			 
rset.next();
if(rset.getString(1).equals("01") && rset.getString(2).equals("03"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>PIPELINE</td>
			</tr>
			<%
				//RWS_PWS_PUMPINGMAIN_TB
			stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select pumpingmain_code,nvl(location,'-') from RWS_PWS_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'"); //pumpingmain%>
			<tr class="btext">
				<td class=rptValue>Pumping Main</td>
				</tr>
			  <tr>	
				<% s13=conn.createStatement();
	r13=s13.executeQuery("select count(*) from RWS_PWS_PUMPINGMAIN_TBl    where asset_code= '"+ assetcode+"'   ");
	r13.next();
		count11=r13.getInt(1);
		if(count11!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumpingmain1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count11%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count11!=0)
				 {
		while(rs15.next())
		{
		
		%>
		<% if(rs15.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs15.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs15.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs15.getString(2)%></td>
		<%} else{%>
           <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		
         <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%	}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%	//RWS_PWS_GRAVITYMAIN_TBL 
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select gravitymain_code,nvl(location,'-') from RWS_PWS_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'");//gravitymain%> 
			
				
					
				<tr class="btext">
				<td class=rptValue>Gravity Main</td>
				</tr>
				<tr>	
				<% s14=conn.createStatement();
	r14=s14.executeQuery("select count(*) from RWS_PWS_GRAVITYMAIN_TBL    where asset_code= '"+ assetcode+"'   ");
	r14.next();
		count10=r14.getInt(1);
		if(count10!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_gravitymain1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count10%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count10!=0)
				 {
		while(rs9.next())
		{
		
		%>
		<% if(rs9.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs9.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs9.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs9.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		<td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select distrisc_code,nvl(location,'-') from RWS_PWS_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'"); //distribution%>
			
			

                <tr class="btext">
				<td class=rptValue>Distribution</td>
				</tr>
				<tr>	
				<% s15=conn.createStatement();
	r15=s15.executeQuery("select count(*) from RWS_PWS_DISTRI_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'   ");
	r15.next();
		count9=r15.getInt(1);
		if(count9!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_distribution1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count9%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count9!=0)
				 {
		while(rs5.next())
		{
		
		%>
		<% if(rs5.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs5.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs5.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs5.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
			
}//END OF PIPELINE
			
			 rset.next();
			 if(rset.getString(1).equals("01") && rset.getString(2).equals("04"))
			 {%>
			<tr class="btext">
			<td class=rptHeading>SR.RESERVOIRS</td>
			</tr>
			<%
stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select ohsr_code,nvl(ohsr_loc,'-'),ohsr_cap_lts from RWS_PWS_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'"); //ohsr%>
			
				
				<tr class="btext">
				<td class=rptValue>Ohsr</td>
				</tr>
				<tr>	
				<% s16=conn.createStatement();
	r16=s16.executeQuery("select count(*) from RWS_PWS_OHSR_SC_PARAM_TBL where asset_code= '"+ assetcode+"'   ");
	r16.next();
		count8=r16.getInt(1);
		if(count8!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ohsr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count8%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count8!=0)
				 {
		while(rs11.next())
		{
		
		%>
		<% if(rs11.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs11.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs11.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				//RWS_CPWS_OHBR_SC_PARAM_TBL 
                stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select ohbr_code,nvl(ohbr_loc,'-'),ohbr_cap_lts from RWS_PWS_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'"); //ohbr%>
			
				<tr class="btext">
				<td class=rptValue>Ohbr</td>
				</tr>
				<tr>	
				<% s17=conn.createStatement();
	r17=s17.executeQuery("select count(*) from RWS_PWS_OHBR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r17.next();
		count7=r17.getInt(1);
		if(count7!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ohbr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count7%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count7!=0)
				 {
		while(rs10.next())
		{
		
		%>
		<% if(rs10.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs10.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs10.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				 stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select glsr_code,nvl(glsr_loc,'-'),glsr_cap_lts from RWS_PWS_GLSR_SC_PARAM_TBL  where asset_code= '"+assetcode+"'"); //glsr%>
			
				<tr class="btext">
				<td class=rptValue>Glsr</td>
				</tr>
				<tr>	
				<% s18=conn.createStatement();
	r18=s18.executeQuery("select count(*) from RWS_PWS_GLSR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r18.next();
		count6=r18.getInt(1);
		if(count6!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_glsr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count6%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count6!=0)
				 {
		while(rs8.next())
		{
		
		%>
		<% if(rs8.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs8.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs8.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select glbr_code,nvl(glbr_loc,'-'),glbr_cap_lts from RWS_PWS_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'"); //glbr%>
			
				<tr class="btext">
				<td class=rptValue>Glbr</td>
				</tr>
				<tr>	
				<% s19=conn.createStatement();
	r19=s19.executeQuery("select count(*) from RWS_PWS_GLBR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r19.next();
		count5=r19.getInt(1);
		if(count5!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_glbr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count5%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count5!=0)
				 {
		while(rs7.next())
		{
		
		%>
		<% if(rs7.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs7.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs7.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select bpt_code,nvl(location,'-'),capacity from rws_pws_bpt_param_tbl where asset_code='" + assetcode + "' "); //bpt%>
		<tr class="btext">
				<td class=rptValue>Bpt</td>
				</tr>
				<tr>	
				<% s20=conn.createStatement();
	r20=s20.executeQuery("select count(*) from rws_pws_bpt_param_tbl    where asset_code= '"+ assetcode+"'   ");
	r20.next();
		count4=r20.getInt(1);
		if(count4!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_bpt1.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count4%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count4!=0)
				 {
		while(rs1.next())
		{
		
		%>
		<% if(rs1.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				stmt2=conn.createStatement();
				rs2=stmt2.executeQuery("select CISSC_CODE,nvl(CIS_LOC,'-'),CIS_CAP_LTS  from RWS_PWS_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"'"); //cistern%>
			
				<tr class="btext">
				<td class=rptValue>Cisterns</td>
				</tr>
				<TR>
				<% s21=conn.createStatement();
	r21=s21.executeQuery("select count(*) from RWS_PWS_CIS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r21.next();
		count3=r21.getInt(1);
		if(count3!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_cisterns1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count3%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count3!=0)
				 {
		while(rs2.next())
		{
		
		%>
		<% if(rs2.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs2.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs2.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		}//END OF SR.RESERVOIRS
	
			 rset.next();
			 if(rset.getString(1).equals("01") && rset.getString(2).equals("05"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>Others</td>
			</tr>
			<%
				
//RWS_CPWS_OTHERS_PARAM_TBL 
stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select OTHER_COMP_CODE,nvl(COMP_LOCATION,'-') from RWS_PWS_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'"); //others%>
			
				
				<tr class="btext">
				<td class=rptValue>Miscellaneous</td>
				</tr>
				<TR>
				<% s22=conn.createStatement();
	r22=s22.executeQuery("select count(*) from RWS_PWS_OTHERS_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r22.next();
		count2=r22.getInt(1);
		if(count2!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_other1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count2%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count2!=0)
				 {
		while(rs12.next())
		{
		
		%>
		<% if(rs12.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs12.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs12.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs12.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				}//END OF OTHERS
		 }

	else if(typeassetcode.equals("02")) // Mpws

		 {
			 rset.next();
         if(rset.getString(1).equals("02") && rset.getString(2).equals("01"))
			 {%>
			<tr class=btext>
			<td class=btext colspan="5">MPWS</td>
			</tr>
			<tr class=btext>
			<td class=rptHeading>SOURCE</td>
			<td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
		</tr>
			<%

         stmt23=conn.createStatement();
	/*rs23=stmt23.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1' ");*/

	rs23=stmt23.executeQuery("select source_code,nvl(location,'-'),nvl(yield,'-') from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '4%' and source_type_code='1' ");%>
	<tr class=btext>
				<td class=rptValue>Sub Surface Source</td>
	</tr>
	
	<tr>

	
	<% s1=conn.createStatement();
	r1=s1.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '4%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='1' ");
	r1.next();
		count23=r1.getInt(1);
		if(count23!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_source1_tbl.jsp?assetcode=<%=assetcode%>&typeassetcode=<%=typeassetcode%>&sourcetypecode=<%='l'%>">
				<%=count23%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count23!=0)
				 {
		while(rs23.next())
		{
		
		%>
		<% if(rs23.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs23.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs23.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs23.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<% }
				 }else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>

	<% 
	
	stmt24=conn.createStatement();
	rs24=stmt24.executeQuery("select source_code,nvl(location,'-'),nvl(yield,'-') from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '4%' and source_type_code='2' ");%>
	<tr class=btext>
				<td class=rptValue>Surface Source</td>
				
				</tr>
	 <tr>

	
	<% s2=conn.createStatement();
	r2=s2.executeQuery("select count(*) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '4%' and p.source_type_code=s.source_type_code  and asset_code='" + assetcode + "' and p.source_type_code='2' ");
	r2.next();
		count22=r2.getInt(1);
		if(count22!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_source1_tbl.jsp?assetcode=<%=assetcode%>&typeassetcode=<%=typeassetcode%>&sourcetypecode=<%='2'%>">
				<%=count22%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count22!=0)
				 {
		while(rs24.next())
		{
		
		%>
		<% if(rs24.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs24.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs24.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs24.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select pump_code,nvl(location,'-'),pump_cpty from RWS_MPWS_SUBCOMP_PARAM_TBL where asset_code= '"+ assetcode+"'");//pumpsets%> 

<tr class=btext>
				<td class=rptValue>Pumpsets</td>
</tr>
			<TR>
				<% s3=conn.createStatement();
	r3=s3.executeQuery("select count(*) from RWS_MPWS_SUBCOMP_PARAM_TBL  where asset_code= '"+ assetcode+"' ");
	r3.next();
		count21=r3.getInt(1);
		if(count21!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumpsets1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count21%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count21!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

			
			} //END OF SOURCE
	//}
	rset.next();

		if(rset.getString(1).equals("02") && rset.getString(2).equals("02"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>HEADWORKS</td>
			
			</tr>
			<%


		 //RWS_CPWS_RW_COLLWELL_PARAM_TBL 
		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select  rw_collwell_code,nvl(location,'-'),capacity  from rws_Mpws_rw_collwell_param_tbl  where asset_code='"+assetcode+"'"); //rawwater%>
			
				
				<tr class="btext">
				<td class=rptValue>Raw Water Collection Well</td>
			   </tr>
<tr>	
				<% s4=conn.createStatement();
	r4=s4.executeQuery("select count(*) from RWS_MPWS_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"' ");
	r4.next();
		count20=r4.getInt(1);
		if(count20!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_rawwater1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count20%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count20!=0)
				 {
		while(rs17.next())
		{
		
		%>
		<% if(rs17.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs17.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs17.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs17.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

		stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select  sssc_code,nvl(location,'-'),capacity_mcum from rws_Mpws_ss_sc_param_tbl where asset_code='" + assetcode + "'" );//sstank%>
			
				
				<tr class="btext">
				<td class=rptValue>SS Tank</td>
			
</tr>
				<tr>	
				<% s5=conn.createStatement();
	r5=s5.executeQuery("select count(*) from RWS_MPWS_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r5.next();
		count19=r5.getInt(1);
		if(count19!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_sstank1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count19!=0)
				 {
		while(rs18.next())
		{
		
		%>
		<% if(rs18.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs18.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs18.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs18.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

					//ss filter
stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select  wtpsc_code,nvl(location,'-'),use_capacitymld from RWS_MPWS_WTP_SC_PARAM_TBL   where substr(wtpsc_code,20,2) like 'S%' and asset_code='" + assetcode + "'");%>
 
			
				<tr class="btext">
				<td class=rptValue>SS Filter</td>
				</tr>
			   
             <tr>	
				<% s6=conn.createStatement();
	r6=s6.executeQuery("select count(*) from RWS_MPWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'   and substr(wtpsc_code,20,2) like 'S%'");
	r6.next();
		count18=r6.getInt(1);
		if(count18!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_wtp1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>&rs=<%="SS"%>"><%=count18%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count18!=0)
				 {
		while(rs42.next())
		{
		
		%>
		<% if(rs42.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs42.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs42.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs42.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
	
stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select  wtpsc_code,nvl(location,'-'),use_capacitymld from RWS_MPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='R%'");%>

			
				
				<tr class="btext">
				<td class=rptValue>RS Filter</td>
				</tr>
				<tr>	
				<% s7=conn.createStatement();
	r7=s7.executeQuery("select count(*) from RWS_MPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='R%'");
	r7.next();
		count17=r7.getInt(1);
		if(count17!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_wtp1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>&rs=<%="RS"%>"><%=count17%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count17!=0)
				 {
		while(rs22.next())
		{
		
		%>
		<% if(rs22.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs22.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs22.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs22.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%//RWS_PWS_SUMP_M_SC_PARAM_TBL 
	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select sumpcode,nvl(location,'-'),sump_capacity from rws_Mpws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"'"); //sump%> 
			
				<tr class="btext">
				<td class=rptValue>Sump</td>
				</tr>
			  
			  
			  <tr>	
				<% s8=conn.createStatement();
	r8=s8.executeQuery("select count(*) from rws_Mpws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"'");
	r8.next();
		count16=r8.getInt(1);
		if(count16!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_sump1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count16%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count16!=0)
				 {
		while(rs20.next())
		{
		
		%>
		<% if(rs20.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs20.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs20.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs20.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%  
			    stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select bridge_code from RWS_MPWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"'");%> 
				
				<tr class="btext">
				<td class=rptValue>Foot Path Bridge</td>
			  
			   </tr>
			  <tr>	
				<% s9=conn.createStatement();
	r9=s9.executeQuery("select count(*) from RWS_MPWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"'");
	r9.next();
		count15=r9.getInt(1);
		if(count15!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_footpathbridge1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count15%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count15!=0)
				 {
		while(rs6.next())
		{
		
		%>
		<% if(rs6.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs6.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 <td class=rptValue align=center><%="-"%></td>
         
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				//RWS_PWS_PUMPHOUSE_PARAM_TBL
stmt14=conn.createStatement();
rs14=stmt14.executeQuery("select pumphouse_code,nvl(location,'-')  from RWS_MPWS_PUMPHOUSE_PARAM_TBL  where asset_code= '"+ assetcode+"'");//pumphouse%> 
			
				
				<tr class="btext">
				<td class=rptValue>Pump House</td>
				</TR>

			 
			   
				<tr>	
				<% s10=conn.createStatement();
	r10=s10.executeQuery("select count(*) from RWS_MPWS_PUMPHOUSE_PARAM_TBL   where asset_code= '"+ assetcode+"'   ");
	r10.next();
		count14=r10.getInt(1);
		if(count14!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumphouse1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count14%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count14!=0)
				 {
		while(rs14.next())
		{
		
		%>
		<% if(rs14.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs14.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs14.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs14.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		

		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		//RWS_PWS_WATCHMAN_PARAM_TBL 
					stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select watchman_code,nvl(location,'-') from RWS_MPWS_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'"); //watchman%>
			
				
				<tr class="btext">
				<td class=rptValue>Watchman Quarter</td>
				</tr>
			  
			  
			   <tr>	
				<% s11=conn.createStatement();
	r11=s11.executeQuery("select count(*) from RWS_MPWS_WATCHMAN_PARAM_TBL   where asset_code= '"+ assetcode+"'   ");
	r11.next();
		count13=r11.getInt(1);
		if(count13!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_watchmanquarter1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count13%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count13!=0)
				 {
		while(rs21.next())
		{
		
		%>
		<% if(rs21.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs21.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs21.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs21.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
          <td class=rptValue align=center><%="-"%></td>

		 </tr>
		 <tr>
		 <td colspan=2></td>
		

		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select cw_collwell_code,nvl(location,'-'),capacity from RWS_MPWS_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"'"); //collwell%>
			<tr class="btext">
				<td class=rptValue>Clear Water Collection Well</td>
				</tr>
			  
             <tr>	
				<% s12=conn.createStatement();
	r12=s12.executeQuery("select count(*) from RWS_MPWS_CW_COLLWELL_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r12.next();
		count12=r12.getInt(1);
		if(count12!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_clearwater1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count12%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count12!=0)
				 {
		while(rs4.next())
		{
		
		%>
		<% if(rs4.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs4.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs4.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs4.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
		}//END OF HEADWORKS
			 
rset.next();
if(rset.getString(1).equals("02") && rset.getString(2).equals("03"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>PIPELINE</td>
			</tr>
			<%
				//RWS_PWS_PUMPINGMAIN_TB
			stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select pumpingmain_code,nvl(location,'-') from RWS_MPWS_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'"); //pumpingmain%>
			<tr class="btext">
				<td class=rptValue>Pumping Main</td>
				</tr>
			   <tr>	
				<% s13=conn.createStatement();
	r13=s13.executeQuery("select count(*) from RWS_MPWS_PUMPINGMAIN_TBl    where asset_code= '"+ assetcode+"'   ");
	r13.next();
		count11=r13.getInt(1);
		if(count11!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_pumpingmain1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count11%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count11!=0)
				 {
		while(rs15.next())
		{
		
		%>
		<% if(rs15.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs15.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs15.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs15.getString(2)%></td>
		<%} else{%>
           <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		
         <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%	}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%	//RWS_PWS_GRAVITYMAIN_TBL 
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select gravitymain_code,nvl(location,'-') from RWS_MPWS_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'");//gravitymain%> 
			
				
					
				<tr class="btext">
				<td class=rptValue>Gravity Main</td>
				</tr>
				<tr>	
				<% s14=conn.createStatement();
	r14=s14.executeQuery("select count(*) from RWS_MPWS_GRAVITYMAIN_TBL    where asset_code= '"+ assetcode+"'   ");
	r14.next();
		count10=r14.getInt(1);
		if(count10!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_gravitymain1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count10%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count10!=0)
				 {
		while(rs9.next())
		{
		
		%>
		<% if(rs9.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs9.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs9.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs9.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		<td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
					 stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select distrisc_code,nvl(location,'-') from RWS_MPWS_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'"); //distribution%>
			
			

                <tr class="btext">
				<td class=rptValue>Distribution</td>
				</tr>
				<tr>	
				<% s15=conn.createStatement();
	r15=s15.executeQuery("select count(*) from RWS_MPWS_DISTRI_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'   ");
	r15.next();
		count9=r15.getInt(1);
		if(count9!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_distribution1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count9%></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count9!=0)
				 {
		while(rs5.next())
		{
		
		%>
		<% if(rs5.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs5.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs5.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs5.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
}//END OF PIPELINE
			
			 rset.next();
			 if(rset.getString(1).equals("02") && rset.getString(2).equals("04"))
			 {%>
			<tr class="btext">
			<td class=rptHeading>SR.RESERVOIRS</td>
			</tr>
			<%
stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select ohsr_code,nvl(ohsr_loc,'-'),ohsr_cap_lts from RWS_MPWS_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'"); //ohsr%>
			
				
				<tr class="btext">
				<td class=rptValue>Ohsr</td>
				</tr>
				<tr>	
				<% s16=conn.createStatement();
	r16=s16.executeQuery("select count(*) from RWS_MPWS_OHSR_SC_PARAM_TBL where asset_code= '"+ assetcode+"'   ");
	r16.next();
		count8=r16.getInt(1);
		if(count8!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ohsr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count8%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count8!=0)
				 {
		while(rs11.next())
		{
		
		%>
		<% if(rs11.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs11.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs11.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs11.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%//RWS_CPWS_OHBR_SC_PARAM_TBL 
                stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select ohbr_code,nvl(ohbr_loc,'-'),ohbr_cap_lts from RWS_MPWS_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'"); //ohbr%>
			
				<tr class="btext">
				<td class=rptValue>Ohbr</td>
				</tr>
				 <tr>	
				<% s17=conn.createStatement();
	r17=s17.executeQuery("select count(*) from RWS_MPWS_OHBR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r17.next();
		count7=r17.getInt(1);
		if(count7!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ohbr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count7%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count7!=0)
				 {
		while(rs10.next())
		{
		
		%>
		<% if(rs10.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs10.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs10.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs10.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				
				 stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select glsr_code,nvl(glsr_loc,'-'),glsr_cap_lts from RWS_MPWS_GLSR_SC_PARAM_TBL  where asset_code= '"+assetcode+"'"); //glsr%>
			
				<tr class="btext">
				<td class=rptValue>Glsr</td>
				</tr>
				 <tr>	
				<% s18=conn.createStatement();
	r18=s18.executeQuery("select count(*) from RWS_MPWS_GLSR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r18.next();
		count6=r18.getInt(1);
		if(count6!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_glsr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count6%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count6!=0)
				 {
		while(rs8.next())
		{
		
		%>
		<% if(rs8.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs8.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs8.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs8.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%

stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select glbr_code,nvl(glbr_loc,'-'),glbr_cap_lts from RWS_MPWS_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'"); //glbr%>
			
				<tr class="btext">
				<td class=rptValue>Glbr</td>
				</tr>
				<tr>	
				<% s19=conn.createStatement();
	r19=s19.executeQuery("select count(*) from RWS_MPWS_GLBR_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r19.next();
		count5=r19.getInt(1);
		if(count5!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_glbr1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count5%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count5!=0)
				 {
		while(rs7.next())
		{
		
		%>
		<% if(rs7.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs7.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs7.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs7.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%	
			stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select bpt_code,nvl(location,'-'),capacity from rws_Mpws_bpt_param_tbl where asset_code='" + assetcode + "' "); //bpt%>
		<tr class="btext">
				<td class=rptValue>Bpt</td>
				</tr>
				<tr>	
				<% s20=conn.createStatement();
	r20=s20.executeQuery("select count(*) from rws_Mpws_bpt_param_tbl    where asset_code= '"+ assetcode+"'   ");
	r20.next();
		count4=r20.getInt(1);
		if(count4!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_bpt1.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count4%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count4!=0)
				 {
		while(rs1.next())
		{
		
		%>
		<% if(rs1.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs1.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
			
				 
				 stmt2=conn.createStatement();
				rs2=stmt2.executeQuery("select CISSC_CODE,nvl(CIS_LOC,'-'),CIS_CAP_LTS  from RWS_MPWS_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"'"); //cistern%>
			
				<tr class="btext">
				<td class=rptValue>Cisterns</td>
				</tr>
				<TR>
				<% s21=conn.createStatement();
	r21=s21.executeQuery("select count(*) from RWS_MPWS_CIS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r21.next();
		count3=r21.getInt(1);
		if(count3!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_cisterns1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count3%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count3!=0)
				 {
		while(rs2.next())
		{
		
		%>
		<% if(rs2.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs2.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs2.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs2.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
		<% }//END OF SR.RESERVOIRS
	
			 rset.next();
			 if(rset.getString(1).equals("02") && rset.getString(2).equals("05"))
			 {%>
			<tr class=btext>
			<td class=rptHeading>Others</td>
			</tr>
			<%
				
//RWS_CPWS_OTHERS_PARAM_TBL 
stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select OTHER_COMP_CODE,nvl(COMP_LOCATION,'-') from RWS_MPWS_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'"); //others%>
			
				
				<tr class="btext">
				<td class=rptValue>Miscellaneous</td>
				</tr>
				 <TR>
				<% s22=conn.createStatement();
	r22=s22.executeQuery("select count(*) from RWS_MPWS_OTHERS_PARAM_TBL    where asset_code= '"+ assetcode+"'   ");
	r22.next();
		count2=r22.getInt(1);
		if(count2!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_other1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count2%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count2!=0)
				 {
		while(rs12.next())
		{
		
		%>
		<% if(rs12.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs12.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs12.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs12.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 <td class=rptValue align=center><%="-"%></td>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
				}//END OF OTHERS
		 }


else if(typeassetcode.equals("07")) // ponds
	{%>
<tr class=btext>
			<td class=btext COLSPAN=5><CENTER>PONDS</CENTER></td>
			 </tr>
			<tr class=btext>
            <td class=rptHeading>SOURCE</td>
			<td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
		</tr>
<% stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select nvl(pond_code,'-'),nvl(pond_location,'-'),nvl(storage_vol,'-') from rws_openwell_pond_tbl where asset_code='"+assetcode+"'  ");%>
			
				<tr class="btext">
				<td class=rptValue>Ponds</td>
				</tr>
				 <TR>
				<% s22=conn.createStatement();
	r22=s22.executeQuery("select count(*) from rws_openwell_pond_tbl  where asset_code= '"+ assetcode+"'   ");
	r22.next();
		count2=r22.getInt(1);
		if(count2!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_ponds1_rpt.jsp?typeassetcode=<%=typeassetcode%>
				&assetcode=<%=assetcode%>"><%=count2%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count2!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%} if(rs19.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%	//end of if
	}


		
else if(typeassetcode.equals("05")) // shallowpumps
	{%>
<tr class=btext>
			<td class=btext COLSPAN=5><CENTER>SHALLOW HANDPUMPS</CENTER></td>
			 </tr>
			<tr class=btext>
			<td class=rptHeading>SOURCE</td>
            <td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
		</tr>
	
	<% stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select nvl(SHALLOWHP_CODE,'-'),nvl(location,'-'),yield  from RWS_SHALLOWHANDPUMPS_TBL     where asset_code= '"+ assetcode+"' ");%>
			
				<tr class="btext">
				<td class=rptValue>Shallow HandPumps</td>
				</tr>
				 <TR>
				<% s22=conn.createStatement();
	r22=s22.executeQuery("select count(*) from RWS_SHALLOWHANDPUMPS_TBL  where asset_code= '"+ assetcode+"'   ");
	r22.next();
		count2=r22.getInt(1);
		if(count2!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_shallow1_rpt.jsp?typeassetcode=<%=typeassetcode%>
				&assetcode=<%=assetcode%>"><%=count2%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count2!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%} if(rs19.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
	}


else if(typeassetcode.equals("04")) // handpumps
	{
		rset.next();
		if(rset.getString(1).equals("04") && rset.getString(2).equals("01"))
			 {%>
			 <tr class=btext>
			<td class=btext COLSPAN=5><CENTER>HANDPUMPS</CENTER></td>
			 </tr>
			<tr class=btext>
			<td class=rptHeading>SOURCE</td>
            <td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
		</tr>
<% stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select nvl(hp_code,'-'),nvl(location,'-'),p_yeild from rws_hp_subcomp_param_tbl     where asset_code= '"+ assetcode+"'  ");%>
			
				
				<tr class="btext">
				<td class=rptValue>BoreWells</td>
				</tr>
				<TR>
				<% s22=conn.createStatement();
	r22=s22.executeQuery("select count(*) from rws_hp_subcomp_param_tbl where asset_code= '"+ assetcode+"'   ");
	r22.next();
		count2=r22.getInt(1);
		if(count2!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_handpumps1_rpt.jsp?typeassetcode=<%=typeassetcode%>
				&assetcode=<%=assetcode%>"><%=count2%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count2!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%} if(rs19.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getFloat(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		 
		 </tr>
		 <tr>
		 <td colspan=2></td>
		<%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%
	}

	else if(typeassetcode.equals("06")) // openwells
	{%>

	
			 <tr class=btext>
			<td class=btext COLSPAN=5><CENTER>OPENWELLS</CENTER></td>
			 </tr>
			<tr class=btext>
			<td class=rptHeading>SOURCE</td>
			<td class=rptHeading>Count</td>
			<td class=rptHeading>Code</td>
			<td class=rptHeading>Location</td>
			<td class=rptHeading>Yeild/Capacity(Lts)</td>
		</tr>
	<% stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select openwell_code,nvl(location,'-') from rws_open_well_mast_tbl  where asset_code='"+assetcode+"'  ");%>
			
				<tr class="btext">
				<td class=rptValue>OpenWells</td>
				</tr>
				 <TR>
				<% s21=conn.createStatement();
	r21=s21.executeQuery("select count(*) from rws_open_well_mast_tbl   where asset_code= '"+ assetcode+"'   ");
	r21.next();
		count3=r21.getInt(1);
		if(count3!=0)
			{
				%>
				<td class=rptValue></td>
				<td class=rptValue><a href="./rws_openwell1_rpt.jsp?typeassetcode=<%=typeassetcode%>&assetcode=<%=assetcode%>"><%=count3%></a></td>
				<%
			}
				else{%>
				<td class=rptValue></td>
				<td class=rptValue><%="-"%></td>
				
                 <%}
				 if(count3!=0)
				 {
		while(rs19.next())
		{
		
		%>
		<% if(rs19.getString(1)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(1)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs19.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=center><%=rs19.getString(2)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		<td class=rptValue align=center><%="-"%></td>
		
		 </tr>
		 <tr>
		 <td colspan=2></td>
		
		 <%
		}
				 }
				 else{%>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
				<td class=rptValue><%="-"%></td>
                 <%}%>
	 </tr>
<%	}

	
	}
		
}

	
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
	conn.close();
}

%>
</table>
</form>
</body>
</html>
