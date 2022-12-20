<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();


String dcode=request.getParameter("district1");
	if(dcode!=null){
	session.setAttribute("dcode",dcode);
	}
String dname=request.getParameter("dname1");
if(dname!=null){
session.setAttribute("dname",dname);
}

String fyear=request.getParameter("fy");
if(fyear!=null)
{
session.setAttribute("fyear",fyear);
}

String tyear=request.getParameter("ty");
if(tyear!=null)
{session.setAttribute("tyear",tyear);
}
String hcode="",qry="";
String del_qry="",dis_qry="",cov_query="",qry1="",qry2="",qry3="",qry4="",qry2010="",qry2009="",qry2008="",qry2007="",qry_check="",qry5="",qry_insert="",query="",sel_qry="";
String ruery="";
String a2010="",a2009="",a2008="",a2007="",a2011="";
WorksData1 wd = new WorksData1();
int cur_year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
int cur_year=cur_year1;
int fyear1=Integer.parseInt(fyear);
int tyear1=Integer.parseInt(tyear);
//System.out.println("start year"+fyear1);
//System.out.println("end year"+tyear1);
Statement del_stmt=null,dis_stmt=null,sel_stmt=null,up_stmt=null,cov_stmt=null,stmtt=null,stmt_insert=null,stmt_tbl_drop=null,stmt_check=null,stmt_tbl=null,stmt2=null,stmt3=null,stmt11=null,stmt10=null,stmt09=null,stmt08=null,stmt07=null;
ResultSet dis_rs=null,sel_rs=null,cov_rs=null,rss=null,rs_check=null,rs2=null,rs3=null,rs11=null,rs10=null,rs09=null,rs08=null,rs07=null,rs_insert=null;
ResultSetMetaData md;

String cstatus="",curr_status="",prev_status="",panch_code="",panch_name="",stat_dt1="",stat_dt2="",stat_tbl="",cov_status="";
%>
<form>
<center>
<table width="90%">

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<a href="./rws_slippagetable_hab_list1_xls.jsp" target="_new">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
<tr><td align=right>
</tr>
</table>

<p align="center"><font face=verdana size=2><b>Status Of Habitations From: <%=fyear%>&nbsp;To: <%=cur_year1%></b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%></font>&nbsp; 
&nbsp; </p>
<p align="center">

