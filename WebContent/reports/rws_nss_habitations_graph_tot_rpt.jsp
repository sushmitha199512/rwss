


<%	
int j=1;

Statement stmt1=null;
rs1=null;
Statement stmt2=null;
rs2=null;
String s=null;
int pcount=0;
int count=0;
int count1=0;
int count2=0;
int count3=0;
int count4=0;
int count5=0;
query=null;
query1=null;
String query2=null;
 tot=0;
int tot1=0;
int mcount=0;
dCode=request.getParameter("district");
if(dCode.equals("51"))
{
try{

                   // query1="select hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.coverage_status = 'NSS' and hd.hab_code in (select hab_code from rws_hab_contamination_tbl where cont_perc is not null and cont_perc <> 0)  order by 1 ";
                      query1="select  hd.panch_code  from rws_complete_hab_view hd  where hd.coverage_status = 'NSS' and hd.panch_code in (select hab_code from rws_hab_contamination_tbl where cont_perc is not null and cont_perc <> 0)  order by 1 ";
                     // System.out.println("query1*******"+query1);         
					  stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs1 = stmt1.executeQuery(query1);
				while(rs1.next())
				{
					 tot1++;
					 s=rs1.getString(1);
					  count=0;
					  try
					{
					  query2="select (select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='01' and hab_code='"+s+"') as a1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='02' and hab_code='"+s+"') as b1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='03' and hab_code='"+s+"') as c1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='04' and hab_code='"+s+"') as d1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='05' and hab_code='"+s+"') as d1 from dual ";         
						  
						  
					  
						   stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs2 = stmt2.executeQuery(query2);
				
				if(rs2.next())

	            {
					if((rs2.getDouble(1)>0) && (rs2.getDouble(2)>0) && (rs2.getDouble(3)>0) && (rs2.getDouble(4)>0) && (rs2.getDouble(5)>0))
					{
							pcount=count+1;
							out.println("c"+pcount);
					}
					   
					if(rs2.getDouble(1)>0)
						
					{
							count=count+1;
							count1++;
							
					}
					if(rs2.getDouble(2)>0)
					{
						count=count+1;
						count2++;
					}
					if(rs2.getDouble(3)>0)
					{
						count=count+1;
						count3++;
					}
					if(rs2.getDouble(4)>0)
					{
						count=count+1;
						count4++;
					}
					if(rs2.getDouble(5)>0)
					{
						count=count+1;
						count5++;
					}


					
					
					
				}	
				  		

				}
				catch(Exception l)
						{
						}
						
				
				
				

				
				
				if(count>1)
										mcount++;
					
				
				

				

				}
				
				}
				catch(Exception o)
	{
	}
	finally
	{
		conn.close();	
		
	}
	
				


			   %>
			   <html>
<head>

<title> WaterSoft </title>
<script>
window.history.forward(1);
</script>
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
.btext
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}

</style>
</head>
<body bgcolor="#edf2f8">

			   
				 <tr>
				 <td class="btext">sno</td>
				
				<td class="btext">Total NSS Habs </td>
                
				
				 <td class="btext">Flouride</td>
                 
				 <td class="btext">Brakish</td>
				 
				 <td class="btext">Iron</td>
				 
				 <td class="btext">Aresenic</td>
				 
				 <td class="btext">Nitrate</td>
				
                 <td class="btext">No Data</td>
				 <td class="btext">Multiple</td>

				 </tr>
				 
				 
				
				 
				 
				 
			 

			 
					  <tr>
						<td class="mystyle1" align="center"><%=j++%></td>
                        <td class="mystyle1" align="center"><%=tot1%></td>
												<td class="mystyle1" align="center"><%=count1%></td>
						
						<td class="mystyle1" align="center"><%=count2%></td>
						
						<td class="mystyle1" align="center"><%=count3%></td>
						
						<td class="mystyle1" align="center"><%=count4%></td>
						
						<td class="mystyle1" align="center"><%=count5%></td>
						
						<td class="mystyle1" align="center"><%=pcount%></td>
						<td class="mystyle1" align="center"><%=mcount%></td>
						</tr>

					
						
					    
