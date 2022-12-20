<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%	
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	Statement st1=null,st2=null;
	ResultSet rs1 = null,rs2 = null;

	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,qu=null, a1="",codename=null,mand=null,mname=null,dist=null,dname=null,panch=null,pname=null,vill=null,vname=null,habcode=null,hname=null,code=null,sourcecode=null;
     
	 code=request.getParameter("code");
	 dist=request.getParameter("dcode");
	 mand=request.getParameter("mcode");
	 panch=request.getParameter("pcode");
	 habcode=request.getParameter("hcode");
	%>
<html>
<title> WaterSoft </title>
<head>

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}


</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
				<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><a href="javascript:history.back(-1)">Back|</a><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:history.back(-1)" >Back</td></tr>
<%} %>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan=10 >
			<font color="ffffff">Status Report </font></td>
	</tr>
	<tr>
	 <% if(code.equals("Assets"))
	 {
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>AssetName-HP Code/SchemeCode</td>
        <td class="btext" align=center>Location</td>
		<td class="btext" align=center>Asset Status</td>
		<td class="btext" align=center>Date Of Creation</td>
		<td class="btext" align=center>Cost Of Asset<br>(Rs In Lakhs)</td>
	
	</tr>
     <%
	 }
	else if(code.equals("Works"))
	{
		//// System.out.println(" in works count");
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Work Name</td>
		<td class="btext" align=center>Programme Name</td>
		<td class="btext" align=center>SubProgramme Name</td>
		<td class="btext" align=center>Asset Name</td>
		<td class="btext" align=center>Work Category</td>
		</tr>
   
     <%
	 }
	 else if(code.equals("school"))
	 {%>
		 <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>School Name</td>
      	<td class="btext" align=center>Type of School</td>
		<td class="btext" align=center>Linked To Asset/Work</td>
		
	</tr>


	 <%}else if(code.equals("source"))
	 {%>
			
		<td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>SourceCode-Source Name</td>
		<td class="btext" align=center>Source Location</td>
		<td class="btext" align=center>Water Quality</td>
	 <%}

