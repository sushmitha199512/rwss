<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
    String dname=(String)session.getAttribute("dname");
	String mname=(String)session.getAttribute("mname");
	String dcode=(String)session.getAttribute("dcode");
	String mcode=(String)session.getAttribute("mcode"); 
	String gtxidValueOld = "",gtxidValue="";
	int sno=1;
	int tot=0;
	String qry="";
	String h1="",h2="",h3="",h4="";
	String z1="",z2="",z3="",z4="";
	//Added for house connections and households and panchayat longitude ,latitude,way_point,landmark
	String hconn1="",hconn2="",hconn3="",hconn4="",hconn5="";
    String hhold1="",hhold2="",hhold3="",hhold4="",hhold5="";
	String phold1="",phold2="",phold3="",phold4="",phold5="";
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan="27" > Basic Information -General &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext  rowspan = 2 nowrap>HabitationCode/Name</td>
	<td class=btext colspan=5 nowrap>Population </td>
	<td class=btext  colspan=5 nowrap >No of HouseHolds<BR>
	(as per 2011 Census)</td>
	<td class=btext  colspan=5 nowrap>No of House Connections given<BR>
	
	<td class=btext rowspan = 2 >HabType(SC/ST<br>/Plain/Minority)</td>
	<td class=btext  colspan=2>IF ST</td>
		<td class=btext  colspan=1>Whether LWE</td>
	<td class=btext rowspan=2> Remarks</td>
	 <td class=btext  colspan=5> Importent Landmark which is Centrally Located </td>
			<!-- <td class=btext  colspan=2>Whether it is Covered with CPWS Scheme(If Yes) </td>
			<td class=btext  colspan=4>Reservoires (Where Single Village Scheme not Exsisting) </td>
	<td class=btext  colspan=4>Co-ordinates</td>
	<td class=btext  colspan=4>Scheme Covered (Yes/No)</td> --> 

	</td>
	</tr>
	<tr>
	<td class=btext align="center"> Gen</td>
	<td class=btext align="center"> SC</td>
	<td class=btext align="center"> ST</td>
	<td class=btext align="center"> Minority</td>
	<td class=btext align="center"> Total</td>
	<td class=btext align="center"> Plain</td>
	<td class=btext > &nbsp;&nbsp;&nbsp;SC&nbsp;&nbsp;&nbsp;</td>
	<td class=btext >&nbsp;&nbsp;&nbsp;ST&nbsp;&nbsp;&nbsp;</td>
		<td class=btext align="center"> Minority</td>
		<td class=btext align="center"> Total</td>
	<td class=btext align="center"> Plain</td>
	<td class=btext align="center"> SC</td>
	<td class=btext align="center"> ST</td>
	<td class=btext align="center"> Minority</td>
	<td class=btext align="center"> Total</td>

	<td class=btext> TSP</td>
	<td class=btext> NTSP</td>
	 <td class=btext> Yes/No</td>
 <td class=btext >GPS Code<br>(Way Point)</td>
	<td class=btext  nowrap>Latitude</td>
	<td class=btext  nowrap>Longitude</td>
	<td class=btext  nowrap>Elevation</td>
	<td class=btext  nowrap>Landmark Name</td>
	<!-- <td class=btext  nowrap>Scheme Name</td>
	<td class=btext  nowrap>Scheme Code</td>
<td class=btext nowrap>Service Reservoirs  </td>
	<td class=btext nowrap>Capacity(LTS)</td>
	<td class=btext nowrap>&nbsp;&nbsp;&nbsp;Location&nbsp;&nbsp;&nbsp;</td>
	<td class=btext nowrap>No.of Fillings Per Day</td>
	
	<td class=btext nowrap>GPS Code<br>(Way Point)</td>
	<td class=btext nowrap>Latitude</td>
	<td class=btext nowrap>Longitude</td>
	<td class=btext nowrap>Elevation</td>

	<td class=btext nowrap>Plain Area</td>
	<td class=btext nowrap>SC Area</td>
	<td class=btext nowrap>ST Area</td>
	<td class=btext nowrap>Minority <br>Area</td> --> 
	</tr>
