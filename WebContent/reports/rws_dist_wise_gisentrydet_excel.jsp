<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "GISEntryDetails.xls");

%>
<%


String qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry7="",qry8="",qry9="",qry10="",qry11="",qry12="",qry13="",qry14="",qry15="",qry16="",qry17="",qry18="",qry19="",qry20="",qry21="",qry22="",qry23="",qry24="";
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null,st14=null,st15=null,st16=null,st17=null,st18=null,st19=null,st20=null,st21=null,st22=null,st23=null,st24=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs13=null,rs14=null,rs15=null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null,rs23=null,rs24=null;
int slno=0;
int habtot=0,habgistot=0,assttot=0,asstgistot=0,schtot=0,schgistot=0,hptot=0,hpgistot=0,shptot=0,shpgistot=0,optot=0,opgistot=0,glbrtot=0,glbrgistot=0,glsrtot=0,glsrgistot=0,ohbrtot=0,ohbrgistot=0,ohsrtot=0,ohsrgistot=0,pumptot=0,pumpgistot=0,filtot=0,filgistot=0;
Hashtable h1=new Hashtable();
Hashtable h2=new Hashtable();
Hashtable h3=new Hashtable();
Hashtable h4=new Hashtable();
Hashtable h5=new Hashtable();
Hashtable h6=new Hashtable();
Hashtable h7=new Hashtable();
Hashtable h8=new Hashtable();
Hashtable h9=new Hashtable();
Hashtable h10=new Hashtable();
Hashtable h11=new Hashtable();
Hashtable h12=new Hashtable();
Hashtable h13=new Hashtable();
Hashtable h14=new Hashtable();
Hashtable h15=new Hashtable();
Hashtable h16=new Hashtable();
Hashtable h17=new Hashtable();
Hashtable h18=new Hashtable();
Hashtable h19=new Hashtable();
Hashtable h20=new Hashtable();
Hashtable h21=new Hashtable();
Hashtable h22=new Hashtable();
Hashtable h23=new Hashtable();
Hashtable h24=new Hashtable();
try{

//-------------------------habs---------------------------------
//qry1="select count(*),substr(hab_code,1,2) from rws_panchayat_raj_tbl group by substr(hab_code,1,2)"; 
qry1="select count(*),substr(a.hab_code,1,2) FROM rws_panchayat_raj_tbl A,RWS_HABITATION_DIRECTORY_TBL B  WHERE  A.panch_code=B.HAB_CODE AND B.HAB_CODE IS NOT NULL AND COVERAGE_STATUS <>'UI' group by substr(a.hab_code,1,2)";
st1=conn.createStatement();
rs1=st1.executeQuery(qry1);
while(rs1.next())
{
h1.put(rs1.getString(2),rs1.getString(1));
}
//System.out.println("qry1......"+qry1);
//---------------------------------------------------------------

qry2="select count(*),substr(a.hab_code,1,2) from rws_panchayat_raj_tbl A,RWS_HABITATION_DIRECTORY_TBL B where (latitude is not null and  longitude is not null) and A.panch_code=B.HAB_CODE AND B.HAB_CODE IS NOT NULL AND COVERAGE_STATUS <>'UI' group by substr(a.hab_code,1,2)";
    st2=conn.createStatement();
	rs2=st2.executeQuery(qry2);
   while(rs2.next())
  {
   h2.put(rs2.getString(2),rs2.getString(1));
  }
//System.out.println("qry2......"+qry2);
//----------------------------------------------------------------------------asset mast table

qry3="select count(*),CIRCLE_OFFICE_CODE  from rws_asset_mast_tbl where TYPE_OF_ASSET_CODE in('01','02','03','09')  group by CIRCLE_OFFICE_CODE ";
st3=conn.createStatement();
rs3=st3.executeQuery(qry3);
while(rs3.next())
 
{
   h3.put(rs3.getString(2),rs3.getString(1));
 }
//System.out.println("qry3......"+qry3);

qry4="select  count(*),CIRCLE_OFFICE_CODE FROM rws_asset_mast_tbl  subCompTbl WHERE  subCompTbl.TYPE_OF_ASSET_CODE in ('01','02','03','09')  and subCompTbl.latitude is not null and  subCompTbl.longitude is not null group by CIRCLE_OFFICE_CODE" ; 
st4=conn.createStatement();
rs4=st4.executeQuery(qry4);
while(rs4.next())
 
{
   h4.put(rs4.getString(2),rs4.getString(1));
 }
System.out.println("qry4......"+qry4);

//--------------------------------schools-----------------------------

qry5="select count(*),substr(hab_code,1,2) from rws_school_master_tbl group by substr(hab_code,1,2)";
st5=conn.createStatement();
rs5=st5.executeQuery(qry5);
while(rs5.next())
{
   h5.put(rs5.getString(2),rs5.getString(1));
}
//System.out.println("qry5......"+qry5);

qry6="select  count(*),substr(hab_code,1,2) FROM rws_school_master_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(hab_code,1,2)" ; 
st6=conn.createStatement();
rs6=st6.executeQuery(qry6);
while(rs6.next())
{
   h6.put(rs6.getString(2),rs6.getString(1));
}
//System.out.println("qry6......"+qry6);
//---------------------------------sources-----------------hp tables
qry7="select  count(*),substr(hp_code,1,2) FROM rws_hp_subcomp_param_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group  by substr(hp_code,1,2)"; 
st7=conn.createStatement();
rs7=st7.executeQuery(qry7);
while(rs7.next())
{
   h7.put(rs7.getString(2),rs7.getString(1));
}
//System.out.println("qry7......"+qry7);

qry8="select count(*),substr(hp_code,1,2) from rws_hp_subcomp_param_tbl group by substr(hp_code,1,2)";
st8=conn.createStatement();
rs8=st8.executeQuery(qry8);
while(rs8.next())
{
   h8.put(rs8.getString(2),rs8.getString(1));
}
//System.out.println("qry8......"+qry8);

//--------------------------------Shps--------------------------------------


qry9="select count(*),substr(hab_code,1,2) from rws_shallowhandpumps_tbl group by substr(hab_code,1,2)";
st9=conn.createStatement();
rs9=st9.executeQuery(qry9);
while(rs9.next())
{
   h9.put(rs9.getString(2),rs9.getString(1));
}
//System.out.println("qry9......"+qry9);
//6021
qry10="select  count(*),substr(hab_code,1,2) FROM rws_shallowhandpumps_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(hab_code,1,2)"; 
//3019
st10=conn.createStatement();
rs10=st10.executeQuery(qry10);
while(rs10.next())
{
   h10.put(rs10.getString(2),rs10.getString(1));
}
//System.out.println("qry10......"+qry10);
//---------------------------------------------------------------op------------------------------------------------------------------
///
qry11="select count(*),substr(habitation_code,1,2) from rws_open_well_mast_tbl group by substr(habitation_code,1,2)";
//2772
st11=conn.createStatement();
 rs11=st11.executeQuery(qry11);
while(rs11.next())
{
   h11.put(rs11.getString(2),rs11.getString(1));
}
//System.out.println("qry11......"+qry11);

qry12="select  count(*),substr(habitation_code,1,2) FROM rws_open_well_mast_tbl  subCompTbl WHERE  (subCompTbl.latitude is not null and  subCompTbl.longitude is not null) group by substr(habitation_code,1,2)" ;
//386
st12=conn.createStatement();
rs12=st12.executeQuery(qry12);

while(rs12.next())
{
   h12.put(rs12.getString(2),rs12.getString(1));
}
//System.out.println("qry12......"+qry12);

//-------------------------------------glsr---------------------------------------------
qry13="select count(*),substr(glsr_code,1,2) from rws_ast_glsr_sc_param_tbl group by substr(glsr_code,1,2)";
//12325
st13=conn.createStatement();
rs13=st13.executeQuery(qry13);
while(rs13.next())
{
   h13.put(rs13.getString(2),rs13.getString(1));
}
System.out.println("qry13......"+qry13);

qry14="select  count(*),substr(glsr_code,1,2) FROM rws_ast_glsr_sc_param_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(glsr_code,1,2)"; 
st14=conn.createStatement();
rs14=st14.executeQuery(qry14);
while(rs14.next())
{
   h14.put(rs14.getString(2),rs14.getString(1));
}
//System.out.println("qry14......"+qry14);

//---------------------------------glbr---------------------------------------------------------------


qry15="select count(*),substr(glbr_code,1,2) from rws_ast_glbr_sc_param_tbl group by substr(glbr_code,1,2)";
st15=conn.createStatement();
rs15=st15.executeQuery(qry15);
while(rs15.next())
{
   h15.put(rs15.getString(2),rs15.getString(1));
}
//System.out.println("qry15......"+qry15);

qry16="select  count(*),substr(glbr_code,1,2) FROM rws_ast_glbr_sc_param_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(glbr_code,1,2)"; 
//11
st16=conn.createStatement();
rs16=st16.executeQuery(qry16);
while(rs16.next())
{
   h16.put(rs16.getString(2),rs16.getString(1));
}
//System.out.println("qry16......"+qry16);

//------------------------------------ohsr-------------------------------------



qry17="select count(*),substr(ohsr_code,1,2) from rws_ast_ohsr_sc_param_tbl group by substr(ohsr_code,1,2)";//30502
st17=conn.createStatement();
rs17=st17.executeQuery(qry17);
while(rs17.next())
{
   h17.put(rs17.getString(2),rs17.getString(1));
}
//System.out.println("qry17......"+qry17);

qry18="select  count(*),substr(ohsr_code,1,2) FROM rws_ast_ohsr_sc_param_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(ohsr_code,1,2)"; 
//7208
st18=conn.createStatement();
rs18=st18.executeQuery(qry18);
while(rs18.next())
{
   h18.put(rs18.getString(2),rs18.getString(1));
}
//System.out.println("qry18......"+qry18);

//----------------------ohbr-----------------------------

qry19="select count(*),substr(ohbr_code,1,2) from rws_ast_ohbr_sc_param_tbl group by substr(ohbr_code,1,2)";//357
st19=conn.createStatement();
rs19=st19.executeQuery(qry19);
while(rs19.next())
{
   h19.put(rs19.getString(2),rs19.getString(1));
}
//System.out.println("qry19......"+qry19);

qry20="select  count(*),substr(ohbr_code,1,2) FROM rws_ast_ohbr_sc_param_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(ohbr_code,1,2)"; 
//52
st20=conn.createStatement();
rs20=st20.executeQuery(qry20);
while(rs20.next())
{
   h20.put(rs20.getString(2),rs20.getString(1));
}
//System.out.println("qry20....."+qry20);
//-------------------------------------pumpset-------------------------------------


qry21="select count(*),substr(pump_code,1,2) from rws_ast_subcomp_param_tbl group by substr(pump_code,1,2)";//52584
st21=conn.createStatement();
rs21=st21.executeQuery(qry21);
while(rs21.next())
{
   h21.put(rs21.getString(2),rs21.getString(1));
}
//System.out.println("qry21......"+qry21);

qry22="select  count(*),substr(pump_code,1,2) FROM rws_ast_subcomp_param_tbl subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null  group by substr(pump_code,1,2)"; 
//9037
st22=conn.createStatement();
rs22=st22.executeQuery(qry22);
while(rs22.next())
{
   h22.put(rs22.getString(2),rs22.getString(1));
}
//System.out.println("qry22......"+qry22);

//-----------------------------------Filters--------------------------------------

qry23="select count(*),substr(WTPSC_CODE,1,2) from rws_ast_wtp_sc_param_tbl group by substr(WTPSC_CODE,1,2)";
//1607
st23=conn.createStatement();
rs23=st23.executeQuery(qry23);
while(rs23.next())
{
   h23.put(rs23.getString(2),rs23.getString(1));
}
//System.out.println("qry23......"+qry23);

qry24="select  count(*),substr(WTPSC_CODE,1,2) FROM rws_ast_wtp_sc_param_tbl  subCompTbl WHERE  subCompTbl.latitude is not null and  subCompTbl.longitude is not null and  subCompTbl.elevation is not null  group by substr(WTPSC_CODE,1,2)"; 
//873
st24=conn.createStatement();
rs24=st24.executeQuery(qry24);
while(rs24.next())
{
   h24.put(rs24.getString(2),rs24.getString(1));
}
//System.out.println("qry24......"+qry24);

}
catch(Exception e)
{
e.printStackTrace();
}



