<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String cat="",cat1="",cat2="",cat3="",cat4="";
	String dsname="";
    Statement stmt1=null;
	String gqry="";
	
	
	String dcode=request.getParameter("dcode");
	String st=request.getParameter("status");
	String status="";
	if(dcode.equals("51"))
	{
		dsname="ALL";
	}
	else
	{
		dsname=(String)session.getAttribute("dName");
	}
	if(st.equals("1"))
	{
		status="FC";
	}
	else if(st.equals("2"))
	{
		status="PC1";
	}

	else if(st.equals("3"))
	{
		status="PC2";
	}
		else if(st.equals("4"))
	{
		status="PC3";
	}
		else if(st.equals("5"))
	{
		status="PC4";
	}
		else if(st.equals("6"))
	{
		status="NC";
	}
		else if(st.equals("7"))
	{
		status="NSS";
	}

   String fdate=request.getParameter("fd");



	
    

   
	
	int sno=1;
	int tot=0;
	String qry="";
	
	int j=0;
	

String hp="";
	
	
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="45%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td class="bwborder"><a href="rws_coveragefc_status_graph_frm.jsp">Home  </a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Habitations Coverage Status  Report   </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="45%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   
   <tr align=center>
	<td class=btext colspan=10>District:<font color="red"><%=dsname%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coverage Status:<font color="red"><%=status%></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status Date:<font color=red><%=fdate%></font>  </td>
	</tr>
	<tr align=center>
	
	<td class=btext  nowrap>Sl.No</td>
    
	<td class=btext  nowrap>Habitation Code</td>
	<td class=btext  nowrap>Habitation Name</td>
     
	
	</tr>
	<tr>
<%
try
{
Statement	stmt8=conn.createStatement();
      if(dcode.equals("51") )
				 {
					 gqry ="select panch_code,panch_name from rws_complete_hab_view where coverage_status='"+status+"' order by panch_code";
						
						 
												 
                 }

				 else if(!dcode.equals("51") )
				 {
					 gqry ="select panch_code,panch_name from rws_complete_hab_view where coverage_status='"+status+"' and substr(panch_code,1,2)='"+dcode+"' order by panch_code";		
                  }
    
	

	 
	System.out.println("gqry********"+gqry);
	
	
    
	ResultSet rs8=stmt8.executeQuery(gqry);
    

	while (rs8.next())
	{
    
	%>
	<tr>
	
	
    <td class="rptValue" align=center><%=sno++%></td>
	<td class="rptValue" align=center><%=rs8.getString(1)%></td>
    <td class="rptValue" align=left><%=rs8.getString(2)%></td> 
    
	</tr>
	
<%
}

	
}catch(SQLException e)
		{
		e.printStackTrace();
		}
		%>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>
</p>

  
