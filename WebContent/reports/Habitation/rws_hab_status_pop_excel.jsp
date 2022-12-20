<%@ include file="/reports/conn.jsp" %>
<form>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "UnSafeHabsList.xls");
Statement stmt1=null,stmt2=null,stmt3=null;

ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;



String dcode=(String)session.getAttribute("rDistrict");


int sno=1;
String qry="";
String queryasset="";






%>

<table    width="80%"  border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr  align="center">
		<td align="center" class="gridhdbg" colspan="13"> Priority Report</td>
</tr>
<tr align=center>

               <td class=gridhdbg rowspan="2">Sl.No</td>
               <td class=gridhdbg rowspan="2">District</td>
               <td class=gridhdbg rowspan="2">Total Habs</td>
               <td class=gridhdbg rowspan="2">Population</td>
                            
                                                             
                              <td class=gridhdbg rowspan="1" colspan="2" >PWS</td>
                                                         
               <td class=gridhdbg  rowspan="1" colspan="2">MPWS</td>
                                                      

                                                             

<td class=gridhdbg  rowspan="1" colspan="2">HP&shp</td>
      <td class=gridhdbg  rowspan="1" colspan="2">Open Wells</td>                                                     
		<td class=gridhdbg  rowspan="1" colspan="2">Others</td>   
			   </tr>
			   <tr>
			    
			      <td class=gridhdbg>Habs</td>
			    <td class=gridhdbg>Population</td>
			    
			      <td class=gridhdbg>Habs</td>
			    <td class=gridhdbg>Population</td>
			    
			    
			      <td class=gridhdbg>Habs</td>
			    <td class=gridhdbg>Population</td>
			    <td class=gridhdbg>Habs</td>
			    <td class=gridhdbg>Population</td>
			    <td class=gridhdbg>Habs</td>
			    <td class=gridhdbg>Population</td>
			   
			   </tr>
