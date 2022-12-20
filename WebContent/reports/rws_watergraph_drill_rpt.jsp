<%@ include file="/commons/rws_header1.jsp"%><%@ include file="/commons/rws_header2.jsp"%><%@ include file="conn.jsp" %><form><%	String cat="",cat1="",cat2="",cat3="",cat4="";	String dsname="";	String gqry="";			String testcode=request.getParameter("testcode");	String year=request.getParameter("year");	String dcode=request.getParameter("dcode");
    String testname="";
    String sname="";
    String dname="";
    

   if(testcode.equals("1"))
   {
    testname="PHYSICO-CHEMICAL";
   }
   else if(testcode.equals("2"))
   {
    testname="BACT - AT LAB";
   }	dname=(String)session.getAttribute("dName");	if(dcode.equals("51"))
     {
     sname="ALL";
     }
     else
     {
     sname=""+dname;
     }
   		int sno=1;	int tot=0;	String qry="";		int j=0;	String hp="";			%>	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>	<caption>	<table  border=0 rules=none style="border-collapse:collapse" align = "right">				<tr align="right">		<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>	</tr>  	</table>	</caption>	<tr bgcolor="#8A9FCD" align="center">	<td align="center" class="rptHeading" > Water Quality Samples  Report   </td>	</tr>	</table>   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >   <tr align=center>	<td class=btext colspan=10>District:<font color="red"><%=sname%></font>&nbsp;&nbsp;&nbsp;&nbsp;Test name<font color="red"><%=testname%></font>  </td>	</tr>	<tr align=center>		<td class=btext  nowrap>Sl.No</td>    	<td class=btext  nowrap>Samples(Source_code)</td>	<td class=btext  nowrap>Sample Collected Date</td>
     <td class=btext  nowrap>Lab</td>		</tr>	<tr><%try{
Statement	stmt8=conn.createStatement();      if(dcode.equals("51") )				 {					 gqry ="select source_code,to_char(samp_collect_date,'dd/mm/yyyy'),lab_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_complete_hab_view hd,rws_water_quality_lab_tbl l where l.lab_code=w.lab_code and w.test_code=c.test_code and w.SAMP_COLLECT_DATE is not null and to_char (w.SAMP_COLLECT_DATE,'yyyy')='"+year+"' and c.test_code<>'3' and hd.panch_code=w.hab_code and  w.test_code='"+testcode+"'        order by source_code";												 												                  }				 else if(!dcode.equals("51") )				 {					 gqry="select source_code,to_char(samp_collect_date,'dd/mm/yyyy'),lab_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_complete_hab_view hd,rws_district_tbl d,rws_water_quality_lab_tbl l where l.lab_code=w.lab_code and  c.test_code<>'3' and d.dcode=substr(w.hab_code,1,2) and substr(w.hab_code,1,2)= '"+dcode+"' and w.test_code=c.test_code and w.SAMP_COLLECT_DATE is not null and to_char (w.SAMP_COLLECT_DATE,'yyyy')='"+year+"' and hd.panch_code=w.hab_code  and w.test_code='"+testcode+"'  order by source_code";							                  }    		 	System.out.println("gqry********"+gqry);		    	ResultSet rs8=stmt8.executeQuery(gqry);    	while (rs8.next())	{    	%>	<tr>		    <td class="rptValue"><%=sno++%></td>	<td class="rptValue"><%=rs8.getString(1)%></td>    <td class="rptValue"><%=rs8.getString(2)%></td> 
    <td class="rptValue"><%=rs8.getString(3)%></td> 	</tr>	<%}	}catch(SQLException e)		{		e.printStackTrace();		}		%></table><p align=center><%@ include file="/commons/rws_footer.jsp" %></p>  