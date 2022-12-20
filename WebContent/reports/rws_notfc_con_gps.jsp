<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String dcode=request.getParameter("dcode");
if(dcode!=null)
{
session.setAttribute("dcode",dcode);
}
String dname=(String)session.getAttribute("dname");



String qry="",qry2="",qry3="",qry4="",qry5="";
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null;
String mname="",habstatus="",hcode="",cpwslist="",pwslist="",mpwslist="",dplist="",schemetype="",scheme="";
int covstatus=0;
 %>
<table align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptHeading>Not Fully Covered GP's Under District:<%=dname%><br>
(Based on Existing Assets)</td></tr></table><BR>


<table bgcolor="#FFFFFF"  width="70%" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">

<tr align=center>  
<td class=btext>SNO</td>
<td class=btext>Mandal Name</td>
<td class=btext>Panchayat Name</td>
</tr>
<%
  int count=1,incount=1;
  int pcount=0,fcount=0,nfcount=0;
  
  int flag=1,flag2=1;
  int fcsum=0,nfcsum=0,psum=0;
  int habcount=0,schemecount=0;
 try
{
   stmt=conn.createStatement();
   stmt2=conn.createStatement();
   stmt3=conn.createStatement();
   stmt4=conn.createStatement();
   stmt5=conn.createStatement();
   boolean fg=false;
   boolean res=false;

   qry="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
   rs=stmt.executeQuery(qry);
    while(rs.next())
	 {   nfcount=0;fcount=0;
		 
         qry2="select count(pcode) from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs.getString(1)+"' order by pcode";
		 rs2=stmt2.executeQuery(qry2);
	     while(rs2.next())
		 {
            pcount=rs2.getInt(1);
         }
           psum+=pcount;
          //System.out.println("Mandal name"+rs.getString(2));
         %>
           <tr>
                <td class=rptvalue><%=count++%></td>
                <td class=rptvalue><%=rs.getString(2)%></td>
            <%
         qry5="select distinct pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs.getString(1)+"' order by pcode";      
         rs5=stmt5.executeQuery(qry5); 
         while(rs5.next())
          {
            qry3="select distinct c.hab_code from rws_panchayat_raj_tbl b,rws_habitation_directory_tbl c where c.coverage_status<>'UI' and c.coverage_status is not null and c.hab_code=b.panch_code and  substr(c.hab_code,1,2)='"+dcode+"' and substr(c.hab_code,6,2)='"+rs.getString(1)+"' and substr(c.hab_code,13,2)='"+rs5.getString(1)+"'";
		    rs3=stmt3.executeQuery(qry3);
		    while(rs3.next())
	        {   
                qry4="select distinct b.TYPE_OF_ASSET_NAME from rws_asset_mast_tbl A,RWS_ASSET_TYPE_TBL B,rws_habitation_directory_tbl c where b.type_of_asset_code not in ('10','11','12','06','07','08','04','05') and substr(a.asset_code,7,2)=b.TYPE_OF_ASSET_CODE AND a.hab_code=c.hab_code and a.hab_code='"+rs3.getString(1)+"'";
		        rs4=stmt4.executeQuery(qry4);
                 res=rs4.next();
				 if(!res){
                  fg=false;}
            }
				if(!fg)
				{
				nfcount++;
                //System.out.println("not fully count Panch name..."+rs5.getString(2));
                %>
                <tr class=rptvalue>
                <td></td>
                <td class=rptvalue align=right><%=incount++%>&nbsp;&nbsp;</td>
                <td class=rptvalue><%=rs5.getString(2)%></td>
                </tr>
                <%
				}else{
				fcount++;
                  //System.out.println("fully count Panch name..."+rs5.getString(2));  
				}
				fg=true;
                        
      }
   %></tr><%  
  }

}

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
}
%>