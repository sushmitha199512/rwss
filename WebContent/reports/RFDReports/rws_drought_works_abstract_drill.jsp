<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   
  String type=request.getParameter("type");

  String subType=request.getParameter("subType");


  String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
}


    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
   <td class="bwborder">
<a href="javascript:onclick=history.go(-1)">Back|</td></tr>
            <a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Amount In Rupees </td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>DISTRICT   </b></td>
<td class=btext ><b>Work Id   </b></td>
<td class=btext ><b>Work Name </b></td>
<td class=btext ><b>Admin Date </b></td>    
<td class=btext ><b>Cost   </b></td>  
<td class=btext ><b>Expenditure UpTo   </b></td>  
<td class=btext ><b>Date Of Copletion   </b></td>


  </tr>





	<%try
      { int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       stmt3=conn.createStatement();
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
System.out.println("Type"+type);
if(type.equals("1")){

 query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Deeping'  and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";

} else if(type.equals("2")){
query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Flushing'  and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
}else if(type.equals("3")){
query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Flushing and Deeping'  and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
}else if(type.equals("4")){
query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where   substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
}else if(type.equals("5")){

 query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Deeping'  and DATE_OF_COMPLETION is not null and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";

} else if(type.equals("6")){
query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Flushing'  and  DATE_OF_COMPLETION is not null and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
}else if(type.equals("7")){
query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Flushing and Deeping'  and DATE_OF_COMPLETION is not null and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
}else if(type.equals("8")){
query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where DATE_OF_COMPLETION is not null and   substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
}

//and DATE_OF_COMPLETION is not null 
System.out.println("query"+query);

rs3=stmt3.executeQuery(query);

while(rs3.next()){

%>
<tr><td class=rptValue><%=count++ %></td><td class=rptValue><%=rs3.getString(1) %></td><td class=rptValue><%=rs3.getString(2) %></td><td class=rptValue><%=rs3.getString(3) %></td><td class=rptValue><%=rs3.getString(4) %></td><td class=rptValue><%=rs3.getString(5) %></td><td class=rptValue><%=rs3.getString(6) %></td>
<td class=rptValue><%=rs3.getString(7) %></td>



</tr>
<% 



}
if(count==1){ %>
<tr><td colspan=8 class=btext align=center>No Works </td></tr>
<% 
}
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

