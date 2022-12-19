<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>




<%

		StringBuffer dcode =new StringBuffer(request.getParameter("dcode"));
        StringBuffer type =new StringBuffer(request.getParameter("type"));
        
        StringBuffer query = new StringBuffer();
		nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

		//22/08/2013
		//System.out.println("Server Date:"+w.getServerDate());

		StringBuffer cYear=new StringBuffer(); 
		cYear.append(w.getServerDate().substring(6,10));

	%>


<head>
  
</head>
	<html>
<body>
  
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                          <tr align=center>
<td class="gridhdbg" ><b>SNO   </b></td>
<td class="gridhdbg" ><b>District</b></td>
<td class="gridhdbg" ><b>Mandal</b></td>
<td class="gridhdbg" ><b>Panchayat</b></td>
<td class="gridhdbg" ><b>Village</b></td>
<td class="gridhdbg" ><b>Work Code </b></td>
<td class="gridhdbg" ><b>Work Name </b></td>    
<td class="gridhdbg" ><b>Habitation Code</b></td>  
<td class="gridhdbg" ><b>Habitation Name </b></td>
<td class="gridhdbg" ><b>Coverage&nbsp;Status </b></td>  
  
</tr>

	<%try
      { 
		int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       stmt1=conn.createStatement();
       StringBuffer selectedPrograms=new StringBuffer();
       selectedPrograms.delete(0,selectedPrograms.length());
       selectedPrograms.append("'01','02','18','23','32','48','49','51','53','58','59','60','04','57','65','46','12'");
       query.delete(0,query.length());
       query.append("select d.dname,ch.MNAME,ch.PNAME,ch.VNAME,b.work_id,ad.work_name,ch.PANCH_CODE ,ch.PANCH_NAME,ch.COVERAGE_STATUS from rws_work_admn_tbl a,rws_work_comp_hab_lnk_tbl b,rws_district_tbl d ,rws_complete_hab_view ch,rws_work_admn_tbl ad  where d.dcode='"+dcode.toString()+"' and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(to_char(date_of_completion,'dd/mm/yy'),'dd/mm/yy')>='01-APR-"+cYear.toString()+"' )   and a.WORK_CANCEL_DT is null and ad.work_id=b.work_id and a.category_code='"+type+"' and a.type_of_asset in('01','02','03') and ch.panch_code=b.hab_code and  a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2) and substr(a.work_id,1,2) in ("+selectedPrograms.toString()+")");      
         rs1=stmt1.executeQuery(query.toString());
       while(rs1.next())
       {
       	%>			                                                
                <tr>
                <td style="text-align: left;" class="gridbg2">&nbsp;<%=count++%> </td>
				<td style="text-align: left;" class="gridbg2">&nbsp;<%=rs1.getString(1)%> </td>    
				<td style="text-align: left;" class="gridbg2"><%=rs1.getString(2)%>   </td>  
				<td style="text-align: left;" class="gridbg2"><%=rs1.getString(3)%>   </td>  
				<td style="text-align: left;" class="gridbg2" ><%=rs1.getString(4)%>  </td> 
				<td style="text-align: left;" class="gridbg2" ><%=rs1.getString(5)%>  </td>
				<td style="text-align: left;" class="gridbg2" ><%=rs1.getString(6)%>  </td>
				<td style="text-align: left;" class="gridbg2" ><%=rs1.getString(7)%>  </td>
				<td style="text-align: left;" class="gridbg2" ><%=rs1.getString(8)%>  </td>
				<td style="text-align: left;" class="gridbg2" ><%=rs1.getString(9)%>  </td>  
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
               
</body>
</html>
