<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<script language="JavaScript">
function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}
</script>
<%
String dcode=request.getParameter("dcode");
String check=request.getParameter("check");
//System.out.println("check:"+check);
 if(check.equals("nss"))
 {
%>
<body>
<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=9>Water Quality NSS Habitation Status</td>	
		</tr>
<tr>
<td class=btext>SNO</td>
<td class=btext>District</td>
<td class=btext>Mandal</td>
<td class=btext>Panchayat</td>
<td class=btext>Village</td>
<td class=btext>HabCode</td>
<td class=btext>Habitation</td>
<td class=btext>Total Sources</td>
<td class=btext>Tested Sources</td>
</tr>


<%
java.util.ArrayList list=new ArrayList();
try{
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
int sno=1,tot1=0,tot2=0;;
String qry="",qry1="",qry2="";

qry="select distinct v.* from rws_habitation_directory_tbl h,rws_wq_test_results_tbl w,rws_complete_hab_view v where h.hab_code=substr (source_code,1,16) and v.COVERAGE_STATUS='NSS' and v.panch_code=h.hab_code and v.panch_code=substr (source_code,1,16) ";
 if(dcode!=null && !dcode.equals("") &&  !dcode.equals("00"))
	{
    	qry+= " and substr(v.panch_code,1,2)='"+dcode+"' ";
	}
qry+=" order by dname ";
stmt=conn.createStatement();
//System.out.println("qry"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{
 	list.add(rs.getString(1));
	list.add(rs.getString(2));
	list.add(rs.getString(3));
	list.add(rs.getString(4));
	list.add(rs.getString(5));
	list.add(rs.getString(6));
	list.add(rs.getString(7));
	list.add(rs.getString(8));
	list.add(rs.getString(9));
	list.add(rs.getString(10));
}
 if(rs!=null) rs.close();
 if(stmt!=null) stmt.close();
//System.out.println(" list size:" +list.size());
if(list.size()==0)
{%>
	<tr>
	 <td class=rptValue align="center"  colspan="9">No Records Matching With This Selection Criteria </td>
<%}
 int j=8,k=0;
 for(int i=0;j<list.size();i++)
	{%>
	 <tr>
	 <td class=rptValue><%=sno++%></td>
	 <td class=rptValue><%=list.get(k+1)%></td>
	 <td class=rptValue><%=list.get(k+3)%></td>
	 <td class=rptValue><%=list.get(k+5)%></td>
	 <td class=rptValue><%=list.get(k+7)%></td>
	 <td class=rptValue><%=list.get(k+8)%></td>
	 <td class=rptValue><%=list.get(k+9)%></td>
  <% //System.out.println("j:"+list.get(j));
	qry1="select distinct count(*) from rws_wq_test_results_tbl a where substr (source_code,1,16)='"+list.get(j)+"' ";
	stmt1=conn.createStatement();
	//System.out.println("qry1:"+qry1);
	rs1=stmt1.executeQuery(qry1);
	if(rs1.next())
	{%>
	   <td class=rptValue align="right"><%=rs1.getString(1)%></td>
	 <%}
	 if(rs1!=null) rs1.close();
	if(stmt1!=null) stmt1.close();
	qry2="select distinct source_code  from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and substr (source_code,1,16)='"+list.get(j)+"' ";
	stmt2=conn.createStatement();
	//System.out.println("qry2:"+qry2);
	rs2=stmt2.executeQuery(qry2);
	int count=0;
	while(rs2.next())
	{
	 count++;
	}
	 if(rs2!=null) rs2.close();
	 if(stmt2!=null) stmt2.close();
      String  val="District: "+list.get(k+1)+"  Mandal: "+list.get(k+3) +":   Panchayat: "+list.get(k+5) +":  Village :"+list.get(k+7) +":  Habitation:" +list.get(k+9) ;
	%>
	<td class=rptValue align="right">
	<a href="#"onclick="wopen('./rws_water_nss_habs_rpt1.jsp?habcode=<%=list.get(k+8)%>&value=<%=val%>','popup', 640, 480)" ><%=count%></a></td>
	</tr>
	<%
	 k=k+10;
	 j=j+10;
	}

}catch(Exception e) {
    System.out.println("Exception in NSS Habitation:" +e);	
}finally{
	 if(conn!=null) conn.close();
}
%>
</table>
</body>

