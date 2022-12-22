
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "conn.jsp" %>
<%

String dcode=(String)session.getAttribute("dcode");
	

String dname=(String)session.getAttribute("dname");

String mcode=(String)session.getAttribute("mandal");
	

String mname1=(String)session.getAttribute("mname1");


String qry="",qry2="",qry3="",qry4="",qry5="";
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null;
String mname="",habstatus="",hcode="",cpwslist="",pwslist="",mpwslist="",dplist="",schemetype="";
int covstatus=0;
%>
<center>
<p align="center"><font face=verdana size=2><b>GP's Consolidate Coverage Status Report</b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%>(Based on Coverage Status)</font>&nbsp; 
&nbsp; </p>

<p align="center">
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext width=20><b>S.No</b></td>
<td class=btext ><b>Mandal Name</b></td>
<td class=btext><b>No.of GP's</b></td>
<td class=btext><b>Fully Covered GP's</b></td>
<td class=btext><b>Not Fully Covered GP's</b></td>
</tr>
<%
  int ncount=0,count=1,fccount=0,nfcount=0,panch_count=0,fcount=0;
  boolean flag=false;
  int fcsum=0,nfcsum=0,psum=0;
 try
{
   stmt=conn.createStatement();
   stmt2=conn.createStatement();
   stmt3=conn.createStatement();
   stmt4=conn.createStatement();
   stmt5=conn.createStatement();
  
   qry="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
   rs=stmt.executeQuery(qry);
    while(rs.next())
	 {
       System.out.println(" mandal name....."+rs.getString(2));
       
       qry2="select distinct count(pcode) from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs.getString(1)+"'";
	   rs2=stmt2.executeQuery(qry2);
	       while(rs2.next())
		   {
	        panch_count=rs2.getInt(1);
	       }
        
       qry5="select distinct pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs.getString(1)+"'";      
       rs5=stmt5.executeQuery(qry5); 
         while(rs5.next())
          { 
            //System.out.println(" panchayat qry::"+qry5);
          //System.out.println(" panchayat name::"+rs5.getString(2));

	      qry3="select count(a.hab_code) from rws_habitation_directory_tbl a, rws_panchayat_raj_tbl b where a.hab_code=b.panch_code and a.coverage_status<>'UI' and a.coverage_status is not null and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+rs.getString(1)+"' and substr(a.hab_code,13,2)='"+rs5.getString(1)+"'" ;
	      //System.out.println(" not fc count::"+qry3);
           rs3=stmt3.executeQuery(qry3); 
           while(rs3.next())
            {
                nfcount=rs3.getInt(1);
            }
              
          //System.out.println(" hab count::"+nfcount);

          qry4="select count(a.hab_code) from rws_habitation_directory_tbl a, rws_panchayat_raj_tbl b where a.hab_code=b.panch_code and a.coverage_status<>'UI' and a.coverage_status is not null and coverage_status='FC'  and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+rs.getString(1)+"' and substr(a.hab_code,13,2)='"+rs5.getString(1)+"'";
          //System.out.println(" fc count ::"+qry4);
             rs4=stmt4.executeQuery(qry4); 
             while(rs4.next())
             {
                 fccount=rs4.getInt(1);
             }
             
            // System.out.println(" fc hab count::"+fccount);
           
            if(nfcount==fccount)
            {
              fcount+=1;
              System.out.println(" fc panch name ::"+rs5.getString(2));
            }
            //System.out.println(" fc panch count ::"+fcount);
            ncount=panch_count-fcount;
           // System.out.println(" not fc panch count ::"+(panch_count-fcount));
            
          }

       psum+=panch_count;
       fcsum+=fcount;
       nfcsum+=ncount;
 
 %> 

        <tr>
       
	   	<td class=rptvalue>&nbsp;<%=count++ %></td>      
		<td class=rptvalue nowrap><%=rs.getString(2)%></td>
		<td class=rptvalue nowrap><%=panch_count%></td>	
        <td class=rptvalue nowrap><%=fcount%></td>
		<td class=rptvalue nowrap><%=ncount%></td>	
        </tr>
        
<%

   fcount=0;
  // System.out.println("refresh fcout ::"+fcount);

 }
%>
        <tr><td class=btext colspan=2>Totals</td>
        <td class=btext><%=psum%></td>      
		<td class=btext nowrap><%=fcsum%></td>
		<td class=btext nowrap><%=nfcsum%></td>	
        </tr>

<%
 }

catch(SQLException e)
{
System.out.println(" RWS_HABITATION_directory_tBL  Exception: \n" + e);
}
finally
 {
    
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

