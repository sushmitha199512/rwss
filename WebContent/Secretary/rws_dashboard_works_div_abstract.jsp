
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%
		DecimalFormat ndf = new DecimalFormat("####.##");
		String name = (String)session.getAttribute("name");
		String type =(String)session.getAttribute("type");
		String query = "";
         String finYear=(String)session.getAttribute("finYear");
         String dcode=(String)request.getParameter("dcode");
         String dname=(String)request.getParameter("dname");
         session.setAttribute("dcode",dcode);
         session.setAttribute("dname",dname);
         String progCodes=Constants.getNrdwp();
         String schemes = "'01','02','03','10'";
         String programQuery=" and substr(w.work_id,1,2) in ("+progCodes+")  and substr(w.work_id,7,2) <>'11' and substr(w.work_id,7,2) <>'12' and    ";
	String fyears[]=finYear.split("-");
	if (name.equals("OnGoing") && type.equals("01")) {
		//query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  "+programQuery+"   w.work_cancel_dt is null and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
		query="SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and d.dcode='"+dcode+"' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	} else if (name.equals("OnGoing") && type.equals("03")) {
		//query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"   w.work_cancel_dt is null and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
		query="SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and d.dcode='"+dcode+"' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	} else if (name.equals("NotGrounded") && type.equals("01")) {
		query = "SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode "+ programQuery +"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and   w.work_cancel_dt is null and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	} else if (name.equals("NotGrounded") && type.equals("03")) {
		query = "SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}else if (name.equals("Completed") && type.equals("01")) {
		query = "SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+fyears[0]+"' ) ) "+ programQuery +"  w.work_cancel_dt is null AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2) in ("+schemes+")  and h.work_id=w.work_id and hd.hab_code=h.hab_code and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}else if (name.equals("Completed") && type.equals("03")) {
		query = "SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+fyears[0]+"' ) ) "+ programQuery +"  w.work_cancel_dt is null AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2)='03' and h.work_id=w.work_id and hd.hab_code=h.hab_code and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}else if (name.equals("Commissioned") && type.equals("01")) {
       query="SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  "+ programQuery +" date_of_comm is not null ) and w.work_cancel_dt is null AND substr(w.work_id,7,2) in ("+schemes+")  and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}else if (name.equals("Commissioned") && type.equals("03")) {
		query="SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code   FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  "+ programQuery +"  date_of_comm is not null ) and w.work_cancel_dt is null AND substr(w.work_id,7,2)='03' and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}
	else if (name.equals("Grounded") && type.equals("01")) {
		query="SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname"; 
	}
	else if (name.equals("Grounded") && type.equals("03")) {
		query="SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}
	else if (name.equals("UnderProgress") && type.equals("01")) {
		query="SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}
	else if (name.equals("UnderProgress") && type.equals("03")) {
		query="SELECT  d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
	}
	%>
<script type="text/javascript">
function viewReport(URL){
	 TINY.box.show({url:URL,boxid:'frameless',width:1000,height:600,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){embedVisible();closeJS()}});
}
</script>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			<%
			if (name.equals("OnGoing") && type.equals("01")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=OnGoing&type=01')" >Back</a>
	        <%
			}else if (name.equals("OnGoing") && type.equals("03")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=OnGoing&type=03')" >Back</a>
	        <%
			}else if (name.equals("NotGrounded") && type.equals("01")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=NotGrounded&type=01')" >Back</a>
	        <%
			}else if (name.equals("NotGrounded") && type.equals("03")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=NotGrounded&type=03')" >Back</a>
	        <%
			}else if (name.equals("Completed") && type.equals("01")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Completed&type=01')" >Back</a>
	        <%
			}else if (name.equals("Completed") && type.equals("03")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Completed&type=03')" >Back</a>
	        <%
			}else if (name.equals("Commissioned") && type.equals("01")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Commissioned&type=01')" >Back</a>
	        <%
			}else if (name.equals("Commissioned") && type.equals("03")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Commissioned&type=03')" >Back</a>
	        <%
			}else if (name.equals("Grounded") && type.equals("01")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Grounded&type=01')" >Back</a>
	        <%
			}else if (name.equals("Grounded") && type.equals("03")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Grounded&type=03')" >Back</a>
	        <%
			}else if (name.equals("UnderProgress") && type.equals("01")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=UnderProgress&type=01')" >Back</a>
	        <%
			}else if (name.equals("UnderProgress") && type.equals("03")) {
			%>
	            <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=UnderProgress&type=03')" >Back</a>
	        <%
			}
			%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
	</tr>  
		</table>
	</caption>
<tr >
		<td align="center" class="gridhdbg" ><%=dname %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=name %>Works </td><td align="right" class="gridhdbg" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>Division  </b></td>
<td class=gridhdbg ><b>No Of Works  </b></td>
<td class=gridhdbg ><b>Sanction Amount </b></td>    
  
</tr>

	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       
       rs1=stmt1.executeQuery(query);
       String style="";
       int styleCount=0;
       
       int workCount=0;
       double sanctionAmount=0;
       while(rs1.next())
       {
          distname1 = ""+rs1.getString(1);
	      
          if(styleCount%2==0)
			{
				 style="gridbg1";
			 }else
			 {
				 style="gridbg2";
			 }
			 styleCount++;
			 
			 workCount+=Integer.parseInt(rs1.getString(3));
			 sanctionAmount+=Double.parseDouble(rs1.getString(4));

		%>
			    
                
                     
                <tr>
                
                <td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class=<%=style %> style="text-align: left;"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_list.jsp?divCode=<%= rs1.getString(5) %>')" ><%=rs1.getString(2)%> </a>  </td>    
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(3)%>   </td>
				<td class=<%=style %> style="text-align: right;"><%=ndf.format(Double.parseDouble(rs1.getString(4)))%>   </td>  
				
				</tr>
		<% 
           distname2 = distname1;
       }
       
       %>
       
       <tr>
                
                <td class=gridhdbg colspan=2 >Total: </td>
				<td class=gridhdbg style="text-align: right;" ><%=workCount %>   </td>
				<td class=gridhdbg style="text-align: right;"><%=ndf.format(sanctionAmount) %>   </td>  
				
				</tr>
       <% 
       
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

