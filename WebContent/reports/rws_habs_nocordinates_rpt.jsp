<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt3=null,st1=null,st2=null,st3=null,st4=null;
    String qry="";
	ResultSet rs8=null,rs131=null,rs1=null,rs2=null,rs3=null,rs4=null;
	String dname=request.getParameter("dname");
if(dname!=null){
session.setAttribute("dname",dname);
}
    int sno=1;
String qry8="",qry9="";
	
	String dcode=request.getParameter("district");
     if(dcode!=null){
session.setAttribute("district",dcode);
}
	
		%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back |&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home  
	</a><a href="./rws_habs_nocordinates_xls.jsp" target=_new> | &nbsp; Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Habitations Not Having GIS  Coordinates(Latitude,Longitude)  - Report</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td class=btext>District:<font color=red><%=dname%></font></font></td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap align=center>Sl.No</td>
    <td class=btext  nowrap align=center>District</td>
	<td class=btext  nowrap align=center>Mandal</td>
	<td class=btext  nowrap align=center>Panchayath</td>
	<td class=btext  nowrap align=center>Habitation Code</td>
    <td class=btext  nowrap align=center>Habitation Name</td>

	
	</tr>
<%
try
{
      

		
	    
     String resultHabs="";  
String qryasset="";  
int a=0;     
boolean flag=false;
stmt8=conn.createStatement();
st1=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();
stmt3=conn.createStatement();
Statement	stmt4=conn.createStatement();
ArrayList assets=(ArrayList)session.getAttribute("assets");

if(assets==null){
qryasset="select hab_code from rws_asset_mast_tbl where longitude is not null and latitude is not null  ";
 rs4=stmt4.executeQuery(qryasset);
assets=new ArrayList();
	while(rs4.next())
	{
		assets.add(rs4.getString(1));
	}
	session.setAttribute("assets",assets);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

}


qryasset="select hab_code from rws_source_tbl where longitude is  not null and latitude is not null  ";
ArrayList sources=(ArrayList)session.getAttribute("sources");
if(sources==null){
stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);
sources=new ArrayList();
	while(rs4.next())
	{
		sources.add(rs4.getString(1));
	}
session.setAttribute("sources",sources);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
}


qryasset="select substr(hp_code,1,16) from rws_hp_subcomp_param_tbl  where longitude is  not null and latitude is not null  ";
	ArrayList hps=(ArrayList)session.getAttribute("hps");
if(hps==null){
stmt4=conn.createStatement();
rs4=stmt4.executeQuery(qryasset);
hps=new ArrayList();
	while(rs4.next())
	{
		hps.add(rs4.getString(1));
	}
	session.setAttribute("hps",hps);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

}

qryasset="select substr(GLBR_CODE,1,16) from rws_ast_glbr_sc_param_tbl   where longitude is  not null and latitude is not null  ";
	
ArrayList glbr=(ArrayList)session.getAttribute("glbr");
if(glbr==null){
glbr=new ArrayList();
stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);
	while(rs4.next())
	{
		glbr.add(rs4.getString(1));
	}
session.setAttribute("glbr",glbr);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

}


qryasset="select substr(GLSR_CODE,1,16) from rws_ast_glsr_sc_param_tbl  where longitude is  not null and latitude is not null  ";
	
ArrayList glsr=(ArrayList)session.getAttribute("glsr");
if(glsr==null){
glsr=new ArrayList();
stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);
	while(rs4.next())
	{
		glsr.add(rs4.getString(1));
	}
    session.setAttribute("glsr",glsr);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();


}

qryasset="select substr(OHSR_CODE ,1,16) from rws_ast_ohsr_sc_param_tbl   where longitude is  not null and latitude is not null  ";

	ArrayList ohsr=(ArrayList)session.getAttribute("ohsr");
 if(ohsr==null){
ohsr=new ArrayList();
	stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);
	while(rs4.next())
	{
		ohsr.add(rs4.getString(1));
	}
	session.setAttribute("ohsr",ohsr);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
}




qryasset="select substr(OHBR_CODE,1,16) from rws_ast_ohbr_sc_param_tbl  where longitude is  not null and latitude is  not null and elevation is not  null and way_point is  not null ";

	ArrayList ohbr=(ArrayList)session.getAttribute("ohbr");
      if(ohbr==null){
ohbr=new ArrayList();
	stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);

	while(rs4.next())
	{
		ohbr.add(rs4.getString(1));
	}
 		session.setAttribute("ohbr",ohbr);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
}





