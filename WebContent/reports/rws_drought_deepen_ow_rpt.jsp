<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String cat="",cat1="",cat2="",cat3="",cat4="";
	String dsname="";
	
	//String fromdate=request.getParameter("fromDate");
	
	
	String dcode=request.getParameter("district");
	session.setAttribute("dcode",dcode);
	
	String gtxidValueOld = "",gtxidValue="";
	int sno=1;
	int tot=0;
	String qry="";
	String gqry="";
	String p1="",p2="",p3="",p5="",p6="";
	String c10="",c1="",c2="",c3="",c4="";
	String hconn1="",hconn2="",hconn3="",hconn4="",hconn5="",hconn6="",hconn7="",hconn8="";
	int j=0;
	String attend="";
	String sname="";
	attend=request.getParameter("attend");
	if(attend.equals("1"))
	{
		sname="Flushing";
	}
	else if(attend.equals("2"))
	{
		sname="Deepening";
	}
	String fromdate=request.getParameter("fromdate");
	//System.out.println("fromdate********"+fromdate);
	String todate=request.getParameter("todate");
    //System.out.println("todate********"+todate);
	String dname=request.getParameter("dname");
String qryhp="";
String loc="";
String hp="";
	
	
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Borewells <%=sname%> Report   </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
	<td class=btext colspan=10>District:<font color="red"><%=dname%>&nbsp;&nbsp;</font>&nbsp;FromDate:<font color="red"><%=fromdate%>&nbsp;&nbsp;</font>&nbsp;Todate:<font color="red"><%=todate%></font>  </td>
	</tr>
	<tr align=center>
	
	<td class=btext rowspan = 2 nowrap>Sl.No</td>
    <td class=btext rowspan = 2 nowrap>Mandal</td>
	<td class=btext rowspan = 2 nowrap>Panchayat</td>
	<td class=btext rowspan = 2 nowrap>Village</td>
	<td class=btext  rowspan = 2 nowrap>HabitationName/Code</td>
	<td class=btext  rowspan = 2 nowrap>Openwell </td>
    	<td class=btext  rowspan = 2 nowrap>Location</td>
		<td class=btext  rowspan = 2 nowrap>Date</td>
     	<td class=btext  rowspan = 2 nowrap><%=sname%></td>
	
	<td class=btext  rowspan = 2 nowrap>Remarks</td>
    <td class=btext  rowspan = 2 nowrap>Depth<br>( In Metres )</td>
	</tr>
	<tr>
<%
try
{
    Statement	stmt9=conn.createStatement();
    
	

	 if(attend.equals("1"))
	{
		 
		 gqry="select habitation_code,hp_code,to_char(date_of_completion,'dd/mm/yyyy'),decode(deepen_flush,'F','FlUSHING','D','DEEPENING','B','Both'),nvl(a.remarks,'-'),b.panch_name,nvl(depth,'0'),mname,pname,vname,substr(hp_code,20,2) from RWS_DROUGHT_FLUSH_DEEPEN_TBL  a,rws_complete_hab_view b where a.habitation_code=b.panch_code and substr(habitation_code,1,2)='"+dcode+"' and deepen_flush='F'  and substr(hp_code,20,2)='OW' and date_of_completion >=to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy')";
	//gqry="select habitation_code,hp_code,to_char(date_of_completion,'dd/mm/yyyy'),decode(deepen_flush,'F','FlUSHING','D','DEEPENING','B','Both'),nvl(a.remarks,'-'),b.panch_name,nvl(depth,'0'),mname,pname,vname,substr(hp_code,20,2) from RWS_DROUGHT_FLUSH_DEEPEN_TBL  a,rws_complete_hab_view b where a.habitation_code=b.panch_code and substr(habitation_code,1,2)='"+dcode+"' and deepen_flush='F'  and date_of_completion >=to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy')   ";	
	}
	else if(attend.equals("2"))
	{
		 gqry="select habitation_code,hp_code,to_char(date_of_completion,'dd/mm/yyyy'),decode(deepen_flush,'F','FlUSHING','D','DEEPENING','B','Both'),nvl(a.remarks,'-'),b.panch_name,nvl(depth,'0'),mname,pname,vname,substr(hp_code,20,2) from RWS_DROUGHT_FLUSH_DEEPEN_TBL  a,rws_complete_hab_view b where a.habitation_code=b.panch_code and substr(habitation_code,1,2)='"+dcode+"' and deepen_flush='D'  and substr(hp_code,20,2)='OW' and date_of_completion >=to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy')";
		//gqry="select habitation_code,hp_code,to_char(date_of_completion,'dd/mm/yyyy'),decode(deepen_flush,'F','FlUSHING','D','DEEPENING','B','Both'),nvl(a.remarks,'-'),b.panch_name,nvl(depth,'0'),mname,pname,vname,substr(hp_code,20,2) from RWS_DROUGHT_FLUSH_DEEPEN_TBL  a,rws_complete_hab_view b where a.habitation_code=b.panch_code and substr(habitation_code,1,2)='"+dcode+"' and deepen_flush='D' and date_of_completion >=to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy')   ";	
	}
//	System.out.println("gqry********"+gqry); 
	
	
	   
	
	
	
	Statement	stmt8=conn.createStatement();
    
	ResultSet rs8=stmt8.executeQuery(gqry);
    

	while (rs8.next())
	{
		j++;
    hp=rs8.getString(11);
    if(hp.equals("HP"));
    {
     qryhp="select nvl(b.location,'-') from rws_hp_subcomp_param_tbl a,rws_asset_mast_tbl b  where a.asset_code=b.asset_code and hp_code='"+rs8.getString(2)+"'";

    }
    if(hp.equals("SO"))
   {
  qryhp="select nvl(b.location,'-') from rws_source_tbl a,rws_asset_mast_tbl b  where a.asset_code=b.asset_code and source_code='"+rs8.getString(2)+"'";
   }
     if(hp.equals("OW"))
   {
  qryhp="select nvl(b.location,'-') from rws_open_well_mast_tbl a,rws_asset_mast_tbl b  where a.asset_code=b.asset_code and openwell_code='"+rs8.getString(2)+"'";
   }
    ResultSet rs9=stmt9.executeQuery(qryhp);
   // System.out.println("hp*******"+hp);
    while(rs9.next())
    {
    loc=rs9.getString(1);
    }
	
	%>
	<tr>
	
	
    <td class="rptValue"><%=sno++%></td>
	<td class="rptValue"><%=rs8.getString(8)%></td>
    <td class="rptValue"><%=rs8.getString(9)%></td> 
	<td class="rptValue"><%=rs8.getString(10)%></td>
	<td class="rptValue"><%=rs8.getString(1)%>/<br><%=rs8.getString(6)%></td>
	
	<td class="rptValue"><%=rs8.getString(2)%></td>
    <td class="rptValue"><%=loc%></td>
	<td class="rptValue"><%=rs8.getString(3)%></td>
	<td class="rptValue"><%=rs8.getString(4)%></td>
	<td class="rptValue"><%=rs8.getString(5)%></td>
	<td class="rptValue"><%=rs8.getString(7)%></td>
	
	</tr>
	
<%

	}
	
	if(j==0)
	{%>
	<tr>
	<td colspan=7 align="center">No Records</td>
	</tr>
	
	<%
		
		}
	
}catch(Exception e)
		{
		e.printStackTrace();
		}
		%>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>
</p>

  
