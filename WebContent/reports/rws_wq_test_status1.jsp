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

String circlecode=null,divisioncode=null,subdivisioncode=null, sourcecode=null,circlename=null,divisionname=null,subdivisionname=null,sourcename=null,fromdate=null,
todate=null;
int slno=0;
	  
	  
        
	   circlename=(String)session.getAttribute("circleName");
	   divisionname=(String)session.getAttribute("divName");
	   subdivisionname=(String)session.getAttribute("subdivName");
	   fromdate=(String)session.getAttribute("FDATE");
	 //todate=(String)session.getAttribute("TDATE");
	  sourcename=(String)session.getAttribute("sName");
	   
	   
	    circlecode=(String)session.getAttribute("circleCode");
		divisioncode=(String)session.getAttribute("divCode");
		subdivisioncode=(String)session.getAttribute("subdivCode");
		
		sourcecode=(String)session.getAttribute("sCode");
		
		%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_water_frm.jsp">Back</td> 
				</tr>
			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>Water Quality Report &nbsp;&nbsp;During &nbsp;&nbsp;<%=fromdate%></td>	
	</tr>
	

		<%@ include file="test1.label1.jsp"%>
	
<%
       

	   try
		{
	   String str=" ";
	   
         if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && sourcecode.equals("00"))
			{
	   //out.println("in circle all,program al and  subprog all or subprog nt sel ,year all,month,al");
	   
	   /*str="select DISTINCT c.circle_office_code,c.circle_office_name,sc.source_code,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),t.test_name,nvl(to_char(sc.assigned_on,'dd-MON-yyyy'),'-') from rws_water_sample_collect_tbl sc,RWS_CIRCLE_OFFICE_TBL c,rws_water_quality_test_tbl t where sc.circle_office_code=c.CIRCLE_OFFICE_CODE  and sc.test_code=t.test_code AND SC.SAMP_COLLECT_DATE >='"+fromdate+"' AND sc.SAMP_COLLECT_DATE <='"+todate+"'";*/

	   /*str="select DISTINCT c.circle_office_code,c.circle_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_CIRCLE_OFFICE_TBL c,rws_water_quality_test_tbl t where sc.circle_office_code=c.CIRCLE_OFFICE_CODE  and sc.test_code=t.test_code AND substr(SC.Assigned_on,4,10) >='"+fromdate+"' AND substr(sc.Assigned_on,4,10)<='"+todate+"' group by c.circle_office_code,c.circle_office_name,sc.source_type"; */

	  str="select DISTINCT sc.circle_office_code,c.circle_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_CIRCLE_OFFICE_TBL c, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr where sc.circle_office_code=c.CIRCLE_OFFICE_CODE  and sc.lab_code=l.lab_code and sc.test_code=t.test_code and sc.hab_code=pr.panch_code and to_char(sc.assigned_on,'YYYY')='"+fromdate+"' group by sc.circle_office_code,c.circle_office_name,sc.source_type";
        //sc.test_id=a.test_id

		
		 slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?ccode=<%=rs.getString(1)%>&sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
			<%
	   }
		   
		rs.close();   
	   }
	   else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& sourcecode!=null && sourcecode.equals("00"))
		    {
		           //out.println("cicle selcted,div ALL,subdiv nt, mnth all ,program all,year all");

                
				 str="select distinct sc.division_office_code,d.division_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_division_OFFICE_TBL d, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where d.circle_office_code=sc.CIRCLE_OFFICE_CODE and d.division_office_code=sc.division_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code  and   to_char(sc.assigned_on,'YYYY')='"+fromdate+"' and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' group by sc.division_office_code,d.division_office_name,sc.source_type"; 
              //,and sc.test_id=a.test_id
          ps=conn.prepareStatement(str);
	         slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			 <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>  
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?dcode=<%=rs.getString(1)%>&sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
			
	<%
	   }
		   
		rs.close();   
			}
                 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") &&  sourcecode!=null && sourcecode.equals("00"))
		    {
				//out.println("cicle selcted,div seletcd,subdiv ALL, mnth all ,program all,year all");
                
                str="select distinct sc.subdivision_office_code,sd.subdivision_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_subdivision_OFFICE_TBL sd, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where sd.circle_office_code=sc.CIRCLE_OFFICE_CODE and sd.division_office_code=sc.division_OFFICE_CODE  and sd.subdivision_office_code=sc.subdivision_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code  and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_OFFICE_CODE='"+divisioncode+"' and   to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  group by sc.subdivision_office_code,sd.subdivision_office_name,sc.source_type ";
			
			//,rws_wq_geologist_test_tbl a,and sc.test_id=a.test_id
			ps=conn.prepareStatement(str);
	        
			  slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>  
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?sdcode=<%=rs.getString(1)%>&sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&divisioncode=<%=divisioncode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
		 <%
	   }
		   
		rs.close();   
			}
                     else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") &&  subdivisioncode!=null && !subdivisioncode.equals("-1") &&  sourcecode!=null && sourcecode.equals("00"))
			{    
			//out.println("cicle slcted,div slcted,subdiv slected,program all, mnth ntall ,year ntall");

				str="select DISTINCT sc.subdivision_office_code,sd.subdivision_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_subdivision_OFFICE_TBL sd, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where sd.circle_office_code=sc.CIRCLE_OFFICE_CODE and sd.division_office_code=sc.division_OFFICE_CODE  and sd.subdivision_office_code=sc.subdivision_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code  and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_OFFICE_CODE='"+divisioncode+"' and sc.subdivision_OFFICE_CODE='"+subdivisioncode+"' and   to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  group by sc.subdivision_office_code,sd.subdivision_office_name,sc.source_type ";

				 ps=conn.prepareStatement(str);
				 slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>  
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&divisioncode=<%=divisioncode%>&subdivisioncode=<%=subdivisioncode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
		   <%
	   }
		   
		rs.close();   
			}
         else if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && !sourcecode.equals("00"))
			{
	   
	  str="select DISTINCT sc.circle_office_code,c.circle_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_CIRCLE_OFFICE_TBL c, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where sc.circle_office_code=c.CIRCLE_OFFICE_CODE  and sc.lab_code=l.lab_code and sc.test_code=t.test_code and  sc.source_type='"+sourcecode+"' and  to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  group by sc.circle_office_code,c.circle_office_name,sc.source_type";
        
		 slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>       
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?ccode=<%=rs.getString(1)%>&sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
			<%
	   }
		   
		rs.close();   
	   }
	 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& sourcecode!=null && !sourcecode.equals("00"))
		    {
		           //out.println("cicle selcted,div ALL,subdiv nt, mnth all ,program all,year all");

                
				 str="select distinct sc.division_office_code,d.division_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_division_OFFICE_TBL d, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where d.circle_office_code=sc.CIRCLE_OFFICE_CODE and d.division_office_code=sc.division_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code and   to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' AND  sc.source_type='"+sourcecode+"' group by sc.division_office_code,d.division_office_name,sc.source_type"; 

          ps=conn.prepareStatement(str);
	         slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			 <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>  
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?dcode=<%=rs.getString(1)%>&sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
			
	<%
	   }
		   
		rs.close();   
			}

			 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") &&  sourcecode!=null && !sourcecode.equals("00"))
		    {
				//out.println("cicle selcted,div seletcd,subdiv ALL, mnth all ,program all,year all");
                
                str="select distinct sc.subdivision_office_code,sd.subdivision_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_subdivision_OFFICE_TBL sd, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where sd.circle_office_code=sc.CIRCLE_OFFICE_CODE and sd.division_office_code=sc.division_OFFICE_CODE  and sd.subdivision_office_code=sc.subdivision_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_OFFICE_CODE='"+divisioncode+"' and  sc.source_type='"+sourcecode+"' and to_char(sc.assigned_on,'YYYY')='"+fromdate+"' group by sc.subdivision_office_code,sd.subdivision_office_name,sc.source_type ";
			
			ps=conn.prepareStatement(str);
	        
			  slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>  
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?sdcode=<%=rs.getString(1)%>&sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&divisioncode=<%=divisioncode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
		 <%
	   }
		   
		rs.close();   
			}
			 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") &&  subdivisioncode!=null && !subdivisioncode.equals("-1") &&  sourcecode!=null && !sourcecode.equals("00"))
			{    
			//out.println("cicle slcted,div slcted,subdiv slected,program all, mnth ntall ,year ntall");

				str="select DISTINCT sc.subdivision_office_code,sd.subdivision_office_name,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','CPWSSURFACE','0301003','CPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'),count(source_code),sc.source_type from rws_water_sample_collect_tbl sc,RWS_subdivision_OFFICE_TBL sd, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t where sd.circle_office_code=sc.CIRCLE_OFFICE_CODE and sd.division_office_code=sc.division_OFFICE_CODE  and sd.subdivision_office_code=sc.subdivision_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_OFFICE_CODE='"+divisioncode+"' and sc.subdivision_OFFICE_CODE='"+subdivisioncode+"' and sc.source_type='"+sourcecode+"' and to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  group by sc.subdivision_office_code,sd.subdivision_office_name,sc.source_type ";

				 ps=conn.prepareStatement(str);
				 slno=0;
	         rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
  			<td class=rptValue><%=rs.getString(3)%></td>  
			<td class=rptValue><a href="rws_wq_testdet_rpt.jsp?sourcetype=<%=rs.getString(5)%>&fromdate=<%=fromdate%>&circlecode=<%=circlecode%>&divisioncode=<%=divisioncode%>&subdivisioncode=<%=subdivisioncode%>&sourcename=<%=rs.getString(3)%>"><%=rs.getString(4)%></a></td>	
			</tr>
		   <%
	   }
		   
		rs.close();   
			}
		if(slno==0)
		{%> <tr align="center">
           <td class=rptHeading colspan=8 ><a href="javascript:window.history.back()"><%="No Records For this Query"%></a></td></tr>
		<% } 
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
