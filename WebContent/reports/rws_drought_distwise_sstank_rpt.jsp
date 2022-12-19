<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
%>
<script type="text/javascript">
function fnSubmit()
{
   var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
                //alert("hai if");
				alert("Please Select District");
				return false;
			}
           if(document.f1.demo1.value=='')
			{
                //alert("hai if");
				alert("Please Select From Year");
				return false;
			}
          if(document.f1.demo2.value=='')
			{
                //alert("hai if");
				alert("Please Select To Year");
				return false;
			} 
			else
			{
                //alert("hai else");
				if(loggedUser=="admin"||loggedUser=="100000"||loggedUser=="1000DR")
				{
                 //alert("hai else if ");
				document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
				 //alert(document.f1.dname1.value);        
				}
				
				else
				{    //alert("hai else else");
					document.f1.dname1.value = document.f1.district1.value;
				    alert(document.f1.dname1.value); 
				}
                //alert("....hai....."+document.f1.dname1.value);
                var d=document.getElementById('demo1').value;
                var d1=document.getElementById('demo2').value;//date value
                document.f1.mydate.value=d; 
                document.f1.mydate1.value=d1; 
    			document.f1.action="./rws_drought_distwise_sstank_rpt.jsp";
				  //alert("hai");
				document.f1.submit();
			}		
  

}
</script>
<%

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null;
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
//////System.out.println("rvalue........"+rvalue);



StringBuffer rvalue1=new StringBuffer();
rvalue1.append(request.getParameter("mydate1"));
if(rvalue1!=null){
session.setAttribute("rvalue1",rvalue1.toString());
}
if(rvalue1==null || rvalue1.toString().equals("null")){
	rvalue1.delete(0,rvalue1.length());	
	rvalue1.append(currentdate);
}
//////System.out.println("rvalue1........"+rvalue1);




StringBuffer dyear=new StringBuffer();
dyear.append(request.getParameter("dyear"));
if(dyear!=null){
session.setAttribute("dyear",dyear.toString());
}



StringBuffer dname=new StringBuffer();
dname.append(request.getParameter("dname1"));
if(dname!=null){
session.setAttribute("dname",dname.toString());
}


StringBuffer dist_code=new StringBuffer();
dist_code.append(String.valueOf(session.getAttribute("dcode")));
if(dist_code!=null){
session.setAttribute("distcode",dist_code.toString());
}
////System.out.println("this is distcode..."+dist_code);
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
		<td align="center" class="rptHeading" colspan=3>DROUGHT SS TANKS</td>	
	</tr>
 <%
 StringBuffer dcode=new StringBuffer();
 StringBuffer divcode=new StringBuffer();
 StringBuffer dcode1=new StringBuffer();
 StringBuffer divcode1=new StringBuffer();
 StringBuffer dyr=new StringBuffer();
 StringBuffer query=new StringBuffer();
 
 try{
    dcode.append(request.getParameter("district1"));
    ////System.out.println("this is dcode..."+dcode.toString());
    session.setAttribute("dcode",dcode.toString());
  	
	divcode.append(request.getParameter("division"));
	dcode1.append(request.getParameter("district1"));
	divcode1.append(request.getParameter("division"));
    dyr.append(request.getParameter("dyear"));
    ////System.out.println("this is dyr..."+dyr.toString());
    session.setAttribute("dyr",dyr.toString());
 %>
 
 
 
<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST)||loggedUser.toString().equals(Constants.DROUGHT_USER)||loggedUser.toString().equals(Constants.SEC_USER)))
		{
		%>
			<SELECT name="district1" id="combo" class="mycombo" style="width:150px" >
			<option value="">SELECT</option>
		<%
			stmt = conn.createStatement();
			query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
	        rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode1.toString()))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
		}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			query.delete(0,query.length());
			//// ////System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.toString().substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{
				dcode1.append(rs.getString(1));
	%>
				<input type="text" name="dname1" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district1" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
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
 <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table>

<%
}
catch(Exception e1)
		{
// ////System.out.println("Exception in bill Report frm jsp:"+e);
        }

%>
  

<input type="hidden" name="mydate">
<input type="hidden" name="mydate1">
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="dname1">
<INPUT type="hidden" name="mname1">
<input type="hidden" name="dyear" >

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="../home.jsp">Home</a>|
					<a href="./rws_drought_distwise_sstank_rpt_xls.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
  


		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=25>DISTRICT WISE DROUGHT SSTANKS REPORT OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp; ON &nbsp;&nbsp;<%=rvalue%> &nbsp;&nbsp; To &nbsp;&nbsp;<%=rvalue1%><font color="blue"></font></td>	
		</tr>
		
<%

