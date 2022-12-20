<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="conn.jsp" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Assets_PriorityReport.xls");
%>
<form>
<%
Statement stmt1=null,stmt2=null;
Statement st1=null,st2=null,st3=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null;
ResultSet rs6=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs7=null;
ResultSet rs8=null;
ResultSet pwsrs=null;
ResultSet pwscovrs=null;
ResultSet pwspoprs=null;
Statement pwsst=null;
Statement pwscovst=null;
Statement pwspopst=null;
int gtot=0;
int gatot=0;
int bgtot=0;
int tot=0;
int tot1=0;
int tot2=0;
ResultSet r1=null,r2=null,r3=null,r4=null,r5=null,r6=null,r7=null,r8=null,r9=null,r10=null,r11=null;
Statement t1=null,t2=null,t3=null,t4=null,t5=null,t6=null,t7=null,t8=null,t9=null;




String dcode=(String)session.getAttribute("dcode");
session.setAttribute("dcode",dcode);

int sno=1;
String qry="";
String queryasset="";

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  style="border-collapse:collapse"  ALIGN=CENTER>
<tr  align="center">
		<td align="center" class="gridhdbg" colspan="23">  Assets Priority Report</td>
</tr>
<tr>
               <td class=gridhdbg>Sl.No</td>
               <td class=gridhdbg >District</td>
                              <td class=gridhdbg  >CPWS</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>
                              <td class=gridhdbg >PWS</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>
               <td class=gridhdbg >MPWS</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>
<td class=gridhdbg >Direct Pumping</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>

<td class=gridhdbg >HP/SHP</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>
<td class=gridhdbg >Openwells</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>

<td class=gridhdbg >Others &nbsp;(Schools,Sustainbility,Others,Ponds)</td>
                                                             <td class=gridhdbg >Habs Covered</td>
                              <td class=gridhdbg >Population</td>
		    
		   
			   </tr>
<%
try
{

String query = "";   
String cpwsquery="";
String cpwspop="";
String pwscount="";
String pwscov="";
String pwspop="";
int s1=0;
int s2=0;
int s3=0;
int gtot1=0;
int gtot2=0;
int s4=0;
int s5=0;
int s6=0;
int g4=0;
int g5=0;
int g6=0;
int s7=0;
int s8=0;
int s9=0;
int g7=0;
int g8=0;
int g9=0;
int s10=0;
int s11=0;
int s12=0;
int s13=0;
int s14=0;
int s15=0;
int g10=0;
int g11=0;
int g12=0;
int g13=0;
int g14=0;
int g15=0;

int gOW=0,gOWH=0,gOWPop=0;
int gO=0,gOH=0,gOPop=0;

Set cpwsSet=new HashSet();
Set pwsSet=new HashSet();
Set mpwsSet=new HashSet();
Set dpSet=new HashSet();
Set hpSet=new HashSet();
Set openwell=new HashSet();
Set othersSet=new HashSet();

if(session.getAttribute("cpwsSet")==null){


String popCalculateQuery="select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code    order by type_of_asset_code";

Statement sm1=conn.createStatement();

r10=sm1.executeQuery(popCalculateQuery);


 while(r10.next()){
	 
	 if(r10.getString(2).equals("03")){
	 if(!cpwsSet.contains(r10.getString(1))){
		 cpwsSet.add(r10.getString(1));
	 }
	 }else if(r10.getString(2).equals("01")){
		 
		 if(cpwsSet.contains(r10.getString(1))){
		 			 continue;
		 }
		 if(!pwsSet.contains(r10.getString(1))){
			 pwsSet.add(r10.getString(1));
		 }
		 }else if(r10.getString(2).equals("02")){
			 
			 if(cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1)) ){
						 continue;
			 }
			 if(!mpwsSet.contains(r10.getString(1))){
				 mpwsSet.add(r10.getString(1));
			 }
			 }else if(r10.getString(2).equals("09")){
				 if(cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1)) || mpwsSet.contains(r10.getString(1)) ){
					 continue;
				 }
				 if(!dpSet.contains(r10.getString(1))){
					 dpSet.add(r10.getString(1));
				 }
				 }else if(r10.getString(2).equals("04") || r10.getString(2).equals("05")){
					 
					 if(cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1)) || mpwsSet.contains(r10.getString(1)) || dpSet.contains(r10.getString(1)) ){
						 continue;
					 }
					 
					 if(!hpSet.contains(r10.getString(1))){
						 hpSet.add(r10.getString(1));
					 }
					 }else if(r10.getString(2).equals("06")){
						 
						 if(cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1)) || mpwsSet.contains(r10.getString(1)) || dpSet.contains(r10.getString(1)) || hpSet.contains(r10.getString(1))){
							 continue;
						 }
						 
						 if(!openwell.contains(r10.getString(1))){
							 openwell.add(r10.getString(1));
						 }
						 }else{
							 
							 if(cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1)) || mpwsSet.contains(r10.getString(1)) || dpSet.contains(r10.getString(1)) || hpSet.contains(r10.getString(1)) || openwell.contains(r10.getString(1))){
								 continue;
							 }
							 
							 if(!othersSet.contains(r10.getString(1))){
								 othersSet.add(r10.getString(1));
							 } 
							 
						 }
	       
 }
 
 
 session.setAttribute("cpwsSet",cpwsSet);
 session.setAttribute("pwsSet",pwsSet);
 session.setAttribute("mpwsSet",mpwsSet);
 session.setAttribute("dpSet",dpSet);
 session.setAttribute("hpSet",hpSet);
 session.setAttribute("openwell",openwell);
 session.setAttribute("othersSet",othersSet);
 
 
