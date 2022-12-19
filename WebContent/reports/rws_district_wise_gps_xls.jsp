<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%

String dcode=(String)session.getAttribute("dcode");
	

String dname=(String)session.getAttribute("dname");

String mcode=(String)session.getAttribute("mandal");
	

String mname1=(String)session.getAttribute("mname1");


String qry="",qry2="",qry3="",qry4="",qry5="";
Statement stmt=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs=null,rs2=null,rs3=null,rs4=null,rs5=null;
String mname="",habstatus="",hcode="",cpwslist="",pwslist="",mpwslist="",dplist="",schemetype="";
int covstatus=0;

%>
<center>
<p align="center"><font face=verdana size=2><b>District Wise 100% GP's Report</b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%>(Based on Coverage Status)</font>&nbsp; 
&nbsp; </p>
<table>
<tr><td width="5%" bgcolor="green" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Fully Covered - GP's are Fully Covered if all the habitations in the GP covered with any one of the schemes[CPWS/PWS/MPWS/DP]</td></tr>
<tr><td width="5%" bgcolor="orange" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Not Fully Covered- GP's are partially covered if any one habitation is not covered even with a single schemes </td></tr>
</table>

<p align="center">
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext width=20><b>S.No</b></td>
<td class=btext ><b>Mandal Name</b></td>
<td class=btext><b>GP Name</b></td>
<td class=btext><b>Habitation Name</b></td>
<td class=btext><b>Habitation Code</b></td>
<td class=btext><b>Type Of Asset</b></td>

</tr>
<%
  int count=0;
  
  int flag=1,flag2=1;

 try
{
   stmt=conn.createStatement();
   stmt2=conn.createStatement();
   stmt3=conn.createStatement();
   stmt4=conn.createStatement();
   stmt5=conn.createStatement();
   boolean fg=false;
	qry2="select pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+mcode+"' order by pname";
	rs2=stmt2.executeQuery(qry2);
    while(rs2.next())
	 {
         flag=1;
		 count=count+1;
	System.out.println("panchayatname:"+rs2.getString(1)+"Code:"+ rs2.getString(2));
       qry3="select distinct c.hab_code,b.panch_name,COVERAGE_STATUS from rws_asset_hab_tbl a,rws_panchayat_raj_tbl b,rws_habitation_directory_tbl c where c.coverage_status<>'UI' and c.coverage_status is not null and c.hab_code=b.panch_code and  substr(c.hab_code,1,2)='"+dcode+"' and substr(c.hab_code,6,2)='"+mcode+"' and substr(c.hab_code,13,2)='"+rs2.getString(1)+"'";
	   rs3=stmt3.executeQuery(qry3);
	   //System.out.println(" habcode  qry"+qry3);
       while(rs3.next())
	    {
		   flag2=1;
        
%>
     <tr>

<%   if(flag==1) { flag=0; %>
	   	<td class=rptvalue><%=count %></td>
      	<td class=rptvalue nowrap><%=mname1 %></td>
		<td class=rptvalue nowrap><%=rs2.getString(2)%></td>

<%  } else {   %>

<td class=rptvalue></td>
      	<td class=rptvalue nowrap>''</td>
		<td class=rptvalue nowrap>''</td>
       
<%  } %>

 <td class=rptvalue nowrap><%=rs3.getString(2)%></td>
		<td class=rptvalue nowrap>&nbsp;<%=rs3.getString(1)%></td>

<%
          qry4="select distinct b.TYPE_OF_ASSET_NAME from rws_asset_mast_tbl A,RWS_ASSET_TYPE_TBL B,rws_habitation_directory_tbl c where b.type_of_asset_code not in ('10','11','12','06','07','08','04','05') and substr(a.asset_code,7,2)=b.TYPE_OF_ASSET_CODE AND a.hab_code=c.hab_code and a.hab_code='"+rs3.getString(1)+"'";
		  rs4=stmt4.executeQuery(qry4);
          //System.out.println(" asset  qry"+qry4);
		  mname=rs2.getString(2);
          boolean f=false;
          while(rs4.next())
			{    f=true;
			     schemetype=rs4.getString(1);
                 System.out.println("St"+ schemetype);
               	if(flag2==0)
				{  %>
				<tr>
				<td></td><td>''</td><td>''</td><td>''</td><td>''</td>
				
				<%} %>
               	
				<td class=rptvalue nowrap><%=schemetype%></td>
                </tr>
				
<% 	
				flag2=0;
                schemetype="";
		   }
if(!f)
{ 
 schemetype="-";
fg=true;
%>
   
<td class=rptvalue nowrap><%=schemetype%></td>
</tr>     
 <% }
 }

	if(fg)
			{
		%>
		<tr><td></td><td class=btext><b>Panchayat - <%= mname%>&nbsp;&nbsp;</b></td>

		<td class=rptvalue nowrap colspan=4 align=center bgcolor=orange ><font color="white"><b>Not Fully Covered</b></td></tr>
		<%	

			}else {  %>
        

		<tr><td></td><td class=btext><b><%= mname%>&nbsp;&nbsp;Coverage Status</b></td>

		<td class=rptvalue nowrap colspan=4 align=center bgcolor=green><font color="white"><b>Fully Covered</b></td></tr>


			<% }
	fg=false;

}
  
 
}
catch(SQLException e)
{
System.out.println(" RWS_HABITATION_directory_tBL  Exception: \n" + e);
}
finally
 {
   if(rs4 != null)
	{
		try
		{
		rs4.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt4 != null)
	{
		try
		{
		stmt4.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }



    if(rs3 != null)
	{
		try
		{
		rs3.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt3 != null)
	{
		try
		{
		stmt3.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }



	if(rs2 != null)
	{
		try
		{
		rs2.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt2 != null)
	{
		try
		{
		stmt2.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }
	if(rs != null)
	{
		try
		{
		rs.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt != null)
	{
		try
		{
		stmt.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }
 }

%>
</center>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

