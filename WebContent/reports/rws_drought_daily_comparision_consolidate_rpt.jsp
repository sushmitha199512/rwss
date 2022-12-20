<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	//String query = null;
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());


%>
<script type="text/javascript">

//date condition
function getDateObject(dateString,dateSeperator)
{
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;  
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
  	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth-1,cDate);	
	return dtObject;
} 
  
	 
 //end
function fnSubmit()
{
   var loggedUser = '<%=loggedUser%>';
			
           if(document.f1.demo1.value=='')
			{
                //alert("hai if");
				alert("Please Select From Date");
				return false;
			}
           if(document.f1.demo2.value=='')
			{
                //alert("hai if");
				alert("Please Select To Date");
				return false;
			}
			else
			{
                 var d=document.getElementById('demo1').value;//date value
                 var d1=document.getElementById('demo2').value;//date value			  
				  //alert("hai");
				  document.f1.mydate.value=d; 
                  document.f1.mydate1.value=d1; 
			        var fDate=getDateObject(document.f1.mydate.value,"-");
				    var tDate=getDateObject(document.f1.mydate1.value,"-");
				    if(fDate<=tDate)
					{
				    document.f1.action="./rws_drought_daily_comparision_consolidate_rpt.jsp";
					document.f1.submit();
					}
				    else
				    {
					 alert("To Date Must be always greater than From Date");   
					}
			   }

				
			}		
  
</script>
<%

ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null,pst5=null;
int count=1;

//first time display purpose
//String s;
StringBuffer s=new StringBuffer();
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
//s = formatter.format(date);
s.append(formatter.format(date));
StringBuffer currentdate=new StringBuffer(s.toString().replace("/","-"));
//////System.out.println("current"+currentdate);


StringBuffer rvalue=new StringBuffer();
rvalue.append(request.getParameter("mydate"));
if(rvalue!=null){
session.setAttribute("rvalue",rvalue.toString());
}
if(rvalue==null || rvalue.toString().equals("null")){
	rvalue.delete(0,rvalue.length());	
rvalue.append(currentdate);
}



	StringBuffer rvalue1=new StringBuffer();
rvalue1.append(request.getParameter("mydate1"));
if(rvalue1!=null){
session.setAttribute("rvalue1",rvalue1.toString());
}
if(rvalue1==null || rvalue1.toString().equals("null")){
	rvalue1.delete(0,rvalue1.length());	
	rvalue1.append(currentdate);
}




StringBuffer dname=new StringBuffer();
dname.append(request.getParameter("dname1"));
if(dname!=null){
session.setAttribute("dname",dname.toString());
}





%>

<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<form name=f1>
<body bgcolor="#edf2f8">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="30%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
    <caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
   <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>CONSOLIDATED DAILY COMPARISION SCARCITY REPORT</td>	
	</tr>
 <%try{
	 
	 //String dcode = request.getParameter("district1");
	 StringBuffer dcode=new StringBuffer();
	 dcode.append(request.getParameter("district1"));
     session.setAttribute("dcode",dcode.toString());
     // ////System.out.println("this is dcode..."+dcode.toString());
    
     
     //String divcode = request.getParameter("division");
	 StringBuffer divcode=new StringBuffer();
	 divcode.append(request.getParameter("division"));
     session.setAttribute("divcode",divcode.toString());
     // ////System.out.println("this is divcode..."+divcode.toString());
   
	
	//String dcode1 = request.getParameter("district1");
	StringBuffer dcode1=new StringBuffer();
	dcode1.append(request.getParameter("district1"));
     session.setAttribute("dcode1",dcode1.toString());
     // ////System.out.println("this is dcode1..."+dcode1.toString());
   
     
     
	//String divcode1 = request.getParameter("division");
	StringBuffer divcode1=new StringBuffer();
	divcode1.append(request.getParameter("division"));
     session.setAttribute("divcode1",divcode1.toString());
     // ////System.out.println("this is divcode1..."+divcode1.toString());
   

 %>
 <tr><td class=rptLabel>From Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" value="<%=rvalue%>">
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td></tr>
<tr>
<td class=rptLabel>To Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo2" type="text" size="10" value="<%=rvalue1%>">
       <a href="javascript:NewCal('demo2','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 
<%
}
catch(Exception e1)
		{
// ////System.out.println("Exception in bill Report frm jsp:"+e);
        }

%>
   <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table>


