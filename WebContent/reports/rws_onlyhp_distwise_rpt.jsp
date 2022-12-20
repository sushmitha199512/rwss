<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%

//System.out.print("SSSenter");

//System.out.println("rDistrict:"+request.getParameter("rDistrict"));
String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null;
ResultSet rs1=null,rs2=null,prs = null,vrs =null,hrs = null,mrs=null,crs=null,othrs =null;
Statement pst = null, vst = null ,cst = null , hst = null,getHabSt=null,stmt1=null,mst=null,othst=null;
PreparedStatement ps1=null;
rDistrict = request.getParameter("rDistrict");
if(rDistrict!=null){
session.setAttribute("rDistrict",rDistrict);
}
rDistrictName = request.getParameter("rDistrictName");
if(rDistrictName!=null){
session.setAttribute("rDistrictName",rDistrictName);
}
rMandal=request.getParameter("rMandal");
if(rMandal!=null){
session.setAttribute("rMandal",rMandal);
}
rMandalName=request.getParameter("rMandalName");
if(rMandalName!=null){
session.setAttribute("rMandalName",rMandalName);
}
rPanchayat=request.getParameter("rPanchayat");
if(rPanchayat!=null){
session.setAttribute("rPanchayat",rPanchayat);
}
rPanchayatName=request.getParameter("rPanchayatName");
if(rPanchayatName!=null){
session.setAttribute("rPanchayatName",rPanchayatName);
}
String dname = request.getParameter("rDistrictName");
if(rDistrictName!=null){
session.setAttribute("rDistrictName",dname);
}
String drill = request.getParameter("drill");
if(drill!=null){
session.setAttribute("drill",drill);
}

%>
<html>
 <head>


<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_onlyhp_distwise_xls.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=14>Coverage of Habitations  by Hand Pumps </td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
	
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District</td>
			<td class=btext rowspan=2>No. of Habs</td>	
			<td class=btext rowspan=2>Pop</td>	
			 <td class=btext colspan="3" >Habs covered by HPs only</td>
 		</tr>
		<tr align="center">
			<td class=btext>No of Habs</td>
			<td class=btext>Pop</td>
			<td class=btext>No of HPs</td>
		</tr>
	<%

       String habpop="select hd.hab_code,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)) from rws_habitation_directory_tbl hd group by hd.hab_code";
       Statement popst=conn.createStatement();
       ResultSet poprs=popst.executeQuery(habpop);
       Hashtable poplist=new Hashtable();
       while(poprs.next())
		{
         poplist.put(poprs.getString(1),poprs.getString(2));
		}

		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
		//System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery(); 
		int hcount=0,sno=1,totalpop=0,hcount1=0,cpwspop=0,columnTotal3=0,Gtotalpop=0,columnTotal4=0,columnTotal5=0,Gcpwstotal=0;
        int hpscount=0;
		while(rs2.next())
		{
		    //Query modified by pranavi
			String hQuery = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'";
			String cpQuery="select hd.hab_code from rws_habitation_directory_tbl hd,rws_hp_subcomp_param_tbl hp where   substr(hp.hp_code,1,2)='"+rs2.getString(1)+"' and substr(hp.hp_code,1,16)=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by hd.hab_code ";
		    String hpcount="select count(*) from rws_hp_subcomp_param_tbl  where substr(hp_code,1,2)='"+rs2.getString(1)+"'";
			   
	           //System.out.println("cpQuery:"+cpQuery);
				hst = conn.createStatement();
				hrs = hst.executeQuery(hQuery);

			    /////////habcount,pop distwise/////////////
				while(hrs.next())
				{
					hcount++;
	              	totalpop=totalpop+hrs.getInt(2);
							
			    }
               
				 /////////only hp habcount,pop distwise/////////////
             	cst = conn.createStatement();
				crs = cst.executeQuery(cpQuery);
				while(crs.next())
				{
	               hcount1++; 
                   String poptot=""+poplist.get(crs.getString(1));
                   cpwspop=cpwspop+Integer.parseInt(poptot);
	             
	            }
				
              /////////hp cont distwise/////////////
			   mst = conn.createStatement();
			   vrs = mst.executeQuery(hpcount);
              // System.out.println("hpcount qry:"+hpcount);
			   if(vrs.next())
				{
                   hpscount=hpscount+vrs.getInt(1);
                }  
              
                   %>
                <tr>
				<td class=rptValue><%=sno++%></td>
				<td class="rptValue"><%=rs2.getString(2)%></td>
				<td class=rptValue align="right"><%=hcount%></td>
				<td class=rptValue align="right"><%=totalpop%></td>
				<td class=rptValue align="right"><%=hcount1 %></td>
				<td class=rptValue align="right"><%=cpwspop%></td>	
            	<td class=rptValue align="right"><%=hpscount%></td>
				</tr>
			<%
			
                columnTotal3 += hcount;
                Gtotalpop+=totalpop;
                columnTotal4 +=hcount1;
				Gcpwstotal+=cpwspop;
	            columnTotal5+=hpscount;

				hcount=0;
              	totalpop=0;
               	hcount1=0;
				cpwspop=0;
	            hpscount=0;
        
}
cpwspop=0;
		%>
		<tr>
				<td class=btext align="right" colspan="2">Total</td>
				<td class=btext align="right"><%=columnTotal3%></td>
				<td class=btext align="right"><%=Gtotalpop%></td>
				<td class=btext align="right"><%=columnTotal4%></td>
				<td class=btext align="right"><%=Gcpwstotal%></td>
				<td class=btext align="right"><%=columnTotal5%></td>				
			</tr>
	<%
				columnTotal3=0;
				hcount=0;
                Gtotalpop=0;
				totalpop=0;
                columnTotal4=0;
				hcount1=0;
				Gcpwstotal=0;
				cpwspop=0;
	            columnTotal5=0;
				hpscount=0;

}
	
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
 try{
      //rs1.close();
      //stmt1.close();
     // rs2.close();
     // ps1.close();
     

    }
catch(Exception w)
{
}
}


%>
</table>
<br>
<table width="30%" align=center>
<tr><td bordercolor="black"><font color="red">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td><td class=rptValue nowrap>This report is generated based on <font color=red>Actual Schemes</font> present in the WaterSoft.</td></tr>

</table>
</body>
</html>
<%@ include file = "footer.jsp" %>
