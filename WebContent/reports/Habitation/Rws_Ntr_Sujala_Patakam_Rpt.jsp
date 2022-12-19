<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.util.*"%>
<%
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	String dcode = request.getParameter("district");
	session.setAttribute("dcode", dcode);
	
	String dname = request.getParameter("dname");
	session.setAttribute("dname", dname);
	
	System.out.println("d" + dcode);
	String myphase = request.getParameter("myphase");
	
	session.setAttribute("myphase", myphase);
%>
<html>
<body>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
<%//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td ><a href="./Rws_Ntr_Sujala_Patakam_Rpt_frm.jsp">Back|</a><a href="./Rws_Ntr_Sujala_Patakam_Excel.jsp">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" ><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	</table>
	
<table  cellspacing=0 cellpadding=0 width="60%"	 style="border-collapse: collapse" 	align="center">
<tr>
			<td align="center" class="gridhdbg" colspan=43>Sujala Patakam &nbsp;&nbsp;District:&nbsp;<%=dname%> </td>
	</tr>
	 <tr align="center" >
     <td rowspan=2 class="gridhdbg">SlNo</td>
     <td rowspan=2 class="gridhdbg">Constituency</td>
     <td rowspan=2 class="gridhdbg">Mandal</td>
     <td rowspan=2 class="gridhdbg">Panchayat</td>       
     <td rowspan=2 class="gridhdbg">Habitation/Habitation Name</td>
     <td rowspan=2 class="gridhdbg">Population</td>
     <td rowspan=2 class="gridhdbg">Coverage Status</td>     
     <td rowspan=2 class="gridhdbg">Type of Source</td> 
     <td rowspan=2 class="gridhdbg">Source Code</td> 
     <td rowspan=2 class="gridhdbg">Source Name</td>
     <td rowspan=2 class="gridhdbg">Source Location</td>
     <td rowspan=2 class="gridhdbg">Source Condition</td>
     <td colspan=2 class="gridhdbg">Existing Scheme Details (Covered by CPWS/PWS/ MPWS)</td>
     <td colspan=13 class="gridhdbg">Raw Water Chemical analysis details  and problem of the selected source</td> 
     <td rowspan=2 class="gridhdbg">Water Quality <br> issues identified </td>
     <td rowspan=2 class="gridhdbg">Type of Plant Suggested</td>   
     <td rowspan=2 class="gridhdbg">General Health issues identified in this habitation - Provide the details in consultation with Health Department</td>
     <td rowspan=2 class="gridhdbg">Availablity of existing Building  for installation of Water Treatment Plant</td>
     <td colspan=4 class="gridhdbg">Building Details</td>
     <td rowspan=2 class="gridhdbg">Whether any firm/ NGO/ SHGs  installed Water Treatment <br> plant in this habitation</td>
     <td colspan=3 class="gridhdbg">Firm/ NGO/ SHGs Details</td>
     <td rowspan=2 class="gridhdbg">Whether any Corporate  House/ NGO/ SHGs are ready  to take up this programme on voluntary basis</td>
     <td colspan=1 class="gridhdbg">Corporate House/ NGO/ SHGs  Details</td>    
     
         		
</tr>
<tr align="center" >
       <td class="gridhdbg">Type of Scheme</td> 
      <!--  <td class="gridhdbg">Type of Source (Surface/ Ground Water)</td> -->
       <td class="gridhdbg">Scheme Code/Scheme Name</td>   
       <td class="gridhdbg">Test Date</td> 
       <td class="gridhdbg">Colour (Co-Pt)</td>
       <td class="gridhdbg">Turbidity NTU</td>
       <td class="gridhdbg">pH</td>
       <td class="gridhdbg">TDS mg/l</td>
       <td class="gridhdbg">Fluoride mg/l</td>
       <td class="gridhdbg">Chlorides mg/l</td>
       <td class="gridhdbg">Nitrate mg/l</td>
       <td class="gridhdbg">Iron  (Fe) mg/l</td>
       <td class="gridhdbg">Sulphate mg/l as So4</td> 
       <td class="gridhdbg">Alkalinity mg/l as Caco3</td>
       <td class="gridhdbg">Hardness mg/l as Caco3</td>
       <td class="gridhdbg">E. Coli no/100Ml</td>	  
       <td class="gridhdbg">Name/Location/Size(sft)</td>
       <td class="gridhdbg">Is Water convinently Available</td>	     		
       <td class="gridhdbg">Distance of Water Available from Buliding(mts)</td> 
       <td class="gridhdbg">Is Power Available</td>	
       <td class="gridhdbg">Name/Location</td>
       <td class="gridhdbg">Exisiting Plant Type</td>
       <td class="gridhdbg">Plant Capacity(LPH)</td>
       <td class="gridhdbg">Name/Location</td>      
