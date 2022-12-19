<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>



<style type="text/css">
<!--
/* begin some basic styling here */
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #338de8; FONT-SIZE: 9px;  TEXT-DECORATION: none
}
.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: black; FONT-SIZE: 9px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
body {
background: #FFF;
color: #000;
font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;
margin: 0px;
padding: 0
}
table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}
div#tbl-container22 {
width: 980px;
height: 430px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
padding: 4px 4px 4px 4px;
font-size: 11px;
height: 18px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;
padding: 4px 4px 4px 4px; 
font-size: 11px;.
height: 18px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: #8b4513Smoke;
}

div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;
background-color: #f5f5dc;
color: #8b4513;
position:relative;
cursor: default; 
}
div#tbl-container22 thead th {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 20;
}
div#tbl-container22 thead th.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 th.locked{
background-color: #ffeaff;
font-weight: bold;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;
width:120px;
}
-->
</style>


<%

    Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null;
String mcode="";
String dcode="";
String year="";
int flag=0;
dcode=(String)session.getAttribute("districtCode");
mcode=	(String)session.getAttribute("mandalCode");
year=(String)session.getAttribute("year");
System.out.println("year"+year);

	//System.out.println("the error in Complaint get2 is " + mcode);
//System.out.println("the error in Complaint get2 is " + dcode);


%>



<form>
<center>
<table width="100%"  bgcolor="white">
<tr><td align=right><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;

</tr>


<tr bgcolor="white" align="center">
		<td align="center" class="rptHeading" colspan="14"> <b><font color=black size=2>Status of available resources in Contigency Plan habitations</font></b> year:<font color='red'><%=year%></font></td>
</tr>
 
 </table>
<div id="tbl-container22">
<table  border = 2 align=center bordercolor=black style="border-collapse:collapse">
	
<thead class="fixedHeader">
<tr>

	
<th  align="center" rowspan="2" style="background-color: #f5f5dc" width=50 > <font color="#8b4513"><b>S.No.</b></font></th>
<th align="center" rowspan="2" style="background-color: #f5f5dc" width=120><font color="#8b4513" ><b>Mandal Name</font></b></th>
<th  align="center" rowspan="2" style="background-color: #f5f5dc"width=120><font color="#8b4513" ><b>Panchayat Name</font></b></th>
<th  align="center" rowspan="2" style="background-color: #f5f5dc" width=120><font color="#8b4513" ><b>Village  Name</font><b></th>
<th  align="center" rowspan="2" style="background-color: #f5f5dc" width=120><font color="#8b4513"><b>Hab Code</b></font></th>
<th  align="center"  rowspan="2" style="background-color: #f5f5dc" width=120><font color="#8b4513" ><b>Hab Name </font></b></th>
<th  align="center"  rowspan="2" style="background-color: #f5f5dc" width=120><font color="#8b4513" ><b>Coverage Status</b></font></th>
<th  align="center" colspan="4" style="background-color: #f5f5dc" width=400><b><font color="#8b4513" >On Going Works </font></b></th>
<th  align="center" colspan="5" style="background-color: #f5f5dc" width=400> <b><font color="#8b4513" >Asset </font></b></th>
		
</tr>

<tr>
<th  style="background-color: #f5f5dc" align="center" width=100><b><font color="#8b4513" >Type</font></b> </th>
<th  style="background-color: #f5f5dc" align="center" width=120><b><font color="#8b4513" > Name </b></th>
<th style="background-color: #f5f5dc" align="center" width=120><b><font color="#8b4513" >Sanction Amount(Rs. in Lakhs)</b></font></th>
<th style="background-color: #f5f5dc" align="center" width=120><b><font color="#8b4513">Probably Date Of Completion</font></b></th>

<th  align="center" style="background-color: #f5f5dc" width=120><b><font color="#8b4513">Type</font></b></th>
<th  align="center" style="background-color: #f5f5dc" width=120><b><font color="#8b4513">Name </font></b></th>
<th  align="center" style="background-color: #f5f5dc" width=120><b><font color="#8b4513">Cost Of Asset(Rs. in Lakhs)</font></b></th>
<th  align="center" style="background-color: #f5f5dc" width=120><font color="#8b4513"><b>Creation Date</b></font></th>
<th  align="center" style="background-color: #f5f5dc" width=120><font color="#8b4513"><b>Status</font></b></th>


</tr>
</thead>


