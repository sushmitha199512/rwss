<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 



<%
 





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
<table  bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO</b></td>
<td class=btext ><b>DISTRICT </b></td>
<td class=btext ><b>DIVISION</b></td>
<td class=btext><b>Work ID</b></td>
<td class=btext><b>Work Name</b></td>

<td class=btext><b>SCHOOL_NAME</b></td>
  <td class=btext><b>SCHOOL CODE</b></td>
  
  <td class=btext><b>SCHOOL LOCATION </b></td>
  <td class=btext><b>SCHOOL CATEGORY CODE</b></td>

</tr>
<tr>
<td align="center" class=btext>1</td><td align="center" class=btext>2</td>
<td align="center" class=btext>3</td><td align="center" class=btext>4</td>
<td align="center" class=btext >5</td><td align="center" class=btext>6</td>
<td align="center" class=btext >7</td><td align="center" class=btext >8</td>

</tr>
	<%try
      {
		int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
	
       String distname1="",distname2="";


String anganiVadiQuery="select s.dname,b.division_office_name,w.work_id,w.work_name,d.SCHOOL_NAME,d.SCHOOL_CODE,nvl(d.SCHOOL_LOCATION,'-'),d.SCHOOL_CATEGORY_CODE FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d,rws_district_tbl s where b.CIRCLE_OFFICE_CODE =s.DCODE and substr(w.work_id,7,2)='11' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE ='01' and c.school_code=d.school_code and substr(w.office_code,2,2)='"+dcode+"' and substr(w.office_code,4,1)='"+divCode+"' ";




System.out.println("anganiVadiQuery****"+anganiVadiQuery);
   rs1=stmt1.executeQuery(anganiVadiQuery);
   

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
                <td class=rptValue ><%=rs1.getString(6)%>   </td>
                <td class=rptValue ><%=rs1.getString(7)%>   </td>
                <td class=rptValue ><%=rs1.getString(8)%>   </td>
			  
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