<% }else {

	 //System.out.println("In else part of ");
	 java.util.ArrayList list=new ArrayList();
	 Statement stmt1=null,stmt2=null;
	 ResultSet rs1=null,rs2=null;

%>
<body>
<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
		  <%if(check.equals("flouride")) {%>
			<td align="center" class="rptHeading" colspan=9>Flouride Contamination Habitations </td>
			<%}else if(check.equals("tds")) {%>
			<td align="center" class="rptHeading" colspan=9>TDS Contamination Habitations </td>
			<%}%>
		</tr>
<tr>
<td class=btext>SNO</td>
<td class=btext>District</td>
<td class=btext>Mandal</td>
<td class=btext>Panchayat</td>
<td class=btext>Village</td>
<td class=btext>HabCode</td>
<td class=btext>Habitation</td>
<%if(check.equals("flouride")) {%>
	<td class=btext>Flouride Value</td>
	<%}else if(check.equals("tds")) {%>
	<td class=btext>TDS Value</td>
	<%}%>

</tr>
<% try{
int sno=1;


String qry="select distinct v.*,test_id from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_habitation_directory_tbl h where h.hab_code=substr (source_code,1,16) and v.panch_code=h.hab_code and v.panch_code=substr (source_code,1,16) ";
if(dcode!=null && !dcode.equals("") &&  !dcode.equals("00"))
	{
    	qry+= " and substr(v.panch_code,1,2)='"+dcode+"' ";
	}
 qry+=" order by dname ";
stmt=conn.createStatement();
//System.out.println("qry:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{
	
	list.add(rs.getString(1));
	list.add(rs.getString(2));
	list.add(rs.getString(3));
	list.add(rs.getString(4));
	list.add(rs.getString(5));
	list.add(rs.getString(6));
	list.add(rs.getString(7));
	list.add(rs.getString(8));
	list.add(rs.getString(9));
	list.add(rs.getString(10));
	list.add(rs.getString(11));
	
}
if(rs!=null) rs.close();
if(stmt!=null) stmt.close();

int j=10,k=0;
 for(int i=0;j<list.size();i++) 
{
  	
	String qry1="select testing_parameter_value  from rws_wq_test_results_lnk_tbl where ";
	if(check.equals("flouride"))
	{
		qry1+=" testing_parameter_code='13' and testing_parameter_value>1.5 and test_id='"+list.get(j)+"'  ";
	}
	else if(check.equals("tds"))
	{
		 qry1+=" testing_parameter_code='05' and testing_parameter_value>2000 and test_id='"+list.get(j)+"'  ";
	}
	
	stmt1=conn.createStatement();
	System.out.println("qry:" +qry1);
	rs1=stmt1.executeQuery(qry1);
	if(rs1.next())
	{%>
		<tr>
			 <td class=rptValue><%=sno++%></td>
			 <td class=rptValue><%=list.get(k+1)%></td>
			 <td class=rptValue><%=list.get(k+3)%></td>
			 <td class=rptValue><%=list.get(k+5)%></td>
			 <td class=rptValue><%=list.get(k+7)%></td>
			 <td class=rptValue><%=list.get(k+8)%></td>
			 <td class=rptValue><%=list.get(k+9)%></td>
			 <td class=rptValue><%=rs1.getString(1)%></td>
		 </tr>
	 <%}
		 if(rs1!=null) rs1.close();
		 if(stmt1!=null) stmt1.close();
		 k=k+11;
		 j=j+11;
		 
		
	}
}catch(Exception e)
  {
	System.out.println(" Exception in  Flouride and TDS habitations."+e);
  }
 %>
</table>
</body>
<%}%>
</html>