StringBuffer distcode=new StringBuffer();
//StringBuffer dyr=new StringBuffer();
    StringBuffer h1values=new StringBuffer();
    StringBuffer h2values=new StringBuffer();
    StringBuffer h3values=new StringBuffer();
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
    
    String ext_fac[]=null;
    String tras[]=null;
    String workdet[]=null;
    
    //StringBuffer query= new StringBuffer();
    
try
{   
     distcode.append(String.valueOf(session.getAttribute("dcode")));
     ////System.out.println("this is dcode..."+distcode.toString());
     
     distcode.append(String.valueOf(session.getAttribute("dyr")));
     ////System.out.println("this is dyr..."+dyr.toString());
     
     
     
     int v1sum=0,v2sum=0,v4sum=0,v5sum=0;
     double v3sum=0.0;
    // String h1values="",h2values="",h3values="",v1="",v2="",v3="",v4="",h2v1="",h2v2="",h2v3="",h2v4="",h2v5="",h2v6="",h2v7="",h3v1="",h3v2="",h3v3="",h3v4="";
     //String ext_fac[],tras[],workdet[];
     
    
	%>
		   <tr align="center" bgcolor="#ffffff">
			<tr>	<td class=btext  align=center rowspan="2">Sl.No</td>
					<td class=btext  align=center rowspan="2">HabCode</td>
				     <td class=btext  align=center rowspan="2">Habitation</td>
                    <td class=btext align=center rowspan="2">SSSCode</td>
                     <td class=btext  align="center"  rowspan="2">Population served<br> by Tank</td>
	       <td class=btext  align="center" colspan=2">Scheme details</td>
			<td class=btext  align="center" colspan="2">Source of Feeding</td>
			<td class=btext  align="center" rowspan="2">Tank Capacity(Full)<br> litres in lakhs</td>
		<td class=btext  align="center" rowspan="2">How many days water can be supplied ,<br> if the tank is filled<br> upto full capacity</td>
<td class=btext align="center" rowspan="2">Present status <br> (% of filling)</td>
<td class=btext  align="center" rowspan="2" >Canal running (Yes/No)</td>
<td class=btext  align="center" rowspan="2" width="90">Date of Full Filling</td>
<td class=btext align="center" rowspan="2">Probable date <br>of Canal closure <br>(dd/mm/yy)</td>
<td class=btext  align="center" rowspan="2">Probable date<br> of re opening and<br> intermitant fillings <br>if any (dd/mm/yy)</td>
<td class=btext  align="center" rowspan="2">Whether steps have <br>been taken to fill up  <br>SS Tank to full capacity <br> before canal closure <br> and contingent plan to <br> fill up tank to  <br>full capacity</td>
<td class=btext align="center" rowspan="2">Steps Taken</td>
<td class=btext  align="center" rowspan="2">Identified alternative <br>measures to mitigate<br> scarcity(if araises) in case<br> of longer canal closure due <br>to Mtc./Non filling of<br> Tank to full capacity etc.</td>
<td class=btext align="center" rowspan="2">Identified Alternatives</td>
<td class=btext  align="center" rowspan="2">Remarks<br>(specific problems and also <br>reasons for less than 50% <br>filling and present supply <br>measures for 0% filling))</td>
</tr>
<tr>
<td class=btext align="center">Scheme Name</td>
<td class=btext  align="center">No. of habs covering</td>
<td class=btext  align="center">Name of <br>River/Vagu /etc.</td>
<td class=btext  align="center">Canal Name</td>
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
            <td class=btext>18</td>	
            <td class=btext>19</td>
            <td class=btext>20</td>		
            <td class=btext>21</td>
		</tr>
     
        <%
 //queries
