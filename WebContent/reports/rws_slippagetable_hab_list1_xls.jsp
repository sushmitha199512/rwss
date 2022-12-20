<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%

String dcode=(String)session.getAttribute("dcode");
	
String mandal=(String)session.getAttribute("mandal");

String dname=(String)
session.getAttribute("dname");

String mname=(String)
session.getAttribute("mname");

String fyear=(String)
session.getAttribute("fyear");

String tyear=(String)
session.getAttribute("tyear");
String hcode="",qry="";
String dis_qry="",cov_query="",qry1="",qry2="",qry3="",qry4="",qry2010="",qry2009="",qry2008="",qry2007="",qry_check="",qry5="",qry_insert="",query="",sel_qry="";
String ruery="";
String a2010="",a2009="",a2008="",a2007="",a2011="";
WorksData1 wd = new WorksData1();
int cur_year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
int cur_year=cur_year1;
int fyear1=Integer.parseInt(fyear);
int tyear1=Integer.parseInt(tyear);
Statement dis_stmt=null,sel_stmt=null,up_stmt=null,cov_stmt=null,stmtt=null,stmt_insert=null,stmt_tbl_drop=null,stmt_check=null,stmt_tbl=null,stmt2=null,stmt3=null,stmt11=null,stmt10=null,stmt09=null,stmt08=null,stmt07=null;
ResultSet dis_rs=null,sel_rs=null,cov_rs=null,rss=null,rs_check=null,rs2=null,rs3=null,rs11=null,rs10=null,rs09=null,rs08=null,rs07=null,rs_insert=null;
ResultSetMetaData md;

String cstatus="",curr_status="",prev_status="",panch_code="",panch_name="",stat_dt1="",stat_dt2="",stat_tbl="",cov_status="";
%>

<form>
<center>