<%
try
{
String houseconn="select nvl(con_plain,'0'),nvl(con_sc,'0'),nvl(con_st,'0'),nvl(con_minority,'0'),nvl(NO_OF_HOUSECONN_GIVEN,'0') ,hab_code from rws_habitation_directory_tbl a where substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"'  ";
	Statement	stmt888=conn.createStatement();
	//System.out.println("houseconn:"+houseconn);
	ResultSet rs888=stmt888.executeQuery(houseconn);
	Hashtable houseconh=new Hashtable();
		while(rs888.next())
	{
		houseconh.put(rs888.getString(6),rs888.getString(1)+"@"+rs888.getString(2)+"@"+rs888.getString(3)+"@"+rs888.getString(4)+"@"+rs888.getString(5));
	}
	String household="select nvl(households_plain,'0'),nvl(households_sc,'0'),nvl(households_st,'0'),nvl(households_minority,'0'),nvl(household_no,'0'),hab_code from rws_habitation_directory_tbl a where substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"'  ";
	Statement	stmt88=conn.createStatement();
	//System.out.println("household:"+household);
	ResultSet rs88=stmt88.executeQuery(household);
	Hashtable householdh=new Hashtable();
		while(rs88.next())
	{
		householdh.put(rs88.getString(6),rs88.getString(1)+"@"+rs88.getString(2)+"@"+rs88.getString(3)+"@"+rs88.getString(4)+"@"+rs88.getString(5));
	}
	String hp="select  nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_MINORITY_POPU,0),hab_code from rws_habitation_directory_tbl a where  substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' ";
	Statement	stmt6=conn.createStatement();
	//System.out.println("ohsr:"+hp);
	ResultSet rs6=stmt6.executeQuery(hp);
	Hashtable hph=new Hashtable();
		while(rs6.next())
	{
		hph.put(rs6.getString(5),rs6.getString(1)+"@"+rs6.getString(2)+"@"+rs6.getString(3)+"@"+rs6.getString(4));
	}
    //for panchayat raj longitude,latitude,elevation,way_point and landmark
	String panch="select  nvl(way_point,'0'),nvl(longitude,'0'),nvl(latitude,'0'),nvl(elevation,'0'),nvl(landmark,'-'),panch_code from rws_panchayat_raj_tbl a where  substr(a.panch_code,1,2)='"+dcode+"' and substr(a.panch_code,6,2)='"+mcode+"' ";
	Statement stmt99=conn.createStatement();
//	System.out.println("panchlatitude:"+panch);
	ResultSet rs99=stmt99.executeQuery(panch);
	Hashtable panchh=new Hashtable();
		while(rs99.next())
	{
		panchh.put(rs99.getString(6),rs99.getString(1)+"@"+rs99.getString(2)+"@"+rs99.getString(3)+"@"+rs99.getString(4)+"@"+rs99.getString(5));
	}

	//
	String owq="select  nvl(decode(LWE,'Y','Yes','N','No'),'-') as LWE,nvl(remarks,'-'),habitation_sub_type,hab_code from rws_habitation_directory_tbl a where  substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' group by a.hab_code,LWE,remarks,habitation_sub_type";
	Statement	stmt11=conn.createStatement();
//	System.out.println("owq:"+owq);
	ResultSet rs11=stmt11.executeQuery(owq);
	Hashtable owh=new Hashtable();
		while(rs11.next())
	{
		owh.put(rs11.getString(4),rs11.getString(1)+"@"+rs11.getString(2)+"@"+rs11.getString(3));
	}
	//

	String cpws=" select b.asset_name ,a.asset_code,a.hab_code from RWS_ASSET_HAB_TBL a,rws_asset_mast_tbl b   where substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"'  and type_of_asset_code='03' and a.asset_code=b.asset_code ";
	Statement	stmt12=conn.createStatement();
	//System.out.println("cpws:"+cpws);
	ResultSet rs12=stmt12.executeQuery(cpws);
	Hashtable cpwsh=new Hashtable();
		while(rs12.next())
	{
		cpwsh.put(rs12.getString(3),rs12.getString(1)+"@"+rs12.getString(2));
	}
	String gqry=" select c.dname,c.mname,c.pname,c.panch_name,c.panch_code,b.CENSUS_PLAIN_POPU,b.CENSUS_ST_POPU,b.CENSUS_SC_POPU,nvl(b.census_minority_popu,0)    from rws_complete_hab_view c,rws_habitation_directory_tbl b where b.hab_code=c.panch_code and   substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"'  order by c.pname,c.panch_name";
	Statement	stmt8=conn.createStatement();
   // System.out.println("gqry:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);

	while (rs8.next())
	{
	String hiss=""+hph.get(rs8.getString(5));
	if(hiss!=null && !hiss.equals("") && !hiss.equals("null"))
		{
		String []zzz=hiss.split("@");
		z1=zzz[0];
		z2=zzz[1];
		z3=zzz[2];
		z4=zzz[3];

		}
		else
		{
			z1="0";
			z2="0";
			z3="0";
			z4="0";
		}
		 tot=Integer.parseInt(z1)+Integer.parseInt(z2)+Integer.parseInt(z3)+Integer.parseInt(z4);
	
	String hiss1=""+owh.get(rs8.getString(5));
	if(hiss1!=null && !hiss1.equals("") && !hiss1.equals("null"))
	{
	String []hhh=hiss1.split("@");
	h1=hhh[0];
	h2=hhh[1];
	h3=hhh[2];
	//h4=hhh[3];
	//System.out.println("h2 remarks::"+h2);
	}
	else{
	h1="-";
	h2="-";
	h3="-";
	//h4="-";
		}
		String cp1="",cp2="";
		String cpwss=""+cpwsh.get(rs8.getString(5));
	if(cpwss!=null && !cpwss.equals("") && !cpwss.equals("null"))
	{
	String []cc=cpwss.split("@");
	cp1=cc[0];
	cp2=cc[1];
	//System.out.println("cpws::"+cp1);
		}
	else{
	cp1="-";
	cp2="-";
		}
		//////households
		
	String households=""+householdh.get(rs8.getString(5));
	if(households!=null && !households.equals("") && !households.equals("null"))
	{
	String []hhold=households.split("@");
	hhold1=hhold[0];
	hhold2=hhold[1];
	hhold3=hhold[2];
	hhold4=hhold[3];
	hhold5=hhold[4];
	
	}
	else
	{
	hhold1="0";
	hhold2="0";
	hhold3="0";
	hhold4="0";
	hhold5="0";
	}
	//////
	/////panchayat latitude,longitude,elevation,way_point,landmark

	/////
			
			
			
	/////housecon1
	String housecon1=""+houseconh.get(rs8.getString(5));
	if(housecon1!=null && !housecon1.equals("") && !housecon1.equals("null"))
	{
	String []hconn=housecon1.split("@");
	hconn1=hconn[0];
	hconn2=hconn[1];
	hconn3=hconn[2];
	hconn4=hconn[3];
	hconn5=hconn[4];
	}
	else
	{
	hconn1="0";
	hconn2="0";
	hconn3="0";
	hconn4="0";
	hconn5="0";
	}
	/////panchayat latitude,longitude,elevation,way_point,landmark
	String phold=""+panchh.get(rs8.getString(5));
	if(phold!=null && !phold.equals("") && !phold.equals("null"))
	{
	String []pr=phold.split("@");
	phold1=pr[0];
	phold2=pr[1];
	phold3=pr[2];
	phold4=pr[3];
	phold5=pr[4];
	}
	else
	{
	phold1="0";
	phold2="0";
	phold3="0";
	phold4="0";
	phold5="-";
	}
	////
	gtxidValue = ""+rs8.getString(3);
	if(!gtxidValue.equals(gtxidValueOld)){
	//System.out.println("gtxidValue::"+gtxidValue);
	//System.out.println("gtxidValueOld::"+gtxidValueOld);
	%>
<tr><td  colspan="27"  class=btext>Panchayat Name:<%=rs8.getString(3)%></td></tr>
<%}else{}%>
	 
  
<tr>
	<td class="rptValue"><%=sno++%></td>
	<td class="rptValue"><%=rs8.getString(5)%>/<br><%=rs8.getString(4)%></td>
	<td class="rptValue"><%=rs8.getString(6)%></td>
	<td class="rptValue"><%=rs8.getString(7)%></td>
	<td class="rptValue"><%=rs8.getString(8)%></td>
	<td class="rptValue"><%=rs8.getString(9)%></td>
	<td class="rptValue"><%=tot%></td>
    <td class="rptValue"><%=hhold1%></td>
	<td class="rptValue"><%=hhold2%></td>
	<td class="rptValue"><%=hhold3%></td>
	<td class="rptValue"><%=hhold4%></td>
	<td class="rptValue"><%=hhold5%></td>
	
	<td class="rptValue"><%=hconn1%></td>
	<td class="rptValue"><%=hconn2%></td>
	   <td class="rptValue"><%=hconn3%></td>
	     <td class="rptValue"><%=hconn4%></td>
		 <td class="rptValue"><%=hconn5%></td>
	
	<td class="rptValue"><%=h3%></td>
	 <td class="rptValue"></td>
	 <td class="rptValue"></td>
	<td class="rptValue"><%=h1%></td>
	<%if(h2.equals("0"))
		{
	h2="-";
		}%>
	  <td class="rptValue"><%=h2%></td>
	  
 <td class="rptValue"><%=phold1%></td>
	<td class="rptValue"><%=phold3%></td>
	<td class="rptValue"><%=phold2%></td>
	<td class="rptValue"><%=phold4%></td>
	<td class="rptValue"><%=phold5%></td>
	
		<!--<td class="rptValue"><%=cp1%></td>
	<td class="rptValue"><%=cp2%></td>

<td class="rptValue"><b>GLSR:</b><br><b>OHSR:</b></td>
	<td class="rptValue"><b>GLSR:</b><br><b>OHSR:</b></td>
	<td class="rptValue"><b>GLSR:</b><br><b>OHSR:</b></td>
	<td class="rptValue"><b>GLSR:</b><br><b>OHSR:</b></td>
	
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->

	<%gtxidValueOld = gtxidValue;%>
	 	</tr>
    	<%}
}catch(Exception e)
		{
		System.out.println("error::"+e);
		}%>
</table>

  
