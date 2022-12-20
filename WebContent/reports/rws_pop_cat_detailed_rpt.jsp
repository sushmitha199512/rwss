<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	DecimalFormat ndf = new DecimalFormat("####.00");
	Statement st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs2=null,rs1=null,rs3=null,rs4=null,rs5=null;
	int sno=1;
	int total1=0,total2=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0,total11=0,total12=0,total13=0,total14=0,total15=0,total16=0,total17=0,total19=0,total20=0,total21=0;
	double total18 = 0.0;

	String per = request.getParameter("per");
	String type = request.getParameter("type");
	if(per==null)per="HAB_SUB_TYPE_40PC_CALC";
	if(type==null)type="ST";
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	String q1 = "select dcode||mcode,sum(case when a.coverage_status='FC' then 1 else 0 end)||':'||sum(case when a.coverage_status='PC1' then 1 else 0 end)||':'||sum(case when a.coverage_status='PC2' then 1 else 0 end)||':'||sum(case when a.coverage_status='PC3' then 1 else 0 end)||':'||sum(case when a.coverage_status='PC4' then 1 else 0 end)||':'||sum(case when a.coverage_status='NC' then 1 else 0 end)||':'||sum(case when a.coverage_status='NSS' then 1 else 0 end)||':'||sum(case when a.coverage_status is not null then 1 else 0 end)||':'||SUM(CASE WHEN HABITATION_TYPE='AGENCY' THEN 1 ELSE 0 END)||':'||sum(a.CENSUS_PLAIN_POPU)||':'||sum(a.CENSUS_SC_POPU)||':'||sum(a.CENSUS_ST_POPU) from rws_habitation_directory_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.HABitation_SUB_TYPE= 'ST' group by dcode,dname,mcode,mname order by 1";
	rs1 = st1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(1),rs1.getString(2)); 
	}
	//System.out.println("ht1 size:"+ht1.size());
	String q2 = "select dcode||mcode,sum(case when TYPE_OF_ASSET_CODE='03' then 1 else 0 end)||':'|| sum(case when TYPE_OF_ASSET_CODE='01' then 1 else 0 end)||':'|| sum(case when TYPE_OF_ASSET_CODE='02' then 1 else 0 end)||':'|| sum(case when TYPE_OF_ASSET_CODE='09' then 1 else 0 end)||':'|| sum(case when TYPE_OF_ASSET_CODE='04' then 1 else 0 end)||':'|| sum(case when TYPE_OF_ASSET_CODE='06' then 1 else 0 end)||':'|| sum(case when TYPE_OF_ASSET_CODE='07' then 1 else 0 end) from rws_habitation_directory_tbl a,rws_complete_hab_view b,rws_asset_mast_tbl c where a.hab_code=b.panch_code and a.hab_code=c.hab_code(+) and a.HABitation_SUB_TYPE= 'ST' group by dcode,dname,mcode,mname order by 1";
	//System.out.println("qry2:"+q2);
	rs2 = st2.executeQuery(q2);
	Hashtable ht2 = new Hashtable();
	while(rs2.next())
	{
		ht2.put(rs2.getString(1),rs2.getString(2)); 
	}
	String q3 = "select distinct dcode,mcode from rws_habitation_directory_tbl a,rws_complete_hab_view b,rws_admn_hab_lnk_tbl c,RWS_WORK_ADMN_TBL D where a.hab_code=b.panch_code and a.hab_code=c.hab_code(+) AND C.WORK_ID=D.WORK_ID and a."+per+"= '"+type+"' and D.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and date_of_completion<='31/MAR/2010') and category_code='2' order by 1,2";
	//System.out.println("qry3:"+q3);
	rs4 = st4.executeQuery(q3);
	Hashtable ht3 = new Hashtable();
	if(rs4.next())
	{
		String	 q4 = "select distinct C.work_id,sanction_amount from rws_habitation_directory_tbl a,rws_complete_hab_view b,rws_admn_hab_lnk_tbl c,RWS_WORK_ADMN_TBL D where a.hab_code=b.panch_code and a.hab_code=c.hab_code(+) AND C.WORK_ID=D.WORK_ID and a."+per+"= '"+type+"' and D.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and date_of_completion<='31/MAR/2010') and category_code='2' and dcode='"+rs4.getString(1)+"' and mcode='"+rs4.getString(2)+"'";
		rs5 = st5.executeQuery(q4);
		int works = 0;double amt = 0.0;
		while(rs5.next())
		{
			works ++;
			amt += rs5.getDouble(2);
		}
	//	String val = ""+works+":"+""+amt;
		ht3.put(rs4.getString(1)+rs4.getString(2),works+":"+amt);
	}
	//System.out.println(ht3.get("0101"));