<input type="hidden" name="mydate" >
<input type="hidden" name="mydate1" >
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="dname1">
<INPUT type="hidden" name="mname1">

<%

if(rvalue.toString()!=null && !rvalue.toString().equals("") && !rvalue.toString().equals("null"))
{
%>

   
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_drought_daily_comparision_consolidate_rpt_xls.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
  


		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=25>CONSOLIDATE DAILY COMPARISION SCARCITY REPORT OF HABITATIONS AS ON:&nbsp;&nbsp;<%=rvalue%>&nbsp;&nbsp;To&nbsp;&nbsp;<%=rvalue1%>&nbsp;&nbsp; </td>	
		</tr>
		
<%

StringBuffer h1values =new StringBuffer();
StringBuffer h2values=new StringBuffer();
StringBuffer h3values=new StringBuffer();
StringBuffer h4values=new StringBuffer();
StringBuffer h5values=new StringBuffer();
StringBuffer v1=new StringBuffer();
StringBuffer v2=new StringBuffer();
StringBuffer v3=new StringBuffer();
StringBuffer v4=new StringBuffer();
StringBuffer h2v1=new StringBuffer();
StringBuffer h2v2=new StringBuffer();
StringBuffer h2v3=new StringBuffer();
StringBuffer h2v4=new StringBuffer();
StringBuffer h2v5=new StringBuffer();
StringBuffer h2v6=new StringBuffer();
StringBuffer h2v7=new StringBuffer();
StringBuffer h3v1=new StringBuffer();
StringBuffer h3v2=new StringBuffer();
StringBuffer h3v3=new StringBuffer();
StringBuffer h3v4=new StringBuffer();
StringBuffer h3v5=new StringBuffer();
StringBuffer h3v6=new StringBuffer();
StringBuffer h3v7=new StringBuffer();
StringBuffer h3v8=new StringBuffer();
StringBuffer h4v1=new StringBuffer();
StringBuffer h4v2=new StringBuffer();
StringBuffer h5v1=new StringBuffer();
StringBuffer h5v2=new StringBuffer();

// String ext_fac[],tras[],workdet[],dailydet[],deepflush[];
String ext_fac[]=null;
String tras[]=null;
String workdet[]=null;
String dailydet[]=null;
String deepflush[]=null;

StringBuffer query=new StringBuffer();
StringBuffer distcode=new StringBuffer();

try
{   
    // String distcode =(String)session.getAttribute("dcode");
    //StringBuffer distcode=null;
    //distcode=new StringBuffer(String.valueOf(session.getAttribute("dcode")));
     distcode.append(String.valueOf(session.getAttribute("dcode")));
  // ////System.out.println("this is dcode..."+distcode);
 
 
//String h1values="",h2values="",h3values="",h4values="",h5values="",v1="",v2="",v3="",v4="",h2v1="",h2v2="",h2v3="",h2v4="",h2v5="",h2v6="",h2v7="",h3v1="",h3v2="",h3v3="",h3v4="",h3v5="",h3v6="",h3v7="",h3v8="",h4v1="",h4v2="",h5v1="",h5v2="";
   
     
     int v1sum=0,v2sum=0,v3sum=0,v4sum=0,v5sum=0,v6sum=0,v7sum=0,v8sum=0,v9sum=0,v10sum=0,v11sum=0,v12sum=0,v13sum=0,v14sum=0,v15sum=0;
	%>
		   <tr align="center" bgcolor="#ffffff">
			<td class=btext align="center" rowspan="2">S.No.</td>
			<td class=btext align="center" rowspan="2">District</td>
			<td class=btext align="center" rowspan="2">No.of Habs</td>
           	<td class=btext align="center" colspan="4">Existing Facilities</td>
			<td class=btext align="center" colspan="2">Transportation of<br> Water </td>
			<td class=btext align="center" colspan="2">Hiring of Private<br> Sources </td>
            <td class=btext align="center" colspan="2">Flushing of<br> Borewells</td>
<td class=btext align="center" colspan="2">Deeping of<br> Borewells</td>
<td class=btext align="center" colspan="2">Power <br> Problem</td>
	</tr>
			<tr>
			<td class=btext align="center">OWs</td>
			<td class=btext align="center">HPs</td>
			<td class=btext align="center">PWSS </td>
			<td class=btext align="center">CPWSS </td>
			<td class=btext align="center">Contingency<br> Plan</td>
			<td class=btext align="center">Daily Report </td>
            <td class=btext align="center">Contingency <br>Plan</td>
			<td class=btext align="center">Daily Report </td>
			<td class=btext align="center">Contingency<br> Plan</td>
			<td class=btext align="center">Daily Report </td>
			<td class=btext align="center">Contingency<br> Plan</td>
			<td class=btext align="center">Daily Report </td>
			
			<td class=btext align="center">Yes </td>
			<td class=btext align="center">No</td>		
			</tr>
		
       <tr align="center">
            <td class=btext>1</td>	
			<td class=btext>2</td>	
			<td class=btext>3</td>
            <td class=btext>4</td>
			<td class=btext>5</td>
			<td class=btext>6</td>
			<td class=btext>7</td>
            <td class=btext>8</td>
            <td class=btext>9</td>
			<td class=btext>10</td>
            <td class=btext>11</td>
			<td class=btext>12</td>	
			<td class=btext>13</td>	
			<td class=btext>14</td>
            <td class=btext>15</td>
			<td class=btext>16</td>
			<td class=btext>17</td>
			
			
			
			
			
		</tr>
     
        <%
 //queries
           

        query.delete(0,query.length());
        
          //  String qry5="select distinct substr(b.habitation_code,1,2), sum(case when DEEPEN_FLUSH='F' then 1 else 0 end) as flush ,sum(case when DEEPEN_FLUSH='D' then 1 else 0 end) as deep from RWS_DROUGHT_FLUSH_DEEPEN_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL  b  where a.habitation_code=b.habitation_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(b.habitation_code,1,2)";
          query.append("select distinct substr(b.habitation_code,1,2), sum(case when DEEPEN_FLUSH='F' then 1 else 0 end) as flush ,sum(case when DEEPEN_FLUSH='D' then 1 else 0 end) as deep from RWS_DROUGHT_FLUSH_DEEPEN_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL  b  where a.habitation_code=b.habitation_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(b.habitation_code,1,2)");
	       Hashtable h5=new Hashtable();
	       pst5=conn.createStatement();
	      // rs5=pst5.executeQuery(qry5);
	      rs5=pst5.executeQuery(query.toString());
         //  ////System.out.println("deepen/flush... "+query.toString());
	       while(rs5.next())
	       {
	         h5.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
           //  ////System.out.println("................."+h5.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3)));
	       }

	       
	       

	       query.delete(0,query.length());
          //    String qry4="select distinct substr(habcode,1,2),sum(case when (TANKER_NO_OF_TRIPS>0 ) or  (TANKER_CAPACITY>0) or(TANKER_QTY>0) then 1 else 0 end) as trandaily ,sum(case when (PVT_SOURCES_HIRED_NO>0 ) or  (PVT_SOURCES_QTY>0) then 1 else 0 end) as sourcedaily  from RWS_DROUGHT_HABITATION_TBL  a,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b, rws_habitation_directory_tbl h,RWS_DROUGHT_SCAR_REASONS_TBl s  where a.habcode=h.hab_code and  a.scarcity_code=s.scarcity_code  and a.habcode=b.habitation_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(habcode,1,2)";
           query.append("select distinct substr(habcode,1,2),sum(case when (TANKER_NO_OF_TRIPS>0 ) or  (TANKER_CAPACITY>0) or(TANKER_QTY>0) then 1 else 0 end) as trandaily ,sum(case when (PVT_SOURCES_HIRED_NO>0 ) or  (PVT_SOURCES_QTY>0) then 1 else 0 end) as sourcedaily  from RWS_DROUGHT_HABITATION_TBL  a,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b, rws_habitation_directory_tbl h,RWS_DROUGHT_SCAR_REASONS_TBl s  where a.habcode=h.hab_code and  a.scarcity_code=s.scarcity_code  and a.habcode=b.habitation_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(habcode,1,2)");   
           Hashtable h4=new Hashtable();
	       pst4=conn.createStatement();
	      // rs4=pst4.executeQuery(qry4);
	      rs4=pst4.executeQuery(query.toString());
       //    ////System.out.println("hiring of private sources.... "+query.toString());
	       while(rs4.next())
	       {
	         h4.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3));
          //   ////System.out.println("................."+h4.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3)));
	       }
	       
	       
	       
	       query.delete(0,query.length());
          // String qry3="select distinct substr(habcode,1,2),sum(case when TRANSPORTATION='Y' then 1 else 0 end) as trans ,sum(nvl(HIRING_OF_SOURCES,'0')),sum(nvl(FLUSHING,'0')),sum(nvl(DEEPENING,'0')),sum(case when POWER_PROBLEM='Y' then 1 else 0 end) as Y , sum(case when POWER_PROBLEM='N' then 1 else 0 end) as N  from RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,rws_habitation_directory_tbl h,RWS_DROUGHT_SCAR_REASONS_TBl s where  a.habcode=h.hab_code and  a.scarcity_code=s.scarcity_code and a.habcode=b.habitation_code and TRANSPORTATION='Y' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(habcode,1,2)";
          query.append("select distinct substr(habcode,1,2),sum(case when TRANSPORTATION='Y' then 1 else 0 end) as trans ,sum(nvl(HIRING_OF_SOURCES,'0')),sum(nvl(FLUSHING,'0')),sum(nvl(DEEPENING,'0')),sum(case when POWER_PROBLEM='Y' then 1 else 0 end) as Y , sum(case when POWER_PROBLEM='N' then 1 else 0 end) as N  from RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,rws_habitation_directory_tbl h,RWS_DROUGHT_SCAR_REASONS_TBl s where  a.habcode=h.hab_code and  a.scarcity_code=s.scarcity_code and a.habcode=b.habitation_code and TRANSPORTATION='Y' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(habcode,1,2)"); 
          Hashtable h3=new Hashtable();
	       pst3=conn.createStatement();
	       //rs3=pst3.executeQuery(qry3);
	         rs3=pst3.executeQuery(query.toString());
	      
       //    ////System.out.println("transportation ....... "+query.toString());
	       while(rs3.next())
	       {
	         h3.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7));
             //////System.out.println( h3.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7)));
	       }

	       
	       
	       
	       
	       
	       query.delete(0,query.length());
           //String qry2="select distinct substr(a.hab_code,1,2),sum(case when type_of_asset_code='06' then 1 else 0 end) as oh,sum(case when type_of_asset_code='04' then 1 else 0 end) as hp,sum(case when type_of_asset_code='01' then 1 else 0 end) as pws,sum(case when type_of_asset_code='03' then 1 else 0 end) as cpws from rws_asset_mast_tbl a,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,RWS_DROUGHT_HABITATION_TBL c,RWS_DROUGHT_SCAR_REASONS_TBL s ,rws_habitation_directory_tbl h where a.hab_code=b.habitation_code and b.habitation_code=c.habcode and b.habitation_code=h.hab_code and a.hab_code=c.habcode and c.scarcity_code=s.scarcity_code and date_of_entry>=to_date ('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(a.hab_code,1,2)";
           query.append("select distinct substr(a.hab_code,1,2),sum(case when type_of_asset_code='06' then 1 else 0 end) as oh,sum(case when type_of_asset_code='04' then 1 else 0 end) as hp,sum(case when type_of_asset_code='01' then 1 else 0 end) as pws,sum(case when type_of_asset_code='03' then 1 else 0 end) as cpws from rws_asset_mast_tbl a,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,RWS_DROUGHT_HABITATION_TBL c,RWS_DROUGHT_SCAR_REASONS_TBL s ,rws_habitation_directory_tbl h where a.hab_code=b.habitation_code and b.habitation_code=c.habcode and b.habitation_code=h.hab_code and a.hab_code=c.habcode and c.scarcity_code=s.scarcity_code and date_of_entry>=to_date ('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(a.hab_code,1,2)");
           Hashtable h2=new Hashtable();
	       pst2=conn.createStatement();
	       //rs2=pst2.executeQuery(qry2);
	       rs2=pst2.executeQuery(query.toString());
         //  ////System.out.println("assets........ "+query.toString());
	       while(rs2.next())
	       {
	         h2.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
             //////System.out.println("habcode"+rs2.getString(1));
             //////System.out.println(h1.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)));
	       }

 
	       
	       
	       
	       query.delete(0,query.length());
          String qry1="select distinct substr(habitation_code,1,2),count(distinct habitation_code) from RWS_DROUGHT_HAB_TR_PVT_SO_TBL a,RWS_DROUGHT_HABITATION_TBL  e,RWS_DROUGHT_SCAR_REASONS_TBL f,rws_habitation_directory_tbl g  where a.habitation_code=e.habcode and e.scarcity_code=f.scarcity_code and a.habitation_code=g.hab_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(habitation_code,1,2)";
          query.append("select distinct substr(habitation_code,1,2),count(distinct habitation_code) from RWS_DROUGHT_HAB_TR_PVT_SO_TBL a,RWS_DROUGHT_HABITATION_TBL  e,RWS_DROUGHT_SCAR_REASONS_TBL f,rws_habitation_directory_tbl g  where a.habitation_code=e.habcode and e.scarcity_code=f.scarcity_code and a.habitation_code=g.hab_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by substr(habitation_code,1,2)");
          //////System.out.println("my qry1 "+query.toString());
          pst1=conn.createStatement();
          rs1=pst1.executeQuery(qry1);
          Hashtable h1=new Hashtable();
       //   ////System.out.println("no of habs count...."+qry1);
          while(rs1.next())
          {
            h1.put(rs1.getString(1),rs1.getString(2));
            //////System.out.println(h1.put(rs1.getString(1),rs1.getString(2)));
          }

          
          session.setAttribute("h1",h1);
          session.setAttribute("h2",h2);
          session.setAttribute("h3",h3);
          session.setAttribute("h4",h4);
          session.setAttribute("h5",h5);
         

          query.delete(0,query.length());
        // String qry="select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode";
       query.append("select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode");
        stmt=conn.createStatement();
         //rs=stmt.executeQuery(qry);
         rs=stmt.executeQuery(query.toString());
         while(rs.next())
        {

           //hash1 values getting
            
           // h1values=(String)h1.get(rs.getString(1));
            h1values.delete(0,h1values.length());
            h1values.append(h1.get(rs.getString(1)));
           
           // if(h1values!=null)
        	     if(h1values!=null&& !h1values.toString().equals("null"))
            {
             ext_fac=h1values.toString().split("@");
            // v1=ext_fac[0];
            //v1sum+=Integer.parseInt(v1);
            v1.delete(0,v1.length());
            v1.append(ext_fac[0]);
          	v1sum+=Integer.parseInt(v1.toString().equals("null")?"0":v1.toString());
		
            
			// v2=ext_fac[1];(already commented)
			// v3=ext_fac[2];(already commented)
			
			
             }
           else
			{	
	         //v1="0";
	         v1.delete(0,v1.length());
	         
	         v1.append("0");
			 //v2="-";(already commented)
			// v3="-";(already commented)
			}
            //end
           //exit hash2 values
           
           
           
        //    h2values=(String)h2.get(rs.getString(1));
            h2values.delete(0,h2values.length());
            h2values.append(h2.get(rs.getString(1)));
          
            //if(h2values!=null)
            	if(h2values!=null&& !h2values.toString().equals("null"))
            {
             tras=h2values.toString().split("@");
            //  h2v1=tras[0];
			// h2v2=tras[1];
		    // h2v3=tras[2];
           //  h2v4=tras[3];
          
           
           h2v1.delete(0,h2v1.length());
           h2v2.delete(0,h2v2.length());
           h2v3.delete(0,h2v3.length());
           h2v4.delete(0,h2v4.length());
           
           
           h2v1.append(tras[0]);
           h2v2.append(tras[1]);
           h2v3.append(tras[2]);
           h2v4.append(tras[3]);
           
           
           
           //v2sum+=Integer.parseInt(h2v1);
          // v3sum+=Integer.parseInt(h2v2);
          // v4sum+=Integer.parseInt(h2v3);
          // v5sum+=Integer.parseInt(h2v4);
           v2sum=Integer.parseInt(h2v1.toString().equals("null")?"0":h2v1.toString());   
           v3sum=Integer.parseInt(h2v2.toString().equals("null")?"0":h2v2.toString()); 
           v4sum=Integer.parseInt(h2v3.toString().equals("null")?"0":h2v3.toString()); 
           v5sum=Integer.parseInt(h2v4.toString().equals("null")?"0":h2v4.toString()); 
             }
           else
			{	
	        // h2v1="0";
			 //h2v2="0";
			 //h2v3="0";
             //h2v4="0";
             
             h2v1.delete(0,h2v1.length());
             h2v2.delete(0,h2v2.length());
             h2v3.delete(0,h2v3.length());
             h2v4.delete(0,h2v4.length());
             
        	   h2v1.append("0"); 
        	   h2v2.append("0"); 
        	   h2v3.append("0"); 
        	   h2v4.append("0"); 
			}
            //end 


            
            
            
            
            
            
            
          //hash3 values
          //  h3values=(String)h3.get(rs.getString(1));
             h3values.delete(0,h3values.length());
             h3values.append(h3.get(rs.getString(1)));
          
            //if(h3values!=null)
            	if(h3values!=null&& !h3values.toString().equals("null"))
            {
             workdet=h3values.toString().split("@");
             
             h3v1.delete(0,h3v1.length());
             h3v2.delete(0,h3v2.length());
             h3v3.delete(0,h3v3.length());
             h3v4.delete(0,h3v4.length());
             h3v5.delete(0,h3v5.length());
             h3v6.delete(0,h3v6.length());
             
             h3v1.append(workdet[0]);
             h3v2.append(workdet[1]);
			 h3v3.append(workdet[2]);
             h3v4.append(workdet[3]);
             h3v5.append(workdet[4]);
             h3v6.append(workdet[5]);
            
            // h3v7=workdet[6];(already commented)
			 //h3v8=workdet[7];(already commented)
 
            v6sum+=Integer.parseInt(h3v1.toString().equals("null")?"0":h3v1.toString()); 
			v7sum+=Integer.parseInt(h3v2.toString().equals("null")?"0":h3v2.toString()); 
			v8sum+=Integer.parseInt(h3v3.toString().equals("null")?"0":h3v3.toString()); 
			v9sum+=Integer.parseInt(h3v4.toString().equals("null")?"0":h3v4.toString()); 
			v10sum+=Integer.parseInt(h3v5.toString().equals("null")?"0":h3v5.toString()); 
            v15sum+=Integer.parseInt(h3v6.toString().equals("null")?"0":h3v6.toString()); 
      
			
             }
           else
			{	
        	   
        	   h3v1.delete(0,h3v1.length());
        	   h3v2.delete(0,h3v2.length());
        	   h3v3.delete(0,h3v3.length());
        	   h3v4.delete(0,h3v4.length());
        	   h3v5.delete(0,h3v5.length());
        	   h3v6.delete(0,h3v6.length());
        	   
	         h3v1.append("0");
			 h3v2.append("0");
			 h3v3.append("0");
             h3v4.append("0");
             h3v5.append("0");   
             h3v6.append("0");  
             //h3v7="-";   
             //h3v8="-"; 
			}
            //end
            
            
            
            
            
            
            //daily  hash4 values
         //   h4values=(String)h4.get(rs.getString(1));
            h4values.delete(0,h4values.length());
            h4values.append(h4.get(rs.getString(1)));
            //if(h4values!=null)
            	if(h4values!=null&& !h4values.toString().equals("null"))
            {
             dailydet=h4values.toString().split("@");
             
             h4v1.delete(0,h4v1.length());
             h4v2.delete(0,h4v2.length());
             
             h4v1.append(dailydet[0]);
			 h4v2.append(dailydet[1]);
			v11sum+=Integer.parseInt(h4v1.toString().equals("null")?"0":h4v1.toString()); 
			v12sum+=Integer.parseInt(h4v2.toString().equals("null")?"0":h4v2.toString()); 
			
             }
           else
			{	
        	   h4v1.delete(0,h4v1.length());
        	   h4v2.delete(0,h4v2.length());
	         h4v1.append("0");
			 h4v2.append("0");
			// h4v3="-";
            // h4v4="-";
                       
			}
            //end 

            
            
           //deep flush  hash5 values
           // h5values=(String)h5.get(rs.getString(1));
            h5values.delete(0,h5values.length());
            h5values.append(h5.get(rs.getString(1)));
          
            //if(h5values!=null)
            	if(h5values!=null&& !h5values.toString().equals("null"))
            {
             deepflush=h5values.toString().split("@");
             
             h5v1.delete(0,h5v1.length());
             h5v2.delete(0,h5v2.length());
             
             h5v1.append(deepflush[0]);
			 h5v2.append(deepflush[1]);
			 v13sum+=Integer.parseInt(h5v1.toString().equals("null")?"0":h5v1.toString()); 
			v14sum+=Integer.parseInt(h5v2.toString().equals("null")?"0":h5v2.toString()); 
				 
             }
           else
			{	
        	   h5v1.delete(0,h5v1.length());
        	   h5v2.delete(0,h5v2.length());
	         h5v1.append("0");
			 h5v2.append("0");
			
                       
			}
            //end 
      if(!v1.toString().equals("0"))
{
         %>
      <tr align="center">
           <td class=rptvalue align="left"><%=count++%></td>
           <td class=rptvalue align="left"><b><a href="rws_drought_daily_comparision_rpt.jsp?distcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>"><%=rs.getString(2)%></a></b></td>
           <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=v1.toString()%></b></td>	
           <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h2v1.toString()%></b></td>	
			<td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h2v2.toString()%></b></td>	
			<td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h2v3.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h2v4.toString()%></b></td>
			<td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h3v1.toString()%></b></td>
			<td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h4v1.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h3v2.toString()%></b></td>
			<td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h4v2.toString()%></b></td>
			<td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h3v3.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h5v1.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h3v4.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h5v2.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h3v5.toString()%></b></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><b><%=h3v6.toString()%></b></td>
            
		</tr>
	<%
 }
else
{%>
<tr align="center">
           <td class=rptvalue align="left"><%=count++%></td>
           <td class=rptvalue align="left"><%=rs.getString(2)%></td>
           <td class=rptvalue align="right"><%=v1.toString()%></td>	
           <td class=rptvalue align="right"><%=h2v1.toString()%></td>	
			<td class=rptvalue align="right"><%=h2v2.toString()%></td>	
			<td class=rptvalue align="right"><%=h2v3.toString()%></td>
            <td class=rptvalue align="right"><%=h2v4.toString()%></td>
			<td class=rptvalue align="right"><%=h3v1.toString()%></td>
			<td class=rptvalue align="right"><%=h4v1.toString()%></td>
            <td class=rptvalue align="right"><%=h3v2.toString()%></td>
			<td class=rptvalue align="right"><%=h4v2.toString()%></td>
			<td class=rptvalue align="right"><%=h3v3.toString()%></td>
            <td class=rptvalue align="right"><%=h5v1.toString()%></td>
            <td class=rptvalue align="right"><%=h3v4.toString()%></td>
            <td class=rptvalue align="right"><%=h5v2.toString()%></td>
            <td class=rptvalue align="right"><%=h3v5.toString()%></td>
            <td class=rptvalue align="right"><%=h3v6.toString()%></td>
            
		</tr>

<%
}
}
    