<%
 try
{
	   qry2 = "select distinct to_char(STATUS_date,'dd-MON-yyyy') from rws_habitation_directory_tbl where coverage_status<>'FC' and coverage_status<>'UI'";
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
	qry3 = "select distinct to_char(STATUS_date,'dd-MON-yyyy') from RWS_HABITATION_dir_his_TBL where coverage_status<>'FC' and coverage_status<>'UI'";
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
   String tbl_check=null;
   String up_qry="";
   int start=Integer.parseInt(start_dt);  
   int qrylen=0,statlen=0;
   String finalstr="",finalstatus="";
    //System.out.println("....start date........"+start_dt+start);
 
try
{

    //System.out.println(" i am in try block of table creation process");
    qry_check="select tname from tab where tname like 'RWS_SLIPPAGE_TEMP_STATUS_TBL'";
	stmt_check=conn.createStatement();
    rs_check=stmt_check.executeQuery(qry_check);
	
	while(rs_check.next())
	{
	tbl_check=rs_check.getString(1);
	}
     if(rs_check!=null)
         rs_check.close();
     if(stmt_check!=null)
       stmt_check.close();
 
	if(tbl_check!=null)
	{
     // System.out.println(" i am getting status years list"+"status loop end"+(start-1)+"status loop start"+fyear1);
      System.out.println(" i am in if block of table creation process-- if already table");
      qry5="Drop table rws_slippage_temp_status_tbl";
	  stmt_tbl_drop=conn.createStatement();
	  stmt_tbl_drop.executeUpdate(qry5);
      conn.commit();
	    for(int j=start-1;j>=fyear1;j--)
	    {
	    stat_qry+="status"+j+" VARCHAR2(3),";
		qrylen=stat_qry.length();
	    statlen=cstatus.length();
	
		finalstr=stat_qry.substring(0,qrylen-1);
		
	    }
		qry4="create table rws_slippage_temp_status_tbl(hab_code VARCHAR2(16) not null,hab_name VARCHAR2(50),cur_status VARCHAR2(3),prev_status VARCHAR2(3),"+finalstr+",PRIMARY KEY (hab_code))";
		stmt_tbl=conn.createStatement();
		stmt_tbl.executeUpdate(qry4);

	   
	}
	else
	{
       System.out.println(" i am in else block of table creation process-- if no table");
       for(int j=start-1;j>=fyear1;j--)
	   {
	    stat_qry+="status"+j+" VARCHAR2(3),";
		qrylen=stat_qry.length();
	    
		finalstr=stat_qry.substring(0,qrylen-1);
		//System.out.println("....final query...."+finalstr);
		
	   }
	
    qry4="create table rws_slippage_temp_status_tbl(hab_code VARCHAR2(16) not null,hab_name VARCHAR2(50),cur_status VARCHAR2(3),prev_status VARCHAR2(3),"+finalstr+",PRIMARY KEY (hab_code))";
	stmt_tbl=conn.createStatement();
	stmt_tbl.executeUpdate(qry4);
	System.out.println(" successfully created");

		
	}
   // System.out.println("....table creation query...."+qry4);
   //int fvar=stat_qry.lastIndexOf(',');
   //System.out.println("....last ..." +fvar);
 }
catch(Exception e)
{	
System.out.println(" creation Exception: \n" + e);
e.printStackTrace();
}
finally
	{
		if(stmt_tbl_drop != null)
	    {	try
				{	stmt_tbl_drop.close();					
				}
				catch(SQLException sqle){ }
	   }

	    if(stmt_tbl != null)
	    {	try
				{	stmt_tbl.close();					
				}
				catch(SQLException sqle){ }
	     }
	}

try
{  
    qry1="select panch_code,panch_name,COVERAGE_STATUS,PREVIOUS_YR_STATUS from RWS_COMPLETE_HAB_VIEW  where dcode='"+dcode+"' and coverage_status<>'FC' and coverage_status<>'UI'"; 
	//System.out.println("............."+qry1);
	stmt=conn.createStatement();
	stmt_insert=conn.createStatement();
    rs=stmt.executeQuery(qry1); 
	while(rs.next())
	{
	   //panch_code=rs.getString(1);
	   //panch_name=rs.getString(2);
	   //curr_status=rs.getString(3);
	   //prev_status=rs.getString(4);
      	
      qry_insert="insert into rws_slippage_temp_status_tbl(hab_code,hab_name,cur_status,prev_status)values('"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"')";
	  //System.out.println("insert qry"+qry_insert);	                                                        
	  stmt_insert.executeQuery(qry_insert);
      }

}
catch(SQLException e)
	{
	e.printStackTrace();
	}
	finally
	 {
      	if(stmt_insert != null)
		{
			try
			{
			stmt_insert.close();	
	        			
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

try
{
  sel_qry="select hab_code from rws_slippage_temp_status_tbl";
  sel_stmt=conn.createStatement();
  sel_rs=sel_stmt.executeQuery(sel_qry);
  cov_stmt=conn.createStatement();
	
up_stmt=conn.createStatement();  
while(sel_rs.next())
  {
        panch_code=sel_rs.getString(1);
      
	for(int j=start-1;j>=fyear1;j--)
	{
     
    cov_query="select hab_code,nvl(coverage_status,'_') from rws_habitation_dir_his"+j+"_tbl  where hab_code='"+sel_rs.getString(1)+"'";
    cov_rs=cov_stmt.executeQuery(cov_query);
	 while(cov_rs.next())
	 {  hcode=cov_rs.getString(1);
        cov_status=cov_rs.getString(2);

        if(hcode!=null && !hcode.equals(""))
         {
          query="update rws_slippage_temp_status_tbl set status"+j+"='"+cov_status+"' where hab_code='"+sel_rs.getString(1)+"'"; 
          up_stmt.executeUpdate(query);
         // System.out.println(".....update qry........"+query);
         }

         }
     
	}
   }
  }
catch(SQLException e)
	{
	e.printStackTrace();
	}
	finally
	 {
             try{
		  up_stmt.close();

	      if(cov_rs!=null)
	      cov_rs.close();
	      if(cov_stmt!=null)
	      cov_stmt.close();

          if(sel_rs!=null)
	      sel_rs.close();
	      if(sel_stmt!=null)
	      sel_stmt.close();}catch(Exception e){}

		
		}
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
		    <th class=btext>SLNO</th>
		   <%
			for (int p=1; p<=count; p++)
		    {
		   %>
			<th class=btext><%=md.getColumnName(p)%>
			<%
		    }
		    %>
			</tr>
	  

      <%  while(dis_rs.next())
       {
           //System.out.println( "result set value......."+dis_rs.getString(3));
           
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