%><body>


	<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" style="border-collapse:collapse" align = "center">




<tr>
		<td class="gridhdbg" colspan=28>District Wise GIS Entry(Latitude,Longitude) Details </td>	
	</tr>

<tr>
   <td class="gridhdbg">SlNo&nbsp;&nbsp;</td>
    <td class="gridhdbg" >District&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>Habs&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>Assets<br>(CPWS,PWS,MPWS,DP)</br>&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>Schools&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>HP&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>SHP&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>OPs&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>GLSR&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>GLBR&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>OHSR&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>OHBR&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>PumpSets&nbsp;&nbsp;</td>
	<td class="gridhdbg" align="center" colspan=2>Filters&nbsp;&nbsp;</td>	
</tr>

<tr> <td class="gridhdbg" align="center" colspan=2></td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>
<td class="gridhdbg" align="center">AVL</td>
<td class="gridhdbg" align="center">UPD</td>

</tr>


<%

int styleCount=0;
String style="";
try{
qry24="select dname,dcode from rws_district_tbl where dcode<>'16'order by dcode"; 
st24=conn.createStatement();
rs24=st24.executeQuery(qry24);
while(rs24.next())
{
slno++;
String panch_count=""+h1.get(rs24.getString(2));
if(panch_count!=null && !panch_count.equals("") && !panch_count.equals("null")){} else{ panch_count="0";}

String panch_giscount=""+h2.get(rs24.getString(2));
if(panch_giscount!=null && !panch_giscount.equals("") && !panch_giscount.equals("null")){} else{ panch_giscount="0";}

String asst_count=""+h3.get(rs24.getString(2));
if(asst_count!=null && !asst_count.equals("") && !asst_count.equals("null")){} else{ asst_count="0";}

String asst_giscount=""+h4.get(rs24.getString(2));
if(asst_giscount!=null && !asst_giscount.equals("") && !asst_giscount.equals("null")){} else{ asst_giscount="0";}

String sch_count=""+h5.get(rs24.getString(2));
if(sch_count!=null && !sch_count.equals("") && !sch_count.equals("null")){} else{ sch_count="0";}

String sch_giscount=""+h6.get(rs24.getString(2));
if(sch_giscount!=null && !sch_giscount.equals("") && !sch_giscount.equals("null")){} else{ sch_giscount="0";}

String hp_count=""+h7.get(rs24.getString(2));
if(hp_count!=null && !hp_count.equals("") && !hp_count.equals("null")){} else{ hp_count="0";}

String hp_giscount=""+h8.get(rs24.getString(2));
if(hp_giscount!=null && !hp_giscount.equals("") && !hp_giscount.equals("null")){} else{ hp_giscount="0";}

String shp_count=""+h9.get(rs24.getString(2));
if(shp_count!=null && !shp_count.equals("") && !shp_count.equals("null")){} else{ shp_count="0";}

String shp_giscount=""+h10.get(rs24.getString(2));
if(shp_giscount!=null && !shp_giscount.equals("") && !shp_giscount.equals("null")){} else{ shp_giscount="0";}

String op_count=""+h11.get(rs24.getString(2));
if(op_count!=null && !op_count.equals("") && !op_count.equals("null")){} else{ op_count="0";}

String op_giscount=""+h12.get(rs24.getString(2));
if(op_giscount!=null && !op_giscount.equals("") && !op_giscount.equals("null")){} else{ op_giscount="0";}

String glsr_count=""+h13.get(rs24.getString(2));
if(glsr_count!=null && !glsr_count.equals("") && !glsr_count.equals("null")){} else{ glsr_count="0";}

String glsr_giscount=""+h14.get(rs24.getString(2));
if(glsr_giscount!=null && !glsr_giscount.equals("") && !glsr_giscount.equals("null")){} else{ glsr_giscount="0";}

String glbr_count=""+h15.get(rs24.getString(2));
if(glbr_count!=null && !glbr_count.equals("") && !glbr_count.equals("null")){} else{ glbr_count="0";}

String glbr_giscount=""+h16.get(rs24.getString(2));
if(glbr_giscount!=null && !glbr_giscount.equals("") && !glbr_giscount.equals("null")){} else{ glbr_giscount="0";}

String ohsr_count=""+h17.get(rs24.getString(2));
if(ohsr_count!=null && !ohsr_count.equals("") && !ohsr_count.equals("null")){} else{ ohsr_count="0";}

String ohsr_giscount=""+h18.get(rs24.getString(2));
if(ohsr_giscount!=null && !ohsr_giscount.equals("") && !ohsr_giscount.equals("null")){} else{ ohsr_giscount="0";}

String ohbr_count=""+h19.get(rs24.getString(2));
if(ohbr_count!=null && !ohbr_count.equals("") && !ohbr_count.equals("null")){} else{ ohbr_count="0";}

String ohbr_giscount=""+h20.get(rs24.getString(2));
if(ohbr_giscount!=null && !ohbr_giscount.equals("") && !ohbr_giscount.equals("null")){} else{ ohbr_giscount="0";}

String ps_count=""+h21.get(rs24.getString(2));
if(ps_count!=null && !ps_count.equals("") && !ps_count.equals("null")){} else{ ps_count="0";}

String ps_giscount=""+h22.get(rs24.getString(2));
if(ps_giscount!=null && !ps_giscount.equals("") && !ps_giscount.equals("null")){} else{ ps_giscount="0";}

String filter_count=""+h23.get(rs24.getString(2));
if(filter_count!=null && !filter_count.equals("") && !filter_count.equals("null")){} else{ filter_count="0";}

String filter_giscount=""+h24.get(rs24.getString(2));
if(filter_giscount!=null && !filter_giscount.equals("") && !filter_giscount.equals("null")){} else{ filter_giscount="0";}

if(styleCount%2==0){
	 style="gridbg1";
 }else{
	 style="gridbg2";
 }
 styleCount++;

%>


<tr>
<td class=<%=style %> style="text-align: left;" ><%=slno%></td>
<td class=<%=style %> style="text-align: left;" ><%=rs24.getString(1)%></td>
<td class=<%=style %> style="text-align: right;" ><%=panch_count%></td>
<td class=<%=style %> style="text-align: right;"><%=panch_giscount%></td>
<td class=<%=style %> style="text-align: right;" ><%=asst_count%></td>
<td class=<%=style %> style="text-align: right;" ><%=asst_giscount%></td>
<td class=<%=style %> style="text-align: right;" ><%=sch_count %></td>
<td class=<%=style %> style="text-align: right;"><%=sch_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%=hp_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%=hp_count %></td>
<td class=<%=style %> style="text-align: right;"><%=shp_count %></td>
<td class=<%=style %> style="text-align: right;"><%=shp_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%=op_count%></td>
<td class=<%=style %> style="text-align: right;"><%=op_giscount%></td>
<td class=<%=style %> style="text-align: right;"><%=glsr_count %></td>
<td class=<%=style %> style="text-align: right;"><%=glsr_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%=glbr_count %></td>
<td class=<%=style %> style="text-align: right;"><%=glbr_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%= ohsr_count%></td>
<td class=<%=style %> style="text-align: right;"><%=ohsr_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%=ohbr_count %></td>
<td class=<%=style %> style="text-align: right;"><%=ohbr_giscount %></td>
<td class=<%=style %> style="text-align: right;" ><%=ps_count %></td>
<td class=<%=style %> style="text-align: right;"><%=ps_giscount %></td>
<td class=<%=style %> style="text-align: right;"><%=filter_count%></td>
<td class=<%=style %> style="text-align: right;" ><%=filter_giscount%></td>

</tr>


<%
habtot+=Integer.parseInt(panch_count);
habgistot+=Integer.parseInt(panch_giscount);

assttot+=Integer.parseInt(asst_count);
asstgistot+=Integer.parseInt(asst_giscount);

schtot+=Integer.parseInt(sch_count);
schgistot+=Integer.parseInt(sch_giscount);

hptot+=Integer.parseInt(hp_giscount);
hpgistot+=Integer.parseInt(hp_count);

shptot+=Integer.parseInt(shp_count);
shpgistot+=Integer.parseInt(shp_giscount);

optot+=Integer.parseInt(op_count);
opgistot+=Integer.parseInt(op_giscount);

glbrtot+=Integer.parseInt(glbr_count);
glbrgistot+=Integer.parseInt(glbr_giscount);

glsrtot+=Integer.parseInt(glsr_count);
glsrgistot+=Integer.parseInt(glsr_giscount);

ohbrtot+=Integer.parseInt(ohbr_count);
ohbrgistot+=Integer.parseInt(ohbr_giscount);

ohsrtot+=Integer.parseInt(ohsr_count);
ohsrgistot+=Integer.parseInt(ohsr_giscount);

pumptot+=Integer.parseInt(ps_count);
pumpgistot+=Integer.parseInt(ps_giscount);

filtot+=Integer.parseInt(filter_count);
filgistot+=Integer.parseInt(filter_giscount);




}
}
catch(Exception e)
	{
      e.printStackTrace();
	}