qryasset="select substr(openwell_code,1,16)  from rws_open_well_mast_tbl   where longitude is  not null and latitude is not null  ";

	ArrayList openWellMaster=(ArrayList)session.getAttribute("openWellMaster");
      if(openWellMaster==null){
		openWellMaster=new ArrayList();
	stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);

	while(rs4.next())
	{
		openWellMaster.add(rs4.getString(1));
	}

		session.setAttribute("openWellMaster",openWellMaster);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

}





qryasset="select hab_code from rws_ast_subcomp_param_tbl  where longitude is  not null and latitude is not null  ";

ArrayList subComp=(ArrayList)session.getAttribute("subComp");
 if(subComp==null){	
subComp=new ArrayList();
stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);
	while(rs4.next())
	{
		subComp.add(rs4.getString(1));
	}
	session.setAttribute("subComp",subComp);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

}


qryasset="select hab_code from rws_ast_wtp_sc_param_tbl where longitude is  not null and latitude is not null  ";
	ArrayList subComp1=(ArrayList)session.getAttribute("subComp1");
		if(subComp1==null){
subComp1=new ArrayList();
	stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);

	while(rs4.next())
	{
		subComp1.add(rs4.getString(1));
	}
	session.setAttribute("subComp1",subComp1);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

}
qryasset="select hab_code from rws_school_master_tbl  where longitude is  not null and latitude is not null  ";
	ArrayList school=(ArrayList)session.getAttribute("school");
  if(school==null){
	school=new ArrayList();
	stmt4=conn.createStatement();
 rs4=stmt4.executeQuery(qryasset);

	while(rs4.next())
	{
		school.add(rs4.getString(1));
	}
session.setAttribute("school",school);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
}

if(dcode.equals("ALL"))
{
qry8="select distinct a.panch_code from rws_panchayat_raj_tbl a,rws_complete_hab_view b where a.panch_code=b.panch_code and coverage_status is not null and coverage_status<>'UI' and (longitude is  null and latitude is null and elevation is null and way_point is null and landmark is null) ";
}
else
{
  qry8="select distinct a.panch_code  from rws_panchayat_raj_tbl a,rws_complete_hab_view b where a.panch_code=b.panch_code and coverage_status is not null and coverage_status<>'UI' and (longitude is  null and latitude is null and elevation is null and way_point is null and landmark is null) and substr(a.panch_code,1,2)='"+dcode+"'";
}
  
   //System.out.println("qry8*********"+qry8);
   
   rs8=stmt8.executeQuery(qry8);
   while(rs8.next())
   {
              String habCode=rs8.getString(1);
                   if(assets.contains(habCode) ||  sources.contains(habCode) ||  hps.contains(habCode) ||  glsr.contains(habCode) ||  glbr.contains(habCode) || ohsr.contains(habCode) || ohbr.contains(habCode) || openWellMaster.contains(habCode) || subComp.contains(habCode) || subComp1.contains(habCode) || school.contains(habCode)){
        
					}else{
           resultHabs=resultHabs+","+rs8.getString(1);
       }

     } 

if(resultHabs.length()>1){
String finalValue=resultHabs.substring(1,resultHabs.length()-1);
String q1="select  b.dname,b.mname,a.panch_code,a.panch_name,b.PNAME  from rws_panchayat_raj_tbl a,rws_complete_hab_view b  where  a.panch_code=b.panch_code  and  a.panch_code in("+finalValue+")";


ResultSet rrs=stmt3.executeQuery(q1);
     while(rrs.next()){
		%>
	<tr>
    <td class="rptValue"><%=sno++%></td>
        <td class="rptValue" align=left><%=rrs.getString(1) %></td>
    <td class="rptValue" align=left><%=rrs.getString(2) %></td>
 <td class="rptValue" align=left><%=rrs.getString(5) %></td>  
    <td class="rptValue" align=left><%=rrs.getString(3) %></td>
    <td class="rptValue" align=left><%=rrs.getString(4) %></td>  

    </tr>

 
<%
 
	   
 }
}
%>

<% 
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
try
{
if(stmt8 != null)
{
stmt8.close();
}
if(rs8 != null)
{
rs8.close();
}
if( conn != null )
{
conn.close();
}
}
catch(SQLException p)
{
p.printStackTrace();
}
}
%>
     

</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
