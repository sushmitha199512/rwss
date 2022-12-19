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
    Statement stmt131=null;
    ResultSet rs131=null;
	int sno=1;
	String qry="";
	String h1="",h2="",h3="",h4="",h5="",h6="",h7="",h8="",h9="",h10="",h11="",h12="",h13="",h14="";
	String s1="",s2="",s3="",s4="";
    String sh1="",sh2="",sh3="",sh4="";
    String a1="",a2="",a3="",a4="";
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan="15" > School  Information - Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
	<td class=btext rowspan = 2 nowrap>Sl.No</td>
	<td class=btext rowspan = 2 nowrap>Habitation Code/<br>Name</td>
	<td class=btext rowspan=2 nowrap>Schoolcode/<br>Name</td>
    	
	<td class=btext rowspan=2 nowrap>SchoolLocation</td>
    <td class=btext  rowspan=2 nowrap>Category of School/<br>Classification</td>
	 
     <td class=btext  rowspan = 2 nowrap>Facilities Available(Yes/No)<br>Drinking Water/Sanitation</td>
     <td class=btext  colspan=4 nowrap>DW Covered by (Borewell/Scheme)</td> 
     <td class=btext colspan=4 nowrap>School Location</td> 
	<td class=btext rowspan = 2 nowrap>Remarks</td>
	
	</tr>
	<tr>
	<td class=btext nowrap>Borewell Name</td>
    <td class=btext nowrap>Pump Code</td>
    <td class=btext nowrap>Scheme Name</td>
    <td class=btext nowrap>SchemeCode</td>
	<td class=btext nowrap>GPS Code<br>(Way point)</td>
	<td class=btext nowrap>Latitude</td>
	<td class=btext nowrap>Longitude</td>
	<td class=btext nowrap>Elevation</td>
	
	</tr>     
	
	

	                 
<%
try
{
    Statement stmt8=null;
	ResultSet rs8=null;
	//for asset_codes
    String asset="select  a.asset_code,b.school_code,nvl(c.asset_name,'-'),c.type_of_asset_code,a.hab_code from rws_school_asset_lnk_tbl a,rws_school_master_tbl b,rws_asset_mast_tbl c where a.hab_code||a.school_code=b.hab_code||b.school_code and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and c.asset_code=a.asset_code and c.hab_code=b.hab_code";
	Statement	stsh=conn.createStatement();
	//System.out.println("sh:"+sh);
	ResultSet rssh=stsh.executeQuery(asset);
	Hashtable shh=new Hashtable();
	while(rssh.next())
	{
	shh.put(rssh.getString(5),rssh.getString(1)+"#"+rssh.getString(2)+"#"+rssh.getString(3)+"#"+rssh.getString(4));
	}
	if(rssh != null)
	{
		rssh.close();
	}
	if(stsh != null)
	{
		stsh.close();
	}
    //
    String hh="select hp_code,asset_code from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)='"+dcode+"' and substr(hp_code,6,2)='"+mcode+"'"; 
	Statement	p1=conn.createStatement();
	//System.out.println("hh:"+hh);
	ResultSet p2=p1.executeQuery(hh);
	Hashtable hp5=new Hashtable();
	while(p2.next())
	{
	hp5.put(p2.getString(2),p2.getString(1));
	}
	if(p2 != null)
	{
		p2.close();
	}
	if(p1 != null)
	{
		p1.close();
	}
    ///
       qry="select mname,pname,panch_name,panch_code from rws_complete_hab_view where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' order by panch_code";
  
        stmt131=conn.createStatement();
	   //System.out.println(" handpumps:"+qry);
	    rs131=stmt131.executeQuery(qry);
	    Hashtable hp1=new Hashtable();
		while(rs131.next())
	   {
		hp1.put(rs131.getString(4),rs131.getString(1)+"#"+rs131.getString(2)+"#"+rs131.getString(3));
       
	   }
	if(rs131!=null)rs131.close();
	if(stmt131!=null)stmt131.close();

    //
	
	
	String gqry="select  a.school_code,nvl(school_name,'-'),nvl(school_location,'-'),decode(school_category_code,'01','Balwadi/Aganwadi','02','Primary','03','Upper Primary','04','Secondary','05','Sr. Secondary' ) as school_category_code,school_classification,facilities_available,nvl(way_point,'0'),nvl(latitude,'0'),nvl(longitude,'0'),nvl(elevation,'0'),a.hab_code from rws_school_master_tbl a where   substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' order by hab_code";
	stmt8=conn.createStatement();
    //System.out.println("gqry*******:"+gqry);
	rs8=stmt8.executeQuery(gqry);
    gtxidValue="";
	while (rs8.next())
	{
//    hp1
    String sw=(String)hp1.get(rs8.getString(11));
	if(sw!=null && !sw.equals("") && !sw.equals("null"))
	{String []sh=sw.split("#");
    sh1=sh[0];
    sh2=sh[1];
	sh3=sh[2];
    
     
	}
	else{
	sh1="-";
	sh2="-";
	sh3="-";
    
    
	}
    ///
String aw=(String)shh.get(rs8.getString(11));
	if(aw!=null && !aw.equals("") && !aw.equals("null"))
	{String []awh=aw.split("#");
    a1=awh[0];
    a2=awh[1];
	a3=awh[2];
    a4=awh[3];
    
     
	}
	else{
	a1="-";
	a2="-";
	a3="-";
    a4="-";
    
    
	}


////
   String hb=(String)hp5.get(a1);
	
	if(hb != null && !hb.equals("") && !hb.equals("null"))
	{
	}
	else
		{
		hb="-";
		}
	

	  
     gtxidValue = ""+sh2;
		
		if(!gtxidValue.equals(gtxidValueOld)){
		
		%>
<tr><td  colspan="15"  class=btext>Panchayat Name:<%=sh2%></td></tr>
<%}else{}%>
	<tr>
	<td class="rptValue"><%=sno++%></td>
       <td class="rptValue"><%=rs8.getString(11)%>/<br><%=sh3%></td>
    	<td class="rptValue"><%=rs8.getString(1)%>/<br><%=rs8.getString(2)%></td>
        
        <td class="rptValue">&nbsp;<%=rs8.getString(3)%></td>
        <td class="rptValue"><%=rs8.getString(4)%>/</Br><%=rs8.getString(5)%></td>
        <td class="rptValue"><%=rs8.getString(6)%></td>
        <%

    if(a4.equals("04"))
	{%>
	<td class="rptValue"><%=a3%></td>
    <td class="rptValue"><%=hb%>/<br>&nbsp;<%=a1%></td>
	<td class="rptValue">-</td>
	<td class="rptValue">-</td>
	<%}else{%>
	<td class="rptValue">-</td>
	<td class="rptValue">-</td>
    <td class="rptValue"><%=a3%></td>
	<td class="rptValue">&nbsp;<%=a1%></td>
	<%}%>
	
        
        
       <td class="rptValue"><%=rs8.getString(7)%></td>
       <td class="rptValue"><%=rs8.getString(8)%></td>
      <td class="rptValue"><%=rs8.getString(9)%></td>
      <td class="rptValue"><%=rs8.getString(10)%></td> 
      <td class="rptValue"></td>
      
        	
			</tr>
    
	<%gtxidValueOld = gtxidValue;
}
}catch(Exception e)
		{
		//System.out.println("error::"+e);
        e.printStackTrace();
		}
				
		%>
</table>

  