query.delete(0,query.length());
           query.append("select substr(a.panch_code,1,16),asset_name,count(d.hab_code) from  rws_complete_hab_view a,RWS_AST_SS_SC_PARAM_TBL  b,rws_asset_mast_tbl c ,rws_asset_hab_tbl d where d.asset_code=c.asset_code  and b.asset_code=c.asset_code and c.hab_code=a.panch_code  and a.panch_code=substr(b.sssc_code,1,16) group by substr(a.panch_code,1,16),asset_name");
		   Hashtable h1=new Hashtable();
	       pst2=conn.createStatement();
	       rs2=pst2.executeQuery(query.toString());
           ////System.out.println("rep qry "+query);
	       while(rs2.next())
	       {
	         h1.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
           //  ////System.out.println("................."+h5.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3)));
	       }		
       
	       
	       session.setAttribute("h1",h1);
	       
	       
         query.delete(0,query.length());
         
        query.append("SELECT distinct a.hab_code,b.panch_name,SSSC_CODE,nvl(popu_served,0),nvl(river_name,'-'),nvl(canal_name,'-'),nvl(tank_capacity,0),nvl(no_of_days_serve,0),nvl(present_status,0),nvl(to_char(fill_date,'dd/mm/yyyy'),'-'),nvl(to_char(prob_canal_clos_dt,'dd/mm/yyyy'),'-'),nvl(to_char(prob_canal_reopen_dt,'dd/mm/yyyy'),'-'),nvl(steps_taken,'-'),nvl(steps_taken_reason,'-'),nvl(identified_alternative,'-'),nvl(identified_alternative_reason,'-'),nvl(remarks,'-'),nvl(decode(CANAL_RUNNING,'Y','YES','N','NO'),'-') as CANAL_RUNNING FROM RWS_DROUGHT_SSTANK_TBL a,rws_panchayat_raj_tbl b WHERE a.hab_code=b.panch_code and SUBSTR(a.HAB_CODE,1,2)='"+distcode+"' and drought_date>=to_date('"+rvalue+"','dd-mm-yyyy') and drought_date<=to_date('"+rvalue1+"','dd-mm-yyyy')");
          pst1=conn.createStatement();
          rs1=pst1.executeQuery(query.toString());
          //System.out.println("my qry1 "+query.toString());
          while(rs1.next())
          {
           //hash1 values getting
            h1values.delete(0,h1values.length());
            h1values.append(h1.get(rs1.getString(1)));
           // if(h1values!=null)
        	   if(h1values!=null&& !h1values.toString().equals("null"))
            {
             ext_fac=h1values.toString().split("@");
             v1.delete(0,v1.length());
             v1.append(ext_fac[0]);
             
             v2.delete(0,v2.length());
			 v2.append(ext_fac[1]);
			// v3=ext_fac[2];
			v2sum+=Integer.parseInt(v2.toString().equals("null")?"0":v2.toString()); 
             }
           else
			{
        	   v1.delete(0,v1.length());
	         v1.append("-");
	         v2.delete(0,v2.length());
			 v2.append("-");
			// v3="-";
			}
            //end
    
         %>
        <tr align="center">
           <td class=rptvalue align="left"><%=count++%></td>
           <td class=rptvalue align="left">&nbsp;<%=rs1.getString(1)%></td>
            <td class=rptvalue align="left"><%=rs1.getString(2)%></td>
            <td class=rptvalue align="left"><%=rs1.getString(3)%></td>		
			<td class=rptvalue align="center"><%=rs1.getString(4)%></td>	
			 <td class=rptvalue align="center"><%=v1 %></td>
			<td class=rptvalue align="center"><%=v2%></td>
			<td class=rptvalue align="center"><%=rs1.getString(5)%></td>
			<td class=rptvalue align="right"><%=rs1.getString(6)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(7)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(8)%></td>
            <td class=rptvalue align="center" width="90"><%=rs1.getString(9)%></td>
            <td class=rptvalue align="center"><%=rs1.getString("CANAL_RUNNING")%></td>
            <td class=rptvalue align="left"><%=rs1.getString(10)%></td>	
            <td class=rptvalue align="left"><%=rs1.getString(11)%></td>	
			<td class=rptvalue align="left"><%=rs1.getString(12)%></td>	
			 <td class=rptvalue align="center"><%=rs1.getString(13)%></td>
            <td class=rptvalue align="right"><%=rs1.getString(14)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(15)%></td>
			<td class=rptvalue align="right"><%=rs1.getString(16)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(17)%></td>
             </tr>
	<%
   v1sum+=Integer.parseInt(rs1.getString(4));
   v3sum+=Double.parseDouble(rs1.getString(7));
   v4sum+=Integer.parseInt(rs1.getString(8));
   v5sum+=Integer.parseInt(rs1.getString(9));
}
    

%>
       <tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=4>Totals</td>
             <td class=btext align="right"><%=v1sum%></td>
			 <td class=btext align="right">-</td>
             <td class=btext align="right"><%=v2sum%></td>
            <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
			<td class=btext align="right"><%=v3sum%></td>
			<td class=btext align="right"><%=v4sum%></td>
			<td class=btext align="right"><%=v5sum%></td>
			 <td class=btext align="right">-</td>
           <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
			<td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
            <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>

		</tr>
<%
}

catch(Exception e1)
{
	e1.printStackTrace();
}

finally
{
	  s=null;
	  rvalue=null;
	  rvalue1=null;
	  dyear=null;
	  dname=null;
	  dist_code=null;
	  distcode=null;
	  dyr=null;
	     h1values=null;
	      h2values=null;
	      h3values=null;
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
	      h3v1=null;
	      h3v2=null;
	      h3v3=null;
	      h3v4=null;
	    
	      ext_fac =null;
	      tras =null;
	      workdet =null;
}
%>
</table>

</body>
</form>
</html>

<%@ include file = "footer.jsp" %>
