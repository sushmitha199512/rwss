
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
         
         String programQuery=" and substr(w.work_id,1,2) in (01,02,18,23,32,48,49,51,58,62,04,57,65,70,63)  and substr(w.work_id,7,2) <>'11' and substr(w.work_id,7,2) <>'12' and    ";
System.out.println("Year:"+finYear);
//2012-2013
String fyears[]=finYear.split("-");

		if (name.equals("OnGoing") && type.equals("01")) {
			query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  "+programQuery+"   w.work_cancel_dt is null and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
		} else if (name.equals("OnGoing") && type.equals("03")) {
			query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"   w.work_cancel_dt is null and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
		} else if (name.equals("NotGrounded") && type.equals("01")) {
			query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and   substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+" w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
		} else if (name.equals("NotGrounded") && type.equals("03")) {
			query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and   substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+" w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name ,dv.division_office_code order by d.dname";
		}else if (name.equals("Completed") && type.equals("01")) {
			query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"') ) and w.work_cancel_dt is null AND PLAN_CODE='1' and substr(w.work_id,5,2)=d.dcode "+programQuery+" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2)='01' and d.dcode='"+dcode+"' group by d.dname,dv.division_office_name,dv.division_office_code  order by d.dname";
		}else if (name.equals("Completed") && type.equals("03")) {
			query = "SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"') ) and w.work_cancel_dt is null AND PLAN_CODE='1' and substr(w.work_id,5,2)=d.dcode "+programQuery+"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2)='03' and d.dcode='"+dcode+"'  group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";
		}else if (name.equals("Commissioned") && type.equals("01")) {
           query="SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"' )  and date_of_comm is not null ) and w.work_cancel_dt is null AND PLAN_CODE='1' AND substr(w.work_id,7,2)='01' "+programQuery+"   substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and d.dcode='"+dcode+"'  group by d.dname,dv.division_office_name,dv.division_office_code order by d.dname";

		}else if (name.equals("Commissioned") && type.equals("03")) {
			query="SELECT d.dname,dv.division_office_name,count(*),sum(nvl(w.SANCTION_AMOUNT,'0')),dv.division_office_code  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"' )  and date_of_comm is not null ) and w.work_cancel_dt is null AND PLAN_CODE='1' AND substr(w.work_id,7,2)='03' "+programQuery+"   substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and d.dcode='"+dcode+"'  group by d.dname,dv.division_office_name,dv.division_office_code  order by d.dname";
		}



	%>



<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="javascript:window.history.go(-1);">Back</a>
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
       
      System.out.println("qry***********"+query);
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
				<td class=<%=style %> style="text-align: left;"><a href="rws_dashboard_works_list.jsp?divCode=<%= rs1.getString(5) %>" ><%=rs1.getString(2)%> </a>  </td>    
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