// System.out.println("CPWS Habs:"+cpwsSet.size());
 //System.out.println("PWS Habs:"+pwsSet.size());
 //System.out.println("MPWS Habs:"+mpwsSet.size());
 //System.out.println("DP Habs:"+dpSet.size());
 //System.out.println("HP Habs:"+hpSet.size());
}else{
	

	cpwsSet=(HashSet)session.getAttribute("cpwsSet");
	pwsSet=(HashSet)session.getAttribute("pwsSet");
	mpwsSet=(HashSet)session.getAttribute("mpwsSet");
	dpSet=(HashSet)session.getAttribute("dpSet");
	hpSet=(HashSet)session.getAttribute("hpSet");
	othersSet=(HashSet)session.getAttribute("othersSet");
	openwell=(HashSet)session.getAttribute("openwell");
	
}
 
 

cpwsquery="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03' group by substr(panch_code,1,2)";

st1=conn.createStatement();
 ////System.out.println("qry2:"+cpwsquery);
rs4=st1.executeQuery(cpwsquery);
Hashtable cpws=new Hashtable();
while(rs4.next())
 {
   cpws.put(rs4.getString(2),rs4.getString(1));
 }



//pws
pwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' group by substr(panch_code,1,2)";

pwsst=conn.createStatement();
 //System.out.println("qry2:"+pwscount);
pwsrs=pwsst.executeQuery(pwscount);
Hashtable pws=new Hashtable();
while(pwsrs.next())
 {
   pws.put(pwsrs.getString(2),pwsrs.getString(1));
 }
//mpws
String mpwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='02' group by substr(panch_code,1,2)";

t1=conn.createStatement();
 //System.out.println("qry2:"+mpwscount);
r1=t1.executeQuery(mpwscount);
Hashtable mpws=new Hashtable();
while(r1.next())
 {
   mpws.put(r1.getString(2),r1.getString(1));
 }


//hp & Openwell
String hpwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('04','05') group by substr(panch_code,1,2)";

t4=conn.createStatement();
 //System.out.println("qry2:"+hpwscount);
r4=t4.executeQuery(hpwscount);
Hashtable hmpws=new Hashtable();
while(r4.next())
 {
   hmpws.put(r4.getString(2),r4.getString(1));
 }


//OW
String dpwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='09' group by substr(panch_code,1,2)";
t7=conn.createStatement();
 //System.out.println("qry2:"+dpwscount);
