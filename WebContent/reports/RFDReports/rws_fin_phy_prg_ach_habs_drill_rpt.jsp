<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
String financialyr="";
String type=request.getParameter("type");

if(type!=null){
	session.setAttribute("type",type);
}
String dateField=null;


 
 
 
 
 
 
 

double aas=0;
       String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
}

if(session.getAttribute("financialyr")!=null){
financialyr=(String)session.getAttribute("financialyr");
}


	String yr =financialyr.substring(0,4);
  session.setAttribute("yr",yr);
	
  
  String prvyr=""+(Integer.parseInt(yr)-1);
	String nextyr=""+(Integer.parseInt(yr)+1);
  
	//System.out.println("nextyr:"+nextyr);
    String subnextyr=nextyr.substring(2,4);
    
   
   String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
//System.out.println("Yr"+yr);
   System.out.println("sysyear::"+sysyear);
 //  int prevyear=0,prevmon=0;String fyear,fyear1;

        
  // String type=request.getParameter("type");
   String dcode=request.getParameter("dcode");
   String divCode=request.getParameter("divCode");
   String programe=request.getParameter("prg");
   String scheme=(String)session.getAttribute("scheme");
   
   

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
<table  bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO</b></td>
<td class=btext ><b>DISTRICT </b></td>
<td class=btext ><b>DIVISION</b></td>
<td class=btext><b>Programm Name</b></td>
<td class=btext><b>Work ID</b></td>
<td class=btext ><b>Work Name</b></td>    
<td class=btext><b>Admin Date</b></td>
<td class=btext ><b>NO OF HABS</b></td>
<td class=btext ><b>HAB CODE</b></td>
</tr>
<tr>
<td align="center" class=btext>1</td><td align="center" class=btext>2</td>
<td align="center" class=btext>3</td><td align="center" class=btext>4</td>
<td align="center" class=btext >5</td><td align="center" class=btext>6</td>
<td align="center" class=btext>7</td><td align="center" class=btext>8</td><td align="center" class=btext>9</td>

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

         String ongoingWorks="";
         String DateOfCompl="";
		 String DateOfComm="";
	
 
String sanctionedHabs="select d.dname,b.division_office_name,p.programme_name,w.work_id,w.work_name,nvl(to_char(w.ADMIN_DATE),0),w.NO_OF_HABS,HAB_CODE  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_admn_hab_lnk_tbl c,rws_district_tbl d where b.CIRCLE_OFFICE_CODE =d.DCODE and to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"' and c.work_id=w.work_id and w.programme_code=p.programme_code   and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and substr(w.office_code,2,2)='"+dcode+"' and substr(w.office_code,4,1)='"+divCode+"' ";
if(scheme!=null && !scheme.equals("")){
         sanctionedHabs+="and w.type_of_asset in("+scheme+")";
}
sanctionedHabs+=" and w.programme_code in ("+programe+") and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  ";

System.out.println("sanctionedHabs****"+sanctionedHabs);
   rs1=stmt1.executeQuery(sanctionedHabs);
   

   while(rs1.next())
       {
	       
	         %>

             <tr>
        
                <td class=rptLabel>&nbsp;<%=count++%> </td>
                <td  class=rptLabel align="center"><%=rs1.getString(1)%> </td>         	  
	            <td class=btext ><%=rs1.getString(2)%></td> 
	              <td class=rptValue><%=rs1.getString(3)%></td>
	                <td class=rptValue align="right"><%=rs1.getString(4)%>   </td> 
                <td class=rptValue ><%=rs1.getString(5)%>   </td>
			  <td class=rptValue><%=rs1.getString(6)%>   </td>
			   <td class=rptValue><%=rs1.getString(7)%>   </td>
			    <td class=rptValue><%=rs1.getString(8)%>   </td>
			  
				    				</tr>
<%       }
  





String sanctionedHabs1="select d.dname,b.division_office_name,p.programme_name,w.work_id,w.work_name,nvl(to_char(w.ADMIN_DATE),0),w.NO_OF_HABS,HAB_CODE  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_admn_hab_lnk_tbl c,rws_district_tbl d where b.CIRCLE_OFFICE_CODE =d.DCODE and to_date(w.ADMIN_DATE) >='01-Apr-"+yr+"' and c.work_id=w.work_id and w.programme_code=p.programme_code   and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and substr(w.office_code,2,2)='"+dcode+"' and substr(w.office_code,4,1)='"+divCode+"' ";
if(scheme!=null && !scheme.equals("")){
         sanctionedHabs1+="and w.type_of_asset in("+scheme+")";
}
sanctionedHabs1+=" and w.programme_code in ("+programe+")   ";

System.out.println("sanctionedHabs1****"+sanctionedHabs1);
 
   rs1=stmt1.executeQuery(sanctionedHabs1);
   

   while(rs1.next())
       {
	       
	         %>

             <tr>
        
                <td class=rptLabel>&nbsp;<%=count++%> </td>
                <td  class=rptLabel align="center"><%=rs1.getString(1)%> </td>         	  
	            <td class=btext ><%=rs1.getString(2)%></td> 
	            <td class=rptValue><%=rs1.getString(3)%></td>
	            <td class=rptValue align="right"><%=rs1.getString(4)%>   </td> 
                <td class=rptValue ><%=rs1.getString(5)%>   </td>
			    <td class=rptValue><%=rs1.getString(6)%>   </td>
			    <td class=rptValue><%=rs1.getString(7)%>   </td>
			    <td class=rptValue><%=rs1.getString(8)%>   </td>
			  
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