%>
<tr><td colspan=2 class="gridhdbg" style="text-align: right;" >Total</td>
<td class="gridhdbg" style="text-align: right;"  ><%=habtot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=habgistot %></td>
<td class="gridhdbg" style="text-align: right;"><%=assttot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=asstgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=schtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=schgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=hptot %></td>
<td class="gridhdbg" style="text-align: right;"><%=hpgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=shptot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=shpgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=optot %></td>
<td class="gridhdbg" style="text-align: right;"><%=opgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=glsrtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=glsrgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=glbrtot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=glbrgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=ohsrtot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=ohsrgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=ohbrtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ohbrgistot %></td>
<td class="gridhdbg" style="text-align: right;" ><%=pumptot %></td>
<td class="gridhdbg" style="text-align: right;"><%=pumpgistot %></td>
<td class="gridhdbg" style="text-align: right;"><%=filtot %></td> 
<td class="gridhdbg" style="text-align: right;"><%=filgistot %></td>
</tr>

</table>	
<p align="right">
<table align="left"><tr><td><font color="#FF0000">Note**********</font>&nbsp;&nbsp;1.AVL:Available Records.</td></tr>
	
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.UPD:Records Updated with GIS Information.(Latitude,Longitude)</td></tr>
	
	
	</table>
</p>
	
	
</body>
</html>
