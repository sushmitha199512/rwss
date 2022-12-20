<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="nic.watersoft.masters.RwsMasterData" %>
<%@page import="nic.watersoft.reports.CheckListMasterData" %>
<%@page import="javax.sql.DataSource" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<%@ page contentType="application/vnd.ms-excel" %>
<%
try
{
%>
<html>
<head>

</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">


<%
RwsMasterData rmd = new RwsMasterData();
CheckListMasterData cmd = new CheckListMasterData();

String hpQuery = "select * from (select a.*,rownum r from(select subCompTbl.*,decode (subCompTbl.PAINTED ,'Y','YES','N','NO')paint,decode (subCompTbl.PLATFORM_CONDITION ,'Y','YES','N','NO')pcond, ASSET_NAME FROM RWS_ASSET_MAST_TBL M, RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(m.hab_code,1,2)= '"+request.getParameter("district")+"' and M.type_of_asset_code='04' and substr(subCompTbl.HP_CODE,17,3) like '0%' )a) ";
stmt = conn.createStatement();
rs = stmt.executeQuery(hpQuery);
 %>
<table>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
HAND PUMPS-SOURCE-BORE WELL-REPORT  for the District:<font color="white"><%=rmd.getDistName1(request.getParameter("district")) %></font>
</td>
</tr>
<tr>
<td>
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH>S.No</TH>
						<TH >District</TH>
						<TH >Mandal</TH>
						<TH >Panchayat</TH>
						<TH >Village</TH>
						<TH>Habitation</TH>
						<TH>Asset Name</TH>
						<TH>Pump Code </TH>
						<TH>Location</TH>
						<TH>Diameter(mm)</TH>
						<TH>Depth(Mts) </TH>
						<TH>Casing(Type) </TH>
					 	<TH>No of GI Pipes </TH>
						<TH>General Condition </TH>
						<TH>Static Water Level(Mts) </TH>
						<TH>Summer Water Level(Mts)(From Ground)  </TH>
						<TH>No Of Hours Serving per day  </TH>
						<TH>No Of Households Served  </TH>
						<TH>HP No Painted  </TH>
					    <TH>Repairs Per Year  </TH>
					    <TH>Platform Existing  </TH>
					    <TH>Platform Condition  </TH>
					    <TH>Drain </TH>
						<TH>Drain Condition </TH>
						<TH>Drain Connected to Side Drains </TH>
						<TH>Leach pit   </TH>
						<TH>Hygiene   </TH>
						<TH>Present Yield (as per Local Enquiry)  </TH>
					    <TH>Yield(l.p.m)   </TH>
					    <TH>Quality Affected[NSS(Y)/Safe Source(N)]</TH>
					
					</THEAD>
<%
int count = 1;
Statement stmt1 = conn.createStatement();
String dname="",mname="",vname="",pname="",habname="";
ResultSet rs1 = null;
while(rs.next())
{
dname="";mname="";vname="";pname="";habname="";
String habQry = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.hab_code='"+rs.getString("HP_CODE").substring(0,16)+"'";
//System.out.println("hab qry:"+habQry);
rs1 = stmt1.executeQuery(habQry);
if(rs1.next())
{
	dname = rs1.getString(2);
	mname = rs1.getString(4);
	pname = rs1.getString(6);
	vname = rs1.getString(8);
	habname = rs1.getString(10);
}
%>
<tr>
	<td><%=count++%></td>
	<td><%=dname%></td>
	<td><%=mname%></td>
	<td><%=pname%></td>
	<td><%=vname%></td>
	<td><%=habname%></td>
	<td><%=cmd.formatData(rs.getString("ASSET_NAME"))%></td>
	<td><%=cmd.formatData(rs.getString("HP_CODE").substring(0,19))%></td>
	<td><%=cmd.formatData(rs.getString("LOCATION"))%></td>
	<td><%=cmd.formatData(rs.getFloat("DIAMETER"))%></td>
	<td><%=cmd.formatData(rs.getFloat("DEPTH"))%></td>
	<td><%=cmd.formatData(rs.getString("CASING"))%></td> 
	<td><%=cmd.formatData(rs.getInt("GI_NO"))%></td> 
	<td><%=cmd.formatData(rs.getString("GEN_CONDITION"))%></td> 
	<td><%=cmd.formatData(rs.getFloat("STATIC_WL"))%></td> 
	<td><%=cmd.formatData(rs.getFloat("SUMMER_WL"))%></td> 
	<td><%=cmd.formatData(rs.getFloat("SER_HRS"))%></td> 
	<td><%=cmd.formatData(rs.getInt("SER_NO"))%></td> 
	<td><%=cmd.formatData(rs.getString("PAINTED"))%></td> 
	<td><%=cmd.formatData(rs.getString("REPAIRS"))%></td>
	<td><%=cmd.formatData(rs.getString("PLATFORM_EXISTING"))%></td>
	<td><%=cmd.formatData(rs.getString("P_COND"))%></td> 
	<td><%=cmd.formatData(rs.getString("DRAIN"))%></td> 
	<td><%=cmd.formatData(rs.getString("DRAIN_CONDITION"))%></td> 
	<td><%=cmd.formatData(rs.getString("DRAIN_SD"))%></td> 
	<td><%=cmd.formatData(rs.getString("DRAIN_LP"))%></td> 
	<td><%=cmd.formatData(rs.getString("HYGIENE"))%></td> 
	<td><%=cmd.formatData(rs.getString("PYEILD_LOCAL"))%></td> 
	<td><%=cmd.formatData(rs.getInt("P_YEILD"))%></td> 
	<td><%=cmd.formatData(rs.getString("QUALITY_AFFECTED"))%></td>
</tr>
<%
//count++;
}
//System.out.println("count:"+count);
 %>					 
				</TABLE>
				</td>
 </tr>
</table>

 <%
}
catch(Exception e)
            {
            e.printStackTrace();
            } %>    
<p align=left><font color=brown face=verdana size=2><b>

</b></font>
      </p>
</form>
<%@ include file = "footer.jsp" %>
</body>
</html>
      


	