<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>


<form>
<%
	String dname=(String)session.getAttribute("dname");
	
	String mname=(String)session.getAttribute("mname");
	
	String aname=(String)session.getAttribute("aname");
	
	String dcode=(String)session.getAttribute("dcode");
	
	String mcode=(String)session.getAttribute("mcode");
	
	String asset=(String)session.getAttribute("asset");
	
	String gtxidValueOld = "",gtxidValue="";
		String habValueOld = "",habValue="";
	String assetname="";
    double ys=0.0;
    int wp=0;
    double lat=0.0;
    double lon=0.0;
    double ele=0.0;
	if(asset.equals("04"))
	{
      assetname="HAND PUMPS";
	}
	
	
	session.setAttribute("assetname",assetname);
	int sno=1;
	String qry="";
String gqry="";
	//ResultSet rs10=null;
	String h1="",h2="",h3="",h4="",h5="",h6="",h7="",h8="",h9="",h10="";
	String sh1="",sh2="",sh3="",sh4="",sh5="",sh6="",sh7="",sh8="",sh9="";
	String ow1="",ow2="",ow3="",ow4="",ow5="",ow6="",ow7="",ow8="",ow9="";
    String hr1="",hr2="",hr3="",hr4="",hr5="",hr6="",hr7="",hr8="",hr9="",hr10="";
	String p1="",sam="";
	String p2="";
    Statement stmt8=null,stmt131=null;
    ResultSet rs8=null,rs131=null;
    int i=0;
    
    
	
%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan="16" > Scheme Information Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Asset Type:<%=assetname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext  rowspan = 2>HabitationCode/Name</td>
	<td class=btext nowrap  rowspan = 2>Asset Code/<br>Asset Name/<br>Date Created/<br>Asset Cost(In Lakhs)</td>

	
	<td class=btext   colspan=10>Hand Pumps</td>
	
	<td class=btext   colspan=2>As Per TestResult</td>
	<td class=btext   colspan=2>If Unsafe</td>
	</tr>
   <tr align=center>

<td class=btext>HP Code/<br>Status/<br>Location/</td>
<td class=btext>Area(Gen/SC/<br>ST/Minority)</td>
<td class=btext>Yield(LPM)</td>
<td class=btext>Drain Existing(Y/N)</td>
<td class=btext>Platform Existing(Y/N)</td>
<td class=btext nowrap>GPS Code<br>(Way Point)</td>
<td class=btext>Latitude</td>
<td class=btext>Longitude</td>
<td class=btext>Elevation</td>
<td class=btext>Sample CollectionDate</td>
<td class=btext>Safe</td>
<td class=btext>UnSafe</td>
<td class=btext nowrap>Type of<br>Contamination</td>
<td class=btext nowrap>Level of<br>Contamination</td>
</tr>
              