%>
<html>
<title> WaterSoft </title>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table width="880" align="center">
<tr>
<td align="right"><a href="/pred/home.do">Home</a></td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr>
		<td class="textborder" align="left">Select Criteria</td>
		<td><select name="per" style="width:150px" class="myCombo">
			<%if(per!=null && per.equals("HABITATION_SUB_TYPE")){%>
				<option value="HABITATION_SUB_TYPE" selected>Selected Sub Type</option>
			<%}
			else
			{
			%>
				<option value="HABITATION_SUB_TYPE">Selected Sub Type</option>
			<%
			}%>

			<%if(per!=null && per.equals("HAB_SUB_TYPE_40PC_CALC")){%>
				<option value="HAB_SUB_TYPE_40PC_CALC" selected>Calculated Sub Type</option>
			<%}
			else
			{
			%>
				<option value="HAB_SUB_TYPE_40PC_CALC">Calculated Sub Type</option>
			<%
			}%>			
		</select>
		</font></td>
	</tr>
	<tr>
		<td class="textborder" align="left">
		Select Type</td>
		<td><select name="type" style="width:150px" class="myCombo">
		
			<%if(type!=null && type.equals("PLAIN")){%>
				<option value="PLAIN" selected>PLAIN</option>
			<%}
			else
			{
			%>
				<option value="PLAIN">PLAIN</option>
			<%
			}%>

			<%if(type!=null && type.equals("SC")){%>
				<option value="SC" selected>SC</option>
			<%}
			else
			{
			%>
				<option value="SC">SC</option>
			<%
			}%>
			<%if(type!=null && type.equals("ST")){%>
				<option value="ST" selected>ST</option>
			<%}
			else
			{
			%>
				<option value="ST">ST</option>
			<%
			}%>
			</select>
		</font>
		</td>
	</tr>
	<tr>
	<td colspan="2" align=center>
	<input type="button" value="Get Report" onclick="this.form.submit()" class="btext">
	</td>
	</tr>
