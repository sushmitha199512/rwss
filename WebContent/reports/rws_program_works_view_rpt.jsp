<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<html>




<form>
<%
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null;
DecimalFormat ndf = new DecimalFormat("######.##");
     nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	if(dcode!=null)
	{
		session.setAttribute("dcode",dcode);
	}
	String dname = request.getParameter("dname");
	if(dname!=null)
	{
		session.setAttribute("dname",dname);
	}
		String subprogram = request.getParameter("subprogram");
		if(subprogram!=null)
		{
			session.setAttribute("subprogram",subprogram);
		}
		String finyear = request.getParameter("finyear");
		if(finyear!=null)
	{
		session.setAttribute("finyear",finyear);
	}
		
		String mode = request.getParameter("mode");	
		int sno=1;
		String programe="",nextyr="";
		
		String[] program=request.getParameterValues("program");
		ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
if(programe!=null)
{
session.setAttribute("programe",programe);
}



}


double rtotal=0,etotal=0;




%>
<body class="landScape">

<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a>
			</td>
				
			
			</tr>  
		</table>
	</caption>
	

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> <font color="red"><b>Amount in Rs. lakhs</b></font></td>
</tr>




	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Sustainbility Works- Releases Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext >Sl.No</td>
               <td class=btext >District</td>
               <td class=btext >Mandal</td>
               <td class=btext >Habitation Name</td> 
			   <td class=btext >HabID</td> 
			   <td class=btext >Work Name</td>
			   <td class=btext >Work ID</td>
	           <td class=btext width="100" >Grant</td>
			   <td class=btext width="100">Estimate Cost <br>(In Lakhs)</td>
			   <td class=btext >Releases<br>(In Rupees)</td>
			   <td class=btext >Completion Date</td>
	</tr> 
    
<% 
try
{
String yr="";
		if(finyear!=null)
			yr=finyear.substring(0,4);
		nextyr=finyear.substring(5,9);
		
		//System.out.println("finyear:"+finyear);
		//System.out.println("yyyyyyyy:"+yr);
			//System.out.println("nextyr:"+nextyr);
		if(yr!=null)
			{
			session.setAttribute("yr",yr);
			}
			if(nextyr!=null)
			{
			session.setAttribute("nextyr",nextyr);
			}
			

	
	
	//System.out.println("dcode"+dcode);
    String query = "";
	if(dcode!=null && dcode.equals("All")) {
	  query="select  dcode,dname from rws_district_tbl";
	  }else
	  {
	    query="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	  }

 
   stmt1=conn.createStatement();
   stmt2=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();
String dateOfCompletion=null;
   
  rs1=stmt1.executeQuery(query);
  while (rs1.next())
	{
  //String q1="select distinct  e.mname,b.LEAD_HABITATION,f.PANCH_NAME,b.work_id,b.work_name,d.PROGRAMME_NAME,b.SANCTION_AMOUNT,a.BILL_AMOUNT_CENTRAL,c.DATE_OF_COMPLETION from RWS_bill_bank_bridge_det_TBL a, rws_work_admn_tbl b ,rws_work_completion_tbl c ,rws_programme_tbl d,rws_mandal_tbl e,RWS_PANCHAYAT_RAJ_TBL f where f.PANCH_CODE=b.LEAD_HABITATION  and a.TXID  is not null and bank_send_date>='01-APR-"+yr+"' and bank_send_date<'31-MAR-"+nextyr+"' and substr(a.office_code,2,2)='"+rs1.getString(1)+"' and a.work_id=b.work_id and c.work_id=a.work_id and e.dcode='"+rs1.getString(1)+"' and substr(a.work_id,1,2)='"+programe+"' and substr(a.work_id,1,2)=d.PROGRAMME_CODE";
 String q1="select distinct * from RWS_bill_bank_bridge_det_TBL,rws_programme_tbl a ,rws_subprogramme_tbl b where substr(office_code,2,2)='"+rs1.getString(1)+"' and  TXID is not null and bank_send_date>='01-APR-"+yr+"' and bank_send_date<='31-MAR-"+nextyr+"' and substr(work_id,1,4)='"+programe+subprogram+"' and b.programme_code='"+programe+"' and b.subprogramme_code='"+subprogram+"' and a.programme_code='"+programe+"' order by work_id" ; ;
	System.out.println("Q5:"+q1);
		rs3=stmt2.executeQuery(q1);
            
			while(rs3.next())
            {
			  
	String q2="select distinct  b.LEAD_HABITATION,f.PANCH_NAME,b.work_id,b.work_name,b.SANCTION_AMOUNT,E.MNAME from rws_work_admn_tbl b ,rws_mandal_tbl e,RWS_PANCHAYAT_RAJ_TBL f where b.work_id='"+rs3.getString(1)+"' and f.PANCH_CODE=b.LEAD_HABITATION AND e.mcode=substr(b.LEAD_HABITATION,3,2) and e.dcode=substr(b.LEAD_HABITATION,1,2)";
		// System.out.println("Q5:"+q2);
		rs4=stmt3.executeQuery(q2);
            while(rs4.next())
            {
           
rtotal+=Double.parseDouble(rs3.getString(4));
etotal+=Double.parseDouble(rs4.getString(5));
	String q3="select distinct to_char(DATE_OF_COMPLETION,'dd/mm/yyyy')DATE_OF_COMPLETION from rws_work_completion_tbl where work_id='"+rs3.getString(1)+"'";
		 rs5=stmt4.executeQuery(q3);
		 dateOfCompletion="";
            if(rs5.next())
			{
			dateOfCompletion=rs5.getString(1);
			}
    	     if(dateOfCompletion==null)
			 {
			  dateOfCompletion="-";
			 }

%>

				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
				<td class=rptValue NOWRAP><%=rs4.getString(6) %></td>
				<td class=rptValue NOWRAP><%=rs4.getString(2) %></td>
				<td class=rptValue NOWRAP><%=rs4.getString(1) %></td>
                <td class=rptValue ><%=rs4.getString(4) %></td>
                <td class=rptValue NOWRAP><%=rs4.getString(3) %></td>
				<td class=rptValue NOWRAP width="100"><%=rs3.getString(10)+"--"+rs3.getString(20)  %></td>
				<td class=rptValue NOWRAP width="100"><%=rs4.getString(5)%></td>            
				<td class=rptValue NOWRAP ><%=rs3.getString(4)  %></td>
                <td class=rptValue NOWRAP><%= dateOfCompletion%></td>
					
				</tr>
<%			
}
} 
}//END loop for districts
	%>
	<tr>
	 <td class="btext" colspan="8" align="center">Total:</td>
       <td class="btext" ><%=ndf.format(etotal) %></td>
	  <td class="btext" ><%=ndf.format(rtotal )%></td>
      <td class="btext" ></td>



 </tr>
	
	<%
	
}
catch(Exception e)
{
	e.printStackTrace();
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
		if(rs3 != null )
		{
			rs3.close();
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
</body>
</html>