<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>

<html>

<head>
<script>
window.history.forward(1);
</script>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<body>
<p align=right>
<%
Statement ps1=null,ps2=null;
ResultSet rs1=null,rs2=null;
ResultSetMetaData rsm=null;
String circlecode=null, programcode=null,circlename=null,programname=null,distcode=null,distname=null,mandcode=null,manname=null,panchcode=null;
	   

        
	   circlename=(String)session.getAttribute("circleName");
	   circlecode=(String)session.getAttribute("circleCode");
	   programcode=(String)session.getAttribute("prCode");
	   programname=(String)session.getAttribute("prName");
		
        
	  
		
	 %>
<table border = 1 cellspacing = 0 cellpadding = 0  align="center"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=50% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_programmes_frm.jsp">Back</td> 
				</tr>
			</table>
		</caption>
		
  <% try
		{
	   String str=" ";
	  
         if(circlecode!=null && circlecode.equals("0") && programcode!=null && programcode.equals("0"))
			{ 
			// out.println("in first condn");
			 String str1= "select distinct pr.programme_code,p.programme_name FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_PROGRAMME_tbl p where pr.programme_code=p.programme_code AND pr.HAB_CODE=E.HAB_CODE order by pr.programme_code";

			  
             ps2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	          rs2=ps2.executeQuery(str1);	
	          rs2.last();
	          int Count = rs2.getRow();
	         
	          rs2.beforeFirst();
               String prgcodes[]=new String[Count];
			   String prgnames[]=new String[Count];
			   String programcodes[]=new String[Count];
	             int k=0;
			     while (rs2.next())
				{
                prgcodes[k]=rs2.getString(1);//getting all table programcodes
			    prgnames[k]=rs2.getString(2);
				//out.println( prgnames[k]);
				 k++;
				}
			String str2= "select distinct p.programme_code,p.programme_name FROM rws_PROGRAMME_tbl p order by p.programme_code";
             
			  ps1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
               rs1=ps1.executeQuery(str2);
			   rs1.last();
	          int Count1 = rs1.getRow();
	        
	           rs1.beforeFirst();
			   String progcodes[]=new String[Count1];
			    int j=0;
			     while(rs1.next())
				{
					 
                 progcodes[j]=rs1.getString(1);
				 //out.println(progcodes[j]);//getting all main codes 
				 j++;
                 
				}
				int s=0;
				
              for(int l=0;l<Count;l++)
				{
					
              
			   for(int m=0;m<Count1;m++)
					{
				 
						if(prgcodes[l].equals(progcodes[m]))
						{        
							  
                             programcodes[s]=progcodes[m];
							 s++;
							break;	
						}
						
					 }
					
			    } 
                 
	 String  q1="";

	   for(int b=0;b<programcodes.length;b++)
				{
                  q1=q1+",sum(Case When pr.programme_code='"+programcodes[b]+"' then  1 else 0 END)";
				}
	     str="SELECT distinct d.dname as DISTRICT,count(*) as TOTAL"+q1+",d.dcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_district_tbl d WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=d.dcode group by d.dcode,d.dname order by d.dcode";
          
		//out.println(str);
		  ps=conn.prepareStatement(str);
		  rs=ps.executeQuery();
		  rsm=rs.getMetaData();
           int Cnt=rsm.getColumnCount();
		  
		   int slno=0,total=0,grandtotal=0;%>
		     
             <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=<%=Cnt%> >&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
			  
		   <tr align=center>
		   <td class=btext>SLNO</b></td>
		   <td class=btext>District</b></td> 
		   <td class=btext>Total</b></td> 
		   <% 
			   for(int t=0;t<Count;t++)
				{ %>
			     <td class="btext"><%=prgnames[t]%></td>
			<%}%>
			</tr>
			<%

	 while(rs.next())
		{
		 
		++ slno;
		//out.println("snno"+slno);
	
%>        
        <tr align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><a href="rws_programmes_mandal.jsp?dcode=<%=rs.getString("dcode")%>&district=<%=circlecode%>&program=<%=programcode%>&distname=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></td>
		<td class=btext><%=rs.getString("Total")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
		    <td class=btext><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>&dcode1=<%=rs.getString("dcode")%>&prog=<%=programcodes[z]%>"><%=record[z]%></a></td>
			<%
            }
            else{%>
            <td class=rptValue><%=record[z]%></td>
			<% }
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("Total");	
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="center"><font color="blue"><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>">
		<%=grandtotal%></a></font></td>
		</tr>
	<%  
			}
 else if(circlecode!=null && circlecode.equals("0") && programcode!=null && !programcode.equals("0"))
			{

String str2= "select distinct p.programme_code,p.programme_name FROM rws_PROGRAMME_tbl p order by p.programme_code";
             
			  ps1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
               rs1=ps1.executeQuery(str2);
			   rs1.last();
	          int Count1 = rs1.getRow();
	        
	           rs1.beforeFirst();
			   String progcodes[]=new String[Count1];
			   String prgnames[]=new String[Count1];
			    int j=0;
			     while(rs1.next())
				{
					 
                 progcodes[j]=rs1.getString(1);//getting all main codes 
				 prgnames[j]=rs1.getString(2);
				 j++;
                 
				}
				int s=0;String  q1="";
				
              for(int l=0;l<Count1;l++)
				{
			  if(progcodes[l].equals(programcode))
				{        
		        
		        q1=q1+",sum(Case When pr.programme_code='"+progcodes[l]+"' then  1 else 0 END)";
				
				break;
				}
				}
			str="SELECT distinct d.dname as DISTRICT,count(*) as TOTAL"+q1+",d.dcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_district_tbl d WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=d.dcode and pr.programme_code='"+programcode+"' group by d.dcode,d.dname order by d.dcode";
			
            ps=conn.prepareStatement(str);
		    rs=ps.executeQuery();
		    rsm=rs.getMetaData();
           int Cnt=rsm.getColumnCount();
		  
		   int slno=0,total=0,grandtotal=0;%>
		     
             <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=<%=Cnt%> >&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
			  
		   <tr align=center>
		   <td class=btext>SLNO</b></td> 
		   <td class=btext>District</b></td> 
		   <td class=btext>Total</b></td> 
		   <td class=btext><%=programname%></b></td>
			</tr>
			<%

	 while(rs.next())
		{
		 
		++ slno;
	
%>        
        <tr align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><a href="rws_programmes_mandal.jsp?dcode=<%=rs.getString("dcode")%>&district=<%=circlecode%>&program=<%=programcode%>&distname=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></td>
		<td class=btext><%=rs.getString("Total")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
		    <td class=rptValue><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>&dcode=<%=rs.getString("dcode")%>"><%=record[z]%></a></td>
			<%
            }
            else{%>
            <td class=rptValue><%=record[z]%></td>
			<% }
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("Total");	
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="center"><font color="blue"><a><%=grandtotal%></a></font></td>
		</tr>
	<%  
			}
   
		else if(circlecode!=null && !circlecode.equals("0") && programcode!=null && programcode.equals("0"))
			{
			
			String str1= "select distinct pr.programme_code,p.programme_name FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_PROGRAMME_tbl p where pr.programme_code=p.programme_code AND pr.HAB_CODE=E.HAB_CODE order by pr.programme_code";

			  
             ps2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	          rs2=ps2.executeQuery(str1);	
	          rs2.last();
	          int Count = rs2.getRow();
	         
	          rs2.beforeFirst();
               String prgcodes[]=new String[Count];
			   String prgnames[]=new String[Count];
			   String programcodes[]=new String[Count];
	             int k=0;
			     while (rs2.next())
				{
                prgcodes[k]=rs2.getString(1);//getting all table programcodes
				prgnames[k]=rs2.getString(2);
				 k++;
				}
			String str2= "select distinct p.programme_code,p.programme_name FROM rws_PROGRAMME_tbl p order by p.programme_code";
             
			  ps1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
               rs1=ps1.executeQuery(str2);
			   rs1.last();
	          int Count1 = rs1.getRow();
	        
	           rs1.beforeFirst();
			   String progcodes[]=new String[Count1];
			    int j=0;
			     while(rs1.next())
				{
					 
                 progcodes[j]=rs1.getString(1);//getting all main codes 
				 j++;
                 
				}
				int s=0;
				
              for(int l=0;l<Count;l++)
				{
					
              
			   for(int m=0;m<Count1;m++)
					{
				 
						if(prgcodes[l].equals(progcodes[m]))
						{        
							  
                             programcodes[s]=progcodes[m];
							 s++;
							break;	
						}
						
					 }
					
			    } 
                 
	 String  q1="";

	   for(int b=0;b<programcodes.length;b++)
				{
                  q1=q1+",sum(Case When pr.programme_code='"+programcodes[b]+"' then  1 else 0 END)";
				}
	   
	   str="SELECT distinct d.dname as DISTRICT,count(*) as TOTAL"+q1+",d.dcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_district_tbl d WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=d.dcode and substr(pr.hab_code,1,2)='"+circlecode+"' group by d.dcode,d.dname order by d.dcode";
			
        
		 //int slno=0;
	    ps=conn.prepareStatement(str);
		//out.println(str);
		 rs=ps.executeQuery();
		 rsm=rs.getMetaData();
         int Cnt=rsm.getColumnCount();
		int slno=0,total=0,grandtotal=0;%>
		
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Wise-Works Status Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=<%=Cnt%>>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
<tr align=center>
		   <td class=btext>SLNO</b></td> 
		    <td class=btext>District</b></td> 
			 <td class=btext>Total</b></td> 
		   <% 
			   for(int f=0;f<Count;f++)
				{ %>
			     <td class="btext"><%=prgnames[f]%></td>
			<%}%>
			</tr>
			<%

	 while(rs.next())
		{
		 
		++ slno;
	
%>        
        <tr align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><a href="rws_programmes_mandal.jsp?district=<%=circlecode%>&program=<%=programcode%>&dcode=<%=circlecode%>"><%=rs.getString(1)%></a></td>
		<td class=btext><%=rs.getString("TOTAL")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
			<td class=rptValue><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>
			&prog=<%=programcodes[z]%>"><%=record[z]%></a></td>
			<% 
			}
			 else{%>
            <td class=rptValue><%=record[z]%></td>
			<%}
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("Total");	
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="center"><font color="blue"><a><%=grandtotal%></a></font></td>
		</tr>
	<%  
			}
else if(circlecode!=null && !circlecode.equals("0") && programcode!=null && !programcode.equals("0"))
			{
	 
String str2= "select distinct p.programme_code,p.programme_name FROM rws_PROGRAMME_tbl p order by p.programme_code";
             
			  ps1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
               rs1=ps1.executeQuery(str2);
			   rs1.last();
	          int Count1 = rs1.getRow();
	        
	           rs1.beforeFirst();
			   String progcodes[]=new String[Count1];
			   String prgnames[]=new String[Count1];
			    int j=0;
			     while(rs1.next())
				{
					 
                 progcodes[j]=rs1.getString(1);//getting all main codes 
				 prgnames[j]=rs1.getString(2);
				 j++;
                 
				}
				int s=0;String  q1="";
				
              for(int l=0;l<Count1;l++)
				{
			  if(progcodes[l].equals(programcode))
				{        
		        
		        q1=q1+",sum(Case When pr.programme_code='"+progcodes[l]+"' then  1 else 0 END)";
				
				break;
				}
				}
			str="SELECT distinct d.dname as DISTRICT,count(*) as TOTAL"+q1+",d.dcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_district_tbl d WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=d.dcode  and  substr(pr.hab_code,1,2)='"+circlecode+"' and pr.programme_code='"+programcode+"' group by d.dname,d.dcode order by d.dcode";
	  
			ps=conn.prepareStatement(str);
		    rs=ps.executeQuery();
		    rsm=rs.getMetaData();
           int Cnt=rsm.getColumnCount();
		  
		   int slno=0,total=0,grandtotal=0;%>
	
 <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=<%=Cnt%>>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>&nbsp;&nbsp;</td>  
   </tr>
		<tr align=center>
		   <td class=btext>SLNO</b></td> 
		    <td class=btext>District</b></td>
			 <td class=btext>Total</b></td>
			  <td class=btext><%=programname%></b></td>
		  
			</tr>
			<%

	 while(rs.next())
		{
		 
		++ slno;
	
%>        
        <tr align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><a href="rws_programmes_mandal.jsp?district=<%=circlecode%>&program=<%=programcode%>&dcode=<%=circlecode%>"><%=rs.getString(1)%></a></td>
		<td class=btext><%=rs.getString("Total")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
		<td class=rptValue><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>"><%=record[z]%>
		</a></td>
			<% 
			}
			 else{%>
            <td class=rptValue><%=record[z]%></td>
			<%}
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("Total");	
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="center"><font color="blue"><a><%=grandtotal%></a></font></td>
		</tr>
	<%  
			}
	}
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
     </body>
	</html>
	<%@ include file = "footer.jsp" %>
