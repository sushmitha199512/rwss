<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
String dcode=request.getParameter("dcode");
//System.out.println("nlkfklsjdfl****"+dcode);
  String circleOfficeCode=request.getParameter("ccode");
   if(circleOfficeCode!=null){
 session.setAttribute("circleOfficeCode",circleOfficeCode);
  }
   
   
   String partADate="";
 
   String type=request.getParameter("type");
   if(type!=null){
		session.setAttribute("type",type);
}
   String subType=request.getParameter("subType");
   if(subType!=null){
		session.setAttribute("subType",type);
}
String field="",dateField=null,chargeField="",subsubType="",subsType="",obdateField,parta="",partcle="";
   
   if(type!=null && type.equals("1")){
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   
	   }
	 //  System.out.println("*****"+field);
	 else if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	   
	  
	  // chargeField="Survey Stage";
	   dateField="DPRSTATUS";
	   
   }else if(type!=null && type.equals("2")){
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   
	   }
	 //  System.out.println("*****"+field);
	 else if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	   
	  
	  // chargeField="Survey Stage";
	   dateField="DPRSTATUS";
   }else if(type!=null && type.equals("3")){
	   chargeField="DPRSTATUS='Survey Stage'  and ";
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   	   }
	 //  System.out.println("*****"+field);
	  if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	
	   dateField="DPRSTATUS";
   } else if(type!=null && type.equals("4")){
	   chargeField="DPRSTATUS='Estimate Stage'  and ";
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   	   }
	 //  System.out.println("*****"+field);
	  if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	
	   dateField="DPRSTATUS";
   } else if(type!=null && type.equals("5")){
	   chargeField="DPRSTATUS='Completed/Approved'  and ";
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   	   }
	 //  System.out.println("*****"+field);
	  if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	
	   dateField="DPRSTATUS";
   } else if(type!=null && type.equals("6")){
	   parta="PARTACLEARNCEDATE is null and ";
	   partADate=",nvl(to_char(PARTACLEARNCEDATE,'dd/mm/yyyy'),'-') ";
	 //  chargeField="DPRSTATUS='Estimate Stage'  and ";
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   	   }
	 //  System.out.println("*****"+field);
	  if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	
	   dateField="DPRSTATUS";
   } else if(type!=null && type.equals("7")){
	   partcle="PARTACLEARNCEDATE  IS NOT NULL and";
	   partADate=",nvl(to_char(PARTACLEARNCEDATE,'dd/mm/yyyy'),'-') ";
	 //  chargeField="DPRSTATUS='Estimate Stage'  and ";
	   if(subType!=null && subType.equals("1")){
		   field="CATEGORY_CODE='2' ";
		   	   }
	 //  System.out.println("*****"+field);
	  if(subType!=null && subType.equals("2")){
			   field="CATEGORY_CODE='1' ";
		   }
	
	   dateField="DPRSTATUS";
   }
   
   
  session.setAttribute("dcode",dcode);
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
}

String sysdate=workData.getDate();
String sysyear=sysdate.substring(6,10);
int yy=Integer.parseInt(sysyear);


    DecimalFormat ndf = new DecimalFormat("##.##");

 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a>|<a href="#" onClick="window.close();">Close</a>
</td>

	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" colspan=8>*** Rupees in Lakhs</td>
</tr>
</table>
<table  bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO</b></td>
<td class=btext ><b>DISTRICT </b></td>
<td class=btext><b>Work ID</b></td>
<td class=btext ><b>Work Name</b></td>    

<td class=btext><b>Sanction Amount(in Lakhs)</b></td>
<td class=btext ><b>DPRSTATUS </b></td>
<td class=btext ><b>DPR COMPLETION DATE</b></td>
<td class=btext ><b>PART-A CLEARANCE DATE</b></td>
</tr>
<tr>
<td align="center" class=btext>1</td><td align="center" class=btext>2</td>
<td align="center" class=btext>3</td><td align="center" class=btext>4</td>
<td align="center" class=btext >5</td><td align="center" class=btext>6</td>
<td align="center" class=btext>7</td>
</tr>
	<%try
      {
		int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
	
       String distname1="",distname2="";
      // double explast=0;

         String query="";
         String DateOfCompl="";
		 String DateOfComm="";
	
    //System.out.println("dateField"+dateField);
  // query="select dname,a.WORK_ID,b.WORK_NAME  ,"+field+" ,b.SANCTION_AMOUNT,"+chargeField+","+dateField+" from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_district_tbl c where a.work_id=b.work_id and c.dcode=substr(b.office_code,2,2) ";
    query="select dname,a.WORK_ID,b.WORK_NAME ,b.SANCTION_AMOUNT,DPRSTATUS ,nvl(to_char(DPRCOMPDATE),'-')"+partADate+" from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_district_tbl c where "+parta+" "+partcle+" a.work_id=b.work_id and "+field+" and "+chargeField+"  c.dcode=substr(b.office_code,2,2) ";
  
  if(dateField!=null){
	  query+="and "+dateField+"  is not null ";
   }
  /*if(parta!=null)
  {
	  query+="and "+parta+" is not null ";
  }*/
  
   query+="and substr(b.office_code,2,2)='"+dcode+"' ";
   System.out.println("qry***********"+query);
   rs1=stmt1.executeQuery(query);
   while(rs1.next())
       {
	       
	         %>

             <tr>
        
                <td class=rptLabel>&nbsp;<%=count++%> </td>
                <td  class=rptLabel align="center">&nbsp;<%=rs1.getString(1)%> </td>         	  
	            <td class=rptValue ><%=rs1.getString(2)%>   </td> 
	              <td class=rptValue><%=rs1.getString(3)%>   </td>
	                <td class=rptValue align="right"><%=rs1.getString(4)%>   </td> 
				  <td class=rptValue align="right"><%=rs1.getString(5)%>   </td>
				    <td class=rptValue align="right"><%=rs1.getString(6)%>   </td>
				    
				    <% if(!partADate.equals("")){ %>
				    <td class=rptValue align="right"><%=rs1.getString(7)%>   </td>
				    <% } else { %>
				    <td class=rptValue align="right"></td>
				    <%} %>
				    
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