</tr>
<tr align="center"  class="gridhdbg">
<%
for(int k=1;k<42;k++)
{
%>
<td > <%=k %>  </td>


<%} %>

</tr>
<tr>
<%
Statement stmt1=null , stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
int count=1;
int styleCount=0;
String style="";
  try{
	  
	    String paraValuesQuery = "select distinct b.test_id, a.testing_parameter_code,nvl(a.testing_parameter_value,0),b.test_code  from  RWS_WQ_TEST_RESULTS_lnk_TBL a,RWS_WQ_TEST_RESULTS_TBL b    where a.test_id in(select test_id from rws_ntr_sujala_master_tbl where substr(hab_code,1,2)='"+dcode+"' and phase='"+myphase+"') and a.test_id=b.test_id and b.test_code in (1,2)  and a.testing_parameter_code in ('01','02','04','05','13','12','15','16','14','07','06') and substr(b.source_code,1,2)='"+dcode+"' ORDER BY (CASE a.testing_parameter_code     WHEN '01'	 THEN 1    WHEN '02'	 THEN 2    WHEN '04'	 THEN 3 WHEN '05'	 THEN 4    WHEN '13'    THEN 5    WHEN '12'	THEN 6    WHEN '15'	THEN 7    WHEN '16'	THEN 8    WHEN '14'	THEN 9  WHEN '05'	 THEN 10   WHEN '06'	THEN 11   ELSE 100 END) ASC";
	   // System.out.println("Query*********" + paraValuesQuery);
	    stmt2=conn.createStatement();	
	    Hashtable paraValues=new Hashtable();
	    rs2=stmt2.executeQuery(paraValuesQuery);	   	
		while (rs2.next()) 
		{ 
			System.out.println(rs2.getString(1)+rs2.getInt(4)+rs2.getString(2)+"==" + rs2.getDouble(3));
			paraValues.put(rs2.getString(1)+rs2.getInt(4)+rs2.getString(2), rs2.getDouble(3));
				
		}
		session.setAttribute("paraValues", paraValues);
		
		 if(stmt2!=null)
		  {
			  stmt2.close();
		   }
		  if(rs2!=null)
		  {
			  rs2.close();
		  } 
		  
	
 
 ///////////////////////////////////sources details//////////////////////////////////////////////////////////
	             
		     String sosourceDetails = "select distinct c.source_code,nvl(source_name,'-'),nvl(a.location,'-'),nvl(source_condition,'-'),source_type_name,a.asset_code,asset_name,e.type_of_asset_name from rws_source_tbl a,rws_source_type_tbl b,rws_ntr_sujala_master_tbl c,rws_asset_mast_tbl d ,rws_asset_type_tbl e   where  a.asset_code=d.asset_code  and d.TYPE_OF_ASSET_CODE =e.TYPE_OF_ASSET_CODE  and a.source_code=c.source_code and a.source_type_code=b.source_type_code and substr(c.source_code,1,2)='"+dcode+"' ";
		    // System.out.println("sosourceDetails*********" + sosourceDetails);
		     stmt2=conn.createStatement();	
		     Hashtable sosourceDetailsList=new Hashtable();
		     rs2=stmt2.executeQuery(sosourceDetails);	   	
			 while (rs2.next()) 
			 { 
				
				 sosourceDetailsList.put(rs2.getString(1), rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6)+"@"+rs2.getString(7)+"@"+rs2.getString(8));
				
			 }
			session.setAttribute("sosourceDetailsList", sosourceDetailsList);
			
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  } 		
			  
			  
			  String hpsourceDetails = "select distinct hp_code,nvl(a.location,'-'),nvl(a.status,'-'),a.asset_code,asset_name ,d.type_of_asset_name from rws_hp_subcomp_param_tbl a,rws_ntr_sujala_master_tbl b,rws_asset_mast_tbl c ,rws_asset_type_tbl d   where  a.asset_code=c.asset_code and c.TYPE_OF_ASSET_CODE =d.TYPE_OF_ASSET_CODE and a.hp_code=b.source_code  and substr(b.source_code,1,2)='"+dcode+"' ";
			//  System.out.println("hpsourceDetails*********" + hpsourceDetails);
			  stmt2=conn.createStatement();	
			  Hashtable hpsourceDetailsList=new Hashtable();
			  rs2=stmt2.executeQuery(hpsourceDetails);	   	
			  while (rs2.next()) 
				 { 
					
				  hpsourceDetailsList.put(rs2.getString(1), rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6));
					
				 }
				session.setAttribute("hpsourceDetailsList", hpsourceDetailsList);
				
				 if(stmt2!=null)
				  {
					  stmt2.close();
				   }
				  if(rs2!=null)
				  {
					  rs2.close();
				  } 		
				  
				  
				  String shsourceDetails = "select distinct SHALLOWHP_CODE,nvl(a.location,'-'),nvl(a.status,'-'),a.asset_code ,asset_name ,d.type_of_asset_name from RWS_SHALLOWHANDPUMPS_TBL a,rws_ntr_sujala_master_tbl b,rws_asset_mast_tbl c ,rws_asset_type_tbl d   where  a.asset_code=c.asset_code and c.TYPE_OF_ASSET_CODE =d.TYPE_OF_ASSET_CODE  and a.SHALLOWHP_CODE=b.source_code  and substr(b.source_code,1,2)='"+dcode+"' ";
				//  System.out.println("shsourceDetails*********" + shsourceDetails);
				  stmt2=conn.createStatement();	
				  Hashtable shsourceDetailsList=new Hashtable();
				  rs2=stmt2.executeQuery(shsourceDetails);	   	
				  while (rs2.next()) 
					 { 
						
					  shsourceDetailsList.put(rs2.getString(1), rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6));
						
					 }
					session.setAttribute("shsourceDetailsList", shsourceDetailsList);
					
					 if(stmt2!=null)
					  {
						  stmt2.close();
					   }
					  if(rs2!=null)
					  {
						  rs2.close();
					  } 		
					  
				  
					  String opsourceDetails = "select distinct OPENWELL_CODE,nvl(a.location,'-'),nvl(a.status,'-'),a.asset_code,asset_name ,d.type_of_asset_name from RWS_OPEN_WELL_MAST_TBL a,rws_ntr_sujala_master_tbl b,rws_asset_mast_tbl c ,rws_asset_type_tbl d    where a.asset_code=c.asset_code and c.TYPE_OF_ASSET_CODE =d.TYPE_OF_ASSET_CODE  and a.OPENWELL_CODE=b.source_code  and substr(b.source_code,1,2)='"+dcode+"' ";
					 // System.out.println("opsourceDetails*********" + opsourceDetails);
					  stmt2=conn.createStatement();	
					  Hashtable opsourceDetailsList=new Hashtable();
					  rs2=stmt2.executeQuery(opsourceDetails);	   	
					  while (rs2.next()) 
						 { 
							
						  opsourceDetailsList.put(rs2.getString(1), rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6));
							
						 }
						session.setAttribute("opsourceDetailsList", opsourceDetailsList);
						
						 if(stmt2!=null)
						  {
							  stmt2.close();
						   }
						  if(rs2!=null)
						  {
							  rs2.close();
						  } 		
				  
			  
						  String pdsourceDetails = "select distinct POND_CODE,nvl(a.POND_LOCATION,'-'),nvl(a.POND_LOCATION,'-'),a.asset_code,asset_name ,d.type_of_asset_name from RWS_OPENWELL_POND_TBL a,rws_ntr_sujala_master_tbl b  , rws_asset_mast_tbl c ,rws_asset_type_tbl d    where a.asset_code=c.asset_code and c.TYPE_OF_ASSET_CODE =d.TYPE_OF_ASSET_CODE  and a.POND_CODE=b.source_code  and substr(b.source_code,1,2)='"+dcode+"' ";
						//  System.out.println("pdsourceDetails*********" + pdsourceDetails);
						  stmt2=conn.createStatement();	
						  Hashtable pdsourceDetailsList=new Hashtable();
						  rs2=stmt2.executeQuery(pdsourceDetails);	   	
						  while (rs2.next()) 
							 { 
								
							  pdsourceDetailsList.put(rs2.getString(1), rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6));
								
							 }
							session.setAttribute("pdsourceDetailsList", pdsourceDetailsList);
							
							 if(stmt2!=null)
							  {
								  stmt2.close();
							   }
							  if(rs2!=null)
							  {
								  rs2.close();
							  } 		
					  
					  
		   
	  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		  
		    String habDetails = "select distinct panch_code,panch_name,coverage_status,sum(census_plain_popu+census_sc_popu+census_st_popu) from rws_complete_hab_view where dcode='"+dcode+"' group by panch_code,panch_name,coverage_status";
		  //  System.out.println("habDetails*********" + habDetails);
		    stmt2=conn.createStatement();	
		    Hashtable habDetailsList=new Hashtable();
		    rs2=stmt2.executeQuery(habDetails);	   	
			while (rs2.next()) 
			{ 
				
				habDetailsList.put(rs2.getString(1), rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
				
			}
			session.setAttribute("habDetailsList", habDetailsList);
			
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  } 		  
		  
		  
		  
		  
		  
		  
		  
		    String officeDetailsQuery1 = "select distinct dname,mname,mcode from rws_district_tbl a,rws_mandal_tbl b where a.dcode=b.dcode and a.dcode='"+dcode+"'";
		  //  System.out.println("officeDetailsQuery*********" + officeDetailsQuery1);
		    stmt2=conn.createStatement();	
		    Hashtable officeDetails1=new Hashtable();
		    rs2=stmt2.executeQuery(officeDetailsQuery1);	   	
			while (rs2.next()) 
			{ 
				
			  officeDetails1.put(rs2.getString(3), rs2.getString(1)+"@"+rs2.getString(2));
				
			}
			session.setAttribute("officeDetails1", officeDetails1);
			
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  } 		  
		
    String officeDetailsQuery = "select distinct mcode,CONSTITUENCY_NAME from RWS_CONSTITUENCY_TBL where dcode='"+dcode+"' and mcode is not null";
	//System.out.println("officeDetailsQuery*********" + officeDetailsQuery);
		    stmt2=conn.createStatement();	
		    Hashtable officeDetails=new Hashtable();
		    rs2=stmt2.executeQuery(officeDetailsQuery);	   	
			while (rs2.next()) 
			{ 
				
			  officeDetails.put(rs2.getString(1), rs2.getString(2));
				
			}
			session.setAttribute("officeDetails", officeDetails);
			
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  } 
		
			  
			  String panchQuery = "select mcode,pname from rws_panchayat_tbl  where dcode='"+dcode+"'";
			  //System.out.println("officeDetailsQuery*********" + officeDetailsQuery1);
			    stmt2=conn.createStatement();	
			    Hashtable panchDetails=new Hashtable();
			    rs2=stmt2.executeQuery(panchQuery);	   	
				while (rs2.next()) 
				{ 
					
					panchDetails.put(rs2.getString(1), rs2.getString(2));
					
				}
				session.setAttribute("panchDetails", panchDetails);
				
				 if(stmt2!=null)
				  {
					  stmt2.close();
				   }
				  if(rs2!=null)
				  {
					  rs2.close();
				  } 			  
			  
		
	//////////////////main/////////////////////	
			  String query="select distinct hab_code,source_code,QUALITY_ISSUE,TYPE_OF_PLANT,nvl(HEALTH_ISSUES,'-'),BLDG_AVAILABLE,nvl(BLDG_NAME,'-'),nvl(BLDG_LOCATION,'-'),BLDG_SIZE,WATER_AVAILABLE,nvl(WATER_DISTANCE,'-'),POWER_SUPPLY,WATER_PLANT_EXTIST,nvl(WATER_PLANT_FIRM,'-'),nvl(WATER_PLANT_LOCATION,'-'),nvl(PLANT_EXIST_TYPE,'-'),nvl(PLANT_CAPACITY,'0'),nvl(TAKE_PROGRAMME_VOL,'-'),nvl(TAKE_PROGRAMME_VOL_NAME,'-'),nvl(TAKE_PROGRAMME_VOL_LOC,'-'),test_id,to_char(test_date,'dd/mm/yyyy')  from rws_ntr_sujala_master_tbl where substr(hab_code,1,2)='"+dcode+"' and phase='"+myphase+"' order by hab_code";
			  System.out.println("main query:"+query);
			  stmt1=conn.createStatement();
			  rs1=stmt1.executeQuery(query);
			 int count1=0;
			 String sosourceValues[]=null;String officeValues[]=null;
			 String habValues[]=null;
			 String hpsourceValues[]=null;
			 String shsourceValues[]=null;
			 String pdsourceValues[]=null;
			 String opsourceValues[]=null;
			 String soassetValues[]=null;
			 String hpassetValues[]=null;
			 String opassetValues[]=null;
			 String shassetValues[]=null;
			 String pdassetValues[]=null;
			 String dist_name="",m_name="",pop="",cstatus="",panch_name="";
			 String soasset_code="",hpasset_code="",shasset_code="",opasset_code="",pdasset_code="";
			 String socode="",soname="",soloc="",sostatus="",soasset_name="",sotype="";
			 String hpcode="",hpname="",hploc="",hpstatus="",hpasset_name="",hptype="";
			 String shcode="",shname="",shloc="",shstatus="",shasset_name="",shtype="";
			 String opcode="",opname="",oploc="",opstatus="",opasset_name="",optype="";
			 String pdcode="",pdname="",pdloc="",pdstatus="",pdasset_name="",pdtype="";
			 String atype="";	
			  while(rs1.next())
			  	{
			 		
			 		count1++;
			  		//List1.put();
			  		String dist_code=rs1.getString(1).substring(0,2);
			  		String m_code=rs1.getString(1).substring(5,7);
			  		String source_code=rs1.getString(2).substring(19,21);
			  		System.out.println("source_code :::::::"+source_code);
			  		
			  		if(officeDetails1.get(m_code)!=null)
			  		{
			  		String officeList=(String)officeDetails1.get(m_code);
			  		officeValues=officeList.split("@");
			  		dist_name=officeValues[0];
			  		m_name=officeValues[1];
			  		}
			  		else
			  		{
			  			dist_name="-";
				  		m_name="-";
				  		
			  		}
			  		
			  		if(habDetailsList.get(rs1.getString(1))!=null)
			  		{
			  		String habList=(String)habDetailsList.get(rs1.getString(1));
			  		habValues=habList.split("@");
			  		panch_name=habValues[0];
			  		pop=habValues[2];
			  		cstatus=habValues[1];		  		
			  		}
			  		else
			  		{   panch_name="";
			  			pop="-";
				  		cstatus="-";
			  		}
			  		
			  		if(sosourceDetailsList.get(rs1.getString(2))!=null)
			  		{
			  		   String sourceList=(String)sosourceDetailsList.get(rs1.getString(2));
			  		   sosourceValues=sourceList.split("@");
			  		   socode=sosourceValues[0];
			  		   soname=sosourceValues[1];
			  		   soloc=sosourceValues[2];
			  		   soasset_code=sosourceValues[4];
			  		   soasset_name=sosourceValues[5];
			  		   sotype=sosourceValues[6];
			  		 
				  		if(sosourceValues[3]!=null)
				  		{
				  		String asset_type=sosourceValues[3];
				  	 	
					  		
					  		if(source_code.equals("SO"))
					  		{
					  			if(sosourceValues[3].equals("SUBSURFACE SOURCE"))
					  			{				  					
					  			  atype="Ground Water";
					  			  
					  			}
					  			else
					  			{
					  				atype=sosourceValues[3];
					  			}
					  		}
					  		else
					  		{
					  			atype="Ground Water";
					  		}
				  		
				  		}
				  		
			  		   
			  		}
			  		else
			  		{
			  			   socode="-";
				  		   soname="-";
				  		   soloc="-";
				  		   soasset_code="-";
				  		   soasset_name="-";
				  		   sotype="-";
			  		}
			  		
			  		
			  		if(hpsourceDetailsList.get(rs1.getString(2))!=null)
			  		{
			  		   String hpList=(String)hpsourceDetailsList.get(rs1.getString(2));
			  		   hpsourceValues=hpList.split("@");
			  		   hpasset_code=hpsourceValues[2];
			  		   hpcode=hpsourceValues[0];
			  		   hploc=hpsourceValues[1];
			  		   hpasset_name=hpsourceValues[3];
			  		   hptype=hpsourceValues[4];
			  		   
			  		}
			  		else
			  		{
			  			   hpasset_code="-";
				  		   hpcode="-";
				  		   hploc="-";
				  		   hpasset_name="-";
				  		   hptype="-";
			  			
			  		}
			  		
			  		if(shsourceDetailsList.get(rs1.getString(2))!=null)
			  		{
			  		   String shpList=(String)shsourceDetailsList.get(rs1.getString(2));
			  		   shsourceValues=shpList.split("@");
			  		    shasset_code=shsourceValues[2];
			  		    shloc=shsourceValues[0];
			  		    shstatus=shsourceValues[1];	
			  		    shasset_name=shsourceValues[3];
			  		    shtype=shsourceValues[4];
			  		}
			  		else
			  		{
			  			shasset_code="-";
			  		    shloc="-";
			  		    shstatus="-";
			  		    shasset_name="-";
			  		    shtype="-";
			  		}
			  		
			  		if(opsourceDetailsList.get(rs1.getString(2))!=null)
			  		{
			  		   String opList=(String)opsourceDetailsList.get(rs1.getString(2));
			  		   opsourceValues=opList.split("@");
			  		   opasset_code=opsourceValues[2];
			  		   oploc=opsourceValues[0];
			  		   opstatus=opsourceValues[1];
			  		   opasset_name=opsourceValues[3];
			  		   optype=opsourceValues[4];
			  		}
			  		else
			  		{
			  			   opasset_code="-";
				  		   oploc="-";
				  		   opstatus="-";
				  		   opasset_name="-";
				  		   optype="-";
			  		}
			  		
			  		
			  		if(pdsourceDetailsList.get(rs1.getString(2))!=null)
			  		{
			  		   String pdList=(String)pdsourceDetailsList.get(rs1.getString(2));
			  		   pdsourceValues=pdList.split("@");
			  		   pdasset_code=pdsourceValues[2];
			  		   pdloc=pdsourceValues[0];
			  		   pdstatus=pdsourceValues[1];
			  		   pdasset_name=pdsourceValues[3];
			  		   pdtype=pdsourceValues[4];
			  		}
			  		else
			  		{
			  			   pdasset_code="-";
				  		   pdloc="-";
				  		   pdstatus="-";
				  		   pdasset_name="-";
				  		   pdtype="-";
			  		}
			  			
			  		String const_name="",p_name="";		
			  			
			  		
			  		if((String)officeDetails.get(m_code)!=null)
			  		{
			  		 const_name=(String)officeDetails.get(m_code);
			  		}
			  		else
			  		{
			  		  const_name="-";
			  		}
			  		
			  		
			  		if((String)panchDetails.get(m_code)!=null)
			  		{
			  		 p_name=(String)panchDetails.get(m_code);
			  		}
			  		else
			  		{
			  			p_name="-";
			  		}
			  		
			  		//parameter values//
			  		Double color=0.0,turbidity=0.0,ph=0.0,tds=0.0,floride=0.0,chloride=0.0,nitrate=0.0,iron=0.0,sulphate=0.0,alkalinity=0.0,hardness=0.0,ecoli=0.0;
			  		////////////////
			  		 
			  		if(paraValues!=null){
			  		   if(paraValues.get(rs1.getString(21)+1+"01")!=null)
						{
						 color=(Double)paraValues.get(rs1.getString(21)+1+"01");
						}
						
						if(paraValues.get(rs1.getString(21)+1+"02")!=null)
						{
							turbidity=(Double)paraValues.get(rs1.getString(21)+1+"02");
									
						}
						if(paraValues.get(rs1.getString(21)+1+"04")!=null)
						{
							ph=(Double)paraValues.get(rs1.getString(21)+1+"04");
									
						}
						if(paraValues.get(rs1.getString(21)+1+"05")!=null)
						{
							tds=(Double)paraValues.get(rs1.getString(21)+1+"05");
									
						}
						if(paraValues.get(rs1.getString(21)+1+"13")!=null)
						{
							floride=(Double)paraValues.get(rs1.getString(21)+1+"13");
								
						}
						if(paraValues.get(rs1.getString(21)+1+"12")!=null)
						{
							chloride=(Double)paraValues.get(rs1.getString(21)+1+"12");
								
						}
						if(paraValues.get(rs1.getString(21)+1+"15")!=null)
						{
							nitrate=(Double)paraValues.get(rs1.getString(21)+1+"15");
									
						}
						if(paraValues.get(rs1.getString(21)+1+"16")!=null)
						{
							iron=(Double)paraValues.get(rs1.getString(21)+1+"16");
									
						}
						if(paraValues.get(rs1.getString(21)+1+"14")!=null)
						{
							sulphate=(Double)paraValues.get(rs1.getString(21)+1+"14");
								
						}
						if(paraValues.get(rs1.getString(21)+1+"07")!=null)
						{
							alkalinity=(Double)paraValues.get(rs1.getString(21)+1+"07");
								
						}
						if(paraValues.get(rs1.getString(21)+1+"06")!=null)
						{
							hardness=(Double)paraValues.get(rs1.getString(21)+1+"06");
										
						}
						if(paraValues.get(rs1.getString(21)+2+"02")!=null)
						{
							ecoli=(Double)paraValues.get(rs1.getString(21)+2+"02");
									
						} 
			  		
			  		}
			  		
			  		
			  		/* String schmeType="";
			  		if(sosourceValues[6]!=null && (sosourceValues[6].equals("PWS") || sosourceValues[6].equals("CPWS") ||  sosourceValues[6].equals("MPWS")))
			  		{
			  			schmeType="Surface";
			  		}
			  		 	
			  		else
			  		{
			  			schmeType="Ground Water";
			  		}
			  	 */	
			  	
			  	 if(styleCount%2==0)
			  	 {
					 style="gridbg1";
				 }else
				 {
					 style="gridbg2";
				 }
				 styleCount++;
				%>
				<tr>
				    <td class=<%=style %> style="text-align: center;"><%=count++ %></td>
				    <td class=<%=style %> style="text-align: left;"><%=const_name %></td>
				    <td class=<%=style %> style="text-align: left;"><%=m_name%></td>
				    <td class=<%=style %> style="text-align: left;"><%=p_name%></td>
			        <td class=<%=style %> style="text-align: left;">&nbsp;<%=rs1.getString(1) %>/<%=panch_name %></td>
			        <td class=<%=style %> style="text-align: left;"><%=pop%></td>
				    <td class=<%=style %> style="text-align: left;"><%=cstatus%></td>		    
				    <td class=<%=style %> style="text-align: left;"><%=atype%></td>
				    <td class=<%=style %> style="text-align: right;"><%=rs1.getString(2) %></td>
				    
				   <% if(rs1.getString(2).substring(19,21).equals("SO"))
				   {		   
				   %>
			        <td class=<%=style %> style="text-align: left;"><%=socode%></td>
			        <td class=<%=style %> style="text-align: left;"><%=soname%></td> 
				    <td class=<%=style %> style="text-align: left;"><%=soloc%></td>
				   
				    
				   <%}
				   
				   else if(rs1.getString(2).substring(19,21).equals("HP"))
				   {		   
				   %>
			        <td class=<%=style %> style="text-align: left;">-</td>
			        <td class=<%=style %> style="text-align: left;"><%=hploc%></td> 
				    <td class=<%=style %> style="text-align: left;"><%=hpstatus%></td>
				    
				   <%}
				   else if(rs1.getString(2).substring(19,21).equals("SH"))
				   {		   
				   %>
			        <td class=<%=style %> style="text-align: left;">-</td>
			        <td class=<%=style %> style="text-align: left;"><%=shloc%></td> 
				    <td class=<%=style %> style="text-align: left;"><%=shstatus%></td>
				    
				   <%}
				   else if(rs1.getString(2).substring(19,21).equals("OW"))
				   {		   
				   %>
			        <td class=<%=style %> style="text-align: left;">-</td>
			        <td class=<%=style %> style="text-align: left;"><%=oploc%></td> 
				    <td class=<%=style %> style="text-align: left;"><%=opstatus%></td>
				    
				   <%}
				   else if(rs1.getString(2).substring(19,21).equals("PD"))
				   {		   
				   %>
			        <td class=<%=style %> style="text-align: left;">-</td>
			        <td class=<%=style %> style="text-align: left;"><%=pdloc%></td> 
				    <td class=<%=style %> style="text-align: left;"><%=pdstatus%></td>
				    
				   <%
				   }
				   %>
				   
				  <!-- asset details -->
				   
				   <% if(rs1.getString(2).substring(19,21).equals("SO"))
				   {		   
				   %>
				   
				    <td class=<%=style %> style="text-align: left;"><%=sotype%></td>
			       <%--  <td class=<%=style %> style="text-align: left;"><%=schmeType %></td>  --%>
				
				   <%}
				    else if(rs1.getString(2).substring(19,21).equals("HP"))
					   {		   
					   %>
					   
					    <td class=<%=style %> style="text-align: left;"><%=hptype%></td>
				      <%--   <td class=<%=style %> style="text-align: left;"><%=schmeType %></td>  --%>
					   
					   <%
					   }
				   else if(rs1.getString(2).substring(19,21).equals("SH"))
				   {		   
				   %>
				   
				    <td class=<%=style %> style="text-align: left;"><%=shtype%></td>
			      <%--   <td class=<%=style %> style="text-align: left;"><%=schmeType %></td>  --%>
				   
				   <%
				   }
				   else if(rs1.getString(2).substring(19,21).equals("OW"))
				   {		   
				   %>
				   
				    <td class=<%=style %> style="text-align: left;"><%=optype%></td>
			      <%--   <td class=<%=style %> style="text-align: left;"><%=schmeType %></td>  --%>
				   
				   <%
				   }
				   else if(rs1.getString(2).substring(19,21).equals("PD"))
				   {		   
				   %>
				   
				    <td class=<%=style %> style="text-align: left;"><%=pdtype%></td>
			       <%--  <td class=<%=style %> style="text-align: left;"><%=schmeType %></td>  --%>
				   
				   <%
				   }
				       %>
				   
				   
				    
				   <!--   ///////////////////////////////////-->
				    <% if(rs1.getString(2).substring(19,21).equals("SO"))
				   {		   
				   %>
			          <td class=<%=style %> style="text-align: left;"><%=soasset_code%>/<%=soasset_name%></td>
				    
				   <%}
				   
				   else if(rs1.getString(2).substring(19,21).equals("HP"))
				   {		   
				   %>
			          <td class=<%=style %> style="text-align: left;"><%=hpasset_code%>/<%=hpasset_name%></td>
				    
				   <%}
				   else if(rs1.getString(2).substring(19,21).equals("SH"))
				   {		   
				   %>
			          <td class=<%=style %> style="text-align: left;"><%=shasset_code%>/<%=shasset_name%></td>
				    
				   <%}
				   else if(rs1.getString(2).substring(19,21).equals("OW"))
				   {		   
				   %>
			          <td class=<%=style %> style="text-align: left;"><%=opasset_code%>/<%=opasset_name%></td>
				    
				   <%}
				   else if(rs1.getString(2).substring(19,21).equals("PD"))
				   {		   
				   %>
			        <td class=<%=style %> style="text-align: left;"><%=pdasset_code%>/<%=pdasset_name%></td>
				    
				   <%
			      }
				   %>
				    
				   <!--   ///////////////////////////////////-->
				   	  
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(22) %></td>
				    <td class=<%=style %> style="text-align: left;"><%=color %></td>
				    <td class=<%=style %> style="text-align: left;"><%=turbidity %></td>       
			       
			        <td class=<%=style %> style="text-align: left;"><%=ph %></td>
				    <td class=<%=style %> style="text-align: left;"><%=tds %></td>
				    <td class=<%=style %> style="text-align: left;"><%=floride %></td>	       
			       
			       <td class=<%=style %> style="text-align: left;"><%=chloride %></td>
				    <td class=<%=style %> style="text-align: left;"><%=nitrate %></td>
				    <td class=<%=style %> style="text-align: left;"><%=iron %></td>	       
			       
			       <td class=<%=style %> style="text-align: left;"><%=sulphate %></td>
				    <td class=<%=style %> style="text-align: left;"><%=alkalinity %></td>
				    <td class=<%=style %> style="text-align: left;"><%=hardness %></td>	       
			       
			        <td class=<%=style %> style="text-align: left;"><%=ecoli %></td>
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(3) %></td>
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(4) %></td>	       
			        <td class=<%=style %> style="text-align: left;"><%=rs1.getString(5) %></td>	       
			       
			       <td class=<%=style %> style="text-align: left;"><%=rs1.getString(6) %></td>
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(7) %>/<%=rs1.getString(8) %>/<%=rs1.getString(9) %></td>
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(10) %></td>	       
			       
			       <td class=<%=style %> style="text-align: left;"><%=rs1.getString(11) %></td>
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(12) %></td>
				    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(13) %></td>	       
			       
			       <td class=<%=style %> style="text-align: left;"><%=rs1.getString(14) %>/<%=rs1.getString(15) %></td>
				   <td class=<%=style %> style="text-align: left;"><%=rs1.getString(16) %></td>
				   <td class=<%=style %> style="text-align: left;"><%=rs1.getString(17) %></td>	       
			       <td class=<%=style %> style="text-align: left;"><%=rs1.getString(18) %></td>
				   <td class=<%=style %> style="text-align: left;"><%=rs1.getString(19) %>/<%=rs1.getString(20) %></td>	       
			              
			       
		     </tr>

				<%
			  	}
			  
			  if(count1==0)
			  {
				  %>
				<tr>
				    <td colspan=42 class=btext style="text-align: center;" >No Records</td>
				</tr>  
			<% }
			  if(stmt1!=null)
			  {
				  stmt1.close();
			   }
			  if(rs1!=null){
				  rs1.close();
				  	  }
			  
			  

		}catch(Exception e)
		{
		e.printStackTrace();
		}

		%>

		</table>	

		<%@ include file = "/reports/footer.jsp" %>
		</body>
		</html>