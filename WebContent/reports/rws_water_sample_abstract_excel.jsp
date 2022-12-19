<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html>

<body>

<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null;
ResultSet rs6=null;
ResultSet rs3=null;

//// System.out.println(" in rpt jsp");
String dcode=request.getParameter("district");
// System.out.println("1"+dcode);
String year=request.getParameter("year");
//// System.out.println("2"+year);
String month=request.getParameter("month");
//// System.out.println("3"+month);

String dname=request.getParameter("dName");
// // System.out.println("4:"+dname);
int sno=1;
int ftk=0;
int gtot=0;
int gtotftk=0;
String cir="";
int watersample=0;
int testresult=0;
int gwatersample=0;
int gftk=0;
int gtestresult=0;
int totwat=0;
int gtotwat=0;
int hpcount=0;

String month1=request.getParameter("month");
String year1=request.getParameter("year");
/*if(month1.equals("0") || month1.equals("51") )
month1="ALL";
else
month1=month;
if(year1.equals("0") || year1.equals("51") )
year1="ALL";
else
year1=year;*/


%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Water Quality Abstract  Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>Circle</td>
               <td class=btext>Division</td>
                <td class=btext>Total No. of Drinking Water Sources</td> 
			    <td class=btext>Total No. of Sources having FTK Test results</td>
			   <td class=btext>Total No. of Water Samples Forwarded to the Laboratory </td>
			   <td class=btext>Total No. of Water Samples having Laboratory Test Results</td>
		   
			   </tr>
<%
try
{
  String query = "";
	 if(dcode!=null && !dcode.equals("") && dcode.equals("51"))
		{
	  query="select  circle_office_code,circle_office_name from rws_circle_office_tbl order by circle_office_name";
	query = "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code order by 2";
	  }
	else if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
	{
	  query="select  circle_office_code,circle_office_name from rws_circle_office_tbl where circle_office_code='"+dcode+"' order by circle_office_name";
		query = "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code='"+dcode+"' and a.circle_office_code=b.circle_office_code order by 2";
	  }
  stmt6=conn.createStatement();
  
  stmt1=conn.createStatement();
  rs1=stmt1.executeQuery(query);
  while (rs1.next())
	{
		String qry="select (select count(*) from rws_water_sample_collect_tbl c,rws_complete_hab_view hd where hd.panch_code=c.hab_code  and c.test_id is not null   ";
		if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and  substr(hd.panch_code,1,2)='"+rs1.getString(1)+"' and c.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(samp_collect_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(samp_collect_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a1,";
		 qry+= "(select count(*) from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code  and c.test_id is not null and r.test_id=c.test_id ";
		 if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (hd.panch_code,1,2)='"+rs1.getString(1)+"' and c.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") && !month.equals("51"))
		{
			 qry+=" and to_char(r.PREPARED_ON,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(r.PREPARED_ON,'yyyy')='"+year+"' ";
		}
		qry+=" ) a2,";
		 qry+="(select count(*) from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16)    ";
		  if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (hd.panch_code,1,2)='"+rs1.getString(1)+"' and c.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(test_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a3, ";

//qry+="(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and substr (m.hab_code,1,2)='01' and substr(source_code,1,16)=r.panch_code"; 
qry+="(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE";
		  if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (m.hab_code,1,2)='"+rs1.getString(1)+"' and m.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(test_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a4, ";


qry+="(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";
		  if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (m.hab_code,1,2)='"+rs1.getString(1)+"' and m.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(test_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a5, ";


qry+="(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";
		  if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (m.hab_code,1,2)='"+rs1.getString(1)+"' and m.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(test_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a6, ";

   qry+="(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code"; 
		  if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (m.hab_code,1,2)='"+rs1.getString(1)+"' and m.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(test_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a7, ";

qry+="(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code"; 
		  if(dcode!=null && !dcode.equals("") &&  !dcode.equals("0"))
		{
		 qry+=" and substr (m.hab_code,1,2)='"+rs1.getString(1)+"' and m.division_office_code='"+rs1.getString(3)+"' ";
		}
		if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
			 qry+=" and to_char(test_date,'MON')='"+month+"' ";
		}
		if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		{
			qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+=" ) a8 ";



		 
		  
//
		




qry+= "from dual ";

		 // System.out.println(" qry:"+qry);  
		  stmt2=conn.createStatement();
		  rs2=stmt2.executeQuery(qry);
           watersample=0;
		  testresult=0;
		  ftk=0;
          hpcount=0;
		 while(rs2.next())
		{
			 watersample=rs2.getInt(1);
			 testresult=rs2.getInt(2);
			 ftk=rs2.getInt(3);
             totwat=rs2.getInt(4)+rs2.getInt(5)+rs2.getInt(6)+rs2.getInt(7)+rs2.getInt(8);
             
             
			 
		}
		gwatersample=watersample+gwatersample;
		gtestresult=testresult+gtestresult;
		gftk=ftk+gftk;
        gtotwat=totwat+gtotwat;

			
		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
                <td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=totwat%></td>
                
				<td class=rptValue><%=ftk%></td>
				<td class=rptValue><%=watersample%></td>
                <td class=rptValue><%=testresult%></td>
				
				
				</tr>
<%			
}
	%>
	<tr>
	<td class="btext" colspan="2">Total:</td>
    <td class="btext" ></td>
    <td class="btext"><%=gtotwat%></td>
    
	<td class="btext"><%=gftk%></td>
	
    <td class="btext"><%=gwatersample%></td>
	<td class="btext"><%=gtestresult%></td>
     
	</tr>
	<%
}
catch(Exception e)
{
	 System.out.println("Exception in  wqter quality entry status:"+e);
}


%>
</table>
</form>

</body>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</html>
