<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";
	//String dprsvs="";

     String completionDate=null;
     																
	
    double aas=0;
         
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
System.out.println("dcode**********" +dcode);

	if(request.getParameter("finyear")!=null)
	
	{
	financialyr=request.getParameter("finyear");
	System.out.println("financialyr"+financialyr);
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
 /* String yr= financialyr.substring(0,4);
session.setAttribute("financialyr",financialyr);*/






String yr =financialyr.substring(0,4);
session.setAttribute("yr",yr);

String prevMonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String prevprevMonth=RwsUtils.getPreviousMonth1().toUpperCase();


  	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="65%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=14>Water Quality tests conducted through FTK(<%=session.getAttribute("financialyr")%>)<font color="red"></font></td>	
	</tr>
<tr >
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
        <td class=btext rowspan=2>Division</td>
        <td class=btext rowspan=2>Up TO <br> (<%=prevprevMonth %>-<%=yr %>)</td>
        <td class=btext rowspan=2>During<br>(<%=prevMonth %>-<%=yr %>)</td>
        <td class=btext rowspan=2>During<br>(<%=cmonth %>-<%=yr %>)</td>
</tr>


<tr>


</tr>
<!-- </tr><tr><td class=btext align="center">1</td><td class=btext align="center">2</td><td class=btext align="center">3</td><td class=btext align="center">4</td><td class=btext align="center">5</td><td class=btext align="center">6</td><td class=btext align="center">7</td><td class=btext align="center">8</td><td class=btext align="center">9</td><td class=btext align="center">10</td><td class=btext align="center">11</td><td class=btext align="center">12</td><td class=btext align="center">13</td><td class=btext align="center">14</td></tr>-->
<%

Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null;
ResultSet rs1=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null;
int count=1;
  try{
	
			
//upto month


//String uptoftk="COUNT(*),substr(source_code,1,2) ,DIVISION_OFFICE_CODE   FROM RWS_FTK_TESTING_TBL ,RWS_WATER_SAMPLE_COLLECT_TBL b WHERE to_date(a.TEST_DATE)>='1-APR-"+yr+"' and a.DIVISION_OFFICE_CODE =b.DIVISION_OFFICE_CODE AND a.SOURCE_CODE =b.SOURCE_CODE  and  to_date(a.TEST_DATE)<'1-"+prevprevMonth+"-"+yr+"' ";

//uptoftk+="  group by CIRCLE_OFFICE_CODE ,a.DIVISION_OFFICE_CODE order by 1";

String uptoftk="SELECT COUNT(*),substr(source_code,1,2) ,DIVISION_OFFICE_CODE   FROM RWS_FTK_TESTING_TBL a WHERE to_date(a.TEST_DATE)>='1-APR-"+yr+"' and  to_date(TEST_DATE)<'1-"+prevMonth+"-"+yr+"' " ;

uptoftk+="group by substr(source_code,1,2) ,DIVISION_OFFICE_CODE order by 1";

stmt3=conn.createStatement();
///System.out.println("uptoftk******"+uptoftk);
	 rs2=stmt3.executeQuery(uptoftk);
	Hashtable uptoftkmonth=new Hashtable();
	while(rs2.next())
	{
		uptoftkmonth.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	}


//during
String duringftkbe="SELECT COUNT(*),substr(source_code,1,2) ,DIVISION_OFFICE_CODE   FROM RWS_FTK_TESTING_TBL  WHERE to_date(TEST_DATE)>='1-"+prevMonth+"-"+yr+"' and  to_date(TEST_DATE)<'1-"+cmonth+"-"+yr+"' ";

duringftkbe+="  group by substr(source_code,1,2) ,DIVISION_OFFICE_CODE order by 1";



stmt3=conn.createStatement();
//System.out.println("uptoftk******"+duringftkbe);
	 rs2=stmt3.executeQuery(duringftkbe);
	Hashtable duringftkbemt=new Hashtable();
	while(rs2.next())
	{
		duringftkbemt.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	}



	//during current
	String duringcurent="SELECT COUNT(*),substr(source_code,1,2) ,DIVISION_OFFICE_CODE   FROM RWS_FTK_TESTING_TBL  WHERE to_date(TEST_DATE)>='1-"+cmonth+"-"+yr+"' ";
	duringcurent+="  group by substr(source_code,1,2),DIVISION_OFFICE_CODE order by 1";



	stmt3=conn.createStatement();
	//System.out.println("duringcurent******"+duringcurent);
		 rs2=stmt3.executeQuery(duringcurent);
		Hashtable duringftkcurent=new Hashtable();
		while(rs2.next())
		{
			duringftkcurent.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
		}


	
	
	
	






/***********************************End  ************************************/



String query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code  and  a.status <> 'UI' order by circle_office_code";
stmt2=conn.createStatement();
 rs1=stmt2.executeQuery(query);

String dname="";
int during=0,upto=0,duringaf=0,gduringbemt=0,gduringftkcure=0,guptoftkmon=0,gduringftkcurent=0;

String exp="",nexp="";
String relS="",relS1="";
while(rs1.next()){
	
	String uptoftkmon=(String)uptoftkmonth.get(rs1.getString(3)+rs1.getString(4));
	
	String duringbemt=(String)duringftkbemt.get(rs1.getString(3)+rs1.getString(4));
	String duringftkcure=(String)duringftkcurent.get(rs1.getString(3)+rs1.getString(4));
	System.out.println("duringbemt"+duringbemt);

	
	
	
	
	%>
<tr></tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<%System.out.println(dname); }
else{
%>
<td  class=rptLabel></td>


<%} %>

<td  class=rptLabel><%=rs1.getString(2) %></td>
<td class=rptValue ><%= uptoftkmonth.get(rs1.getString(3)+rs1.getString(4))==null?"0":(upto=(Integer.parseInt((String)uptoftkmonth.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td  class=rptValue><%= duringftkbemt.get(rs1.getString(3)+rs1.getString(4))==null?"0":(during=(Integer.parseInt((String)duringftkbemt.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td  class=rptValue><%= duringftkcurent.get(rs1.getString(3)+rs1.getString(4))==null?"0":(duringaf=(Integer.parseInt((String)duringftkcurent.get(rs1.getString(3)+rs1.getString(4))))) %></td>


</tr>











<% 

if(uptoftkmon!=null && !uptoftkmon.equals("")){
	guptoftkmon+=Integer.parseInt(uptoftkmon);
	}
if(duringbemt!=null && !duringbemt.equals("")){
	gduringbemt+=Integer.parseInt(duringbemt);
	}


if(duringftkcure!=null && !duringftkcure.equals("")){
	gduringftkcure+=Integer.parseInt(duringftkcure);
	//gduringftkcurent+=Integer.parseInt(duringftkcurent);
	}


	
//gdsvs+=gdsvs+Integer.parseInt(dsvs);

	}







%>
<td colspan=3 class=btext align=right>Total:</td>
<td class=btext><%=guptoftkmon %></td>
<td class=btext><%=gduringbemt %></td>
<td class=btext><%=gduringftkcure%></td>
</tr>

<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>