<%
 try
{
boolean nohabflag=false;
   stmt=conn.createStatement();
   stmt2=conn.createStatement();;
stmt3=conn.createStatement();;
 nic.watersoft.commons.RWS_Drought rw=new nic.watersoft.commons.RWS_Drought();;
nic.watersoft.commons.HabDetails habdetails=null; 
nic.watersoft.commons.DroughtHabWorkDetails dw=null;

   String qry2="",qry4="";
 
 int sno=1;
String  qry="select  distinct habcode from rws_drought_habitation_tbl where substr(habcode,1,2)='"+dcode+ "' and year='"+year+"'" ;
String droughtStatus=null;
 rs=stmt.executeQuery(qry);
 System.out.println(" mandal  qry"+qry);
 while(rs.next())
 {
	 flag=0;
	
        habdetails=rw.getDetailsByHabCode(rs.getString(1));
		//System.out.println("Work size:"+habdetails.getHabworkdetails().size());
		
		%>
		
		<tr class="normalRow">
 
 <td ><font color="red"><b><%=sno++ %></b></font></td>
 <td class=rptvalue nowrap ><%= habdetails.getMname()%></td>
 <td class=rptvalue nowrap><%= habdetails.getPname()%></td>
 <td class=rptvalue nowrap  ><%= habdetails.getVname()%></td>
 <td class=rptvalue nowrap ><%= rs.getString(1)%></td>
 <td class=rptvalue nowrap ><%= habdetails.getHabName()%></td>
<td class=rptvalue nowrap  align=center><%= habdetails.getCoverageStatus()%></td>
 
		<%
		
  qry4="select distinct nvl(b.TYPE_OF_ASSET_NAME,'-'),nvl(A.ASSET_NAME,'-'),nvl(ASSET_COST,0),to_char(DATE_CREATION,'dd/mm/yyyy') DATE_CREATION ,ASSET_STATUS from rws_asset_mast_tbl A,RWS_ASSET_TYPE_TBL B where substr(a.asset_code,7,2)=b.TYPE_OF_ASSET_CODE   AND hab_code='"+rs.getString(1)+"'";

		  rs2=stmt2.executeQuery(qry4);
 	

int k=0;
boolean rsflag=true;
		  while((rsflag=rs2.next())  ||  k<habdetails.getHabworkdetails().size() )
			{
			//System.out.println("Asser t loop");
			 nohabflag=true;

                       if(  k<habdetails.getHabworkdetails().size())
				{
                      	 dw=(nic.watersoft.commons.DroughtHabWorkDetails )habdetails.getHabworkdetails().get(k);
					
				}
				else{
					dw=null;
				}
						 k++;

		   %>

  
 <%
    if(flag==1) {
  %>
<td align=center > </td><td align=center >""</td>
<td align=center > "" </td><td align=center> "" </td>
<td align=center > "" </td><td align=center> "" </td>
<td align=center> "" </td>
		
 <% } %>
		<%   if(dw!=null){%>
  <td class=rptvalue  ><%= dw.getType() %></td>
  <td class=rptvalue nowrap ><%= dw.getName() %></td>
 <td class=rptvalue nowrap  ><%= dw.getAmount() %></td>
 <td class=rptvalue nowrap   ><%= dw.getPdate() %></td>
 
<% } else { %>

  <td class=rptvalue align =center  >-</td>
 <td class=rptvalue nowrap align =center  >-</td>
 <td class=rptvalue nowrap align =center  >-</td>
 <td class=rptvalue nowrap align =center  >-</td>

<%
		 }
	%>
<% if(rsflag) {
	
	
	%>
 <td class=rptvalue nowrap  ><%= rs2.getString(1)%></td>
 <td class=rptvalue   nowrap><%= rs2.getString(2)%></td>
 <td class=rptvalue  nowrap  ><%= rs2.getString(3)%></td>
 <td class=rptvalue nowrap><%= rs2.getString(4)%></td>
 <td class=rptvalue nowrap><%= rw.getAssetStatus(rs2.getString(5))%></td></tr>

	 <% } else {
		 %>
 <td class=rptvalue nowrap align =center >-</td>
 <td class=rptvalue align =center >-</td>
 <td class=rptvalue  nowrap align =center  >-</td>
 <td class=rptvalue align =center  >-</td>
 <td class=rptvalue align =center >-</td></tr>

<%
	 }
	 flag=1;
		 }
		 
		 
		 if(!nohabflag)
		 {
	nohabflag=true;
		    %>
			<td class=rptvalue nowrap align =center >-</td>
 <td class=rptvalue align =center >-</td>
 <td class=rptvalue  nowrap align =center  >-</td>
 <td class=rptvalue align =center  >-</td>
 <td class=rptvalue align =center >-</td>
 <td class=rptvalue align =center >-</td>
 <td class=rptvalue  nowrap align =center  >-</td>
 <td class=rptvalue align =center  >-</td>
 <td class=rptvalue align =center >-</td></tr>

			<%
		 }
                      
 }

 if(sno==1)
	{
	 %>

	 <tr><td colspan=17 align=center ><font color=red size=3><b>No Records </b></font></td></tr>
	 <%
	}
}catch(Exception e)
	{
	 e.printStackTrace();
	}
	finally{
	}
%>

</center>
</form>
</table>
</div>
<%@ include file="/commons/rws_footer.jsp"%>

