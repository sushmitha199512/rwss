<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="conn.jsp" %>
<form>
<%
int sno=1;
	  Statement st1=null,st2=null;
	  ResultSet rs1=null,rs2=null;
	  String qry="";
	  //Connection conn=null;
      String district=(String)session.getAttribute("district");
      //System.out.println("district***********"+district);
      String dname=(String)session.getAttribute("dname");
     
     //  System.out.println("district***********"+dname);
     String asset="";
     String shp="";
     String openwell="";
     String source="";
     String pond=""; 
ResultSet rs3=null,rs4=null,rs5=null;
Statement stmt1=null, stmt2=null,stmt3=null,stmt4=null,stmt5=null;
int total=0,gtotal=0,ftotal=0,f1=0,fc=0;

String fromdate=(String)session.getAttribute("fromdate");
String todate=(String)session.getAttribute("todate");
//System.out.println("fromdate********"+fromdate);
//System.out.println("todate************"+todate);
String gtxidValueOld = "",gtxidValue="";%>
<p align=center>
Note:-<font color=red>No. Of Sources=Sources + Handpumps + Openwells + Ponds + ShallowHandpumps</font>
</p>R
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=6> Water Quality FTK - Report</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center" colspan=6>
	<td class=btext>District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;<font color=red> </font>&nbsp;&nbsp;&nbsp;FromDate:<font color=red><%=fromdate%></font>&nbsp;&nbsp;&nbsp;<font color=red> </font>ToDate:<font color=red><%=todate%></font>&nbsp;&nbsp;&nbsp;<font color=red> </font></td>
	</tr>
	
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap align=center nowrap>Sl.No</td>
    <td class=btext  nowrap align=center nowrap>District</td>
	<td class=btext  nowrap align=center nowrap>Division</td>
	<td class=btext  nowrap align=center nowrap>No. Of Sources</td>
    
	<td class=btext  nowrap align=center nowrap>No. Of  Sources Tested</td>
    <td class=btext  nowrap align=center nowrap>Total No. Of FTK's</td> 
	</tr>
