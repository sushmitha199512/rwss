<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%

String dcode=request.getParameter("district1");
if(dcode!=null)
{
session.setAttribute("dcode",dcode);
}
String dname=request.getParameter("dname1");
if(dname!=null)
{
session.setAttribute("dname",dname);
}
String mcode=request.getParameter("mandal");
if(mcode!=null)
{
session.setAttribute("mandal",mcode);
}
String mname1=request.getParameter("mname");
if(mname1!=null)
{
session.setAttribute("mname1",mname1);
}

String qry="",qry2="",qry3="",qry4="",qry5="";
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null;
String mname="",habstatus="",hcode="",cpwslist="",pwslist="",mpwslist="",dplist="",schemetype="";
int covstatus=0;
%>
<form>
<center>
<table width="90%">
<tr><td align=right><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<!-- <a href="./rws_district_wise_gps_status_xls.jsp" target="_new">Excel</a>-->
</tr>
</table>

<p align="center"><font face=verdana size=2><b>Panchayat Wise Partially Covered Habitations Report</b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;<br>
<font color="blue" face=verdana size=2><b>District&nbsp;&nbsp;:&nbsp;&nbsp;</b></font><font color="black" face=verdana size=2><%=dname%><br>
&nbsp; </p>
<table>
<tr><td width="5%" bgcolor="orange" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Not Fully Covered- GP's are partially covered if any one habitation is not having FC Coverage Status </td></tr>
</table>

<p align="center">
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext width=20><b>Panch Sl.No</b></td>
<td class=btext ><b>Mandal Name</b></td>
<td class=btext><b>GP Name</b></td>
<td class=btext><b>Habitation Name</b></td>
<td class=btext><b>Habitation Code</b></td>
<td class=btext><b>Coverage Status</b></td>

</tr>
<%
  int count=0,scount=0,scount1=0,count2=0;
  String stypes[]=new String[2000];
  int flag=1,flag2=1;
  boolean flagg=false;

 try
{
   stmt2=conn.createStatement();
   stmt3=conn.createStatement();
   stmt4=conn.createStatement();
  
   qry4="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
    //qry2="select a.mcode,b.mname,a.pcode,a.pname from rws_panchayat_tbl a,rws_mandal_tbl b where a.dcode='"+dcode+"' and a.dcode=b.dcode and a.mcode=b.mcode order by mname";
	rs4=stmt4.executeQuery(qry4);
    while(rs4.next())
	 { //System.out.println("..man.."+rs4.getString(2)); 
      
	qry2="select pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs4.getString(1)+"' order by pcode";
    //qry2="select a.mcode,b.mname,a.pcode,a.pname from rws_panchayat_tbl a,rws_mandal_tbl b where a.dcode='"+dcode+"' and a.dcode=b.dcode and a.mcode=b.mcode order by mname";
	rs2=stmt2.executeQuery(qry2);
    while(rs2.next())
	 {    count2=count2+1;
       //System.out.println(". pan..."+rs2.getString(2)); 
      // System.out.println("panch  qry"+qry2);
      // System.out.println(".........."); 
	  //System.out.println(".panch count.."+count2);
	   flag=1;
       
	   qry3="select distinct c.hab_code,b.panch_name,COVERAGE_STATUS from rws_panchayat_raj_tbl b,rws_habitation_directory_tbl c where c.coverage_status<>'UI' and c.coverage_status is not null  and  c.hab_code=b.panch_code and  substr(c.hab_code,1,2)='"+dcode+"' and substr(c.hab_code,6,2)='"+rs4.getString(1)+"' and substr(c.hab_code,13,2)='"+rs2.getString(1)+"'";
	   rs3=stmt3.executeQuery(qry3);
	   
         scount=0;
         scount1=0;   
         while(rs3.next())
	    {
         // System.out.println(" habcode  qry"+qry3);
          //System.out.println(".........."+count);
         // System.out.println(rs3.getString(2)); 
         // System.out.println(".........."); 
          
          scount+=1;
         // scount1+=1;
		  schemetype=rs3.getString(3);			 
		  mname=rs4.getString(2);
       
            stypes[scount]=schemetype;
		    //System.out.println(" ..stypes[scount]..."+stypes[scount]);
            if(stypes[scount].equals("FC"))
            {
             scount1++;
            }
            else
            {
		        %>     
		        <tr>
		       <%if(flag==1)
		        {   count=count+1;
		       %>
			   	<td class=rptvalue align="right"><%=count%></td>      
				<td class=rptvalue nowrap><%=rs4.getString(2) %></td>
				<td class=rptvalue nowrap><%=rs2.getString(2)%></td>	
		       <%
		        flag=0;
		         } 
		       else
		        {
		       %>  
		        <td class=rptvalue></td>      
				<td class=rptvalue nowrap>''</td>
				<td class=rptvalue nowrap>''</td>	
		       <%
		        }
		       %>
		        <td class=rptvalue nowrap><%=rs3.getString(2)%></td>
				<td class=rptvalue nowrap>&nbsp;<%=rs3.getString(1)%></td>
				<td class=rptvalue nowrap><%=schemetype%></td>
				</tr>
		        
		     <%
            }
           // System.out.println(" scount1..."+scount1);
     
            
   }
          // System.out.println(" scount..."+scount);

            

   }
}
%>
       <tr>
         <td></td>
           <td class=rptValue nowrap colspan=8 align=left bgcolor=orange ><b><font color="white"><b> &nbsp;&nbsp;<%=count%> out of <%=count2%> Not Fully Covered GP's</b></td>
        </tr>

<%}

catch(SQLException e)
{
System.out.println(" RWS_HABITATION_directory_tBL  Exception: \n" + e);
}
finally
 {
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
	
 }





%>
</center>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

