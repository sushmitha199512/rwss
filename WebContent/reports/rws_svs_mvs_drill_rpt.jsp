<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
 
  String circleOfficeCode=request.getParameter("ccode");
   if(circleOfficeCode!=null){
 session.setAttribute("circleOfficeCode",circleOfficeCode);
  }
  String divCode=request.getParameter("divCode");
if(divCode!=null){
  session.setAttribute("divCode",divCode);
 }
  String type=request.getParameter("type");
   if(type!=null){
		session.setAttribute("type",type);
}

    DecimalFormat ndf = new DecimalFormat("##.##");

 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="#" onClick="window.close();">Close</a>
</td>

	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>DISTRICT   </b></td>
<td class=btext ><b>Division  </b></td>
<td class=btext><b>Work ID   </b></td>
<td class=btext ><b>Work Name </b></td>    
<td class=btext ><b>Program  </b></td>
<td class=btext><b>Sanction Amount(in Lakhs)   </b></td>
<td class=btext ><b>Expenditure(in Rs.) </b></td>
<td class=btext><b>Admin Sanction Date   </b></td>  
<td class=btext ><b>Date Of Completion  </b></td>
<td class=btext><b>Date Of Updation  </b></td>
</tr>
<tr>
<td align="center" class=btext>1</td><td align="center" class=btext>2</td>
<td align="center" class=btext>3</td><td align="center" class=btext  >4</td>
<td align="center" class=btext >5</td><td align="center" class=btext>6</td>
<td align="center" class=btext>7</td><td align="center"  class=btext>8</td>
<td align="center" class=btext>9</td><td align="center" class=btext >10</td>
<td align="center" class=btext>11</td>
</tr>
	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
	
       String distname1="",distname2="";
       double explast=0;

         String query="";
         String DateOfCompl="";
		 String DateOfComm="";
		
    String expqry="SELECT work_id,sum(voucher_Amt) FROM rws_work_exp_voucher_tbl group by work_id" ;
	Statement stmt3=conn.createStatement();
   	ResultSet rs3=stmt3.executeQuery(expqry);
	Hashtable expAmt=new Hashtable();
	while(rs3.next())
	{
		expAmt.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();




    String datesqry="select work_id,nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(UPDATE_DATE,'dd/mm/yyyy'),'-')  from rws_work_completion_tbl";
	Statement stmt2=conn.createStatement();
   	ResultSet rs2=stmt2.executeQuery(datesqry);
	Hashtable datesList=new Hashtable();
	while(rs2.next())
	{
		datesList.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();


   query="SELECT distinct d.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,p.programme_name,nvl(SANCTION_AMOUNT,'0'),to_char(ADMIN_DATE,'dd/mm/yyyy')  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_district_tbl  d,rws_programme_tbl p  where  w.category_code='"+type+"'  and w.work_cancel_dt is null  and  w.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,5,2)=d.dcode  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  b.circle_office_code='"+circleOfficeCode +"' and b.division_office_code='"+divCode+"' ";
   System.out.println("qry***********"+query);
   rs1=stmt1.executeQuery(query);
   while(rs1.next())
       {
	       
	    String dList=""+datesList.get(rs1.getString(3));
        String datesArr[]=dList.split("@");
        
        %>

             <tr>
        
                <td class=rptLabel>&nbsp;<%=count++%> </td>
                <td  class=rptLabel align="center">&nbsp;<%=rs1.getString(1)%> </td>
         		<td class=rptLabel>&nbsp;<%=rs1.getString(2)%> </td>    
	            <td class=rptValue><%=rs1.getString(3)%>   </td>  
				<td class=rptValue><%=rs1.getString(4)%>   </td>  
				<td class=rptValue><%=rs1.getString(5)%>   </td>  
            	<td class=rptValue align="right"><%=rs1.getDouble(6)%></td> 
                <td class=rptValue align="right"><%=expAmt.get(rs1.getString(3))==null?"0":(explast=(Double.parseDouble((String)expAmt.get(rs1.getString(3)))/100000))%></td> 
                <td class=rptValue><%=rs1.getString(7)%>   </td>  
                <td class=rptValue align="center"><%=datesArr[0]%>  </td>       
                <td class=rptValue align="center"><%=datesArr[1]%>  </td> 
			
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

