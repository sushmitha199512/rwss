<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>

	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("##.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



	%>

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=19>Drought Works Progress</td>	
	</tr>
		<tr >
		<td class=btext rowspan=2 align=center>Sl.No</td>
		<td class=btext rowspan=2 align=center>District</td>
		<td class=btext rowspan=2 align=center>Division</td>
		<td class=btext  align=center colspan=4 nowrap >Deepening</td>
		<td class=btext colspan=4 align=center >Flushing</td>
		<td class=btext colspan=4 align=center >Flushing & Deepening</td>
		<td class=btext colspan=4 align=center >Total</td>

</tr>
<tr>
<td class=btext align="center"  >No Of Works</td>
 <td  class=btext align="center"  >Cost<br>(In Rupees )</td>	
		<td  class=btext align="center" >Completed</td>	
		<td  class=btext align="center"  >Exp</td>
<td class=btext align="center"  >No Of Works</td>
 <td  class=btext align="center"  >Cost <br>(In Rupees )</td>	
		<td  class=btext align="center" >Completed</td>	
		<td  class=btext align="center"  >Exp</td>
<td class=btext align="center"  >No Of Works</td>
 <td  class=btext align="center"  >Cost <br>(In Rupees )</td>	
		<td  class=btext align="center" >Completed</td>	
		<td  class=btext align="center"  >Exp</td>
<td class=btext align="center"  >No Of Works</td>
 <td  class=btext align="center"  >Cost <br>(In Rupees )</td>	
		<td  class=btext align="center" >Completed</td>	
		<td  class=btext align="center"  >Exp</td>



</tr>


<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center" class=btext >10</td><td align="center" class=btext >11</td><td align="center" class=btext >12</td><td align="center" class=btext >13</td><td align="center" class=btext >14</td><td align="center" class=btext >15</td><td align="center" class=btext >16</td><td align="center" class=btext >17</td><td align="center" class=btext >18</td><td align="center" class=btext >19</td>
</tr>



<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
  try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();

//Financial Queries

String deepeningQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*),sum(ADMIN_AMOUNT),sum(EXPENDITURE_UPTO)  from rws_drought_works_tbl where work_type='Deeping' group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("deepeningQuery"+deepeningQuery);
	 rs2=stmt3.executeQuery(deepeningQuery);
	Hashtable deepenHash=new Hashtable();
	while(rs2.next())
	{
		deepenHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String deepeningComplQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*)  from rws_drought_works_tbl where work_type='Deeping'  and DATE_OF_COMPLETION is not null group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("deepeningComplQuery"+deepeningComplQuery);
	 rs2=stmt3.executeQuery(deepeningComplQuery);
	Hashtable deepenCompHash=new Hashtable();
	while(rs2.next())
	{
		deepenCompHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String flushQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*),sum(ADMIN_AMOUNT),sum(EXPENDITURE_UPTO)  from rws_drought_works_tbl where work_type='Flushing' group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("flushQuery"+flushQuery);
	 rs2=stmt3.executeQuery(flushQuery);
	Hashtable flushHash=new Hashtable();
	while(rs2.next())
	{
		flushHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String flushCompQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*)  from rws_drought_works_tbl where work_type='Flushing' and DATE_OF_COMPLETION is not null group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("flushCompQuery"+flushCompQuery);
	 rs2=stmt3.executeQuery(flushCompQuery);
	Hashtable flushCompHash=new Hashtable();
	while(rs2.next())
	{
		flushCompHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String flushDeepenQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*),sum(ADMIN_AMOUNT),sum(EXPENDITURE_UPTO)  from rws_drought_works_tbl where work_type='Flushing and Deeping' group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("flushDeepenQuery"+flushDeepenQuery);
	 rs2=stmt3.executeQuery(flushDeepenQuery);
	Hashtable flushDeepenHash=new Hashtable();
	while(rs2.next())
	{
		flushDeepenHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





String flushDeepenCompltedQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*)  from rws_drought_works_tbl where work_type='Flushing and Deeping' and DATE_OF_COMPLETION is not null group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("flushDeepenCompltedQuery"+flushDeepenCompltedQuery);
	 rs2=stmt3.executeQuery(flushDeepenCompltedQuery);
	Hashtable flushDeepenCompltedHash=new Hashtable();
	while(rs2.next())
	{
		flushDeepenCompltedHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String totalQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*),sum(ADMIN_AMOUNT),sum(EXPENDITURE_UPTO)  from rws_drought_works_tbl  group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("totalQuery"+totalQuery);
	 rs2=stmt3.executeQuery(totalQuery);
	Hashtable totalHash=new Hashtable();
	while(rs2.next())
	{
		totalHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();

String totalCompQuery="select substr(office_code,2,2),substr(office_code,4,1),count(*)  from rws_drought_works_tbl where  DATE_OF_COMPLETION is not null  group by substr(office_code,2,2),substr(office_code,4,1)";

		stmt3=conn.createStatement();
//System.out.println("totalCompQuery"+totalCompQuery);
	 rs2=stmt3.executeQuery(totalCompQuery);
	Hashtable totalCompHash=new Hashtable();
	while(rs2.next())
	{
		totalCompHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




stmt3=conn.createStatement();

int gdCount=0,gfCount=0,gfdCount=0,gtCount=0;
int gdcompCount=0,gfcompCount=0,gfdcompCount=0,gtcompCount=0;
int dcompCount=0,fcompCount=0,fdcompCount=0,tcompCount=0;
double gdCost=0,gfCost=0,gdfCost=0,gtCost=0;
double gdExp=0,gfExp=0,gdfExp=0,gtExp=0;


String mainQuery="select distinct substr(office_code,2,2),substr(office_code,4,1) from rws_drought_works_tbl order by substr(office_code,2,2),substr(office_code,4,1)";
 rs2=stmt3.executeQuery(mainQuery);


while(rs2.next()){



String query="";



query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b  where b.dcode=a.circle_office_code   and a.circle_office_code='"+rs2.getString(1)+"'  and a.division_office_code='"+rs2.getString(2)+"' and a.status<>'UI' order by circle_office_code ";



//112000
//112100

//System.out.println("Main Query"+query);
rs1=stmt2.executeQuery(query);
String dname="";
String dvalue1="",dvalue2="",dvalue3="",dvalue4="";
String fvalue1="",fvalue2="",fvalue3="",fvalue4="";
String fdvalue1="",fdvalue2="",fdvalue3="",fdvalue4="";
String tvalue1="",tvalue2="",tvalue3="",tvalue4="";


while(rs1.next()){
if(deepenHash.get(rs1.getString(3)+rs1.getString(4))!=null){
String deepen[]=((String)deepenHash.get(rs1.getString(3)+rs1.getString(4))).split("@");
dvalue1=deepen[0];
if(dvalue1!=null && !dvalue1.equals("")){
gdCount+=Integer.parseInt(dvalue1);
}
dvalue2=deepen[1];
if(dvalue2!=null && !dvalue2.equals("")){
gdCost+=Double.parseDouble(dvalue2);
}
dvalue3=deepen[2];
if(dvalue3!=null && !dvalue3.equals("")){
gdExp+=Double.parseDouble(dvalue3);
}

}else{
dvalue1="0";dvalue2="0";dvalue3="0";dvalue4="0";
}

if(flushHash.get(rs1.getString(3)+rs1.getString(4))!=null){
String fdeepen[]=((String)flushHash.get(rs1.getString(3)+rs1.getString(4))).split("@");
fvalue1=fdeepen[0];

if(fvalue1!=null && !fvalue1.equals("")){
gfCount+=Integer.parseInt(fvalue1);
}
fvalue2=fdeepen[1];
if(fvalue2!=null && !fvalue2.equals("")){
gfCost+=Double.parseDouble(fvalue2);
}
fvalue3=fdeepen[2];
if(fvalue3!=null && !fvalue3.equals("")){
gfExp+=Double.parseDouble(fvalue3);
}


}else{
fvalue1="0";fvalue2="0";fvalue3="0";fvalue4="0";
}

if(flushDeepenHash.get(rs1.getString(3)+rs1.getString(4))!=null){
String fdeepen[]=((String)flushDeepenHash.get(rs1.getString(3)+rs1.getString(4))).split("@");
fdvalue1=fdeepen[0];
if(fdvalue1!=null && !fdvalue1.equals("")){
gfdCount+=Integer.parseInt(fdvalue1);
}
fdvalue2=fdeepen[1];
if(fdvalue2!=null && !fdvalue2.equals("")){
gdfCost+=Double.parseDouble(fdvalue2);
}
fdvalue3=fdeepen[2];
if(fdvalue3!=null && !fdvalue3.equals("")){
gdfExp+=Double.parseDouble(fdvalue3);
}

}else{
fdvalue1="0";fdvalue2="0";fdvalue3="0";fdvalue4="0";
}
if(totalHash.get(rs1.getString(3)+rs1.getString(4))!=null){
String tdeepen[]=((String)totalHash.get(rs1.getString(3)+rs1.getString(4))).split("@");
tvalue1=tdeepen[0];
if(tvalue1!=null && !tvalue1.equals("")){
gtCount+=Integer.parseInt(tvalue1);
}
tvalue2=tdeepen[1];
if(tvalue2!=null && !tvalue2.equals("")){
gtCost+=Double.parseDouble(tvalue2);
}
tvalue3=tdeepen[2];
if(tvalue3!=null && !tvalue3.equals("")){
gtExp+=Double.parseDouble(tvalue3);
}


}else{
tvalue1="0";tvalue2="0";tvalue3="0";tvalue4="0";
}
if(deepenCompHash.get(rs1.getString(3)+rs1.getString(4))!=null && !deepenCompHash.get(rs1.getString(3)+rs1.getString(4)).equals("")){

dcompCount=Integer.parseInt((String)deepenCompHash.get(rs1.getString(3)+rs1.getString(4)));
gdcompCount+=dcompCount;
}

if(flushCompHash.get(rs1.getString(3)+rs1.getString(4))!=null && !flushCompHash.get(rs1.getString(3)+rs1.getString(4)).equals("")){

fcompCount=Integer.parseInt((String)flushCompHash.get(rs1.getString(3)+rs1.getString(4)));
gfcompCount+=fcompCount;
}
if(flushDeepenCompltedHash.get(rs1.getString(3)+rs1.getString(4))!=null && !flushDeepenCompltedHash.get(rs1.getString(3)+rs1.getString(4)).equals("")){

fdcompCount=Integer.parseInt((String)flushDeepenCompltedHash.get(rs1.getString(3)+rs1.getString(4)));
gfdcompCount+=fdcompCount;
}
if(totalCompHash.get(rs1.getString(3)+rs1.getString(4))!=null && !totalCompHash.get(rs1.getString(3)+rs1.getString(4)).equals("")){

tcompCount=Integer.parseInt((String)totalCompHash.get(rs1.getString(3)+rs1.getString(4)));
gtcompCount+=tcompCount;
}




%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} 

%>
<td  class=rptLabel><%=rs1.getString(2) %></td>
<td  class=rptValue><%=dvalue1 %></td>
<td  class=rptValue><%=dvalue2 %></td>
<td  class=rptValue><%=dcompCount %></td>
<td  class=rptValue><%=dvalue3 %></td>
<td  class=rptValue><%=fvalue1 %></td>
<td  class=rptValue><%=fvalue2 %></td>
<td  class=rptValue><%=fcompCount %></td>
<td  class=rptValue><%=fvalue3 %></td>
<td  class=rptValue><%=fdvalue1 %></td>
<td  class=rptValue><%=fdvalue2 %></td>
<td  class=rptValue><%=fdcompCount %></td>
<td  class=rptValue><%=fdvalue3 %></td>

<td  class=rptValue><%=tvalue1 %></td>
<td  class=rptValue><%=tvalue2 %></td>
<td  class=rptValue><%=tcompCount %></td>
<td  class=rptValue><%=tvalue3 %></td>


<% 
 dvalue1="";dvalue2="";dvalue3="";dvalue4="";
 fvalue1="";fvalue2="";fvalue3="";fvalue4="";
fdvalue1="";fdvalue2="";fdvalue3="";fdvalue4="";
 tvalue1="";tvalue2="";tvalue3="";tvalue4="";
}
}

%>
<tr><td colspan=3 align=right class=btext>Total:</td><td class=btext><%=gdCount %></td><td class=btext><%=ndf.format(gdCost) %></td><td class=btext><%=gdcompCount %></td><td class=btext><%=ndf.format(gdExp) %></td><td class=btext><%=gfCount %></td><td class=btext><%=ndf.format(gfCost) %> </td><td class=btext><%=gfcompCount %></td><td class=btext><%=ndf.format(gfExp) %></td><td class=btext><%=gfdCount %></td><td class=btext><%=ndf.format(gdfCost) %></td><td class=btext><%=gfdcompCount %></td><td class=btext><%=ndf.format(gdfExp) %></td><td class=btext><%=gtCount %></td><td class=btext><%=ndf.format(gtCost) %></td><td class=btext><%=gtcompCount %></td><td class=btext><%=ndf.format(gtExp) %></td></tr>

<% 
}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>