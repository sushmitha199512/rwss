<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 



<%
 
String type = request.getParameter("type");
if (type != null) {
	session.setAttribute("type", type);
}
String subType = request.getParameter("subType");
if (subType != null) {
	session.setAttribute("subType", type);
}
String field = "", chargeField = "", subsubType = "", subsType = "";

if (type != null && type.equals("1")) {
	if (subType != null && subType.equals("1")) {
		field = "CATEGORY_CODE='2' ";

	}
	//  System.out.println("*****"+field);
	else if (subType != null && subType.equals("2")) {
		field = "CATEGORY_CODE='1' ";
	}
}
	// chargeField="Survey Stage";
	//dateField = "DPRSTATUS";



 /*else if (type != null && type.equals("2")) {
	//if (subType != null && subType.equals("1")) {
		field = "CATEGORY_CODE='1' ";

	}
*/

String dcode=request.getParameter("dcode");
String divCode=request.getParameter("divCode");

 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|<a href="#" onClick="window.close();">Close</a>
</td>

	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" colspan=10>*** Rupees in Lakhs</td>
</tr>
</table>
<table  bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO</b></td>
<td class=btext ><b>DISTRICT </b></td>
<td class=btext ><b>DIVISION</b></td>
<td class=btext><b>Work ID</b></td>
<td class=btext><b>Work Name</b></td>

  <td class=btext><b>CATEGORY CODE</b></td>
  <td class=btext><b>ADMIN DATE</b></td>
    <td class=btext><b>HAB CODE </b></td>
	<td class=btext><b>NO OF HABS</b></td>
	<td class=btext><b>WORK CANCEL DATE </b></td>
</tr>
<tr>
<td align="center" class=btext>1</td><td align="center" class=btext>2</td>
<td align="center" class=btext>3</td><td align="center" class=btext>4</td>
<td align="center" class=btext >5</td><td align="center" class=btext>6</td>
<td align="center" class=btext >7</td><td align="center" class=btext >8</td><td align="center" class=btext >9</td>

</tr>
	<%try
      {
		int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
	
       String distname1="",distname2="";


/*
String SVS="select s.dname,b.division_office_name,w.work_id,w.work_name,nvl(WORK_CATEGORY,'-'),nvl(to_char(ADMIN_DATE),'-') FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b , rws_district_tbl s where b.CIRCLE_OFFICE_CODE =s.DCODE and  "+field+" and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and substr(w.office_code,2,2)='"+dcode+"' and substr(w.office_code,4,1)='"+divCode+"' ";
*/

String SVSHABS="select s.dname,b.division_office_name,w.work_id,w.work_name,nvl(WORK_CATEGORY,'-'),nvl(to_char(ADMIN_DATE),'-'),HAB_CODE,NO_OF_HABS ,nvl(to_char(WORK_CANCEL_DT),'-')  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c , rws_district_tbl s where b.CIRCLE_OFFICE_CODE =s.DCODE and "+field+" and w.work_id=c.work_id  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and substr(w.office_code,2,2)='"+dcode+"' and substr(w.office_code,4,1)='"+divCode+"' ";



System.out.println("SVSHABS****"+SVSHABS);
   rs1=stmt1.executeQuery(SVSHABS);
   

   while(rs1.next())
       {
	       
	         %>

             <tr>
        
                <td class=rptLabel>&nbsp;<%=count++%> </td>
                <td  class=rptLabel align="center"><%=rs1.getString(1)%> </td>         	  
	            <td class=btext ><%=rs1.getString(2)%></td> 
	              <td class=rptValue><%=rs1.getString(3)%></td>
	                <td class=rptValue ><%=rs1.getString(4)%>   </td> 
                <td class=rptValue ><%=rs1.getString(5)%>   </td>
                <td class=rptValue ><%=rs1.getString(6)%>   </td>
				<td class=rptValue ><%=rs1.getString(7)%>   </td>
                <td class=rptValue ><%=rs1.getString(8)%>   </td>
				<td class=rptValue ><%=rs1.getString(9)%>   </td>

                
				    				</tr>
<%       }
  
}
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

