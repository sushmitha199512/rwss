<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>

<body>
<p align=right>
<%

String circlecode=null,divisioncode=null,subdivisioncode=null, programcode=null,subprogramcode=null,circlename=null,divisionname=null,subdivisionname=null,
programname=null,str=null;


	   int slno=0;

       circlename=(String)session.getAttribute("circleName");
	   divisionname=(String)session.getAttribute("divName");
	   subdivisionname=(String)session.getAttribute("subdivName");
	   programname=(String)session.getAttribute("prName");
	   
	   circlecode=(String)session.getAttribute("circleCode");
		divisioncode=(String)session.getAttribute("divCode");
		subdivisioncode=(String)session.getAttribute("subdivCode");
		programcode=(String)session.getAttribute("prCode");
		
        
	  
		
	 %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_eoat_rpt_frm.jsp">Back</td> 
				</tr>
			</table>
		</caption>
<%@ include file="worklabel.jsp"%>
	
<%
       

	   try
		{
	   
	   
         if(circlecode!=null && circlecode.equals("00") && programcode!=null &&  programcode.equals("00"))
			{
	   //out.println("in circle all,program al and  subprog all or subprog nt sel ,year all,month,al");
	   
	   str="select DISTINCT c.circle_office_code, c.circle_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_CIRCLE_OFFICE_TBL c,rws_programme_tbl p,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=c.CIRCLE_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code  group by c.circle_office_code,c.circle_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";
        
		// int slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>      			
            <td class=rptValue><%=rs.getString(3)%></td>
			 <td class=rptValue><%=rs.getString(4)%></td>	
			  <td class=rptValue><%=rs.getString(5)%></td>	
			   <td class=rptValue><%=rs.getString(6)%></td>	
			    <td class=rptValue><%=rs.getString(7)%></td>	
				 <td class=rptValue><%=rs.getString(8)%></td>	
				  <td class=rptValue><%=rs.getString(9)%></td>	
				   <%-- <td class=rptValue><%=rs.getString(10)%></td> --%>
				   <td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(10)%>&ccode=<%=rs.getString(1)%>"><%=rs.getString(10)%></a></td>       
			</tr>

		   <%
	   }
		   
		rs.close();   
	   }
	   else if(circlecode!=null && circlecode.equals("00") && programcode!=null && !programcode.equals("00"))
			{
	   // out.println("in circle all,prog sel,subprog sel,year all,mon all...");
	   //out.println(subprogramcode);
	   str="select DISTINCT c.circle_office_code, c.circle_office_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_CIRCLE_OFFICE_TBL c,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=c.CIRCLE_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.programme_code='"+programcode+"' group by c.circle_office_code,c.circle_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";
        
	//	 int slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		  <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>      			
            <td class=rptValue><%=rs.getString(3)%></td>
			 <td class=rptValue><%=rs.getString(4)%></td>	
			  <td class=rptValue><%=rs.getString(5)%></td>	
			   <td class=rptValue><%=rs.getString(6)%></td>	
			    <td class=rptValue><%=rs.getString(7)%></td>	
				 <td class=rptValue><%=rs.getString(8)%></td>	
				  <%-- <td class=rptValue><%=rs.getString(9)%></td> --%>	
				   <td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(9)%>&ccode=<%=rs.getString(1)%>"><%=rs.getString(9)%></a></td>
				         
			</tr>

		   <%
	   }
		   
		rs.close();   
	   }
	   else if( circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& programcode!=null &&  programcode.equals("00"))
			{
		    // out.println("cicle selcted,div sel,subdiv sel, mnth all ,program all,year all");
           
		   str="select distinct d.division_office_code,d.division_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_division_OFFICE_TBL d,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=d.CIRCLE_OFFICE_CODE and e.division_office_code=d.division_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.circle_office_code='"+circlecode+"' group by d.division_office_code,d.division_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";

			ps=conn.prepareStatement(str);
	      
			// int slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       			
            <td class=rptValue><%=rs.getString(4)%></td>	
			<td class=rptValue><%=rs.getString(5)%></td>       
			<td class=rptValue><%=rs.getString(6)%></td> 
            <td class=rptValue><%=rs.getString(7)%></td>            
			<td class=rptValue><%=rs.getString(8)%></td> 
			<td class=rptValue><%=rs.getString(9)%></td> 
			<%-- <td class=rptValue><%=rs.getString(10)%></td> --%>
			<td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(10)%>&dcode=<%=rs.getString(1)%>&circlecode=<%=circlecode%>"><%=rs.getString(10)%></a></td> 
			</tr>

		   <%
	   }
		   
		rs.close();   
	   }
	   else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") &&  programcode!=null &&  programcode.equals("00"))
			{
		   str="select distinct sd.subdivision_office_code,sd.subdivision_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_subdivision_OFFICE_TBL sd,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=sd.CIRCLE_OFFICE_CODE and e.division_office_code=sd.division_OFFICE_CODE and e.subdivision_office_code=sd.subdivision_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.circle_office_code='"+circlecode+"' and e.division_office_code='"+divisioncode+"' group by sd.subdivision_office_code,sd.subdivision_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";
		  
		    ps=conn.prepareStatement(str);
	      
			// int slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       			
            <td class=rptValue><%=rs.getString(4)%></td>	
			<td class=rptValue><%=rs.getString(5)%></td>       
			<td class=rptValue><%=rs.getString(6)%></td> 
            <td class=rptValue><%=rs.getString(7)%></td>            
			<td class=rptValue><%=rs.getString(8)%></td> 
			<td class=rptValue><%=rs.getString(9)%></td> 
			<%-- <td class=rptValue><%=rs.getString(10)%></td> --%>
			<td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(10)%>&sdcode=<%=rs.getString(1)%>&divisioncode=<%=divisioncode%>&circlecode=<%=circlecode%>"><%=rs.getString(10)%></a></td> 
			</tr>

		   <%
	   }
		   
		rs.close();   
	   }
       else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") &&  programcode!=null &&  !programcode.equals("00"))
			{
         str="select distinct sd.subdivision_office_code,sd.subdivision_office_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_subdivision_OFFICE_TBL sd,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=sd.CIRCLE_OFFICE_CODE and e.division_office_code=sd.division_OFFICE_CODE and e.subdivision_office_code=sd.subdivision_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.circle_office_code='"+circlecode+"' and e.division_office_code='"+divisioncode+"' and e.programme_code='"+programcode+"' group by sd.subdivision_office_code,sd.subdivision_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";
		  
		    ps=conn.prepareStatement(str);
	      
			// int slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       			
            <td class=rptValue><%=rs.getString(4)%></td>	
			<td class=rptValue><%=rs.getString(5)%></td>       
			<td class=rptValue><%=rs.getString(6)%></td> 
            <td class=rptValue><%=rs.getString(7)%></td>            
			<td class=rptValue><%=rs.getString(8)%></td> 
			<%-- <td class=rptValue><%=rs.getString(9)%></td>  --%>
			<td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(9)%>&sdcode=<%=rs.getString(1)%>&divisioncode=<%=divisioncode%>&circlecode=<%=circlecode%>"><%=rs.getString(9)%></a></td> 
			</tr>
			

		   <%
	   }
		   
		rs.close();   
	   }
       else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1") &&  programcode!=null &&  !programcode.equals("00"))
			{
         str="select distinct d.division_office_code,d.division_office_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_division_OFFICE_TBL d,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=d.CIRCLE_OFFICE_CODE and e.division_office_code=d.division_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.circle_office_code='"+circlecode+"' and e.programme_code='"+programcode+"' group by d.division_office_code,d.division_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";	  
		    ps=conn.prepareStatement(str);
	      
			// int slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       			
            <td class=rptValue><%=rs.getString(4)%></td>	
			<td class=rptValue><%=rs.getString(5)%></td>       
			<td class=rptValue><%=rs.getString(6)%></td> 
            <td class=rptValue><%=rs.getString(7)%></td>            
			<td class=rptValue><%=rs.getString(8)%></td> 
			<%-- <td class=rptValue><%=rs.getString(9)%></td> --%> 
			<td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(9)%>&dcode=<%=rs.getString(1)%>&circlecode=<%=circlecode%>"><%=rs.getString(9)%></a></td> 
			</tr>
			

		   <%
	   }
		   
		rs.close();   
	   }
	    else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") &&  programcode!=null &&  !programcode.equals("00"))
			{
         str="select distinct sd.subdivision_office_code,sd.subdivision_office_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_subdivision_OFFICE_TBL sd,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=sd.CIRCLE_OFFICE_CODE and e.division_office_code=sd.division_OFFICE_CODE and e.subdivision_office_code=sd.subdivision_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.circle_office_code='"+circlecode+"' and e.division_office_code='"+divisioncode+"' and sd.subdivision_office_code='"+subdivisioncode+"' and e.programme_code='"+programcode+"' group by sd.subdivision_office_code,sd.subdivision_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";
		  
		    ps=conn.prepareStatement(str);
	      
			// int slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       			
            <td class=rptValue><%=rs.getString(4)%></td>	
			<td class=rptValue><%=rs.getString(5)%></td>       
			<td class=rptValue><%=rs.getString(6)%></td> 
            <td class=rptValue><%=rs.getString(7)%></td>            
			<td class=rptValue><%=rs.getString(8)%></td> 
			<%-- <td class=rptValue><%=rs.getString(9)%></td>  --%>
			<td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(9)%>&sdcode=<%=rs.getString(1)%>&divisioncode=<%=divisioncode%>&circlecode=<%=circlecode%>"><%=rs.getString(9)%></a></td> 
			</tr>
			

		   <%
	   }
		   
		rs.close();   
	   }
	    else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") &&  programcode!=null &&  programcode.equals("00"))
			{
         str="select distinct sd.subdivision_office_code,sd.subdivision_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO from rws_eoat_tbl e,RWS_subdivision_OFFICE_TBL sd,rws_programme_tbl p ,rws_work_admn_tbl a where a.work_id=e.work_id and e.circle_office_code=sd.CIRCLE_OFFICE_CODE and e.division_office_code=sd.division_OFFICE_CODE and e.subdivision_office_code=sd.subdivision_OFFICE_CODE and e.work_id is not null and eoat_order_no is not null and p.programme_code=e.programme_code and e.circle_office_code='"+circlecode+"' and e.division_office_code='"+divisioncode+"' and sd.subdivision_office_code='"+subdivisioncode+"' group by sd.subdivision_office_code,sd.subdivision_office_name,p.programme_name,e.work_id,work_name,VALUE_OF_WORK_DONE,COST_OF_WORK,VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,EOAT_ORDER_NO";
		  
		    ps=conn.prepareStatement(str);
	      
			// int slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       			
            <td class=rptValue><%=rs.getString(4)%></td>	
			<td class=rptValue><%=rs.getString(5)%></td>       
			<td class=rptValue><%=rs.getString(6)%></td> 
            <td class=rptValue><%=rs.getString(7)%></td>            
			<td class=rptValue><%=rs.getString(8)%></td> 
			<td class=rptValue><%=rs.getString(9)%></td> 
			<%-- <td class=rptValue><%=rs.getString(10)%></td>  --%>
			<td class=rptValue><a href="rws_eoatdetails_rpt.jsp?eoatno=<%=rs.getString(10)%>&sdcode=<%=rs.getString(1)%>&divisioncode=<%=divisioncode%>&circlecode=<%=circlecode%>"><%=rs.getString(10)%></a></td> 
			</tr>
			

		   <%
	   }
		   
		rs.close();   
	   }
	   if(slno==0)
			{%>
		 <tr align="center">
           <td class=rptHeading colspan=10><a href="./rws_eoat_rpt_frm.jsp"><%="No Records For this Query"%></a></td></tr>

	 <% 
			} 
	 }
   catch(Exception e)
   {
	    e.printStackTrace();
   }
    finally
	{
	conn.close();
	}
	%>
	</table>
  
	</body>
	</html>
	<%@ include file = "footer.jsp" %>