<%
						dist[0]="No. of Nss Habitations";
                        dist[1]="Flouride";
						dist[2]="Brakish";
						dist[3]="Iron";
						dist[4]="Aresenic";
						dist[5]="Nitrate";
						dist[6]="No Date";
						dist[7]="Multiple";
						data[0]=tot1;
						data[1]=count1;
						data[2]=count2;
						data[3]=count3;
						data[4]=count4;
						data[5]=count5;
						data[6]=pcount;
						data[7]=mcount;
}
						

						
						else if(!dCode.equals("51"))
{
try{

                    // query1="select hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.coverage_status = 'NSS' and hd.hab_code in (select hab_code from rws_hab_contamination_tbl where cont_perc is not null and cont_perc <> 0) and d.dcode='"+dCode+"' order by 1 ";
                    query1="select hd.panch_code from rws_complete_hab_view hd  where hd.coverage_status = 'NSS' and hd.panch_code in (select hab_code from rws_hab_contamination_tbl where cont_perc is not null and cont_perc <> 0) and substr(hd.panch_code,1,2)='"+dCode+"' order by 1 ";
                   // System.out.println("query1******"+query1); 
					  stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs1 = stmt1.executeQuery(query1);
				while(rs1.next())
				{
					 tot1++;
					 s=rs1.getString(1);
					  count=0;
					  try
					{
					  query2="select (select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='01' and hab_code='"+s+"' and substr(hab_code,1,2)='"+dCode+"') as a1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='02' and hab_code='"+s+"' and substr(hab_code,1,2)='"+dCode+"') as b1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='03' and hab_code='"+s+"' and substr(hab_code,1,2)='"+dCode+"') as c1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='04' and hab_code='"+s+"' and substr(hab_code,1,2)='"+dCode+"') as d1,(select nvl(cont_perc,0) from rws_hab_contamination_tbl where cont_perc is not null and cont_type='05' and hab_code='"+s+"' and substr(hab_code,1,2)='"+dCode+"') as d1  from dual ";         
						  
						  
					  
						   stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs2 = stmt2.executeQuery(query2);
				
				if(rs2.next())

	            {
					if((rs2.getDouble(1)>0) && (rs2.getDouble(2)>0) && (rs2.getDouble(3)>0) && (rs2.getDouble(4)>0) && (rs2.getDouble(5)>0))
					{
							pcount=count+1;
							out.println("c"+pcount);
					}
					   
					if(rs2.getDouble(1)>0)
						
					{
							count=count+1;
							count1++;
							
					}
					if(rs2.getDouble(2)>0)
					{
						count=count+1;
						count2++;
					}
					if(rs2.getDouble(3)>0)
					{
						count=count+1;
						count3++;
					}
					if(rs2.getDouble(4)>0)
					{
						count=count+1;
						count4++;
					}
					if(rs2.getDouble(5)>0)
					{
						count=count+1;
						count5++;
					}


					
					
					
				}	
				  		

				}
				catch(Exception l)
						{
						}
						
				
				
				

				
				
				if(count>1)
										mcount++;
					
				
				

				

				}
				
				}
				catch(Exception o)
	{
	}
	finally
	{
		conn.close();	
		
	}
	
				


			   %>
			   <html>
<head>

<title> WaterSoft </title>
<script>
window.history.forward(1);
</script>
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
.btext
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}

</style>
</head>
<body bgcolor="#edf2f8">

			   
				 <tr>
				 <td class="btext">sno</td>
				
				<td class="btext">Total NSS Habs </td>
                
				
				 <td class="btext">Flouride</td>
                 
				 <td class="btext">Brakish</td>
				 
				 <td class="btext">Iron</td>
				 
				 <td class="btext">Aresenic</td>
				 
				 <td class="btext">Nitrate</td>
				
                 <td class="btext">No Data</td>
				 <td class="btext">Multiple</td>

				 </tr>
				 
				 
				
				 
				 
				 
			 

			 
					  <tr>
						<td class="mystyle1" align="center"><%=j++%></td>
                        <td class="mystyle1" align="center"><%=tot1%></td>
												<td class="mystyle1" align="center"><%=count1%></td>
						
						<td class="mystyle1" align="center"><%=count2%></td>
						
						<td class="mystyle1" align="center"><%=count3%></td>
						
						<td class="mystyle1" align="center"><%=count4%></td>
						
						<td class="mystyle1" align="center"><%=count5%></td>
						
						<td class="mystyle1" align="center"><%=pcount%></td>
						<td class="mystyle1" align="center"><%=mcount%></td>
						</tr>

					
						
					    
<%
						dist[0]="No. of Nss Habitations";
                        dist[1]="Flouride";
						dist[2]="Brakish";
						dist[3]="Iron";
						dist[4]="Aresenic";
						dist[5]="Nitrate";
						dist[6]="No Date";
						dist[7]="Multiple";
						data[0]=tot1;
						data[1]=count1;
						data[2]=count2;
						data[3]=count3;
						data[4]=count4;
						data[5]=count5;
						data[6]=pcount;
						data[7]=mcount;
}
						%>


						



	
						
				
				   
			   
			   
			   </body>
			   </html>
								
			  
			
	      


				