<%
try
{//cpws safe
	String cpwsqry="select substr(panch_code,1,2),count(panch_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_complete_hab_view ";
	if(dcode!=null && !dcode.equals("")){
		cpwsqry+=" and substr(panch_code,1,2)='"+dcode+"'";
	}
	cpwsqry+=" group by substr(panch_code,1,2) order by substr(panch_code,1,2)";
	//System.out.println("cpwsqry="+cpwsqry);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(cpwsqry);
	Hashtable cpws_hash=new Hashtable();
	while(rs1.next()){
		cpws_hash.put("cpwssafe"+rs1.getString(1), rs1.getInt(2)+"@"+ rs1.getInt(3));
	}
	if(stmt1!=null){
		stmt1.close();
	}
	if(rs1!=null){
		rs1.close();
	}

	//pws un safe
	String pwsunqry="select substr(a.hab_code,1,2),count(distinct a.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_hab_supply_status_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and PWS_UNSAFE_SUPPLY>0  and PWS_SUPPLY=0 and MPWS_SUPPLY=0 and CPWS_SUPPLY=0 ";
	if(dcode!=null && !dcode.equals("")){
		pwsunqry+=" and substr(a.hab_code,1,2)='"+dcode+"'";
	}
	pwsunqry+=" group by substr(a.hab_code,1,2) order by substr(a.hab_code,1,2)";
	//System.out.println("pwsunqry="+pwsunqry);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(pwsunqry);
	Hashtable pws_un_hash=new Hashtable();
	while(rs1.next()){
		pws_un_hash.put("pwsunsafe"+rs1.getString(1), rs1.getInt(2)+"@"+ rs1.getInt(3));
	}
	if(stmt1!=null){
		stmt1.close();
	}
	if(rs1!=null){
		rs1.close();
	}



	//mpws un safe
	String mpwsunqry="select substr(a.hab_code,1,2),count(distinct a.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_hab_supply_status_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and MPWS_UNSAFE_SUPPLY>0 and PWS_SUPPLY=0 and  PWS_UNSAFE_SUPPLY=0 ";
	if(dcode!=null && !dcode.equals("")){
		mpwsunqry+=" and substr(a.hab_code,1,2)='"+dcode+"'";
	}
	mpwsunqry+=" group by substr(a.hab_code,1,2) order by substr(a.hab_code,1,2)";
	//System.out.println("mpwsunqry="+mpwsunqry);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(mpwsunqry);
	Hashtable mpws_un_hash=new Hashtable();
	while(rs1.next()){
		mpws_un_hash.put("mpwsunsafe"+rs1.getString(1), rs1.getInt(2)+"@"+ rs1.getInt(3));
	}
	if(stmt1!=null){
		stmt1.close();
	}
	if(rs1!=null){
		rs1.close();
	}

	//hp un safe
	String hpunqry="select substr(a.hab_code,1,2),count(distinct a.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_hab_supply_status_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and (HPS_OTH_SUPPLY_UNSAFE>0 or SHP_DK_SUPPLY>0) and PWS_UNSAFE_SUPPLY=0 and MPWS_UNSAFE_SUPPLY=0 and stat_of_hab='NSS'  ";
	if(dcode!=null && !dcode.equals("")){
		hpunqry+=" and substr(a.hab_code,1,2)='"+dcode+"'";
	}
	hpunqry+=" group by substr(a.hab_code,1,2) order by substr(a.hab_code,1,2)";
	//System.out.println("hpunqry="+hpunqry);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(hpunqry);
	Hashtable hp_un_hash=new Hashtable();
	while(rs1.next()){
		hp_un_hash.put("hpunsafe"+rs1.getString(1), rs1.getInt(2)+"@"+ rs1.getInt(3));
	}
	if(stmt1!=null){
		stmt1.close();
	}
	if(rs1!=null){
		rs1.close();
	}
	//ow un safe
	String hpqry="select substr(a.hab_code,1,2),count(distinct a.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_hab_supply_status_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and OWS_OTH_SUPPLY>0 and SHP_DK_SUPPLY =0   and HPS_OTH_SUPPLY_UNSAFE=0 and  PWS_UNSAFE_SUPPLY=0 and MPWS_UNSAFE_SUPPLY=0 and stat_of_hab='NSS'";
	if(dcode!=null && !dcode.equals("")){
		hpqry+=" and substr(a.hab_code,1,2)='"+dcode+"'";
	}
	hpqry+=" group by substr(a.hab_code,1,2) order by substr(a.hab_code,1,2)";
	//System.out.println("hpqry="+hpqry);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(hpqry);
	Hashtable hp_hash=new Hashtable();
	while(rs1.next()){
		hp_hash.put("hpsafe"+rs1.getString(1), rs1.getInt(2)+"@"+ rs1.getInt(3));
	}
	if(stmt1!=null){
		stmt1.close();
	}
	if(rs1!=null){
		rs1.close();
	}


	//other un safe
	String dpsqry="select substr(a.hab_code,1,2),count(distinct a.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_hab_supply_status_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and OTHERS_SUPPLY>0 and SHP_DK_SUPPLY =0   and HPS_OTH_SUPPLY_UNSAFE=0 and  PWS_UNSAFE_SUPPLY=0 and MPWS_UNSAFE_SUPPLY=0 and stat_of_hab='NSS' and OWS_OTH_SUPPLY=0";
	if(dcode!=null && !dcode.equals("")){
		dpsqry+=" and substr(a.hab_code,1,2)='"+dcode+"'";
	}
	dpsqry+=" group by substr(a.hab_code,1,2) order by substr(a.hab_code,1,2)";
	//System.out.println("dpsqry="+dpsqry);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(dpsqry);
	Hashtable dp_hash=new Hashtable();
	while(rs1.next()){
		dp_hash.put("dpsafe"+rs1.getString(1), rs1.getInt(2)+"@"+ rs1.getInt(3));
	}
	if(stmt1!=null){
		stmt1.close();
	}
	if(rs1!=null){
		rs1.close();
	}

	int styleCount=0;
	String style="";
	int totcpwssafe=0,totcpwsunsafe=0,totpwssafe=0,totpwsunsafe=0,totmpwssafe=0,totmpwsunsafe=0,totdpsafe=0,totdpunsafe=0,tothpsafe=0,tothpunsafe=0;
	int totcpwssafepop=0,totcpwsunsafepop=0,totpwssafepop=0,totpwsunsafepop=0,totmpwssafepop=0,totmpwsunsafepop=0,totdpsafepop=0,totdpunsafepop=0,tothpsafepop=0,tothpunsafepop=0;
	String mainqry="select dcode,dname from rws_district_tbl where dcode<>'16' ";
	if(dcode!=null && !dcode.equals("")){
		mainqry+=" and dcode='"+dcode+"'";
		}
	mainqry+=" order by dcode";
	stmt2=conn.createStatement();
	rs2=stmt2.executeQuery(mainqry);
	while(rs2.next())
	{
		if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 
		 int cpwssafe=0,cpwsunsafe=0,pwssafe=0,pwsunsafe=0,mpwssafe=0,mpwsunsafe=0,dpsafe=0,dpunsafe=0,hpsafe=0,hpunsafe=0;
		 int cpwssafepop=0,cpwsunsafepop=0,pwssafepop=0,pwsunsafepop=0,mpwssafepop=0,mpwsunsafepop=0,dpsafepop=0,dpunsafepop=0,hpsafepop=0,hpunsafepop=0;
		 if(cpws_hash.get("cpwssafe"+rs2.getString(1))!=null){
			 String cpws=(String)cpws_hash.get("cpwssafe"+rs2.getString(1));
			 String cpwsar[]=cpws.split("@");
			 if(cpwsar[0]!=null){
			 cpwssafe=Integer.parseInt(cpwsar[0]);} if(cpwsar[1]!=null){
			 cpwssafepop=Integer.parseInt(cpwsar[1]);}
		 }
		 
		 if(pws_un_hash.get("pwsunsafe"+rs2.getString(1))!=null){
			 String cpws=(String)pws_un_hash.get("pwsunsafe"+rs2.getString(1));
			 String cpwsar[]=cpws.split("@");
			 if(cpwsar[0]!=null){
			 pwsunsafe=Integer.parseInt(cpwsar[0]);} if(cpwsar[1]!=null){
			 pwsunsafepop=Integer.parseInt(cpwsar[1]);}
		 }
		
		 if(mpws_un_hash.get("mpwsunsafe"+rs2.getString(1))!=null){
			 String cpws=(String)mpws_un_hash.get("mpwsunsafe"+rs2.getString(1));
			 String cpwsar[]=cpws.split("@");
			 if(cpwsar[0]!=null){
			 mpwsunsafe=Integer.parseInt(cpwsar[0]);} if(cpwsar[1]!=null){
			mpwsunsafepop=Integer.parseInt(cpwsar[1]);}
		 }
		
		 if(hp_un_hash.get("hpunsafe"+rs2.getString(1))!=null){
			 String cpws=(String)hp_un_hash.get("hpunsafe"+rs2.getString(1));
			 String cpwsar[]=cpws.split("@");
			 if(cpwsar[0]!=null){
			 hpunsafe=Integer.parseInt(cpwsar[0]);} if(cpwsar[1]!=null){
			hpunsafepop=Integer.parseInt(cpwsar[1]);}
		 }
		 if(hp_hash.get("hpsafe"+rs2.getString(1))!=null){
			 String cpws=(String)hp_hash.get("hpsafe"+rs2.getString(1));
			 String cpwsar[]=cpws.split("@");
			 if(cpwsar[0]!=null){
			 hpsafe=Integer.parseInt(cpwsar[0]);} if(cpwsar[1]!=null){
			 hpsafepop=Integer.parseInt(cpwsar[1]);}
		 }
		 if(dp_hash.get("dpsafe"+rs2.getString(1))!=null){
			 String cpws=(String)dp_hash.get("dpsafe"+rs2.getString(1));
			 String cpwsar[]=cpws.split("@");
			 if(cpwsar[0]!=null){
			 dpsafe=Integer.parseInt(cpwsar[0]);} if(cpwsar[1]!=null){
			 dpsafepop=Integer.parseInt(cpwsar[1]);}
		 }
		%>
		<tr>
		 <td class="<%=style%>"> <%=sno++%></td>
		 <td class="<%=style%>" style="text-align: left;"> <%=rs2.getString(2)%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=cpwssafe%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=cpwssafepop%></td>
		 
		  
		 <td class="<%=style%>" style="text-align: right;"> <%=pwsunsafe%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=pwsunsafepop%></td>

		 <td class="<%=style%>" style="text-align: right;"> <%=mpwsunsafe%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=mpwsunsafepop%></td>

		 
		 <td class="<%=style%>" style="text-align: right;"> <%=hpunsafe%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=hpunsafepop%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=hpsafe%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=hpsafepop%></td>
		  <td class="<%=style%>" style="text-align: right;"> <%=dpsafe%></td>
		 <td class="<%=style%>" style="text-align: right;"> <%=dpsafepop%></td>
		 </tr>
		
		<%
		totcpwssafe+=cpwssafe;totcpwsunsafe+=cpwsunsafe;totpwssafe+=pwssafe;totpwsunsafe+=pwsunsafe;totmpwssafe+=mpwssafe;totmpwsunsafe+=mpwsunsafe;totdpsafe+=dpsafe;totdpunsafe+=dpunsafe;tothpsafe+=hpsafe;tothpunsafe+=hpunsafe;
		totcpwssafepop+=cpwssafepop;totcpwsunsafepop+=cpwsunsafepop;totpwssafepop+=pwssafepop;totpwsunsafepop+=pwsunsafepop;totmpwssafepop+=mpwssafepop;totmpwsunsafepop+=mpwsunsafepop;totdpsafepop+=dpsafepop;totdpunsafepop+=dpunsafepop;tothpsafepop+=hpsafepop;tothpunsafepop+=hpunsafepop;

	}

	%>
	<tr>
		
		 <td class=gridhdbg colspan="2" style="text-align: center;">Total</td>
		 <td class=gridhdbg style="text-align: right;"><%=totcpwssafe%></td>
		 <td class=gridhdbg style="text-align: right;"><%=totcpwssafepop%></td>
		
		 <td class=gridhdbg style="text-align: right;"> <%=totpwsunsafe%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=totpwsunsafepop%></td>

		 <td class=gridhdbg style="text-align: right;"> <%=totmpwsunsafe%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=totmpwsunsafepop%></td>


		 <td class=gridhdbg style="text-align: right;"> <%=tothpunsafe%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=tothpunsafepop%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=tothpsafe%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=tothpsafepop%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=totdpsafe%></td>
		 <td class=gridhdbg style="text-align: right;"> <%=totdpsafepop%></td>
		 </tr>
	<%
	}
	catch(Exception p)
	{
	p.printStackTrace();
	}

	%>

	</table>
	</body>
	<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