<%
try
{
	
	String locality="select nvl(locality_code,'-'),nvl(locality_name,'-'),hab_code from RWS_SC_ST_MIN_LOCALITY_TBL where substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'";
	Statement	stmt77=conn.createStatement();
	//System.out.println("locality:"+locality);
	ResultSet rs77=stmt77.executeQuery(locality);
	Hashtable loh=new Hashtable();
		while(rs77.next())
	{
		loh.put(rs77.getString(3),rs77.getString(1)+"@"+rs77.getString(2));
	}
	if(rs77!=null)rs77.close();
	if(stmt77!=null)stmt77.close();
	
	String sample="select nvl(to_char(SAMP_COLLECT_DATE,'dd/mm/yyyy'),'-'),source_code  from rws_water_sample_collect_tbl where substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'";
	Statement stmt55=conn.createStatement();
	//System.out.println("sourcesample:"+sample);
	ResultSet rs55=stmt55.executeQuery(sample);
	Hashtable sourceh=new Hashtable();
		while(rs55.next())
	{
		sourceh.put(rs55.getString(2),rs55.getString(1));
	}
	if(rs55!=null)rs55.close();
	if(stmt55!=null)stmt55.close();

	   qry="select mname,pname,panch_code,panch_name,c.hab_code   from rws_complete_hab_view b,rws_asset_mast_tbl c where c.hab_code=b.panch_code and   substr(panch_code,1,2)='"+dcode+"' and c.type_of_asset_code='04' and substr(panch_code,6,2)='"+mcode+"' order by panch_name ";
        stmt8=conn.createStatement(); 
        stmt131=conn.createStatement();
	    //System.out.println(" handpumps:"+qry);
	    rs131=stmt131.executeQuery(qry);
	    Hashtable hp1=new Hashtable();
		while(rs131.next())
	   {
		hp1.put(rs131.getString(5),rs131.getString(1)+"#"+rs131.getString(2)+"#"+rs131.getString(3)+"#"+rs131.getString(4));
       
	   }
	if(rs131!=null)rs131.close();
	if(stmt131!=null)stmt131.close();


	
		
         gqry="select   am.hab_code,b.hp_code,nvl(b.location,'-'),nvl(b.P_YEILD,0),nvl(decode(b.platform_existing,'Y','Y','N','N'),'-') as platform_existing,nvl(DECODE(b.DRAIN,'E','Y','N','N'),'-') AS DRAIN,nvl(b.way_point,0),nvl(b.latitude,0.0),nvl(b.longitude,0.0),nvl(b.elevation,0.0),b.asset_code,decode(am.asset_status,'1','Working','2','Not Working','3','Seasonal','4','Dried','5','Condemened') as asset_status,nvl(am.asset_name,'-'),to_char(am.date_creation,'dd/mm/yyyy'),nvl(am.asset_cost,0)  from rws_hp_subcomp_param_tbl b,rws_asset_mast_tbl am,rws_asset_scheme_tbl at where    b.asset_code=am.asset_code and b.asset_code=at.asset_code and type_of_asset_code='04'  and  substr(at.scheme_code,1,2)='"+dcode+"'    ";

		if(mcode!=null && !mcode.equals(""))
		{
	     gqry+="and substr(at.scheme_code,6,2)='"+mcode+"'";
		 }
	    gqry+=" order by am.hab_code asc ";

		
	
    //System.out.println("gqry***********:"+gqry);
	rs8=stmt8.executeQuery(gqry);
   if(rs8.isBeforeFirst())
   {
	while (rs8.next())
	{
		i=i+1;
      


    String sw=(String)hp1.get(rs8.getString(1));
	if(sw!=null && !sw.equals("") && !sw.equals("null"))
	{String []sh=sw.split("#");
    sh1=sh[0];sh2=sh[1];
	sh3=sh[2];
    sh4=sh[3];
     
	}
	else{
	sh1="-";
	sh2="-";
	sh3="-";
    sh4="-";
    
	}
String pw=(String)loh.get(rs8.getString(1));
	if(pw!=null && !pw.equals("") && !pw.equals("null"))
     {String []ph=pw.split("#");
    p1=ph[0];
    p2=ph[1];
	}
	else
{
p1="-";
p2="-";
}

String sd=(String)sourceh.get(rs8.getString(2));
if(sd!=null && !sd.equals("") && !sd.equals("null"))
{
sam=sd;
}
else
{
sam="-";
}


       gtxidValue = ""+sh2;
		
		if(!gtxidValue.equals(gtxidValueOld)){
		
		%>
<tr><td  colspan="17"  class=btext>Panchayat Name:<%=sh2%></td></tr>
<%}else{}%>

	
		<tr>
		<td class="rptValue"><%=sno++%></td>
		<td class="rptValue"><%=sh3%>/<br><%=sh4%></td>

		<td class="rptValue"><%=rs8.getString(11)%>/<br><%=rs8.getString(13)%>/<br><%=rs8.getString(14)%>/<br><%=rs8.getString(15)%></td>
<td class="rptValue"><%=rs8.getString(2)%>/<br><%=rs8.getString(12)%>/<br><%=rs8.getString(3)%></td>
		<td class="rptValue"><%=p1%>/<%=p2%></td>
		<td class="rptValue"><%=rs8.getString(4)%></td>
		<td class="rptValue"><%=rs8.getString(5)%></td>
		<td class="rptValue"><%=rs8.getString(6)%></td>
		<td class="rptValue"><%=rs8.getString(7)%></td>
		<td class="rptValue"><%=rs8.getString(8)%></td>
		<td class="rptValue"><%=rs8.getString(9)%></td>
		<td class="rptValue"><%=rs8.getString(10)%></td>
		<td class="rptValue"><%=sam%></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>

		
<%
gtxidValueOld = gtxidValue;
}}
else
{ %>
		<script>
		alert(" No Matching data is Found- You are redirected to Previous page");
		document.location.href="rws_asurfaceohsr_frm.jsp";
		</script>
<%
}}catch(Exception e)
		{
		//System.out.println("error::"+e);
		}%>
</table>

  
