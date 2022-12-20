<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%


	//String dname=request.getParameter("dname");
	StringBuffer dname=new StringBuffer();
	String dis=request.getParameter("dname");
	if(dis==null||dis==""){
		dis="All";
	}
	//dname.append(request.getParameter("dname"));
	
	dname.append(dis);
	session.setAttribute("dname",dname);
	//System.out.println("dis"+dis);
	
	//String cat="",cat1="",cat2="",cat3="",cat4="";
	
	
	
	//String dsname="";
	StringBuffer dsname=new StringBuffer();
	
	
	/* //String y1=request.getParameter("year1");
	StringBuffer y1=new StringBuffer();
	y1.append(request.getParameter("year1"));
	session.setAttribute("year1",y1); */
	
	
	//String fromdate=request.getParameter("fromDate");
	//String s;
	StringBuffer s=new StringBuffer();
   //fromdate=fromdate.replace("/","-");

//////System.out.println("f1*************"+fromdate);


	


			
//	String todate=request.getParameter("toDate");
//todate=todate.replace("/","-");
	
	//String dcode=request.getParameter("district");
	StringBuffer dcode=new StringBuffer();
	dcode.append(request.getParameter("district"));
	
	session.setAttribute("dcode",dcode.toString());
	
	
	//String gtxidValueOld = "",gtxidValue="";
	StringBuffer gtxidValueOld=new StringBuffer();
	StringBuffer gtxidValue=new StringBuffer();
	
	int sno=1;
	int tot=0;
	int j=0;
	
	StringBuffer qry=new StringBuffer();
	StringBuffer gqry=new StringBuffer();
	
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="61%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
	<td class="bwborder"><a href="./rws_drought_distinct_hab_xlx.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<%
	if(dis.equals("ALL")){
	%>
	
	
	<td align="center" class="rptHeading"  >Drought Distinct Habitations Report  </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
	<td class=btext colspan=7>District:<font color="red"><%=dname%></font> </td>
	</tr>
	<tr align=center>	
	<td class=btext rowspan = 1>Sl.No</td>
	<td class=btext  rowspan = 1 >Dist.Sl.No</td>
	<td class=btext  rowspan = 1 >Mandal</td>
    <td class=btext  rowspan = 1 >Panchayat</td>
    <td class=btext  rowspan = 1 >Village</td>
	<td class=btext  rowspan = 1 >HabitationName/Code</td>	
	<td class=btext  rowspan = 1 >Drought Year</td>
	</tr>
	<%}else{ %>
	<td align="center" class="rptHeading"  colspan=5>Drought Distinct Habitations Report  </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
	<td class=btext colspan=6>District:<font color="red"><%=dname%></font> </td>
	</tr>
	<tr align=center>	
	<td class=btext rowspan = 1>Sl.No</td>
	<td class=btext  rowspan = 1 >Mandal</td>
    <td class=btext  rowspan = 1 >Panchayat</td>
    <td class=btext  rowspan = 1 >Village</td>
	<td class=btext  rowspan = 1 >HabitationName/Code</td>	
	<td class=btext  rowspan = 1 >Drought Year</td>
	</tr>

<%
	}