<p align="center"><font face=verdana size=2><b>Status Of Habitations From: <%=fyear%>&nbsp;To: <%=cur_year1%></b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%></font>&nbsp; 
&nbsp; </p>
<p align="center">
<%
 try
{
	   qry2 = "select distinct to_char(STATUS_date,'dd-MON-yyyy') from rws_habitation_directory_tbl where coverage_status<>'FC'";
	   stmt2=conn.createStatement();
	   rs2=stmt2.executeQuery(qry2);
	   while(rs2.next())
		{
	      stat_dt1=rs2.getString(1);
	     //System.out.println("....stat_dt1........."+qry2+stat_dt1);
		}
}
catch(SQLException e)
{
System.out.println(" RWS_HABITATION_directory_tBL  Exception: \n" + e);
}
finally
 {
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

try
{
	qry3 = "select distinct to_char(STATUS_date,'dd-MON-yyyy') from RWS_HABITATION_dir_his_TBL where coverage_status<>'FC'";
	   stmt3=conn.createStatement();
	   rs3=stmt3.executeQuery(qry3);
	  while(rs3.next())
		{
	      stat_dt2=rs3.getString(1);
	     //System.out.println("....stat_dt2........."+qry3+stat_dt2);
		}
  }
catch(SQLException e)
{
System.out.println(" RWS_HABITATION_dir_his_TBL  Exception: \n" + e);
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

   String start_dt=stat_dt2.substring(7,11);
   String stat_qry="";
   String tbl_check="";
   String up_qry="";
   int start=Integer.parseInt(start_dt);  
   int qrylen=0,statlen=0;
   String finalstr="",finalstatus="";
   //System.out.println("....start date........"+start_dt+start);
 
try
{
   dis_qry="select * from rws_slippage_temp_status_tbl";
   dis_stmt=conn.createStatement(); 
   dis_rs=dis_stmt.executeQuery(dis_qry);
   
	md = dis_rs.getMetaData();
	int count = md.getColumnCount();
    int row=1;
    String dis_value="";
    boolean flag=false;
    %>
    <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
	
		<tr>
		    <th>SLNO</th>
		   <%
			for (int p=1; p<=count; p++)
		    {
		   %>
			<th><%=md.getColumnName(p)%>
			<%
		    }
		    %>
			</tr>
	  

      <%  while(dis_rs.next())
       {
         //  System.out.println( "result set value......."+dis_rs.getString(3));
           
           if(dis_rs.getString(3)==null || dis_rs.getString(3).equals(""))//rs check for null
                      {
                           
                      }
           else//rs check for value
                     { 
                         //start for pc4
                         if(dis_rs.getString(3).equals("PC4"))
                            {
                                //start of pc4
                              for(int i=4;i<=count;i++)
                                 { 
                                   if(dis_rs.getString(i)==null || dis_rs.getString(i).equals(""))//check for null 
                                   {}
                                   else
                                    {
                                     if(dis_rs.getString(i).equals("FC")) 
		                             {
                                        flag=true;
                                     }
                                     else
                                       flag=false;
                                    }
                                 }//inner for
                               if(flag==true)
                                 {
                                    %>
		                              <tr>
	                                      <td class=rptvalue ><%=row++%></td><%
	                                      for(int n=1; n<=count; n++)
	                                      {      
	                                      dis_value=dis_rs.getString(n);
		                
	                                          if(dis_value==null || dis_value.equals(""))
	                                                 {
	                                                dis_value="-";
	                                                  }
	                                          else
	                                            {                                                                  
	                                           dis_value=dis_rs.getString(n);
	                                            }
	        
			                                  %>
						                    <td class=rptvalue nowrap>&nbsp;<%=dis_value%></td>
			                                  <% 
			     	                         }
	                                          %>
			                        </tr>
		                            <%  
                              }//end of flag check                                  
                             }//PC4 END

                     //start for pc3
                       else if(dis_rs.getString(3).equals("PC3"))
                            {
                               for(int i=4;i<=count;i++)
                                 { 
                                   if(dis_rs.getString(i)==null || dis_rs.getString(i).equals(""))//check for null 
                                   {}
                                   else
                                    {
                                     if(dis_rs.getString(i).equals("FC")||dis_rs.getString(i).equals("PC4")) 
		                             {
                                        flag=true;
                                     }
                                     else
                                       flag=false;
                                    }
                                 }//inner for
                               if(flag==true)
                                 {
                                    %>
		                              <tr>
	                                      <td class=rptvalue ><%=row++%></td><%
	                                      for(int n=1; n<=count; n++)
	                                      {      
	                                      dis_value=dis_rs.getString(n);
		                
	                                          if(dis_value==null || dis_value.equals(""))
	                                                 {
	                                                dis_value="-";
	                                                  }
	                                          else
	                                            {                                                                  
	                                           dis_value=dis_rs.getString(n);
	                                            }
	        
			                                  %>
						                    <td class=rptvalue nowrap>&nbsp;<%=dis_value%></td>
			                                  <% 
			     	                         }
	                                          %>
			                        </tr>
		                            <%  
                              }//end of flag check                                  
                             }//PC3 END

                      //start for pc2
                      else if(dis_rs.getString(3).equals("PC2"))
                            {
                               for(int i=4;i<=count;i++)
                                 { 
                                   if(dis_rs.getString(i)==null || dis_rs.getString(i).equals(""))//check for null 
                                   {}
                                   else
                                    {
                                     if(dis_rs.getString(i).equals("FC")||dis_rs.getString(i).equals("PC4")||dis_rs.getString(i).equals("PC3")) 
		                             {
                                        flag=true;
                                     }
                                     else
                                       flag=false;
                                    }
                                 }//inner for
                               if(flag==true)
                                 {
                                    %>
		                              <tr>
	                                      <td class=rptvalue ><%=row++%></td><%
	                                      for(int n=1; n<=count; n++)
	                                      {      
	                                      dis_value=dis_rs.getString(n);
		                
	                                          if(dis_value==null || dis_value.equals(""))
	                                                 {
	                                                dis_value="-";
	                                                  }
	                                          else
	                                            {                                                                  
	                                           dis_value=dis_rs.getString(n);
	                                            }
	        
			                                  %>
						                    <td class=rptvalue nowrap>&nbsp;<%=dis_value%></td>
			                                  <% 
			     	                         }
	                                          %>
			                        </tr>
		                            <%  
                              }//end of flag check                                  
                             }//PC2 END

                      //start for pc1
                     else if(dis_rs.getString(3).equals("PC1"))
                            {
                               for(int i=4;i<=count;i++)
                                 { 
                                   if(dis_rs.getString(i)==null || dis_rs.getString(i).equals(""))//check for null 
                                   {}
                                   else
                                    {
                                     if(dis_rs.getString(i).equals("FC")||dis_rs.getString(i).equals("PC4")||dis_rs.getString(i).equals("PC3")||dis_rs.getString(i).equals("PC2")) 
		                             {
                                        flag=true;
                                     }
                                      else
                                      flag=false;
                                    }
                                 }//inner for
                                 if(flag==true)
                                 {
                                    %>
		                              <tr>
	                                      <td class=rptvalue ><%=row++%></td><%
	                                      for(int n=1; n<=count; n++)
	                                      {      
	                                      dis_value=dis_rs.getString(n);
		                
	                                          if(dis_value==null || dis_value.equals(""))
	                                                 {
	                                                dis_value="-";
	                                                  }
	                                          else
	                                            {                                                                  
	                                           dis_value=dis_rs.getString(n);
	                                            }
	        
			                                  %>
						                    <td class=rptvalue nowrap>&nbsp;<%=dis_value%></td>
			                                  <% 
			     	                         }
	                                          %>
			                        </tr>
		                            <%  
                              }//end of flag check                                  
                             }//PC1 END

                  //start for NC
                     else if(dis_rs.getString(3).equals("NC"))
                            {
                               for(int i=4;i<=count;i++)
                                 { 
                                   if(dis_rs.getString(i)==null || dis_rs.getString(i).equals(""))//check for null 
                                   {}
                                   else
                                    {
                                     if(dis_rs.getString(i).equals("FC")||dis_rs.getString(i).equals("PC4")||dis_rs.getString(i).equals("PC3")||dis_rs.getString(i).equals("PC2")||dis_rs.getString(i).equals("PC1")) 
		                             {
                                        flag=true;
                                     }
                                      else
                                      flag=false;
                                    }
                                 }//inner for
                                 if(flag==true)
                                 {
                                    %>
		                              <tr>
	                                      <td class=rptvalue ><%=row++%></td><%
	                                      for(int n=1; n<=count; n++)
	                                      {      
	                                      dis_value=dis_rs.getString(n);
		                
	                                          if(dis_value==null || dis_value.equals(""))
	                                                 {
	                                                dis_value="-";
	                                                  }
	                                          else
	                                            {                                                                  
	                                           dis_value=dis_rs.getString(n);
	                                            }
	        
			                                  %>
						                    <td class=rptvalue nowrap>&nbsp;<%=dis_value%></td>
			                                  <% 
			     	                         }
	                                          %>
			                        </tr>
		                            <%  
                              }//end of flag check                                  
                             }//NC END

                     //start for NSS
                     else if(dis_rs.getString(3).equals("NSS"))
                            {
                               for(int i=4;i<=count;i++)
                                 { 
                                   if(dis_rs.getString(i)==null || dis_rs.getString(i).equals(""))//check for null 
                                   {}
                                   else
                                    {
                                     if(dis_rs.getString(i).equals("FC")||dis_rs.getString(i).equals("PC4")||dis_rs.getString(i).equals("PC3")||dis_rs.getString(i).equals("PC2")||dis_rs.getString(i).equals("PC1")||dis_rs.getString(i).equals("NC")) 
		                             {
                                        flag=true;
                                     }
                                      else
                                      flag=false;
                                    }
                                 }//inner for
                                 if(flag==true)
                                 {
                                    %>
		                              <tr>
	                                      <td class=rptvalue ><%=row++%></td><%
	                                      for(int n=1; n<=count; n++)
	                                      {      
	                                      dis_value=dis_rs.getString(n);
		                
	                                          if(dis_value==null || dis_value.equals(""))
	                                                 {
	                                                dis_value="-";
	                                                  }
	                                          else
	                                            {                                                                  
	                                           dis_value=dis_rs.getString(n);
	                                            }
	        
			                                  %>
						                    <td class=rptvalue nowrap>&nbsp;<%=dis_value%></td>
			                                  <% 
			     	                         }
	                                          %>
			                        </tr>
		                            <%  
                              }//end of flag check                                  
                             }//NSS END
                        else{}

















                         }  //ELSE CONDITION
                   // }// MAIN FOR         
      }//WHILE END
%>
	 
</table>
<%   
}
catch(SQLException e)
{
e.printStackTrace();
}
finally
{
try{
}
catch(Exception e1)
{
 e1.printStackTrace();
}
}

%>
</center>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>