try
{

st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


if(code.equals("Assets"))
	{
		qu="select distinct b.asset_name,b.location,decode(b.asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),to_char(b.date_creation,'DD-MON-YYYY'),b.asset_cost,a.type_of_asset_code,b.asset_code,s.scheme_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code and d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+dist+"' and substr(d.panch_code,6,2)='"+mand+"' and substr(d.panch_code,13,2)='"+panch+"' and substr(d.panch_code,1,16)='"+habcode+"' and b.type_of_asset_code=a.type_of_asset_code";
	}
	/*else if(code.equals("Assets1"))
	{
		qu="select distinct b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a, rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where b.hab_code=h.hab_code and b.asset_code=s.asset_code and substr (b.hab_code,1,16)='"+habcode+"'  and b.type_of_asset_code=a.type_of_asset_code";
	}*/
	else if(code.equals("Works"))
	{
		qu="select distinct  w.work_id,w.work_name,p.programme_name,sp.subprogramme_name,t.TYPE_OF_ASSET_NAME,decode(w.category_code,'1','Projects','2','Normal','3','District Level','','-'),w.type_of_asset from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_asset_type_tbl t  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and w.work_id=a.work_id and p.programme_code=w.programme_code and sp.programme_code=w.programme_code and sp.subprogramme_code=w.subprogramme_code and w.TYPE_OF_ASSET=t.TYPE_OF_ASSET_CODE and substr(pr.panch_code,1,2)='"+dist+"' and  substr(pr.panch_code,6,2)='"+mand+"' and substr(pr.panch_code,13,2)='"+panch+"' and w.lead_habitation='"+habcode+"'";
	}
else if(code.equals("school"))
	{
       qu="select distinct school_name,school_classification,school_code from rws_school_master_tbl s, rws_complete_hab_view v where s.hab_code=v.panch_code and substr(v.panch_code,1,2)='"+dist+"' and  substr(v.panch_code,6,2)='"+mand+"' and substr(v.panch_code,13,2)='"+panch+"' and substr(v.panch_code,1,16)='"+habcode+"'";
	  
	}
	else if(code.equals("source"))
	{
       qu="select  source_code,nvl(source_name,'-'),nvl(location,'-'),decode(water_quality,'SS','Safe Source','NSS','Not SafeSource','','-') from rws_source_tbl s, rws_complete_hab_view v where s.hab_code=v.panch_code and substr(v.panch_code,1,2)='"+dist+"' and  substr(v.panch_code,6,2)='"+mand+"' and substr(v.panch_code,13,2)='"+panch+"' and substr(v.panch_code,1,16)='"+habcode+"'";
	}
	// System.out.println("qu:"+qu);
	 rs1=st1.executeQuery(qu);
	 int slno=0,total=0;
	while(rs1.next())
	{
	
	if(code.equals("Assets"))
	 {
		
	%>  <TR>
		<td class=rptValue align="left"><%=++slno%></td>
        <td class=rptValue align="left"><%=rs1.getString(1)%><%="-"+rs1.getString(8)%></td>
		<% if(rs1.getString(2)!=null)
		 {
		%>
		<td class=rptValue align="left"><%=rs1.getString(2)%></td>
		<%}else{%>

         <td class=rptValue align="left"><%="-"%></td>
		 <%}
		 if(rs1.getString(3)!=null)
		 {
		%>
		<td class=rptValue align="left"><%=rs1.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align="left"><%="-"%></td>
		 <%}
		 if(rs1.getString(4)!=null)
		 {
		%>
		<td class=rptValue align="left"><%=rs1.getString(4)%></td>
		<%} else{%>

         <td class=rptValue align="left"><%="-"%></td>
		 <%}
		 if(rs1.getString(5)!=null)
		 {
		%>
		<td class=rptValue align="right"><%=rs1.getString(5)%></td>
		<%}
		else{%>

         <td class=rptValue align="left"><%="-"%></td>
		 <%}%>
		
		</TR>
<%
	 }
		/*else  if(code.equals("Assets1"))
		{
			String qry="select  count(*) from rws_asset_hab_tbl where asset_code='"+rs1.getString(1)+"' ";
			//String qry="select distinct b.asset_name,b.location,decode(b.asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),to_char(b.date_creation,'DD-MON-YYYY'),b.asset_cost,b.asset_code from rws_asset_mast_tbl b,rws_asset_hab_tbl c where b.asset_code=c.asset_code and b.asset_code='"+rs1.getString(1)+"' ";
			String acode="";
             stmt=conn.createStatement();
			 // System.out.println(qry);
			 rs=stmt.executeQuery(qry);
			 int count=0;
			 while(rs.next())
			{
				 count+=rs.getInt(1)-1;
				 // System.out.println("count:"+count);
				 if(count>0)
				 {
					acode=rs1.getString(1);  
				 }
               String qry1="select distinct asset_name,location,decode(asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),to_char(date_creation,'DD-MON-YYYY'),asset_cost,asset_code from rws_asset_mast_tbl   where asset_code='"+acode+"' ";
					// System.out.println("acode:"+acode);
			}

		}*/
else if(code.equals("Works"))
	 {
	%>      <TR>
		<td class=rptValue align="left"><%=++slno%></td>
        <td class=rptValue align="left"><a href="./rws_wrk_progress_resource_out_rpt.jsp?work_id=<%=rs1.getString(1)%>&dcode=<%=dist%>&scheme=<%=rs1.getString(7)%>"><%=rs1.getString(2)%><%="-"+rs1.getString(1)%></a>
		</td>
		<td class=rptValue align="left"><%=rs1.getString(3)%></td>
		<td class=rptValue align="left"><%=rs1.getString(4)%></TD>
		<td class=rptValue align="left"><%=rs1.getString(5)%></TD>
		<td class=rptValue align="left"><%=rs1.getString(6)%></TD>
	</TR>
<%
	 } 

else if (code.equals("school"))
		{%>
		<tr>
		<td class=rptValue align="left"><%=++slno%></td>
		<td class=rptValue align="left"><%=rs1.getString(1)%></td>
		<td class=rptValue align="left"><%=rs1.getString(2)%></td>
		<%
		String qry="select (select  distinct asset_name from rws_asset_mast_tbl a,rws_school_asset_lnk_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and a.hab_code='"+habcode+"' and b.school_code='"+rs1.getString(3)+"' )a,(select  distinct work_name from rws_work_admn_tbl a,rws_school_asset_lnk_tbl b where a.work_id=b.asset_code and  b.hab_code='"+habcode+"' and b.school_code='"+rs1.getString(3)+"')b from dual";
        st2=conn.createStatement();
		//// System.out.println("qry:"+qry);
		rs2=st2.executeQuery(qry);
		if(rs2.next())
		{
			if(rs2.getString(1)!=null && !rs2.getString(1).equals("") && !rs2.getString(1).equals("0"))
			{
			%>
		   
               <td class=rptValue align="right"><font color="blue"><%=rs2.getString(1)%></font></td>

		<%}else if(rs2.getString(2)!=null && !rs2.getString(2).equals("") && !rs2.getString(2).equals("0")) {%>
		            <td class=rptValue align="left"><%=rs2.getString(2)%></td>
		<%}	else {%>
			 <td class=rptValue align="left" >-</td>
		<%}
		}
		if(rs2!=null) rs2.close();
     %>

         </tr>
		<%}
		else if (code.equals("source"))
		{%>
		<tr>
		<td class=rptValue align="left"><%=++slno%></td>
		<%if(rs1.getString(1)!=null && !rs1.getString(1).equals(""))%>
		<td class=rptValue align="left"><%=rs1.getString(1)%>-<%=rs1.getString(2)%></td>
		<td class=rptValue align="left"><%=rs1.getString(3)%></td>
		<td class=rptValue align="right""><%=rs1.getString(4)%></td>
		
		</tr>
		<%}

	 } %>
	
<% }
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
<%if(code.equals("school")) {%>
<table broder="0" align="center" width="50%">
	   <tr >
	   <td class=btext >Note: Linked To Assets/Works: </td> 
	   </tr>
	   <tr>
	   <td class=rptValue>
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  A. Assets are displayed with Blue Color.
	  </td></tr>
	  <tr><td class=rptValue>
  	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  B. Works are displayed with Black Color.
	   </td></tr>
	   </table>
	   <%}%>

<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

