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
ResultSetMetaData rsm=null;
ResultSet rs1=null,rs2=null;
String circlecode=null, programcode=null,circlename=null,programname=null,distcode=null,distname=null,mandcode=null,manname=null;
	   
	  
        
	   circlename=(String)session.getAttribute("circleName");
	   circlecode=(String)session.getAttribute("circleCode");
	   programname=(String)session.getAttribute("prName");
	   programcode=(String)session.getAttribute("prCode");
	   distcode=request.getParameter("dcode");
	   //out.println(distcode);
	   distname=request.getParameter("distname");
	   mandcode=request.getParameter("mancode");
	    // out.println(mandcode);
	   manname=request.getParameter("manname");
		
        //PreparedStatement ps=null;
	  
		
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
	   
         if(circlecode!=null && circlecode.equals("0") && programcode!=null && programcode.equals("0") && distcode!=null && mandcode!=null)
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
                  q1=q1+",sum(Case When pr.programme_code='"+programcodes[b]+"' then  1 else 0 END) as";
				}
	     str="SELECT distinct p.pname as PANCHAYAT,count(*) as TOTAL"+q1+",p.pcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_panchayat_tbl p WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=p.dcode and p.mcode=substr(pr.hab_code,6,2) and p.pcode=substr(pr.hab_code,13,2) and substr(pr.hab_code,1,2)='"+distcode+"'  and substr(pr.hab_code,6,2)='"+mandcode+"' group by p.pcode,p.pname order by p.pcode";
          
		
		  ps=conn.prepareStatement(str);
		  rs=ps.executeQuery();
		  rsm=rs.getMetaData();
           int Cnt=rsm.getColumnCount();
		 
		  
		   int slno=0,total=0, grandtotal=0;%>
		     
             <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=<%=Cnt%>>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=distname%>&nbsp;&nbsp;Mandal:<%=manname%>&nbsp;
  &nbsp;Program:<%=programname%></td>
  </tr>
			  
		   <tr align=center>
		   <td class=btext>Slno</b></td>
		   <td class=btext>Panchayat</b></td> 
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
	
%>        
        <tr align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=btext><%=rs.getString("TOTAL")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
			<td class=rptValue><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>&prog=<%=programcodes[z]%>&pcode=<%=rs.getString("pcode")%>&dcode=<%=distcode%>&mcode=<%=mandcode%>"><%=record[z]%></a></td>
			<%
            }
            else{%>
            <td class=rptValue><%=record[z]%></td>
			<% }
	}%>
 </tr>
