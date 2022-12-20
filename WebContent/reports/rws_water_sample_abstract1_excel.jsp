<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>

<html>
<body>
<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;

String dist=request.getParameter("district");
// System.out.println("4:"+dist);
String distname=request.getParameter("distname");
String month=request.getParameter("month");
String year=request.getParameter("year");
//// System.out.println("month:"+month);
//// System.out.println("year:"+year);
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

%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=5><font color="navy">District:<%=distname%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="5"> Water Quality Abstract  Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>Mandal</td>
			    <td class=btext>Total FTK Tested Sources</td>
			   <td class=btext>Total Lab Tested Sources</td>
			   <td class=btext>Total Lab Tested Sources<BR> Having Test Results</td>
		   
			   </tr>
<%
try
{
  // System.out.println("f gdsgfhdg jh");
  String query="select  mcode,mname from rws_mandal_tbl  where dcode='"+dist+"'order by mname ";
  stmt1=conn.createStatement();
// System.out.println("qry"+query);
  rs1=stmt1.executeQuery(query);
  while (rs1.next())
	{
	String qry="select (select count(*) from rws_water_sample_collect_tbl c,rws_habitation_directory_tbl hd where hd.hab_code=c.hab_code and hd.coverage_status is not null  and hd.coverage_status <> 'UI' and c.test_id is not null   and  substr(hd.hab_code,1,2)='"+dist+"' and  substr(hd.hab_code,6,2)='"+rs1.getString(1)+"' ";
	 if(month!=null && !month.equals("") && !month.equals("0") && !month.equals("51"))
		{
	  qry+="and to_char(samp_collect_date,'MON')='"+month+"'  ";
		}
		if(year!=null &&  !year.equals("") &&  !year.equals("0") && !year.equals("51") )
		{
		qry+=" and to_char(samp_collect_date,'yyyy')='"+year+"' ";
		}
		qry+=") a1, ";
		qry+="(select count(*) from rws_water_sample_collect_tbl c,rws_habitation_directory_tbl hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.hab_code=c.hab_code and hd.coverage_status is not null  and hd.coverage_status <> 'UI' and c.test_id is not null and r.test_id=c.test_id  and  substr(hd.hab_code,1,2)='"+dist+"' and  substr(hd.hab_code,6,2)='"+rs1.getString(1)+"'  ";
		if(month!=null && !month.equals("") && !month.equals("0")  && !month.equals("51"))
		{
		 qry+=" and to_char(r.PREPARED_ON,'MON')='"+month+"' " ;
		}
		if(year!=null &&  !year.equals("") &&  !year.equals("0") && !year.equals("51"))
		{
		 qry+="	and to_char(r.PREPARED_ON,'yyyy')='"+year+"' ";
		}
		qry+=" ) a2, ";
		qry+="(select count(*) from rws_ftk_testing_tbl c,rws_habitation_directory_tbl hd where hd.hab_code=substr (c.source_code,1,16) and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and  substr(hd.hab_code,1,2)='"+dist+"' and  substr(hd.hab_code,6,2)='"+rs1.getString(1)+"' ";
		if(month!=null && !month.equals("") && !month.equals("0")  && !month.equals("51"))
		{
		qry+=" and to_char(test_date,'MON')='"+month+"' " ;
		}
		if(year!=null &&  !year.equals("") &&  !year.equals("0") && !year.equals("51"))
		{
		qry+=" and to_char(test_date,'yyyy')='"+year+"' ";
		}
		qry+="	) a3 ";
		
		qry+="from dual ";

		// System.out.println(" qry:"+qry);  
		 stmt2=conn.createStatement();
		  rs2=stmt2.executeQuery(qry);
           watersample=0;
		  testresult=0;
		  ftk=0;
		 while(rs2.next())
		{
			 watersample=rs2.getInt(1);
			 testresult=rs2.getInt(2);
			 ftk=rs2.getInt(3);
			 
		}
		gwatersample=watersample+gwatersample;
		gtestresult=testresult+gtestresult;
		gftk=ftk+gftk;
			
		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
               	<td class=rptValue><%=ftk%></td>
				<td class=rptValue><%=watersample%></td>
                <td class=rptValue><%=testresult%></td>
				
				
				</tr>
<%			
}
	%>
	<tr>
	<td class="btext" colspan="2">Total:</td>
	<td class="btext"><%=gftk%></td>
	
    <td class="btext"><%=gwatersample%></td>
	<td class="btext"><%=gtestresult%></td>
	</tr>
	<%
	} 
catch(Exception e)
{
	// System.out.println("Exception in  wqter quality entry status 1:"+e);
}
finally
{


}


%>
</table>
</form>

</body>
</p>
</html>