</table>
<%if(per!=null && !per.equals("")){
%><BR>
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">Mandal wise - Detailed Report </font></td>
	</tr>
<tr><td valign=top>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=38>District: All</td>		
	</tr>	
	<tr align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Dcode</td>
		<td class=btext>District</td>
		<td class=btext>Mcode</td>
		<td class=btext>Mandal</td>
		<td class=btext>Plain</td>
		<td class=btext>SC</td>
		<td class=btext>ST</td>
		<td class=btext>FC</td>
		<td class=btext>PC4</td>
		<td class=btext>PC3</td>
		<td class=btext>PC2</td>
		<td class=btext>PC1</td>
		<td class=btext>NC</td>				
		<td class=btext>NSS</td>		
		<td class=btext>Total</td>
		<td class=btext>Agency</td>
		<td class=btext>CPWS</td>
		<td class=btext>PWS</td>
		<td class=btext>MPWS</td>
		<td class=btext>DP</td>
		<td class=btext>HP</td>				
		<td class=btext>Open Wells</td>		
		<td class=btext>Ponds</td> 
		<td class=btext>Normal Works</td>
		<td class=btext>Est. Cost(Normal)</td>
	</tr>
	<%


	try
		{
	st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String qrys = "select distinct dcode,dname,mcode,mname from rws_habitation_directory_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and a."+per+"= '"+type+"' order by 1,3";
//System.out.println("sssssssssssssss:"+qrys);
rs3=st3.executeQuery(qrys);
while(rs3.next())
{
	String habs = ""+ht1.get(rs3.getString(1)+rs3.getString(3));
	if(habs!=null && !habs.equals("null")){}else{habs="0:0:0:0:0:0:0:0:0:0:0:0";}
	String[] habss = habs.split(":");
	String assets = ""+ht2.get(rs3.getString(1)+rs3.getString(3));
	if(assets!=null && !assets.equals("null")){}else{assets="0:0:0:0:0:0:0";}
	String[] assetss = assets.split(":");
	String works = ""+ht3.get(rs3.getString(1)+rs3.getString(3));
	if(works!=null && !works.equals("null")){}else{works="0:0";}
	String[] workss = works.split(":");
	total1 += Integer.parseInt(habss[0]);total2 += Integer.parseInt(habss[1]);total3 += Integer.parseInt(habss[2]);
	total4 += Integer.parseInt(habss[3]);total5 += Integer.parseInt(habss[4]);total6 += Integer.parseInt(habss[5]);
	total7 += Integer.parseInt(habss[6]);total8 += Integer.parseInt(habss[7]);total9 += Integer.parseInt(habss[8]);
	total10 += Integer.parseInt(assetss[0]);total11 += Integer.parseInt(assetss[1]);total12 += Integer.parseInt(assetss[2]);
	total13 += Integer.parseInt(assetss[3]);total14 += Integer.parseInt(assetss[4]);total15 += Integer.parseInt(assetss[5]);
	total16 += Integer.parseInt(assetss[6]);
	total17 += Integer.parseInt(workss[0]);total18 += Double.parseDouble(workss[1]);
	total19 += Integer.parseInt(habss[9]);
	total20 += Integer.parseInt(habss[10]);total21 += Integer.parseInt(habss[11]);
	%>
	<tr>
		<td class="rptValue" align="center"><%=sno++%></td>
		<td class="rptValue"><%=rs3.getString(1)%></td>
		<td class="rptValue"><%=rs3.getString(2)%></td>
		<td class="rptValue"><%=rs3.getString(3)%></td>
		<td class="rptValue"><%=rs3.getString(4)%></td>
		<td class="rptValue" align="right"><%=habss[9]%></td>
		<td class="rptValue" align="right"><%=habss[10]%></td>
		<td class="rptValue" align="right"><%=habss[11]%></td>
		<td class="rptValue" align="right"><%=habss[0]%></td>
		<td class="rptValue" align="right"><%=habss[1]%></td>
		<td class="rptValue" align="right"><%=habss[2]%></td>
		<td class="rptValue" align="right"><%=habss[3]%></td>
		<td class="rptValue" align="right"><%=habss[4]%></td>
		<td class="rptValue" align="right"><%=habss[5]%></td>
		<td class="rptValue" align="right"><%=habss[6]%></td>
		<td class="rptValue" align="right"><%=habss[7]%></td>
		<td class="rptValue" align="right"><%=habss[8]%></td>
		<td class="rptValue" align="right"><%=assetss[0]%></td>
		<td class="rptValue" align="right"><%=assetss[1]%></td>
		<td class="rptValue" align="right"><%=assetss[2]%></td>
		<td class="rptValue" align="right"><%=assetss[3]%></td>
		<td class="rptValue" align="right"><%=assetss[4]%></td>
		<td class="rptValue" align="right"><%=assetss[5]%></td>
		<td class="rptValue" align="right"><%=assetss[6]%></td>
		<td class="rptValue" align="right"><%=workss[0]%></td>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(workss[1]))%></td>
	</tr>
	<%
}
int fc=0,pc4=0,pc3=0,pc2=0,pc1=0,nc=0,nss=0;
%>
	<tr>
		<td class="btext" colspan="5" align="center">Total</td>
		<td class="btext" align="right"><%=total19%></td>
		<td class="btext" align="right"><%=total20%></td>
		<td class="btext" align="right"><%=total21%></td>
		<td class="btext" align="right"><%=total1%></td>
		<td class="btext" align="right"><%=total2%></td>
		<td class="btext" align="right"><%=total3%></td>
		<td class="btext" align="right"><%=total4%></td>
		<td class="btext" align="right"><%=total5%></td>
		<td class="btext" align="right"><%=total6%></td>
		<td class="btext" align="right"><%=total7%></td>
		<td class="btext" align="right"><%=total8%></td>
		<td class="btext" align="right"><%=total9%></td>
		<td class="btext" align="right"><%=total10%></td>
		<td class="btext" align="right"><%=total11%></td>
		<td class="btext" align="right"><%=total12%></td>
		<td class="btext" align="right"><%=total13%></td>
		<td class="btext" align="right"><%=total14%></td>
		<td class="btext" align="right"><%=total15%></td>
		<td class="btext" align="right"><%=total16%></td>
		<td class="btext" align="right"><%=total17%></td>
		<td class="btext" align="right"><%=ndf.format(total18)%></td>
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
<%}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>