try
{
	String qry1="",qry2="";
	PreparedStatement pstmt1=null,pstmt2=null;
	ResultSet rs3=null,rs4=null;
	int distcount=0;
	//System.out.println("hello"+dis);
	
	if(dis.equals("ALL")){
		//System.out.println("hellofdfffff"+dis+rs3);
		qry1="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dcode";
		pstmt1 = conn.prepareStatement(qry1);
		//System.out.println("helloaaaaaaaaaaaaaaaa"+dis+rs3);
		 rs3 = pstmt1.executeQuery();
		 
		//System.out.println("hellobbbbbbbbbbb"+dis+rs3);
				while(rs3.next())
				{
					//System.out.println("hellobbbbbbbbbbb"+rs3.getString("dname"));
				
					%>
					 <tr align=center>
						<td class=btext colspan=6>District:<font color="red"><%=rs3.getString("dname")%></font> </td>
					</tr>
					<%
					gqry.delete(0,gqry.length());
					gqry.append("select DISTINCT c.pname,c.panch_name,a.habcode,c.mname,c.VNAME from rws_drought_habitation_tbl a,rws_complete_hab_view c where  c.panch_code=a.habcode  and substr(habcode,1,2)='"+rs3.getString("dcode")+"'");
						
				    // ////System.out.println("query1111**********"+gqry);
					
					Statement	stmt8=conn.createStatement();
					//Statement	stmt2=conn.createStatement();
				    
					ResultSet rs8=stmt8.executeQuery(gqry.toString());
					StringBuffer q2=new StringBuffer();
					distcount=0;
						while (rs8.next())
						{
							distcount++;
							/* q2.delete(0,q2.length());
							q2.append("select SCARCITY_NAME  from RWS_DROUGHT_SCAR_REASONS_TBL where SCARCITY_CODE='"+rs8.getString(1)+"'");

					 
					   ResultSet rs2=stmt2.executeQuery(q2.toString()); */
					   
							qry2="select year from rws_drought_habitation_tbl where habcode='"+rs8.getString("habcode")+"'";
					   		pstmt2=conn.prepareStatement(qry2);
					   		rs4=pstmt2.executeQuery();
							//System.out.println(qry);


						j++;
					%>
					<tr>
					
					<td class="rptValue"><%=sno++%></td>
					 <td class="rptValue"><%=distcount%></td>
				    <td class="rptValue"><%=rs8.getString("mname")%></td>
				    <td class="rptValue"><%=rs8.getString("pname")%></td>
				     <td class="rptValue"><%=rs8.getString("VNAME")%></td>
					<td class="rptValue"><%=rs8.getString("panch_name")%>/<%=rs8.getString("habcode")%>&nbsp;</td>
					<td class="rptValue"><%
				while(rs4.next()){
					//System.out.println("in year   ");
					%><%=rs4.getString("YEAR") %>
						<%}
					rs4.close();
						pstmt2.close();%>
								
					</td>
					</tr>
					
					
				<%
					
					
					if(j==0)
					{%>
					<tr>
					<td colspan=7 align="center">No Records</td>
					</tr>
					
					<%}
												
						}
						rs8.close();
						stmt8.close();
						
				}	
				pstmt1.close();
				rs3.close();
	}else{
		//System.out.println("aaaaaaaaaaaaaaaaaaaaaa");
		gqry.append("select DISTINCT c.pname,c.panch_name,a.habcode,c.mname,c.VNAME from rws_drought_habitation_tbl a,rws_complete_hab_view c where  c.panch_code=a.habcode  and substr(habcode,1,2)='"+dcode+"'");
			
	   // System.out.println("query1111**********"+gqry);
		
		Statement	stmt8=conn.createStatement();
		//Statement	stmt2=conn.createStatement();
	    
		ResultSet rs8=stmt8.executeQuery(gqry.toString());
		StringBuffer q2=new StringBuffer();
			while (rs8.next())
			{
				
				/* q2.delete(0,q2.length());
				q2.append("select SCARCITY_NAME  from RWS_DROUGHT_SCAR_REASONS_TBL where SCARCITY_CODE='"+rs8.getString(1)+"'");

		 
		   ResultSet rs2=stmt2.executeQuery(q2.toString()); */

		   qry2="select year from rws_drought_habitation_tbl where habcode='"+rs8.getString("habcode")+"'";
	   		pstmt2=conn.prepareStatement(qry2);
	   		rs4=pstmt2.executeQuery();
			


			j++;
		%>
		<tr>
		
		<td class="rptValue"><%=sno++%></td>
	    <td class="rptValue"><%=rs8.getString("mname")%></td>
	    <td class="rptValue"><%=rs8.getString("pname")%></td>
	     <td class="rptValue"><%=rs8.getString("VNAME")%></td>
		<td class="rptValue"><%=rs8.getString("panch_name")%>/<%=rs8.getString("habcode")%>&nbsp;</td>
	<td class="rptValue"><%
				while(rs4.next()){
					
					%><%=rs4.getString("YEAR") %>
						<%} 
						rs4.close();
						pstmt2.close();	%>	
						
					</td>
		
		</tr>
		
		
	<%
		
		
		if(j==0)
		{%>
		<tr>
		<td colspan=7 align="center">No Records</td>
		</tr>
		
		<%}
									
			}
			rs8.close();
			stmt8.close();
			
	
	}
}catch(Exception e)
		{
	e.printStackTrace();
		////System.out.println("error::"+e);
		}finally{
			  if(conn!=null){
				   conn.close();
					  }
				   }
		%>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