%>
<tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=2>Totals</td>
            <td class=btext align="right"><%=v1sum%></td>
			<td class=btext align="right"><%=v2sum%></td>
            <td class=btext align="right"><%=v3sum%></td>
            <td class=btext align="right"><%=v4sum%></td>
			<td class=btext align="right"><%=v5sum%></td>
            <td class=btext align="right"><%=v6sum%></td>
			<td class=btext align="right"><%=v11sum%></td>
            <td class=btext align="right"><%=v7sum%></td>
            <td class=btext align="right"><%=v12sum%></td>
			<td class=btext align="right"><%=v8sum%></td>
            <td class=btext align="right"><%=v13sum%></td>
			<td class=btext align="right"><%=v9sum%></td>
            <td class=btext align="right"><%=v14sum%></td>
            <td class=btext align="right"><%=v10sum%></td>
			<td class=btext align="right"><%=v15sum%></td>
			
			
		</tr>
<%
}

catch(Exception e)
{
	e.printStackTrace();
}
finally{
	 h1values =null;
	  h2values=null;
	  h3values=null;
	  h4values=null;
	  h5values=null;
	  v1=null;
	  v2=null;
	  v3=null;
	  v4=null;
	  h2v1=null;
	  h2v2=null;
	  h2v3=null;
	  h2v4=null;
	  h2v5=null;
	  h2v6=null;
	  h2v7=null;
	  h3v1=null;
	  h3v2=null;
	  h3v3=null;
	  h3v4=null;
	  h3v5=null;
	  h3v6=null;
	  h3v7=null;
	  h3v8=null;
	  h4v1=null;
	  h4v2=null;
     h5v1=null;
	  h5v2=null;

	// String ext_fac[],tras[],workdet[],dailydet[],deepflush[];
	 ext_fac=null;
	 tras=null;
	 workdet=null;
	 dailydet=null;
	 deepflush=null;

	  query=null;
	  distcode=null;
	  loggedUser=null;
	    s=null;

	    rvalue=null;
	    rvalue1=null;
	    dname=null;

	  currentdate=null;
}
%>
</table>
<%} %>

</body>
</form>
</html>

<%@ include file = "footer.jsp" %>
