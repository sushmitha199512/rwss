<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
////// System.out.println("rDistrict:"+request.getParameter("rDistrict"));
//String rDistrict = request.getParameter("district1");
StringBuffer rDistrict=new StringBuffer();
rDistrict.append(request.getParameter("district1"));
session.setAttribute("rDistrict",rDistrict);

//String dname = request.getParameter("dname1");
StringBuffer dname=new StringBuffer();
dname.append(request.getParameter("dname1"));
session.setAttribute("rDistrictName",dname);

//String rMandal = request.getParameter("mandal");
StringBuffer rMandal=new StringBuffer();
rMandal.append(request.getParameter("mandal"));
session.setAttribute("rMandal",rMandal);

//String mname = request.getParameter("mname");
StringBuffer mname=new StringBuffer();
mname.append(request.getParameter("mname"));
session.setAttribute("rMandalName",mname);


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
					<a href="../home.jsp">Home</a>|<a href="./rws_school_eduinsti_excel.jsp">Excel</a></td> 
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan=15><font color="yellow">Abstract Report  of Schools Educational Institutions of  District:<%=dname.toString()%> and Mandal:<%=mname.toString()%></font></td>	
		</tr>
		
<%
try
{
	
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>Gram Panchayat</td>
			<td class=gridhdbg rowspan=2>Habitation</td>			
			<td class=gridhdbg rowspan="2">Total Population</td>
			<td class=gridhdbg colspan="5">Type of Institution</td>
			<td class=gridhdbg rowspan="2">Total No. of Institutions in GP</td>			
			<td class="gridhdbg" colspan="2" align="center">General Toilets</td>
			<td class="gridhdbg" colspan="2" align="center">Girls Toilets</td>
			<td class="gridhdbg" rowspan="2">No. of Institutions with drinking water facility</td>
	 </tr>
		<tr>
		<td class="gridhdbg">Primary </td>
		<td class="gridhdbg">Upper Primary </td>
		<td class="gridhdbg">Secondary </td>
		<td class="gridhdbg">Sr. Secondary </td>
		<td class="gridhdbg">Balwadi<br>/Anganwadi  </td>
		
		<td class="gridhdbg">No. of institutions with Toilets</td>
		<td class="gridhdbg">No. of institutions with running water facility</td>
		<td class="gridhdbg">No. of institutions with Toilets</td>
		<td class="gridhdbg">No. of institutions with running water facility</td>
		</tr>
	<%
	  ResultSet rs2=null,rs3=null;
	  Statement stmt2=null,stmt3=null;
	  StringBuffer totiletValues=new StringBuffer();
	  StringBuffer habValues=new StringBuffer();
	  StringBuffer schoolValues=new StringBuffer();
	  StringBuffer style=new StringBuffer();
	  StringBuffer qry=new StringBuffer();
	  
	  qry.delete(0,qry.length());
	  //qry.append("select substr(panch_code,13,2),sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else 0 end) as toilet,sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end)  as water ,sum(case when SEPARATE_TOILET_GIRLS_BOYS ='Yes(Only for Girls)' and FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else 0 end) as girltoilet,sum(case when SEPARATE_TOILET_GIRLS_BOYS ='Yes(Only for Girls)' and RUNNING_WATER_IN_TOILETS ='Yes(Only for Girls)' and FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as girlwater  from rws_complete_hab_view a, rws_school_master_tbl b where a.panch_code=b.HAB_CODE and  dcode='"+rDistrict.toString()+"' and mcode='"+rMandal.toString()+"' group by substr(panch_code,13,2)");
	 // System.out.println("schoolqry qry"+qry.toString());
	 qry.append("select substr(panch_code,13,2),sum(case when SEPARATE_TOILET_GIRLS_BOYS='Yes(for Both)' then 1 else 0 end) as toilet,sum(case when RUNNING_WATER_IN_TOILETS ='Yes(Only for Girls)' or RUNNING_WATER_IN_TOILETS ='Yes(Only for Boys)' then 1 else 0 end)  as water ,sum(case when SEPARATE_TOILET_GIRLS_BOYS ='Yes(Only for Girls)'  then 1 else 0 end) as girltoilet,sum(case when  RUNNING_WATER_IN_TOILETS ='Yes(Only for Girls)'  then 1 else 0 end) as girlwater,sum(case when FACILITIES_AVAILABLE ='Drinking Water Only' then 1 else 0 end)  from rws_complete_hab_view a, rws_school_master_tbl b where a.panch_code=b.HAB_CODE and dcode='"+rDistrict.toString()+"' and mcode='"+rMandal.toString()+"' group by substr(panch_code,13,2)");
	  stmt3=conn.createStatement();
	  rs3=stmt3.executeQuery(qry.toString());
	  Hashtable toieltHash=new Hashtable();
	  while(rs3.next())
	  {
		  toieltHash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6));
	  }
	  //session.setAttribute("toieltHash","toieltHash");
	  
	  if(rs3!=null)rs3.close();
	  if(stmt3!=null)stmt3.close();
	  qry.delete(0,qry.length());
	  
	  
	  qry.append("select substr(panch_code,13,2),sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as primary ,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as UpperPrimary , sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as Secondary,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as SrSecondary ,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as Anganwadi  from rws_complete_hab_view a, rws_school_master_tbl b where a.panch_code=b.HAB_CODE and  dcode='"+rDistrict.toString()+"' and mcode='"+rMandal.toString()+"' group by substr(panch_code,13,2)");
	 // System.out.println("schoolqry qry"+qry.toString());
	  
	  stmt3=conn.createStatement();
	  rs3=stmt3.executeQuery(qry.toString());
	  Hashtable schoolHash=new Hashtable();
	  while(rs3.next())
	  {
		  schoolHash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6));
	  }
	  if(rs3!=null)rs3.close();
	  if(stmt3!=null)stmt3.close();
	  qry.delete(0,qry.length());
	  
	  
	  
	  qry.append("select pcode,count(distinct hab_code),sum(census_plain_popu+census_sc_popu+census_st_popu) from rws_complete_hab_view a,rws_school_master_tbl b where a.panch_code=b.hab_code and dcode='"+rDistrict.toString()+"' and mcode='"+rMandal.toString()+"' group by pcode ");
	  //System.out.println("hab qry"+qry.toString());
	  
	  stmt3=conn.createStatement();
	  rs3=stmt3.executeQuery(qry.toString());
	  Hashtable habHash=new Hashtable();
	  while(rs3.next())
	  {
	  	habHash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3));
	  }
	  
	  if(rs3!=null)rs3.close();
	  if(stmt3!=null)stmt3.close();
	  qry.delete(0,qry.length());
	  
	     
	    qry.append("select pcode,pname from rws_panchayat_tbl where dcode = '"+rDistrict+"' and mcode = '"+rMandal+"' order by pcode ");
		//System.out.println("mainqry::::"+qry.toString());
		stmt2=conn.createStatement();
		rs2=stmt2.executeQuery(qry.toString()); 
		
		int sno = 1;
		int habcnt=0,habpop=0,schprcnt=0,schuprcnt=0,schseccnt=0,schsrprcnt=0,schangcnt=0;
		int habcnttot=0,habpoptot=0,schprcnttot=0,schuprcnttot=0,schseccnttot=0,schsrprcnttot=0,schangcnttot=0,totinst=0;
		int toiletcnt=0,watercnt=0,girltoieltcnt=0,girlwatercnt=0,drinkingwater=0;
		int tottoilet=0,totwater=0,totgirltot=0,totgirlwat=0,totwat=0;
		
		  
		int styleCount=0;
		while(rs2.next())
		{
			 habValues.delete(0,habValues.length());
			 habValues.append(habHash.get(rs2.getString(1)));
			 String []aa=habValues.toString().split("@");
			 if(aa!=null)
			 {
				 habcnt=Integer.parseInt(aa[0]);
				 habpop=Integer.parseInt(aa[1]);
			 }
			 else
			 {
				 habcnt=0;
				 habpop=0;
			 }		
			 
			 schoolValues.delete(0,schoolValues.length());
			 schoolValues.append(schoolHash.get(rs2.getString(1)));
			 String []bb=schoolValues.toString().split("@");
			 if(bb!=null)
			 {
				 schprcnt=Integer.parseInt(bb[0]);
				 schuprcnt=Integer.parseInt(bb[1]);
				 schseccnt=Integer.parseInt(bb[2]);
				 schsrprcnt=Integer.parseInt(bb[3]);
				 schangcnt=Integer.parseInt(bb[4]);
			 }
			 else
			 {
				 schprcnt=0;
				 schuprcnt=0;
				 schseccnt=0;
				 schsrprcnt=0;
				 schangcnt=0;
			 }		
			 
			 totiletValues.delete(0,totiletValues.length());
			 totiletValues.append(toieltHash.get(rs2.getString(1)));
			 String []cc=totiletValues.toString().split("@");
			 if(cc!=null)
			 {   
				 toiletcnt=Integer.parseInt(cc[0]);
			     watercnt=Integer.parseInt(cc[1]);
			     girltoieltcnt=Integer.parseInt(cc[2]);
			     girlwatercnt=Integer.parseInt(cc[3]);
			     drinkingwater=Integer.parseInt(cc[4]);
				
			 }
			 else
			 {
				         toiletcnt=0;
					     watercnt=0;
					     girltoieltcnt=0;
					     girlwatercnt=0;
					     drinkingwater=0;
			 }	
			 
			 
			 
			 
			 if(styleCount%2==0)
			 {   style.delete(0,style.length());
				 style.append("gridbg1");
			 }else
			 {   style.delete(0,style.length());
				 style.append("gridbg2");
			 }
			 styleCount++;
			 
			 
		%>
		
		<tr>
			<td class="<%=style.toString()  %>" style="text-align: left;"><%=sno++%></td>
			<td class="<%=style.toString()  %>" style="text-align: left;"><%=rs2.getString(2) %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=habcnt%></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=habpop %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=schprcnt%></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=schuprcnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=schseccnt%></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=schsrprcnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=schangcnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=schprcnt+schuprcnt+schseccnt+schsrprcnt+schangcnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=toiletcnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=watercnt%></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=girltoieltcnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=girlwatercnt %></td>
			<td class="<%=style.toString()  %>" style="text-align: right;"><%=drinkingwater%></td>
			
		</tr>		
		<%
		habcnttot+=habcnt;
		habpoptot+=habpop;
		schprcnttot+=schprcnt;
		schuprcnttot+=schuprcnt;
		schseccnttot+=schseccnt;
		schsrprcnttot+=schsrprcnt;
		schangcnttot+=schangcnt;
		totinst=schprcnttot+schuprcnttot+schseccnttot+schsrprcnttot+schangcnttot;
		tottoilet+=toiletcnt;
	    totwater+=watercnt;
	    totgirltot+=girltoieltcnt;
	    totgirlwat+=girlwatercnt;
	    
	    totwat+=drinkingwater;
		}
		%>
		<tr>
			<td class=gridhdbg colspan="2">Total</td>
			<td class=gridhdbg align="right"><%=habcnttot%></td>	
			<td class=gridhdbg align="right"><%=habpoptot%></td>	
			<td class=gridhdbg align="right"><%=schprcnttot%></td>
			<td class=gridhdbg align="right"><%=schuprcnttot %></td>
			<td class=gridhdbg align="right"><%=schseccnttot%></td>
			<td class=gridhdbg align="right"><%=schsrprcnttot %></td>
			<td class=gridhdbg align="right"><%=schangcnttot %></td>	
			<td class=gridhdbg align="right"><%=totinst	%></td>	
			<td class=gridhdbg align="right"><%=tottoilet%></td>
			<td class=gridhdbg align="right"><%=totwater %></td>
			<td class=gridhdbg align="right"><%=totgirltot%></td>
			<td class=gridhdbg align="right"><%=totgirlwat %></td>
			<td class=gridhdbg align="right"><%=totwat %></td>
			
		</tr>
		<%

}

catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	  conn.close();
	  StringBuffer totiletValues=null;
	  StringBuffer habValues=null;
	  StringBuffer schoolValues=null;
	  StringBuffer style=null;
	  
}
%>

</table>
</body>
</html>
<%@ include file = "/commons/rws_footer.jsp" %>
