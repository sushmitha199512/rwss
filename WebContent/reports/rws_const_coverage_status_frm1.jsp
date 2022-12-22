<%@ include file = "conn3.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html>
<head>
 <script>
   window.history.forward(1);
 </script>
</head>
<%

	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st41=null;
	Statement st11=null,st22=null;
	ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs41=null;
	ResultSetMetaData rsm=null;
	String query1=null,query2=null,query3=null,query4=null,query5=null,query6=null;	
	String discode=null,disname=null,mandalname=null,empty="-";
	String contname=null;
	int totalpop=0,hpcount=0;
		
%>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border="1">

<tr>
	<td align="center" colspan="45"> Wash Cost Report</td>	
</tr>
<tr align="center">
<tr>
    <td class="btext" rowspan="2">Sno</td>
    <td class="btext" rowspan="2">District Name</td>
    <td class="btext" rowspan="2">Mandal Name</td>
    <td class="btext" rowspan="2">Habitation Name</td>
	<td class="btext" rowspan="2">Habitation Code</td>

    <td class="btext" colspan="4" >Census Population</td>
    <td align="center" class="btext"  colspan="2"  >No.Of</td>
    <td class="btext" rowspan="2" >Updated Date</td>
    <td class="btext" rowspan="2" >Handpumps No</td>
    <td align="center" class="btext" colspan="2" >PWS</td>
	<td align="center" class="btext" colspan="2" >MPWS</td>
	<td align="center" class="btext" colspan="2" >CPWS</td>
	<td class="btext" colspan="2" >CoverageStatus</td>
	<td class="btext" rowspan="2" >Water Quality (F / Br / Others)</td>
  </tr>
	
  <tr align="center">
 <td class="btext" >Plain</td>
    <td class="btext">SC</td>
    <td class="btext">ST</td>
    <td class="btext">Total</td> 
    <td class="btext">Households</td>
    <td class="btext" >Cattle</td>
    <td class="btext">Groundwater-No of BoreWells</td>
    <td class="btext">Surface water (Y/N)</td> 
    <td class="btext">Groundwater-No of BoreWells</td>
    <td class="btext">Surface water (Y/N)</td>
	<td class="btext">Groundwater-No of BoreWells</td>
    <td class="btext">Surface water (Y/N)</td>
	<td class="btext">Prev yr</td>
    <td class="btext">Present yr</td>
        
  </tr>
 
   <%
   try
   {
   int slno = 1;
   st1=conn.createStatement();
   
    	 System.out.println("connection created");
   query1="select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,hd.census_plain_popu, hd.census_sc_popu, hd.census_st_popu,sum(hd.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as total,NVL(hd.household_no,'0'),NVL(hd.no_of_cattle,'0'),to_char(hd.update_date,'DD/MM/YYYY') , NVL(hd.previous_yr_status,'-'),NVL(hd.present_yr_status,'-') from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr(h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='11'  GROUP BY d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,hd.census_plain_popu, hd.census_sc_popu, hd.census_st_popu,hd.previous_yr_status,hd.present_yr_status,hd.update_date,hd.household_no,hd.no_of_cattle order by d.dcode,m.mcode,p.pcode,v.vcode,h.panch_code";
   
   //System.out.println("query1"+query1);
   rs1=st1.executeQuery(query1);
   //System.out.println("query1"+query1);
   while(rs1.next()){
   st2=conn.createStatement();
   st3=conn.createStatement();
        discode=rs1.getString(1);
        disname=rs1.getString(2);
        mandalname=rs1.getString(4);
        
        query2="select count(*) as hpcount from rws_hp_subcomp_param_tbl where substr(hp_code,1,16) ='"+rs1.getString(9)+"'";
        //System.out.println("query2"+query2);
          rs2=st2.executeQuery(query2);
          while(rs2.next()){
          hpcount=rs2.getInt("hpcount");
           // System.out.println("hpcount"+rs2.getInt("hpcount"));
            }
         query3="select a.contamination_name as contname from rws_contamination_tbl a,rws_hab_contamination_tbl b where b.hab_code='"+rs1.getString(9)+"' and a.contamination_code=b.cont_type order by b.cont_perc desc";
         rs3=st3.executeQuery(query3);
         //System.out.println("query3"+query3);
          if(rs3.next()){
           contname=rs3.getString("contname");
          // System.out.println("contname"+contname);
            } else{
            contname="-";
            
            }
    %>
   <tr bgcolor="#edf2f8">
	<td  class="rptValue" ><%=slno++%></td>
	<td  class="rptValue" ><%=rs1.getString(2)%></td>
	<td  class="rptValue" ><%=rs1.getString(4)%></td>
	<td  class="rptValue" ><%=rs1.getString(10)%></td>
	<td  class="rptValue" >&nbsp;<%=rs1.getString(9)%></td>
	<td  class="rptValue" ><%=rs1.getInt(11)%></td>
	<td  class="rptValue" ><%=rs1.getInt(12)%></td>
	<td  class="rptValue" ><%=rs1.getInt(13)%></td>
	<td  class="rptValue" ><%=rs1.getInt("total")%></td>
	<td  class="rptValue" ><%=rs1.getString(15)%></td>
	<td  class="rptValue" ><%=rs1.getString(16)%></td>
	<td  class="rptValue" ><%=rs1.getString(17)%></td>
	<td  class="rptValue" ><%=hpcount%></td>
	<td  class="rptValue" ><%=empty%></td>
	<td  class="rptValue" ><%=empty%></td>
	<td  class="rptValue" ><%=empty%></td>
	<td  class="rptValue" ><%=empty%></td>
	<td  class="rptValue" ><%=empty%></td>
	<td  class="rptValue" ><%=empty%></td>
	<td  class="rptValue" ><%=rs1.getString(18)%></td>
	<td  class="rptValue" ><%=rs1.getString(19)%></td>
	<td  class="rptValue" ><%=contname%></td>
	
	
	<%
	//System.out.println("count"+slno);
	rs3.close();
   	st3.close();
   	rs2.close();
   	st2.close();
	}
	
	}
	catch(Exception e)
   {
     conn.close();
   	 conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
   	 System.out.println("Exception1 "+e);
  	 
   }
    finally
   {
    
   	rs1.close();
   	st1.close();
   	conn.close();
   }
   %>
     </table>
   <%
  System.out.println("Printed Successfully");
%>