<% 
			grandtotal=grandtotal+rs.getInt("TOTAL");	
	        
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
<td class=btext align="center"><%=grandtotal%></td>
		</tr>
	<%  
			}
 else if(circlecode!=null && circlecode.equals("0") && programcode!=null && !programcode.equals("0") && distcode!=null && mandcode!=null)
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
                
	   str="SELECT distinct p.pname as PANCHAYAT,count(*) as TOTAL"+q1+",p.pcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_panchayat_tbl p WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=p.dcode and p.mcode=substr(pr.hab_code,6,2) and p.pcode=substr(pr.hab_code,13,2)  and substr(pr.hab_code,1,2)='"+distcode+"' and substr(pr.hab_code,6,2)='"+mandcode+"' and pr.programme_code='"+programcode+"' group by p.pname,p.pcode order by p.pcode";
	 
		 ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		  rsm=rs.getMetaData();
           int Cnt=rsm.getColumnCount();
		  
		 int total=0,slno=0,grandtotal=0;%>
		 <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=<%=Cnt%> >&nbsp;&nbsp;&nbsp;&nbsp;District:<%=distname%>&nbsp;&nbsp;District:<%=manname%>&nbsp;&nbsp;Program:<%=programname%>&nbsp;&nbsp;</td>
  </tr>
			  
		   <tr align=center>
		   <td class=btext>SLNO</b></td>
		   <td class=btext>Panchayat</b></td> 
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
		<td class=rptValue><%=rs.getString(1)%></td>
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
		&dcode=<%=distcode%>&mcode=<%=mandcode%>&pcode=<%=rs.getString("pcode")%>"><%=record[z]%>
		</a></td>
			<%
            }
            else{%>
            <td class=rptValue><%=record[z]%></td>
			<% }
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("TOTAL");	
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="center"><font color="blue"><a><%=grandtotal%></a></font></td>
		</tr>
	<%  
			}
   
		else if(circlecode!=null && !circlecode.equals("0") && programcode!=null && programcode.equals("0") && distcode!=null && mandcode!=null)
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
	    str="SELECT distinct p.pname as PANCHAYAT,count(*) as TOTAL"+q1+",p.pcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_panchayat_tbl p WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=p.dcode and p.mcode=substr(pr.hab_code,6,2) and p.pcode=substr(pr.hab_code,13,2) and substr(pr.hab_code,1,2)='"+distcode+"' and substr(pr.hab_code,6,2)='"+mandcode+"' group by p.pname,p.pcode order by p.pcode";
	 
			
        
		 //int slno=0;
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		rsm=rs.getMetaData();
           int Cnt=rsm.getColumnCount();
		  int total=0,slno=0,grandtotal=0;%>
		  <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=<%=Cnt%>>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Mandal:<%=manname%>
  &nbsp;&nbsp;Program:<%=programname%></td>
  </tr>
	 <tr align=center>
		   <td class=btext>Slno</b></td> 
		   <td class=btext>Panchayat</b></td> 
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
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=btext><%=rs.getString("TOTAL")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
		   <td class=rptValue><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>&prog=<%=programcodes[z]%>&mcode=<%=mandcode%>&pcode=<%=rs.getString("pcode")%>"><%=record[z]%></a></td>
			<% 
			}
			 else{%>
            <td class=rptValue><%=record[z]%></td>
			<%}
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("TOTAL");	
			}
			rs.close();
		%>
<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="center"><font color="blue"><a><%=grandtotal%></a></font></td>
		</tr>
	<%  
			}
else if(circlecode!=null && !circlecode.equals("0") && programcode!=null && !programcode.equals("0") && distcode!=null && mandcode!=null)
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
     str="SELECT distinct p.pname as PANCHAYAT,count(*) as TOTAL"+q1+",p.pcode FROM RWS_PRAJAPADAM_TBL pr,RWS_PRAJAPADAM_EXIST_SCH_TBL E,rws_panchayat_tbl p WHERE pr.HAB_CODE=E.HAB_CODE and substr(pr.hab_code,1,2)=p.dcode and p.mcode=substr(pr.hab_code,6,2) and p.pcode=substr(pr.hab_code,13,2) and substr(pr.hab_code,1,2)='"+distcode+"' and substr(pr.hab_code,6,2)='"+mandcode+"' and pr.programme_code='"+programcode+"' group by p.pname,p.pcode order by p.pcode";
	  
		 ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 rsm=rs.getMetaData();
         int Cnt=rsm.getColumnCount();
		int slno=0,total=0,grandtotal=0;%>
		<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=<%=Cnt%>>Programme Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=<%=Cnt%>>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Mandal:<%=manname%>
	  &nbsp;&nbsp;Program:<%=programname%>&nbsp;&nbsp;</td>  
   </tr>
 <tr align=center>
		   <td class=btext>SLNO</b></td> 
		    <td class=btext>Panchayat</b></td> 
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
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=btext><%=rs.getString("Total")%></td>
		<%
		String[] record = null;
	    record = new String[Cnt-1];
		for(int z=0,c=3;z<Cnt-1 && c<=Cnt-1;z++,c++)
		{
		record[z] = rs.getString(c);
		if(record[z]!=null && !record[z].equals("0"))
			{%>
		<td class=rptValue><a href="./rws_prajapath_rpt1.jsp?district=<%=circlecode%>&program=<%=programcode%>&mcode=<%=mandcode%>&pcode=<%=rs.getString("pcode")%>"><%=record[z]%></a></td>
			<% 
			}
			 else{%>
            <td class=rptValue><%=record[z]%></td>
			<%}
			}%>
  </tr>
<% 
			grandtotal=grandtotal+rs.getInt("TOTAL");	
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
