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

String dcode=request.getParameter("dcode");
System.out.println("dcode"+dcode);

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
               <td class=btext>Mandal</td>
               <td class=btext>Panchayat</td>
               <td class=btext>Village</td>
   			   <td class=btext>Hab Code</td>
			   <td class=btext>Hab Name</td>
		   
			   </tr>
<%
try
{
	int count=0;
	int ghabCount=0;
	String query="";
	stmt2=conn.createStatement();

	query="select distinct dname,mname,pname,VNAME,panch_code,PANCH_NAME  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c  where coverage_status<>'UI' and coverage_status is not null and substr(a.source_code,1,16)=panch_code  and a.PREPARED_ON >='1-Apr-2013' and c.dcode="+dcode+" and a.test_id=b.test_id group by dname,mname,pname,VNAME,panch_code,PANCH_NAME  ";
 
	 stmt1=conn.createStatement();
	 rs1=stmt1.executeQuery(query);
	 System.out.println("query"+query);
	 int gtesthabcount=0;

	 
	 
while(	 rs1.next()){
	 count++;
%>
<tr>
<td class=rptValue NOWRAP><%=count %></td>
<td class=btext ><%=rs1.getString(1)%></td>
<td class=btext ><%=rs1.getString(2)%></td>
<td class=btext ><%=rs1.getString(3)%></td>
<td class=btext><%=rs1.getString(4)%></td>
<td class=btext><%=rs1.getString(5)%></td>
<td class=btext ><%=rs1.getString(6)%></td>
 
</tr>
<%
				
	//ghabCount+=Integer.parseInt(rs1.getString(2));	 
//gtesthabcount+=Integer.parseInt(rs2.getString(1));

	
		} 
	 %>
	
	 
	 
<%	 
	 
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
