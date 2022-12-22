<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%


   nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();

	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
	
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null;
ResultSet rs6=null;
ResultSet rs3=null;



//String attend="";
//String a="";
StringBuffer attend=new StringBuffer();
StringBuffer a=new StringBuffer();


//String dcode=request.getParameter("district");
StringBuffer dcode=new StringBuffer();
dcode.append(request.getParameter("district"));
StringBuffer year=new StringBuffer();
year.append(request.getParameter("year1"));
System.out.println("year"+year);

StringBuffer dname=new StringBuffer();
dname.append(request.getParameter("dname"));

System.out.println("dname"+dname);

session.setAttribute("dcode",dcode.toString());
session.setAttribute("year",year.toString());

int sno=1;

//cDate=request.getParameter("fromdate");
StringBuffer cDate=new StringBuffer();
cDate.append(request.getParameter("fromdate"));




//String aDate=request.getParameter("adate");
StringBuffer aDate=new StringBuffer();
aDate.append(request.getParameter("adate"));


%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
			<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
				<!--<td class="bwborder"><a href="/pred/rws_login_frm1.html">Home</a></td>-->
				<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
				<td class="bwborder"><a href="./rws_drought_habitations_abstract_xls_rpt.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
				<!--<td class="bwborder"><a href="/pred/rws_login_frm1.html">Home</a></td>-->
				<td class="bwborder"><a href="#" onclick="window.close()">Close | </a></td>
				<td class="bwborder"><a href="./rws_drought_habitations_abstract_xls_rpt.jsp" target=_new>Excel</a></td></tr>
<%} %>


	
			<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading">District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year:<font color=red><%=year%></font></td>
		
		
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan='7'>Abstract Contingency Report</td>
		
		
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
               <td class=btext>Total No. Of Mandals</td> 
			   <td class=btext> No. Of Mandals Entered</td>
			   <td class=btext> No. Of Habitations</td>
		   
			   </tr>
<%
try
{
	int count=0;
	int tmandals=0;
	int tmandalentered=0;
	int thabs=0;
	
	
   // String query = "";
    StringBuffer query= new StringBuffer();
	 if(dcode.toString()!=null && !dcode.toString().equals("") && dcode.toString().equals("51"))
		{
		 query.append("select  dcode,dname from rws_district_tbl where dcode<>'16' order by dname");
	  }
	else if(dcode.toString()!=null && !dcode.toString().equals("") && !dcode.toString().equals("51"))
	{
		query.append("select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'");
	  }
//  ////System.out.println("query*********"+query);
  
  
  stmt1=conn.createStatement();
   stmt2=conn.createStatement();
stmt3=conn.createStatement();
  
  ////System.out.println("query.toString()"+query.toString());
  rs1=stmt1.executeQuery(query.toString());
  
   
  query.delete(0,query.length());
  
  StringBuffer qry=new StringBuffer();
  StringBuffer q1=new StringBuffer();
  
  while (rs1.next())
	{
	  qry.delete(0,qry.length());
		
		//String qry="select (select count(*) from rws_mandal_tbl where dcode='"+rs1.getString(1)+"')a1,(select count(*) from RWS_DROUGHT_habitation_TBL  where   substr(habcode,1,2)='"+rs1.getString(1)+"' )a2  from dual";
qry.append("select (select count(*) from rws_mandal_tbl where dcode='"+rs1.getString(1)+"')a1,(select count(*) from RWS_DROUGHT_habitation_TBL  where   substr(habcode,1,2)='"+rs1.getString(1)+"' and year='"+year+"' )a2  from dual");
System.out.println("qry"+qry);
		
q1.delete(0,q1.length());
		//String q1="select distinct substr(habcode,6,2)  from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'";
  q1.append("select distinct substr(habcode,6,2)  from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and year='"+year+"' ");
  
  System.out.println("q1"+q1);
 rs3=stmt3.executeQuery(q1.toString());
 count=0;
  while(rs3.next())
		{
	                 count++;
		}
 
		  
  
		  ////System.out.println("querycomplaints"+qry.toString());
		  rs2=stmt2.executeQuery(qry.toString());
          
		 while(rs2.next())
		{
			  		
			
		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
			
<%			tmandals+=rs2.getInt(1);
				tmandalentered+=count;
				thabs+=rs2.getInt(2);
	
%>	
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
                                <td class=rptValue NOWRAP><%=rs2.getInt(1)%></td>
                                <td class=rptValue NOWRAP><%=count %></td>
				<td class=rptValue NOWRAP><%=rs2.getInt(2)%></td>
				
				
				</tr>
<%
		}	

}
	%>
	<tr>
	<td class="btext" colspan="2">Total:</td><td class="btext" ><%=tmandals %></td><td class="btext" ><%=tmandalentered %></td><td class="btext" ><%=thabs %></td>
    
     
	</tr>
	<%
}
catch(Exception e)
{
	
}
finally
{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</span>
