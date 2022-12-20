
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.util.*"%>
<%
Statement stmt1=null;
ResultSet rs1=null;
String broid=request.getParameter("bro_id");
stmt=conn.createStatement();
stmt1=conn.createStatement();
%>
<script>
function show(val)
	{
		
		//alert(document.getElementById(val).value);
    	document.getElementById(val).style.display='block';
    }
</script>
<table width="100%"  align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%"  border=1 style="border-collapse:collapse" align="center" >
<tr><td  class=btext  align="center" colspan=5> Loc Details of Bro Id:&nbsp;<%=broid%></td></tr>


<%
//ArrayList loclist=new ArrayList();
int count=0;
String qry="select loc_id,loc_ref,to_char(loc_date,'dd/mm/yyyy'),loc_amount from rws_loc_master_tbl where bro_id='"+broid+"' ";
//System.out.println("qry:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{ 
	int count1=0;
//loclist.add(rs.getString(1));	
%>
<tr>
<td class="rptsubvalue" colspan="10"><font color=black face=verdana size=1><%=++count%>.&nbsp;</font>
 Loc Id:<font color=black face=verdana size=1><%=rs.getString(1)%>&nbsp;&nbsp;</font>
 Loc Reference:<font color=black face=verdana size=1><%=rs.getString(2)%>&nbsp;&nbsp;</font>
 Loc Date:<font color=black face=verdana size=1><%=rs.getString(3)%>&nbsp;&nbsp;</font>
 Loc Amount :<font color=black face=verdana size=1><%=rs.getString(4)%>&nbsp;&nbsp;</font>
</tr>


<!--<div id="locdet<%=count%>" style="display:none;"> -->
 <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align="center" >

 <tr>
 <td class=btext>Sl.No</td>
 <td class=btext>District</td>
 <td class=btext>Program</td>
 <td class=btext>Subprogram</td>
 <td class=btext>Loc Amount</td>
 <td class=btext>Head Of Account</td>
 <td class=btext>Loc Date</td>
 </tr>
<% //for(int i=0;i<loclist.size();i++) {
String qry2="SELECT D.DNAME,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT , LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE,loc_det.loc_id FROM rws_loc_details_tbl LOC_DET,RWS_PROGRAMME_TBL P, RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA  WHERE LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)   AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE  AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) AND LOC_DET.DISTRICT_CODE=D.DCODE(+) AND LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+) and LOC_DET.LOC_ID='"+rs.getString(1)+"' and loc_det.bro_id='"+broid+"' ";
//System.out.println(qry2);
rs1=stmt1.executeQuery(qry2);
while(rs1.next())
{

//System.out.println("count:"+count);
%>


 <tr>
  
  <td class=rptvalue><%=++count1%></td>
 <td class=rptvalue><%=rs1.getString(1)%></td>
 <td class=rptvalue><%=rs1.getString(2)%></td>
 <td class=rptvalue><%=rs1.getString(3)%></td>
 <td class=rptvalue align="right"><%=rs1.getString(4)%></td>
 <td class=rptvalue><%=rs1.getString(5)%></td>
 <td class=rptvalue><%=rs1.getString(6)%></td>
  </tr>
 <%}}//}%>
</td>
</tr>
</table>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
</table>