r7=t7.executeQuery(dpwscount);
Hashtable dmpws=new Hashtable();
while(r7.next())
 {
   dmpws.put(r7.getString(2),r7.getString(1));
 }



//Others
String openwellsCount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='06' group by substr(panch_code,1,2)";
Statement st8=conn.createStatement();
// System.out.println("openwellsCount:"+openwellsCount);
ResultSet rss8=st8.executeQuery(openwellsCount);
Hashtable openwellHash=new Hashtable();
while(rss8.next())
 {
	openwellHash.put(rss8.getString(2),rss8.getString(1));
 }



//dp
String othersCount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('07','08','10','11','12') group by substr(panch_code,1,2)";
Statement st7=conn.createStatement();
 //System.out.println("othersCount:"+othersCount);
ResultSet rss7=st7.executeQuery(othersCount);
Hashtable othersHash=new Hashtable();
while(rss7.next())
 {
	othersHash.put(rss7.getString(2),rss7.getString(1));
 }




Statement ssmt=conn.createStatement();
 

	 if(dcode!=null && !dcode.equals("") && dcode.equals("00"))
		{
	  qry="select  dcode,dname from rws_district_tbl where dcode<>'16' order by dcode";
	  }
	else if(dcode!=null && !dcode.equals("") && !dcode.equals("00"))
	{
	  qry="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"' order by dcode";
	  }
  stmt1=conn.createStatement();
   
//System.out.println("qry2:"+qry);
int styleCount=0;
String style="";
  rs1=stmt1.executeQuery(qry);
  
  while(rs1.next())
  {
	  
	  
	  int  cpwsPop=0,pwsPop=0,mpwsPop=0,dpPop=0,hpPop=0,oWPop=0,oPop=0;
	  int cpwsCount=0,pwsCount=0,mpwsCount=0,dpCount=0,hpCount=0,openWellCount=0,oCount=0;
	  String popQuery="select distinct b.hab_code,nvl(CENSUS_PLAIN_POPU,0) ,nvl(CENSUS_SC_POPU,0) , nvl(CENSUS_ST_POPU,0),type_of_asset_code   from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('01','02','03','04','09','05','06','07','08','10','11','12') and substr(panch_code,1,2)='"+rs1.getString(1)+"' order by type_of_asset_code";
	// System.out.print("Query:"+popQuery);
	  r11=ssmt.executeQuery(popQuery);
	  int notScheme=0;
	  while(r11.next()){
		
		  if(r11.getString(5).equals("03")){
			  if(cpwsSet.contains(r11.getString(1))){
				  cpwsCount++;
			  cpwsPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
			  }
		  }else if(r11.getString(5).equals("01")){
			  if(cpwsSet.contains(r11.getString(1))){
				  continue;
			  }
				  if(pwsSet.contains(r11.getString(1))){
					  pwsCount++;
				  pwsPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
				  }
			  }
		  else if(r11.getString(5).equals("02")){
			  if(cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))){
				  continue;
			  }
			  if(mpwsSet.contains(r11.getString(1))){
				  mpwsCount++;
			  mpwsPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
			  }
		  }
		  else if(r11.getString(5).equals("09")){
			  
	  if(cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))  || mpwsSet.contains(r11.getString(1)) ){
				  continue;
			  }
			  if(dpSet.contains(r11.getString(1))){
				  dpCount++;
			  dpPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
			  }
		  }
		  
		  else if(r11.getString(5).equals("04") || r11.getString(5).equals("05")){
			  if(cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))  || mpwsSet.contains(r11.getString(1)) || dpSet.contains(r11.getString(1)) ){
				  continue;
			  }
			  if(hpSet.contains(r11.getString(1))){
				  hpCount++;
			  hpPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
			  }
		  }
		  else if(r11.getString(5).equals("06")){
			  if(cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))  || mpwsSet.contains(r11.getString(1)) || dpSet.contains(r11.getString(1)) || hpSet.contains(r11.getString(1)) ){
				  continue;
			  }
			  if(openwell.contains(r11.getString(1))){
				  openWellCount++;
			  oWPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
			  }
		  }
		  else{
			  if(cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))  || mpwsSet.contains(r11.getString(1)) || dpSet.contains(r11.getString(1)) || hpSet.contains(r11.getString(1)) || openwell.contains(r11.getString(1)) ){
				  continue;
			  }
			  oCount++;
			  oPop+=Integer.parseInt(r11.getString(2))+Integer.parseInt(r11.getString(3))+Integer.parseInt(r11.getString(4));
		  }
	  }
	  
	  //System.out.println("Count+"+notScheme);
	  