<%
try
{
///select count(*)  from rws_ftk_testing_tbl where  to_date(test_date,'dd-mon-yy')>='05-FEB-09' and to_date(test_date,'dd-mon-yy')<='10-FEB-10'
 asset="select   count(*),substr(source_code,1,2),division_office_code from rws_ftk_testing_tbl a,rws_complete_hab_view b where substr(source_code,1,16)=b.panch_code and to_date(test_date,'dd-mon-yy')>='"+fromdate+"' and to_date(test_date,'dd-mon-yy')<='"+todate+"' group by substr(source_code,1,2),division_office_code";
  
    
    
	Statement	stsh=conn.createStatement();
	//System.out.println("asset:"+asset);
	ResultSet rssh=stsh.executeQuery(asset);
	Hashtable shh=new Hashtable();
	while(rssh.next())
	{
	shh.put(rssh.getString(2)+rssh.getString(3),rssh.getString(1));
	}


  
shp="select    count(distinct source_code),substr(source_code,1,2),division_office_code from rws_ftk_testing_tbl a,rws_complete_hab_view b where substr(source_code,1,16)=b.panch_code and to_date(test_date,'dd-mon-yy')>='"+fromdate+"' and to_date(test_date,'dd-mon-yy')<='"+todate+"' group by substr(source_code,1,2),division_office_code";
Statement sh=conn.createStatement();
//System.out.println("shp**********:"+shp);
ResultSet shrs=sh.executeQuery(shp);
Hashtable h1=new Hashtable();
while(shrs.next())
{
h1.put(shrs.getString(2)+shrs.getString(3),shrs.getString(1));
}
	

/////
String qry1="select count(*),substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
qry1+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
 //System.out.println("qry1:"+qry1);
stmt1=conn.createStatement();
rs1=stmt1.executeQuery(qry1);
Hashtable aht=new Hashtable();
while(rs1.next())
{
  aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
}
//hp
String qry2="select count(*) ,substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";

	qry2+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt2=conn.createStatement();
 //System.out.println("qry2***:"+qry2);
rs2=stmt2.executeQuery(qry2);
Hashtable hpht=new Hashtable();
while(rs2.next())
 {
   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
 }
 //open
 String qry3="select count(*) ,substr(m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";

	qry3+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt3=conn.createStatement();
// System.out.println("qry3*****:"+qry3);
rs3=stmt3.executeQuery(qry3);
Hashtable opht=new Hashtable();
while(rs3.next())
 {
   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
 }
 // shp
 String qry4="select count(*),substr (m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
 	qry4+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt4=conn.createStatement();
 //System.out.println("qry4****:"+qry4);
rs4=stmt4.executeQuery(qry4);
Hashtable shpht=new Hashtable();
while(rs4.next())
 {
   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
 }
//ponds
String qry5="select count(*),substr (m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
 	qry5+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt5=conn.createStatement();
 //System.out.println("qry5*****:"+qry5);
rs5=stmt5.executeQuery(qry5);
Hashtable pondht=new Hashtable();
while(rs5.next())
 {
   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
 }

///
    
    //for hp count

	//qry="select count(*),dcode,dname,a.division_office_code,sd.division_office_name from rws_ftk_testing_tbl a,rws_district_tbl d,rws_division_office_tbl sd  where d.dcode=substr(source_code,1,2) and sd.division_office_code=a.division_office_code and sd.circle_office_code=substr(source_code,1,2) and d.dcode='"+district+"' group by dcode,dname,a.division_office_code,sd.division_office_name order by 2";
    if(district.equals("ALL"))
    {
    qry="select a.circle_office_code,a.circle_office_name,b.division_office_code,b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code  order by a.circle_office_code"; 
   }
   else
    {
       qry="select a.circle_office_code,a.circle_office_name,b.division_office_code,b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and a.circle_office_code='"+district+"'"; 
    }
  
	//System.out.println("qry************"+qry);
    st1=conn.createStatement();
	rs1=st1.executeQuery(qry);
	while(rs1.next())
	{
     String s1=(String)aht.get(rs1.getString(1)+rs1.getString(3));
     if(s1!=null && !s1.equals("") && !s1.equals("null"))
     {
     } 
     else
     {
      s1="0";
      }

//
     String s2=(String)hpht.get(rs1.getString(1)+rs1.getString(3));
     if(s2!=null && !s2.equals("") && !s2.equals("null"))
     {
     } 
     else
     {
      s2="0";
      }

//
     String s3=(String)opht.get(rs1.getString(1)+rs1.getString(3));
     if(s3!=null && !s3.equals("") && !s3.equals("null"))
     {
     } 
     else
     {
      s3="0";
      }     
// 
     String s4=(String)shpht.get(rs1.getString(1)+rs1.getString(3));
     if(s4!=null && !s4.equals("") && !s4.equals("null"))
     {
     } 
     else
     {
      s4="0";
      }
      String s5=(String)pondht.get(rs1.getString(1)+rs1.getString(3));
     if(s5!=null && !s5.equals("") && !s5.equals("null"))
     {
     } 
     else
     {
      s5="0";
      } 
int p1=0; 
p1=Integer.parseInt(s1)+Integer.parseInt(s2)+Integer.parseInt(s3)+Integer.parseInt(s4)+Integer.parseInt(s5);
//System.out.println("count"+p1);
String ftk=(String)shh.get(rs1.getString(1)+rs1.getString(3));
if(ftk!=null && !ftk.equals("") && !ftk.equals("null"))
{
}
else
{
ftk="0";
}

String ftkcount=(String)h1.get(rs1.getString(1)+rs1.getString(3));
if(ftkcount!=null && !ftkcount.equals("") && !ftkcount.equals("null"))
{
}
else
{
ftkcount="0";
}


   

%>

	<tr>
    <td class="rptValue"><%=sno++%></td>
<%gtxidValue=rs1.getString(2);
if(!gtxidValue.equals(gtxidValueOld)){ %>
    <td class="rptValue" align=left><%=rs1.getString(2)%></td>
   
<%}else{ %>  
    <td class="rptValue" align=left></td> 
<%} %>
    <td class="rptValue" align=left><%=rs1.getString(4)%></td>  
    <td class="rptValue" align=center><%=p1%></td>
        
        <td class="rptValue" align=center><%=ftkcount%></td>
        <td class="rptValue" align=center><%=ftk%></td>
    
    
   	</tr>

<%
total=total+p1;
//gtotal=0,ftotal=0,f1=0,fc=0;
ftotal=Integer.parseInt(ftk);
f1=Integer.parseInt(ftkcount);

gtotal=ftotal+gtotal;
fc=fc+f1;
gtxidValueOld = gtxidValue;
 }

%>
<tr>
    <td class="btext">Total:</td>
    <td class="rptValue"></td>
    <td class="rptValue"></td>
    <td class="rptValue" align=center><%=total%></td>
    
    <td class="rptValue" align=center><%=fc%></td>
    <td class="rptValue" align=center><%=gtotal%></td>
    </tr>
    
<% 
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}
%>
     

</table>

  
