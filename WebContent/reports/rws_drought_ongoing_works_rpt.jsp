<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
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
			if(document.f1.district1.value=='')
			{
                //alert("hai if");
				alert("Please Select District");
				return false;
			}
           if(document.f1.demo1.value=='')
			{
                //alert("hai if");
				alert("Please Select Date");
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
				   // alert(document.f1.dname1.value); 
				}
                //alert("....hai....."+document.f1.dname1.value);
                 var d=document.getElementById('demo1').value;//date value
				 var d1=document.getElementById('demo2').value;//date value
				 
				  //alert("hai");
				  document.f1.mydate.value=d; 
                  document.f1.mydate1.value=d1; 
                   var fDate=getDateObject(document.f1.mydate.value,"-");
				   var tDate=getDateObject(document.f1.mydate1.value,"-");
				    if(fDate<=tDate)
					{
				     document.f1.action="./rws_drought_ongoing_works_rpt.jsp";
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

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null;
int count=1;
//first time display purpose
String s;
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
s = formatter.format(date);
String currentdate=s.replace("/","-");
//System.out.println("current"+currentdate);
String rvalue=request.getParameter("mydate");
if(rvalue!=null){
session.setAttribute("rvalue",rvalue);
}
if(rvalue==null)
rvalue=currentdate;
System.out.println("rvalue........"+rvalue);



String rvalue1=request.getParameter("mydate1");
if(rvalue1!=null){
session.setAttribute("rvalue1",rvalue1);
}
if(rvalue1==null)
rvalue1=currentdate;
System.out.println("rvalue1........"+rvalue1);


String dname=request.getParameter("dname1");
if(dname!=null){
session.setAttribute("dname",dname);

	

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
		<td align="center" class="rptHeading" colspan=3>DROUGHT ON GOING WORKS REPORT</td>	
	</tr>
 <%try{
    String dcode = request.getParameter("district1");
    System.out.println("this is dcode..."+dcode);
    session.setAttribute("dcode",dcode);
	String divcode = request.getParameter("division");
	String dcode1 = request.getParameter("district1");
	String divcode1 = request.getParameter("division");

 %>
<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")||loggedUser.equals("1000DR")))
		{
		%>
			<SELECT name="district1" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
	        rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode1))
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
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode1=rs.getString(1);
	%>
				<input type="text" name="dname1" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district1" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

    <tr><td class=rptLabel>Select Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" value="<%=rvalue%>">
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 
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
// System.out.println("Exception in bill Report frm jsp:"+e);
        }

%>
   <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table>


<input type="hidden" name="mydate" >
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="dname1">
<INPUT type="hidden" name="mname1">
<input type="hidden" name="mydate1" >
<%

if(rvalue!=null && !rvalue.equals("") && !rvalue.equals("null"))
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
					<a href="./rws_drought_ongoing_works_rpt_xls.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
  


		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=35>DROUGHT ONGOING WORKS REPORT OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp;ON:&nbsp;&nbsp;<%=rvalue%>&nbsp;&nbsp;To&nbsp;&nbsp;<%=rvalue1%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>
		
<%
try
{   
     String distcode =(String)session.getAttribute("dcode");
     System.out.println("this is dcode..."+distcode);
     String h1values="",h2values="",h3values="",v1="",v2="",v3="",v4="",h2v1="",h2v2="",h2v3="",h2v4="",h2v5="",h2v6="",h2v7="",h3v1="",h3v2="",h3v3="",h3v4="";
     String ext_fac[],tras[],workdet[];
     float v1sum=0,v2sum=0,v3sum=0,v4sum=0;
	%>
		   <tr align="center" bgcolor="#ffffff">
			<td class=btext align="center" rowspan="2">S.No.</td>
			<td class=btext align="center" rowspan="2">Mandal Name</td>
			<td class=btext align="center" rowspan="2">Panchayat Name</td>
			<td class=btext align="center"  rowspan="2">Hab Name </td>
			<td class=btext align="center" rowspan="2">Hab Code</td>
           <td class=btext align="center" rowspan="2">Hab Status</td>
           <td class=btext align="center" colspan="4">On going Works</td>
           <td class=btext align="center" colspan="9">Asset Details</td>
			</tr>
			<tr>
			<td class=btext align="center">Name of<br> the Work</td>
			<td class=btext align="center">Est.Cost<br>(Rs.in Lakhs)</td>
			<td class=btext align="center">Grant</td>
			<td class=btext align="center">Probable date <br>of Completion</td>
			<td class=btext align="center">PWS</td>
			<td class=btext align="center">CPWS</td>
			<td class=btext align="center">MPWS</td>
			<td class=btext align="center">HP</td>
			<td class=btext align="center">DP</td>
			<td class=btext align="center">Sustainability</td>
			<td class=btext align="center">SHP</td>
			<td class=btext align="center">Ponds</td>
			<td class=btext align="center">Open Wells</td>
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
		</tr>
     
        <%
 //queries
           
          
           String qry4="select distinct a.habitation_code,c.work_name ,nvl(c.SANCTION_AMOUNT,0),e.programme_name,nvl(to_char(f.PROBABLE_DATE,'dd-mm-yyyy'),'-') from RWS_DROUGHT_HAB_TR_PVT_SO_TBL a ,rws_admn_hab_lnk_tbl  b ,rws_work_admn_tbl  c,rws_work_completion_tbl d ,rws_programme_tbl e ,RWS_CONTRACTOR_SELECTION_TBL f where a.habitation_code=b.hab_code and substr(a.habitation_code,1,2)='"+distcode+"' and b.work_id=c.work_id and c.work_id=d.work_id  and b.work_id=d.work_id and c.programme_code=e.programme_code and c.work_id=f.work_id and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy')";
	       Hashtable h3=new Hashtable();
	       pst4=conn.createStatement();
	       rs4=pst4.executeQuery(qry4);
           System.out.println("my qry4 "+qry4);
	       while(rs4.next())
	       {
	         h3.put(rs4.getString(1),rs4.getString(2)+"#"+rs4.getString(3)+"#"+rs4.getString(4)+"#"+rs4.getString(5));
             //System.out.println("habcode"+rs2.getString(1));
             //System.out.println(h3.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5)));
	       }

	       if(pst4!=null){
	    		pst4.close();
	    	}
	    	if(rs4!=null){
	    		rs4.close();
	    	}

	    	String assetdetqry="select distinct hab_code,type_of_asset_code,count(1) from RWS_ASSET_MAST_TBL where substr(hab_code,1,2)='"+distcode+"'  group by hab_code,type_of_asset_code";
	    	pst4=conn.createStatement();
	    	rs4=pst4.executeQuery(assetdetqry);
	    	System.out.println("assetdetqry "+assetdetqry);
	    	Hashtable asset_hash=new Hashtable();
	    	while(rs4.next())
	    	{
	    		asset_hash.put(rs4.getString(1)+rs4.getString(2),rs4.getInt(3));
	    	  //System.out.println("habcode"+rs2.getString(1));
	    	  //System.out.println(h3.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5)));
	    	}
	    	if(pst4!=null){
	    	pst4.close();
	    	}
	    	if(rs4!=null){
	    	rs4.close();
	    	}
	    	String csqry="select distinct hab_code,nvl(coverage_status,'-') from rws_habitation_directory_tbl  where substr(hab_code,1,2)='"+distcode+"'";
	    	pst4=conn.createStatement();
	    	rs4=pst4.executeQuery(csqry);
	    	System.out.println("csqry "+csqry);
	    	Hashtable cs_hash=new Hashtable();
	    	while(rs4.next())
	    	{
	    		cs_hash.put(rs4.getString(1),rs4.getString(2));
	    	  //System.out.println("habcode"+rs2.getString(1));
	    	  //System.out.println(h3.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5)));
	    	}
	    	if(pst4!=null){
	    	pst4.close();
	    	}
	    	if(rs4!=null){
	    	rs4.close();
	    	}
	    	session.setAttribute("h3",h3);
	    	session.setAttribute("asset_hash",asset_hash);
	    	session.setAttribute("cs_hash",cs_hash);
          String qry1="select distinct mname,pname,PANCH_NAME,PANCH_CODE from RWS_DROUGHT_HAB_TR_PVT_SO_TBL  a,rws_mandal_tbl b ,rws_panchayat_tbl c ,rws_panchayat_raj_tbl d ,RWS_DROUGHT_HABITATION_TBL  e ,RWS_DROUGHT_SCAR_REASONS_TBL f , rws_habitation_directory_tbl g where  substr(habitation_code,1,2)='"+distcode+"' and substr(habitation_code,1,2)=b.dcode and substr(habitation_code,6,2)=b.mcode and substr(habitation_code,13,2)=c.pcode and substr(habitation_code,6,2)=c.mcode and substr(habitation_code,1,2)=c.dcode  and substr(habitation_code,13,2)=substr(d.hab_code,13,2) and substr(habitation_code,6,2)=substr(d.hab_code,6,2) and substr(habitation_code,1,2)=substr(d.hab_code,1,2) and e.habcode=d.panch_code and e.scarcity_code=f.scarcity_code and a.date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and a.date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') and a.habitation_code=g.hab_code order by pname";
          System.out.println("my qry1 "+qry1);
          pst1=conn.createStatement();
          rs1=pst1.executeQuery(qry1);
          //System.out.println("my qry1 "+qry1);
            int totpwscnt=0,totcpwscnt=0,totmpwscnt=0,tothpcnt=0,totdpcnt=0,totshpcnt=0,totsuscnt=0,totpondscnt=0,totowcnt=0;
          while(rs1.next())
          {
        	  String covstatus="";
        	  if(cs_hash.get(rs1.getString(4))!=null){
        		  covstatus=(String)cs_hash.get(rs1.getString(4));  
        	  }
        	  int pwscnt=0,cpwscnt=0,mpwscnt=0,hpcnt=0,dpcnt=0,shpcnt=0,suscnt=0,pondscnt=0,owcnt=0;
            //System.out.println("111111111"+qry1);
        	  if(asset_hash.get(rs1.getString(4)+"09")!=null){
                  dpcnt=(Integer)asset_hash.get(rs1.getString(4)+"09");
                  totdpcnt+=dpcnt;
                  }
                  if(asset_hash.get(rs1.getString(4)+"10")!=null){
                  	suscnt=(Integer)asset_hash.get(rs1.getString(4)+"10");	
                  totsuscnt+=suscnt;    
                  }
                  if(asset_hash.get(rs1.getString(4)+"05")!=null){
                  	shpcnt=(Integer)asset_hash.get(rs1.getString(4)+"05");	
                  totshpcnt+=shpcnt;   
                  }
                  if(asset_hash.get(rs1.getString(4)+"06")!=null){
                      owcnt=(Integer)asset_hash.get(rs1.getString(4)+"06");	
                  totowcnt+=owcnt;    
                  }
                  if(asset_hash.get(rs1.getString(4)+"07")!=null){
                  	pondscnt=(Integer)asset_hash.get(rs1.getString(4)+"07");	
                  totpondscnt+=pondscnt;    
                  }
                  if(asset_hash.get(rs1.getString(4)+"01")!=null){
                      pwscnt=(Integer)asset_hash.get(rs1.getString(4)+"01");	
                  totpwscnt+=pwscnt;    
                  }
                  if(asset_hash.get(rs1.getString(4)+"02")!=null){
                      mpwscnt=(Integer)asset_hash.get(rs1.getString(4)+"02");	
                  totmpwscnt+=mpwscnt;    
                  }
                  if(asset_hash.get(rs1.getString(4)+"03")!=null){
                      cpwscnt=(Integer)asset_hash.get(rs1.getString(4)+"03");	
                      totcpwscnt+=cpwscnt;  
                  }
                  if(asset_hash.get(rs1.getString(4)+"04")!=null){
                      hpcnt=(Integer)asset_hash.get(rs1.getString(4)+"04");	
                      tothpcnt+=hpcnt;   
                  }         
           //work details hash values
            h3values=(String)h3.get(rs1.getString(4));
            //if(h3values!=null)
            if(h3values!=null && !h3values.equals("") && !h3values.equals("null"))
            {
             workdet=h3values.split("#");
             h3v1=workdet[0];
			 h3v2=workdet[1];
			 h3v3=workdet[2];
             h3v4=workdet[3];
             //System.out.println("h3v2"+h3v2);
             }
           else
			{	
	         h3v1="-";
			 h3v2="0";
			 h3v3="-";
             h3v4="-";                      
			}
           
            //end 
      // 
         %>
      <tr align="center">
           <td class=rptvalue align="left"><%=count++%></td>
           <td class=rptvalue align="left"><%=rs1.getString(1)%></td>
           <td class=rptvalue align="left"><%=rs1.getString(2)%></td>	
            <td class=rptvalue align="left">&nbsp;<%=rs1.getString(3)%></td>	
			<td class=rptvalue align="left"><%=rs1.getString(4)%></td>	
			<td class=rptvalue align="left"><%=covstatus%></td>	
			 <td class=rptvalue align="center"><%=h3v1%></td>
			<td class=rptvalue align="right"><%=h3v2%></td>
            <td class=rptvalue align="center"><%=h3v3%></td>
            <td class=rptvalue align="center"><%=h3v4%></td>
             <td class=rptvalue align="center"><%=pwscnt %></td>
            <td class=rptvalue align="center"><%=cpwscnt %></td>
            <td class=rptvalue align="center"><%=mpwscnt %></td>
            <td class=rptvalue align="center"><%=hpcnt %></td>
            <td class=rptvalue align="center"><%=dpcnt %></td>
            <td class=rptvalue align="center"><%=suscnt %></td>
            <td class=rptvalue align="center"><%=shpcnt %></td>
            <td class=rptvalue align="center"><%=pondscnt %></td>
            <td class=rptvalue align="center"><%=owcnt %></td>
           </tr>

	<%
   //v1sum+=Float.parseFloat(h3v2);
}
    
          if(pst1!=null){
        	  pst1.close();
	    	}
	    	if(rs1!=null){
	    		rs1.close();
	    	}
%>
 <tr align="center" class=btext>
           <td class=btext colspan=7>Totals</td>
            <td class=btext align="right"><%=v1sum%></td>
			<td class=btext align="right">-</td>
            <td class=btext align="right">-</td>
             <td class=btext align="center"><%=totpwscnt %></td>
            <td class=btext align="center"><%=totcpwscnt %></td>
            <td class=btext align="center"><%=totmpwscnt %></td>
            <td class=btext align="center"><%=tothpcnt %></td>
            <td class=btext align="center"><%=totdpcnt %></td>
            <td class=btext align="center"><%=totsuscnt %></td>
            <td class=btext align="center"><%=totshpcnt %></td>
            <td class=btext align="center"><%=totpondscnt %></td>
            <td class=btext align="center"><%=totowcnt %></td>
</tr>  
<%
}

catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try{
	    
		
	}
	catch(Exception e1)
	{
		e1.printStackTrace();
		
	}
	
}
%>
</table>
<br>
<b><font color="red">&nbsp;Note&nbsp;:&nbsp; Amount Displayed in Laksh(s)</font></b>
<% } %>
</body>
</form>
</html>

<%@ include file = "footer.jsp" %>