String ast=""+cpws.get(rs1.getString(1));
		  if(ast!=null && !ast.equals("") && !ast.equals("null")){} else{ ast="0";}

String ast3=""+pws.get(rs1.getString(1));
		  if(ast3!=null && !ast3.equals("") && !ast3.equals("null")){} else{ ast3="0";}

//mpws
String ast6=""+mpws.get(rs1.getString(1));
		  if(ast6!=null && !ast6.equals("") && !ast6.equals("null")){} else{ ast6="0";}
//
//hp
String ast9=""+hmpws.get(rs1.getString(1));
		  if(ast9!=null && !ast9.equals("") && !ast9.equals("null")){} else{ ast9="0";}
//dp
String ast12=""+dmpws.get(rs1.getString(1));
		  if(ast12!=null && !ast12.equals("") && !ast12.equals("null")){} else{ ast12="0";}

		  String ast13=""+openwellHash.get(rs1.getString(1));
		  if(ast13!=null && !ast13.equals("") && !ast13.equals("null")){} else{ ast13="0";}

		  String ast14=""+othersHash.get(rs1.getString(1));
		  if(ast14!=null && !ast14.equals("") && !ast14.equals("null")){} else{ ast14="0";}

		  		  
		  
s1=Integer.parseInt(ast);
gtot+=s1;

gtot1+=cpwsCount;

gtot2+=cpwsPop;
s4=Integer.parseInt(ast3);
g4+=s4;

g5+=pwsCount;


g6+=pwsPop;
s7=Integer.parseInt(ast6);
g7+=s7;


g8+=mpwsCount;

g9+=mpwsPop;

s10=Integer.parseInt(ast9);
g10+=s10;

gOW+=Integer.parseInt(ast13);
gO+=Integer.parseInt(ast14);

gOWH+=openWellCount;
gOH+=oCount;

gOWPop+=oWPop;
gOPop+=oPop;

g11+=hpPop;


g12+=hpCount;

s13=Integer.parseInt(ast12);
g13+=s13;




g14+=dpCount;


g15+=dpPop;

if(styleCount%2==0){
	 style="gridbg1";
}else{
	 style="gridbg2";
}
styleCount++;

%>
<tr>
<td class=<%=style %> style="text-align: right;"><%=sno++%></td>
<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%></td>
<td class=<%=style %> style="text-align: right;"><%=ast%></td>
<td class=<%=style %> style="text-align: right;"><%=cpwsCount %></td>
<td class=<%=style %> style="text-align: right;"><%=cpwsPop %></td>
<td class=<%=style %> style="text-align: right;"><%=ast3%></td>
<td class=<%=style %> style="text-align: right;"><%=pwsCount %></td>
<td class=<%=style %> style="text-align: right;"><%=pwsPop %></td>
<td class=<%=style %> style="text-align: right;"><%=ast6%></td>
<td class=<%=style %> style="text-align: right;"><%=mpwsCount %></td>
<td class=<%=style %> style="text-align: right;"><%=mpwsPop %></td>
<td class=<%=style %> style="text-align: right;"><%=ast12%></td>


<td class=<%=style %> style="text-align: right;"><%=dpCount %></td>
<td class=<%=style %> style="text-align: right;" ><%=dpPop %></td>
<td class=<%=style %> style="text-align: right;"><%=ast9%></td>

