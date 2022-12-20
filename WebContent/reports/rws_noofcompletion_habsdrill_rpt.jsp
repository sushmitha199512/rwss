<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="conn.jsp" %>

<form>
<%

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

StringBuffer cYear=(StringBuffer)session.getAttribute("yr");
//System.out.println("cYear%%%%%%%%%%%%%%%%%%%%%"+cYear);


    Statement stmt8=null;
    ResultSet rs8=null;
    
    int styleCount=0;
    StringBuffer style=new StringBuffer();
    StringBuffer qry=new StringBuffer(); 

	
    int count=0;
   StringBuffer dcode=new StringBuffer();
   dcode.append(request.getParameter("dcode"));
    
    
   StringBuffer status=new StringBuffer();
   status.append(request.getParameter("status"));
   
    //String dcode=request.getParameter("dcode");
    //System.out.println("dcode*******"+dcode);
	//String status=request.getParameter("status");
	
	
	StringBuffer programme=(StringBuffer)session.getAttribute("pname");
	
	StringBuffer scheme=(StringBuffer)session.getAttribute("scheme");
	StringBuffer sname=(StringBuffer)session.getAttribute("scheme");
	
	
    //System.out.println("dcode*******"+status);
    int sno=1;
%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="100%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="rptHeading" >  STATUS WISE COVERAGE OF HABITATIONS DURING THE CURRENT FINANCIAL YEAR -(2013-14)-(as per works monitoring)- Report</td>
	</tr>
  
	</table>
   
   <table width="100%" border=2 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	<td class=gridhdbg rowspan=2><b>Sl.No</b></td>
    <td class=gridhdbg rowspan=2><b>Hab Code</b></td>
    <td class=gridhdbg rowspan=2><b>Hab Name</b></td>
    <td class=gridhdbg rowspan=2><b>Coverage Status</b></td>
    
	
	</tr>
       
       
       
<%
try
{
	//
	
	
	
	System.out.println("sname************"+sname);
	 stmt8=conn.createStatement();
   
   	qry.delete(0,qry.length());
   qry.append("select  c.panch_code,c.panch_name,coverage_status from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null  and (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+cYear.toString()+"') ) and work_cancel_dt is null and coverage_status='"+status.toString()+"' and dcode='"+dcode.toString()+"'");
   
   if(scheme!=null && !scheme.toString().equals("")){
	   qry.append(" and b.type_of_asset in("+scheme.toString()+")");
	  }
   
   if(programme!=null && !programme.toString().equals("")){
	   qry.append(" and substr(b.work_id,1,2) in("+programme+")");
	  }
	
   
   
	
 System.out.println("qry1***************"+qry); 
	rs8=stmt8.executeQuery(qry.toString());
   
	while (rs8.next())
	{
		
		
	 	style.delete(0,style.length());
		 if(styleCount%2==0){
			 style.append("gridbg1");
		 }else{
			 style.append("gridbg2");
		 }
		 styleCount++;
		
%>
<tr></tr>

<tr>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%> </td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%> </td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%> </td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%> </td>
    
   
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
</form>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>
</p>
