<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>


<%

		String dcode = request.getParameter("dcode");
		String type = request.getParameter("type");
		String scheme=(String)session.getAttribute("scheme");
		String programe=(String)session.getAttribute("programe");
		ResultSet rs1=null;
		Statement stmt1=null;
		String query = "";
		nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

		//22/08/2013
		System.out.println("Server Date:"+w.getServerDate());

		String cYear=w.getServerDate().substring(6,10);

%>
<%

if ( type.equals("01")) {
	query = "select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_district_tbl  d,rws_division_office_tbl div where  b.TYPE_OF_ASSET  in("+scheme+") and   work_cancel_dt is null  and substr(b.work_id,1,2) in ("+programe+") and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"' and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
} else if (type.equals("02")) {
	query = "select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_commencement_tbl a ,rws_district_tbl  d,rws_division_office_tbl div where (GROUNDING_DATE-admin_date)<90  and b.TYPE_OF_ASSET  in("+scheme+") and  substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"'  and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
} else if (type.equals("03")) {
	query = "select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_commencement_tbl a ,rws_district_tbl  d,rws_division_office_tbl div where ((GROUNDING_DATE-admin_date)>=90 and (GROUNDING_DATE-admin_date)<180) and b.TYPE_OF_ASSET  in("+scheme+") and  substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"' and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
} else if (type.equals("04")) {
	query = "select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_commencement_tbl a ,rws_district_tbl  d,rws_division_office_tbl div where ((GROUNDING_DATE-admin_date)>=180 and (GROUNDING_DATE-admin_date)<=365) and b.TYPE_OF_ASSET  in("+scheme+") and  substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"' and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}else if (type.equals("05")) {
	query = "select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_commencement_tbl a ,rws_district_tbl  d,rws_division_office_tbl div where ((GROUNDING_DATE-admin_date)>365) and b.TYPE_OF_ASSET  in("+scheme+") and  substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"' and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}else if (type.equals("06")) {
	query = "select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_completion_tbl  a ,rws_work_commencement_tbl c,rws_district_tbl  d,rws_division_office_tbl div where ((DATE_OF_COMPLETION-GROUNDING_DATE)<90) and  c.work_id=b.work_id and b.TYPE_OF_ASSET  in("+scheme+") and   substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"'  and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}else if (type.equals("07")) {
   query="select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_completion_tbl  a ,rws_work_commencement_tbl c,rws_district_tbl  d,rws_division_office_tbl div where ((DATE_OF_COMPLETION-GROUNDING_DATE)>=90 and (DATE_OF_COMPLETION-GROUNDING_DATE)<180) and  c.work_id=b.work_id and b.TYPE_OF_ASSET  in("+scheme+") and   substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"'  and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}else if (type.equals("08")) {
	query="select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_completion_tbl  a ,rws_work_commencement_tbl c,rws_district_tbl  d,rws_division_office_tbl div where ((DATE_OF_COMPLETION-GROUNDING_DATE)>=180 and (DATE_OF_COMPLETION-GROUNDING_DATE)<=365) and  c.work_id=b.work_id and b.TYPE_OF_ASSET  in("+scheme+") and   substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"'  and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}
else if (type.equals("09")) {
	query="select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_work_completion_tbl  a ,rws_work_commencement_tbl c,rws_district_tbl  d,rws_division_office_tbl div where ((DATE_OF_COMPLETION-GROUNDING_DATE)>365) and  c.work_id=b.work_id and b.TYPE_OF_ASSET  in("+scheme+") and   substr(a.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"' and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}
else if (type.equals("10")) {
	query="select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_district_tbl  d,rws_division_office_tbl div where b.TYPE_OF_ASSET  in("+scheme+") and   substr(b.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and b.work_id not in(select work_id from rws_work_commencement_tbl)  and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"'  and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}
else if (type.equals("11")) {
	query="select  d.dcode,d.dname,div.DIVISION_OFFICE_NAME,b.work_id,b.work_name,nvl(b.LEAD_HABITATION,'-'),to_char(b.ADMIN_DATE,'dd/mm/yy'),b.SANCTION_AMOUNT  from rws_work_admn_tbl b,rws_district_tbl  d,rws_division_office_tbl div where  b.TYPE_OF_ASSET  in("+scheme+") and   substr(b.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and b.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  and d.dcode=substr(b.work_id,5,2) and d.dcode='"+dcode+"'  and div.CIRCLE_OFFICE_CODE=substr(b.office_code,2,2) and div.DIVISION_OFFICE_CODE=substr(b.office_code,4,1)";
}




  
       
 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
              <td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a></td>
</td>
	</tr>  
		</table>
</caption>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=gridhdbg  ><b>SLNO   </b></td>
<td class=gridhdbg  ><b>District  </b></td>
<td class=gridhdbg  ><b>Division  </b></td>

<td class=gridhdbg  ><b>Work Id </b></td>    
<td class=gridhdbg  ><b>Work Name   </b></td>  
<td class=gridhdbg  ><b>Lead Habitation </b></td>  
<td class=gridhdbg  ><b>Admn_date</b></td>  
<td class=gridhdbg  ><b>Sanction Amount
</b></td>  
  
</tr>

<% 
try{
stmt1= conn.createStatement();
System.out.println("works......"+query);
 rs1 = stmt1.executeQuery(query);
 int styleCount=0;
 String style="";
 int rowCount=1;
 
 
	 while(rs1.next()){
		 
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
%>
 <tr>
      <td class=<%=style %>  style="text-align: center"><%=rowCount++ %></td>
	  <td class=<%=style %>  style="text-align: left"><%=rs1.getString(2) %></td>
	  <td class=<%=style %>  style="text-align: left"><%=rs1.getString(3) %></td>
	 
	  <td class=<%=style %>  style="text-align: left"><%=rs1.getString(4) %></td>
	  <td class=<%=style %>  style="text-align: left"><%=rs1.getString(5) %></td>
	  <td class=<%=style %>  style="text-align: left"><%=rs1.getString(6) %></td>
      <td class=<%=style %>  style="text-align: left"><%=rs1.getString(7) %></td>
      <td class=<%=style %>  style="text-align: left"><%=rs1.getString(8) %></td>

	
	

	<%
	
	 }
	 
	 }catch(Exception e){ 
		e.printStackTrace();
	 }
		%>
	