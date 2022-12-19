<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);

String nextYear=String.valueOf(Integer.parseInt(cYear)+1);



String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
nYear+=1;
String finYear="";
String currentMonth=RwsUtils.getCurrentMont();
String nextMonth=RwsUtils.getNextMonth();

 String phyprogrammeNames="";


prevmonth=prevmonth.toUpperCase();
%>
<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
</script>
	<% 

    DecimalFormat ndf = new DecimalFormat("##.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



	%>
	<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html>
	<table width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">
    
        <tr>
            <td style="padding-left: 2px; padding-right: 2px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td align="center" valign="top" bgcolor="#f5f5f5" height="348" style="padding: 4px;">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="padding: 4px;" width="750">
                                        

			<table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="padding: 4px;" >

<!-- Search Panel Starts -->


<!-- Search Panel Ends -->



				    </td>
				</tr>
<tr>
<td height="20"></td>

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD">
		<td align="center" class="gridhdbg" colspan=16 ><font color="white"><b>Total Weightage <%=cYear %>-<%=nYear %></b></font></td>	
	</tr>		
		<tr >
		<td class="gridhdbg"   rowspan="2" align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan="2"   align=center>District</td>
		<td class="gridhdbg"  align=center colspan="2" >Schemes</td>
		<td class="gridhdbg"  rowspan="2"  align=center >Preparation of DPRs</td>
		<td class="gridhdbg"   rowspan="2"  align=center> Permissions Pending </td>
		<td class="gridhdbg"  rowspan="2"   align=center>Schemes handing over to GPs</td>
		<td class="gridhdbg"  rowspan="2"   align=center>Sustainability Structures</td>
		<td class="gridhdbg"   rowspan="2"   align=center>Drinking Water Facilities to Schools & Anganwadies</td>
		<td class="gridhdbg"  rowspan="2"   align=center>WQM&S</td>
		<td class="gridhdbg"  rowspan="2"   align=center>Through FTKs</td>
		<td class="gridhdbg"  rowspan="2"   align=center>Habs where atleast one source is tested</td>
		<td class="gridhdbg"  rowspan="2"   align=center>VWSC Members weightage 5</td>
		<td class="gridhdbg"  rowspan="2"   align=center>Usage of FTK kits weightage 5</td>
		
		
		
<td class="gridhdbg" rowspan="2"  align=center >Total Weightage</td>
</tr>
<tr>
<td class="gridhdbg"  align=center  >Financial<br></br>Weightage 15 </td>
<td class="gridhdbg"  align=center >Physical <br></br>Weightage 15 </td> 	
</tr>

<tr><td class="gridhdbg"   align=center>1</td>
<td class="gridhdbg"   align=center>2</td>
<td class="gridhdbg"   align=center>3</td>
<td class="gridhdbg"   align=center>4</td>
<td class="gridhdbg"   align=center>5</td>
<td class="gridhdbg"   align=center>6</td>
<td class="gridhdbg"   align=center>7</td>
<td class="gridhdbg"   align=center>8</td>
<td class="gridhdbg"   align=center>9</td>
<td class="gridhdbg"   align=center>10</td>
<td class="gridhdbg"   align=center>11</td>
<td class="gridhdbg"   align=center>12</td>
<td class="gridhdbg"   align=center>13</td>
<td class="gridhdbg"   align=center>14</td>
<td class="gridhdbg"   align=center>15</td>



	</tr>

<% 

 Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null;
String programmeNames="";
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	 String selectQuery="select *from rws_rfd_weightage_tbl";
	 
	 
 
	   
	  	  
	  
	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>



</table>
                                        <!-- Grid Table Ends -->


				  
				</tr>
				
				
</table>









                                    </td>
                                </tr>
                                
                            </table>
                        </td>
                    </tr>
               
                </table>
            </td>
        </tr>
        
    </table>
 <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Footer.js' />"></script>
</body>
</html>