<td class=<%=style %> style="text-align: right;"><%=hpCount %></td>
<td class=<%=style %> style="text-align: right;"><%=hpPop %></td>
<td class=<%=style %> style="text-align: right;"><%=ast13 %></td>
<td class=<%=style %> style="text-align: right;"><%=openWellCount  %></td>
<td class=<%=style %> style="text-align: right;"><%=oWPop %></td>
<td class=<%=style %> style="text-align: right;"><%=ast14 %></td>
<td class=<%=style %> style="text-align: right;"><%=oCount %></td>
<td class=<%=style %> style="text-align: right;"><%=oPop %></td>



</tr>
<%


}
%>
<tr>
<td class="gridhdbg " style="text-align: right;" colspan="2">Total</td>
<td class="gridhdbg " style="text-align: right;"><%=gtot%></td>
<td class="gridhdbg " style="text-align: right;"><%=gtot1%></td>
<td class="gridhdbg " style="text-align: right;"><%=gtot2%></td>
<td class="gridhdbg " style="text-align: right;"><%=g4%></td>
<td class="gridhdbg " style="text-align: right;"><%=g5%></td>
<td class="gridhdbg " style="text-align: right;"><%=g6%></td>

<td class="gridhdbg " style="text-align: right;"><%=g7%></td>
<td class="gridhdbg " style="text-align: right;"><%=g8%></td>
<td class="gridhdbg " style="text-align: right;"><%=g9%></td>

<td class="gridhdbg " style="text-align: right;"><%=g13%></td>
<td class="gridhdbg " style="text-align: right;"><%=g14%></td>
<td class="gridhdbg " style="text-align: right;"><%=g15%></td>
<td class="gridhdbg " style="text-align: right;"><%=g10%></td>

<td class="gridhdbg " style="text-align: right;"><%=g12%></td>
<td class="gridhdbg " style="text-align: right;"><%=g11%></td>
<td class="gridhdbg " style="text-align: right;"><%=gOW%></td>
<td class="gridhdbg " style="text-align: right;"><%=gOWH %></td>
<td class="gridhdbg " style="text-align: right;"><%=gOWPop %></td>
<td class="gridhdbg " style="text-align: right;"><%=gO%></td>
<td class="gridhdbg " style="text-align: right;"><%=gOH %></td>
<td class="gridhdbg " style="text-align: right;"><%=gOPop %></td>


<%	

}
catch(Exception e)
{
e.printStackTrace();
}
finally
{
try
{
if(rs4 != null)
{
rs4.close();
}
if(st1 != null)
{
st1.close();
}
if(rs6 != null)
{
rs6.close();
}
if(st2 != null)
{
st2.close();
}
if(rs7 != null)
{
rs7.close();
}
if(st3 != null)
{
st3.close();
}
if(pwsrs != null)
{
pwsrs.close();
}
if(pwsst !=null)
{
pwsst.close();
}
if(pwspoprs != null)
{
pwspoprs.close();
}
if(pwspopst !=null)
{
pwspopst.close();
}
if(pwscovrs != null)
{
pwscovrs.close();
}
if(pwscovst !=null)
{
pwscovst.close();
}
if(r1 !=null)
{
r1.close();
}
if(t1 != null)
{
t1.close();
}
if(r2 !=null)
{
r2.close();
}
if(t2 != null)
{
t2.close();
}
if(r3 !=null)
{
r3.close();
}
if(t3 != null)
{
t3.close();
}
if(r4 !=null)
{
r4.close();
}
if(t4 != null)
{
t4.close();
}
if(r5 !=null)
{
r5.close();
}
if(t5 != null)
{
t5.close();
}
if(r6 !=null)
{
r6.close();
}
if(t6 != null)
{
t6.close();
}
if(r7 !=null)
{
r7.close();
}
if(t7 != null)
{
t7.close();
}
if(r8 !=null)
{
r8.close();
}
if(t8 != null)
{
t8.close();
}
if(r9 !=null)
{
r9.close();
}
if(t9 != null)
{
t9.close();
}







if(rs1 != null)
{
rs1.close();
}
if(stmt1 != null)
{
stmt1.close();
}
if( conn != null )
{
conn.close();
}



}
catch(Exception p)
{
p.printStackTrace();
}
}
%>
</tr>
</table>
</body>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
<%@ include file="/commons/rws_footer.jsp" %>
  


