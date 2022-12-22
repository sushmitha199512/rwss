
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%



  String circleOfficeCode=request.getParameter("ccode");
   if(circleOfficeCode!=null){
 session.setAttribute("circleOfficeCode",circleOfficeCode);
  }
  
  String type=request.getParameter("type");
   if(type!=null){
		session.setAttribute("type",type);
}

 String catageory=request.getParameter("cat");
   if(catageory!=null){
		session.setAttribute("catageory",catageory);
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
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>DISTRICT   </b></td>

<td class=btext ><b>Division  </b></td>
<td class=btext ><b>Work ID   </b></td>
<td class=btext ><b>Work Name </b></td>    
<td class=btext ><b>Admin Sanction Date   </b></td>  
<td class=btext ><b>Sanction Amount   </b></td>
<td class=btext ><b>AugMentaion Work ID   </b></td>
<td class=btext ><b>Program  </b></td>
<td class=btext ><b>Remarks  </b></td>
 
  </tr>




	<%try
      { int count=1;
       Statement stmt1=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       stmt1=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();     
stmt5=conn.createStatement();        
stmt6=conn.createStatement();        
stmt7=conn.createStatement();        

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
System.out.println("Type"+type);
if(type.equals("2")){

 query="SELECT d.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),nvl(w.AUG_WORKID,'-'),p.programme_name,nvl(w.remarks,'-')  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_district_tbl  d,rws_programme_tbl p  where  substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,5,2)=d.dcode and  (w.ADMIN_DATE >= '01-Apr-2012' and w.ADMIN_DATE < '01-Apr-2013') and work_cancel_dt is null and  type_of_asset in(01,02,03) and w.category_code='"+catageory+"' and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  b.circle_office_code='"+circleOfficeCode +"' ";

if(catageory!=null && !catageory.equals("")){
          query+="and w.category_code='"+catageory+"'";
}
 //query+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')) ";

} else if(type.equals("2")){


	// query="select d.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),w.category_code,w.AUG_WORKID,p.programme_name,nvl(w.remarks,'-') FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b ,rws_district_tbl  d,rws_programme_tbl p  where  substr(w.work_id,5,2)=d.dcode and  substr(w.work_id,1,2)=p.programme_code and (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and   b.circle_office_code='"+circleOfficeCode +"'" ;
 
if(catageory!=null && !catageory.equals("")){
          query+="and w.category_code='"+catageory+"'";
}
 
}



       System.out.println("qry***********"+query);
       rs1=stmt1.executeQuery(query);
       while(rs1.next())
       {

        %>

                <tr>
	           
                <td class=rptLabel>&nbsp;<%=count++%> </td>
 <td  class=rptLabel align="center">&nbsp;<%=rs1.getString(1)%> </td>
         
				<td class=rptLabel>&nbsp;<%=rs1.getString(2)%> </td>    
					<td class=rptValue><%=rs1.getString(3)%>   </td>  
				<td class=rptValue><%=rs1.getString(4)%>   </td>  
				<td class=rptValue align="center"><%=rs1.getString(5)%>  </td>  

				<td class=rptValue align="right"><%=rs1.getString(6)%>  </td> 
                   <td class=rptValue align="right"><%=rs1.getString(7)%>  </td>
                  
                <td class=rptValue align="right"><%=rs1.getString(8)%>  </td>
                <td class=rptValue align="right"><%=rs1.getString(9)%>  </td>
		
			
				</tr>
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

