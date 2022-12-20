<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>

<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}


</script>

<%
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
System.out.println("dcode**********" +dcode);


   nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;
	
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">		

	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
				<!--<td class="bwborder"><a href="/pred/rws_login_frm1.html">Home</a></td>-->
				<td class="bwborder"><a href="#" onclick="window.close()">Close | </a></td>
				<!-- <td class="bwborder"><a href="./rws_lab_onesource_tested_rpt_xls.jsp" target=_new>Excel</a></td></tr> -->


	
			<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Habs Tested Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
               <td class=btext>Total No. Of Habs</td> 
			   <td class=btext> No. Of Habs Tested</td>
			   <td class=btext> No. Of Habs Not Tested</td>
		   
			   </tr>
<%
try
{
	int count=0;
	int ghabCount=0;
	String query="";
	String query1="";
	String query2="";
	stmt2=conn.createStatement();
	// query="select dname,count(PANCH_CODE),dcode from  rws_complete_hab_view  group by dname ,dcode ";
	query="select dname,count(distinct PANCH_CODE),dcode from  rws_complete_hab_view where coverage_status<>'UI' and coverage_status is not null group by dname ,dcode order by dcode";
 
	stmt1=conn.createStatement();
	 rs1=stmt1.executeQuery(query);
	 System.out.println("query"+query);
	 int gtesthabcount=0;
	 int gnottesthabcount=0;
	 stmt3=conn.createStatement();		 
	 //query1="select count(distinct panch_code),substr(panch_code,1,2)  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c  where  substr(b.source_code,1,16)=panch_code  and a.PREPARED_ON >='1-Apr-2013'   and  a.test_id=b.test_id  group by substr(panch_code,1,2) order by substr(panch_code,1,2)";
	//sri query1="select count(distinct panch_code),substr(panch_code,1,2)  from rws_complete_hab_view c  where c.panch_code in (Select a.hab_code from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b where a.source_code=b.source_code and a.PREPARED_ON >='1-Apr-2013'   and  a.test_id=b.test_id ) group by substr(panch_code,1,2) order by substr(panch_code,1,2)";
	 query1="select count(distinct panch_code),substr(panch_code,1,2) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c  where coverage_status<>'UI' and coverage_status is not null and substr(a.source_code,1,16)=panch_code  and a.PREPARED_ON >='1-Apr-2013' and  a.test_id=b.test_id  group by substr(panch_code,1,2) order by substr(panch_code,1,2)";

	int testhabcount=0;
	 rs2=stmt2.executeQuery(query1);
	
	 
	query2="select count( panch_code),substr(panch_code,1,2) from rws_complete_hab_view  where  coverage_status<>'UI' and coverage_status is not null and  panch_code not in( select substr(source_code,1,16) from rws_water_sample_collect_tbl where  PREPARED_ON >='1-Apr-2013') group by substr(panch_code,1,2) order by substr(panch_code,1,2)";
	// int testhabcount=0;
	 rs3=stmt3.executeQuery(query2);
	
	 
	 
	 
	 for(int k=0;k<22;k++){
		 
	 rs1.next();
	 rs2.next();
	 rs3.next();
	
	//System.out.println("value:"+rs1.getString(1));
			 count++;
%>
<tr>
<td class=rptValue NOWRAP><%=count %></td>
<td class=btext ><%=rs1.getString(1)%></td>

<td class=rptValue align="right"><%=rs1.getString(2)%></td>

<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_lab_onesource_tested_drillrpt.jsp?dcode=<%=rs1.getString(3) %>&&dname=<%=rs1.getString(1) %>')"><%=rs2.getString(1)%></a></td>


 
 <td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_lab_onesource_nottested_drillrpt.jsp?dcode=<%=rs1.getString(3) %>')"><%=rs3.getString(1)%></a></td>
 
</tr>
<%
				
	ghabCount+=Integer.parseInt(rs1.getString(2));	 
    gtesthabcount+=Integer.parseInt(rs2.getString(1));
    gnottesthabcount+=Integer.parseInt(rs3.getString(1));
	
		} 
	 %>
	 <tr>
	 <td></td>
		<td class="btext" align="right">Total:</td>
	    <td class=btext align="right"><%=ghabCount %></td>
        <td class=btext align="right"><%=gtesthabcount %></td>
        <td class=btext align="right"><%=gnottesthabcount %></td>
</tr>
	 
	 
<%	 
	 
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
