<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%

//System.out.println("dsss");
Calendar cal=Calendar.getInstance();
    String year=""+cal.get(Calendar.YEAR);

    String dcode=request.getParameter("rDistrict");
    session.setAttribute("district",dcode);
    System.out.println("dcode"+dcode);
String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null;
ResultSet rs1=null,rs2=null,prs = null,vrs =null,hrs = null,rs3=null,rs4=null;
Statement pst = null, vst = null , hst = null,getHabSt=null,stmt1=null,statament=null;
PreparedStatement ps1=null;
String qyr2="";
String qry3="";
String qry4="";
long ghabsTot=0,ghabspopTot=0,shabsTot=0,shabspopTot=0,shabsTot1=0,shabspopTot1=0;

%>
<html>
 <head>
<title></title>

 </head>
<body>
<form>
<table border = 0 cellspacing = 0 cellpadding = 0 height=5% width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					<!-- <a href="./rws_habitation_abstract_rpt1_excel.jsp" target=_new>Excel</a>  -->
					</td>
				</tr>
			</table>
		</caption>
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class=gridhdbg colspan=8>Coverage Of Habitations(Surface Water & Ground Water)-Report</td>	
		</tr>
		
		<tr align=center>

               <td class=gridhdbg  rowspan=3>Sl.No</td>
               <td class=gridhdbg  rowspan=3>District</td>
                <td class=gridhdbg  colspan=2>Ground Water</td>
                  <td class=gridhdbg colspan=4>Surface Water (Rivers,Canals,Springs and Reservoirs)</td>
              
		   
			   </tr>
			  
			   <tr>
			     <td class=gridhdbg  rowspan=2>Habitations Covered</td>
			     <td class=gridhdbg  rowspan=2>Population Benefited</td>
			    <td class=gridhdbg  colspan=2>PWS</td>
			     <td class=gridhdbg colspan=2 >MPWS</td>
			   </tr>
			   <tr>
			   
			    <td class=gridhdbg  >Habitations Covered</td>
			     <td class=gridhdbg  >Population Benefited</td>
			     <td class=gridhdbg  >Habitations Covered</td>
			     <td class=gridhdbg  >Population Benefited</td>
			     </tr>
		
<%		
try
{
    String query = "",style="";
	
int sno=1,styleCount=0;

  stmt1=conn.createStatement();
  
  
  
   String qry1="select dcode,dname from rws_district_tbl   ";
   if(dcode!=null && !dcode.equals("") && !dcode.equals("00"))
   {
	   qry1+=" where dcode='"+dcode+"' ";
   }
   qry1+=" group by dcode,dname order by dcode";
 

  rs1=stmt1.executeQuery(qry1);
 // System.out.println("Query"+qry1);

  while(rs1.next())
	{
		  String dcode2=rs1.getString(1);
		  //System.out.println("dcode2"+dcode2);
	 vst=conn.createStatement();
		  qyr2="select count(distinct a.hab_code),nvl(sum(PLAIN_POPU_COVERED+SC_POP_COVERED+ST_POP_COVERED),0) from rws_source_tbl a,rws_habitation_directory_tbl  b where a.hab_code=b.hab_code and  SOURCE_TYPE_CODE=2 and substr(asset_code,7,2)='01'  and substr(a.hab_code,1,2)='"+dcode2+"' ";
		
		//  System.out.println("Query2222"+qyr2);
			rs2=vst.executeQuery(qyr2);
			//System.out.println("Query2222"+qyr2);
			while(rs2.next())
			{
				
				statament=conn.createStatement();
				qry4="select count(distinct a.hab_code),nvl(sum(PLAIN_POPU_COVERED+SC_POP_COVERED+ST_POP_COVERED),0) from rws_source_tbl a,rws_habitation_directory_tbl  b where a.hab_code=b.hab_code and  SOURCE_TYPE_CODE=2  and substr(asset_code,7,2)='02' and substr(a.hab_code,1,2)='"+dcode2+"' ";
				rs4=statament.executeQuery(qry4);
				while(rs4.next()){
					
				hst=conn.createStatement();
				qry3="select count(distinct substr(hp_code,1,16)),nvl(sum(b.POPU_BENEFITED),0) from rws_hp_subcomp_param_tbl a,rws_asset_mast_tbl b where  a.asset_code=b.asset_code and  substr(a.asset_code,7,2) in('04') and substr(hp_code,1,2)='"+dcode2+"' ";
				rs3=hst.executeQuery(qry3);
				while(rs3.next())
				{
				 
	   
	   
	  if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
			



	%>
	<tr>
	 <td class="<%=style%>" style="text-align: left;"><%= sno++ %></td>
      
      <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(2)%></td> 
  	 
      <td class="<%=style%>" style="text-align: right;"><%=rs3.getInt(1)%></td>
	  <td class="<%=style%>" style="text-align: right;"><%=rs3.getInt(2)%></td>
	   <td class="<%=style%>" style="text-align: right;"><%=rs2.getInt(1)%></td>
	  <td class="<%=style%>" style="text-align: right;"><%=rs2.getInt(2)%></td>
	  <td class="<%=style%>" style="text-align: right;"><%=rs4.getInt(1)%></td>
	  <td class="<%=style%>" style="text-align: right;"><%=rs4.getInt(2)%></td>
	  	</tr>
	<%  
		
	ghabsTot+=rs3.getInt(1);
	ghabspopTot+=rs3.getInt(2);
	shabsTot+=rs2.getInt(1);
	shabspopTot+=rs2.getInt(2);
	shabsTot1+=rs4.getInt(1);
	shabspopTot1+=rs4.getInt(2);
				}
			}
			}
	}

%>

<% 
 }
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	
	}

%>
<tr>
<td class=gridhdbg colspan=2 style ="text-align:right !important;">Total:</td>
<td class=gridhdbg style ="text-align:right !important;"><%=ghabsTot %></td>
<td class=gridhdbg style ="text-align:right !important;"><%=ghabspopTot %></td>
<td class=gridhdbg style ="text-align:right !important;"><%=shabsTot%></td>
<td class=gridhdbg style ="text-align:right !important;"><%=shabspopTot %></td>
<td class=gridhdbg style ="text-align:right !important;"><%=shabsTot1 %></td>
<td class=gridhdbg style ="text-align:right !important;"><%=shabspopTot1 %></td>
</tr>

</table></form>
</body>
</html>
<table>
<tr>
<td align=center><font color=red>Note:</font></td><td>1.Ground Water Population Benefited Taken from HandPump Habitation wise population Benefited</td></tr>

<tr>
<td align=center></td><td>2.Surface Water Population Benefited Taken from SchemeWise population Benefited</td></tr>

</table>

<%@ include file = "footer.jsp" %>
