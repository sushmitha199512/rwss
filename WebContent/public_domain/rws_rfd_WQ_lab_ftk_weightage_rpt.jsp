<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
//Percentage = (Obtained score x 100) / Total Score
//percentage = (score * 100/ total);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();

String dcode="";
if(loggedUser.substring(0,3).equals("col")){
	dcode=(String)session.getAttribute("district");    
   }
//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());


String cYear1=w.getServerDate().substring(8,10);
//System.out.println("cYear1 *******"+cYear1);



String currentMonth=RwsUtils.getCurrentMont();

if(currentMonth!=null&& !(currentMonth.equals("APR") || currentMonth.equals("MAY") || currentMonth.equals("JUN")
		|| currentMonth.equals("JUL")
		|| currentMonth.equals("AUG")
		|| currentMonth.equals("SEP")
		|| currentMonth.equals("OCT")
		|| currentMonth.equals("NOV")
		|| currentMonth.equals("DEC")

)){
	int tempYear=Integer.parseInt(cYear1);
	tempYear-=1;
	cYear1=String.valueOf(tempYear);
	
}

String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear1);
int pYear=nYear-1;
nYear+=1;
String finYear="";

String nextMonth=RwsUtils.getNextMonth();

//System.out.println("DDED");

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

	DecimalFormat ndf = new DecimalFormat("####.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



	%>
	<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html>
	<body>
	
    <table width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">
    
        <tr>
            <td style="padding-left: 2px; padding-right: 2px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td align="center" valign="top" bgcolor="#f5f5f5" height="348" style="padding: 4px;">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="padding: 4px;" width="650">
                                        

			<table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="padding: 4px;" >

<!-- Search Panel Starts -->


<!-- Search Panel Ends -->



				    </td>
				</tr>
<tr>
<td height="20"></td>

<tr><td align="right" class="bwborder" colspan="2"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;
                    <a href="rws_rfd_WQ_lab_ftk_weightage_excel.jsp" target="_new">Excel</a></td></tr>       

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="gridhdbg" colspan=15><font color="white"><b>WQM&S Report<%=cYear1 %>-<%=nYear %></b></font></td>	
	</tr>
		<tr>
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
<td class="gridhdbg"  align=center colspan=5 nowrap >Through Labs <br></br><font color="red"><b>.</b></font></td>
<td class="gridhdbg" colspan=4 align=center >Through FTKs <br><font color="red"><b></b></font></br></td>
 <td class="gridhdbg" colspan=4 align=center >Habs where atleast one source is tested <br><font color="red"><b></b></font></br></td>
</tr>
<tr>
<td class="gridhdbg"  align="center"  >Total&nbsp;Labs</td>
<td class="gridhdbg"  align="center"  >Target</td>
 <td  class="gridhdbg" align="center"  >Achmt</td>	
 <td class="gridhdbg"  align="center"  >Percentage</td>
 <td  class="gridhdbg" align="center"  >weightage</td>	
 
 <td class="gridhdbg"  align="center"  >Target</td>
 <td  class="gridhdbg" align="center"  >Achmt</td>	
 <td class="gridhdbg"  align="center"  >Percentage</td>
 <td  class="gridhdbg" align="center"  >weightage</td>	
 
<td class="gridhdbg"  align="center"  >Target</td>
 <td  class="gridhdbg" align="center"  >Achmt</td>
 <td class="gridhdbg"  align="center"  >Percentage</td>
 <td  class="gridhdbg" align="center"  >weightage</td>	
 	

 	
 	
 	
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
Statement stmt2=null,stmt3=null,stmt4=null,stmt33=null,stmt44=null,stmt5=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null,rs23=null,rs44=null,rs5=null;
String programmeNames="";
int count=1;
double sanamount=0,achetot=0,pert=0,weighttot=0,ftkweighttot=0,onesourcetestedper=0,onesourcetestedweight=0,percentageonesource=0,weightonesource=0;

int dprpend=0,dprpendnot=0,glabtot=0,dprpendtot=0,dprpendtot1=0,labtarget=0,glabtarget=0,testedtarget=0;
double sss=0;
  try{
	  ///Total Lab count district wise 
 
	  String labcount="select substr(a.office_code,2,2),count(*) from RWS_WATER_QUALITY_LAB_TBL a  where  a.status<>'UI' AND a.STATUS IS NOT NULL group by substr(a.office_code,2,2)order by 1";
	  
	  stmt5=conn.createStatement();
	//System.out.println("dprlan****111**"+labcount);
		 rs5=stmt5.executeQuery(labcount);
		Hashtable labac=new Hashtable();
		//System.out.println("dprlanper"+labac);
		while(rs5.next())
		{
			labac.put(rs5.getString(1),rs5.getString(2));
		}
	  //
	  
	  
	  //Achmt
	  	   
	  //   String labachmt="select count(*),substr(source_code,1,2)  from RWS_WQ_TEST_RESULTS_TBL where  substr(test_id,4,2)>'01-Apr-"+cYear1+"' Group by substr(source_code,1,2) order by substr(source_code,1,2)";
	     String labachmt="select count(*),substr(source_code,1,2)  from RWS_WQ_TEST_RESULTS_TBL where  PREPARED_ON >'01-Apr-"+cYear1+"' Group by substr(source_code,1,2) order by substr(source_code,1,2)";
		 
	 Statement stmt333=conn.createStatement();
	//System.out.println("labachmt******KKKKKK"+labachmt);
		 ResultSet rs233=stmt333.executeQuery(labachmt);
		Hashtable dpr333=new Hashtable();
		while(rs233.next())
		{
			dpr333.put(rs233.getString(2),rs233.getString(1));
			
		}
	  
	  
	  
	  
		//FTK target
	   // String ftktot="select count(*),substr(source_code,1,2)  from RWS_WQ_TEST_RESULTS_TBL where  PREPARED_ON >'01-Apr-"+cYear1+"' Group by substr(source_code,1,2) order by substr(source_code,1,2)";
		   String ftktot="select WQ_FTK_TESTS,dcode from rws_work_sch_target_tbl  Group by WQ_FTK_TESTS,dcode order by 2";
		 Statement stmt67=conn.createStatement();
		//System.out.println("ftktot******KKKKKK"+ftktot);
			 ResultSet rs67=stmt67.executeQuery(ftktot);
			Hashtable ftkco=new Hashtable();
			while(rs67.next())
			{
				ftkco.put(rs67.getString(2),rs67.getString(1));
				
			}
		
		
			//FTK ache
		   String ftkach="select count(*),substr(source_code,1,2)  from RWS_WQ_TEST_RESULTS_TBL where  PREPARED_ON >'01-Apr-"+cYear1+"' Group by substr(source_code,1,2) order by substr(source_code,1,2)";
			 
		  
		    
		    
			 Statement stmt68=conn.createStatement();
			//System.out.println("ftkach******KKKKKK"+ftkach);
				 ResultSet rs68=stmt68.executeQuery(ftkach);
				Hashtable ftkache=new Hashtable();
				while(rs68.next())
				{
					ftkache.put(rs68.getString(2),rs68.getString(1));
					
				}
			
		
				//Habs where atleast one source tested 
				//Ache
								
		   String onesourcetested="select count(distinct substr(source_code,1,16)),substr(source_code,1,2)  from RWS_WQ_TEST_RESULTS_TBL where  PREPARED_ON >'01-Apr-"+cYear1+"' Group by substr(source_code,1,2) order by substr(source_code,1,2)";
			

			 Statement stmt69=conn.createStatement();
			//System.out.println("onesourcetested******KKKKKK"+onesourcetested);
				 ResultSet rs69=stmt69.executeQuery(onesourcetested);
				Hashtable onetested=new Hashtable();
				while(rs69.next())
				{
					onetested.put(rs69.getString(2),rs69.getString(1));
					
				}
					//Habs where atleast one source tested 
				//Target
								
		  //  String onesourcetestedtarget="select count(distinct substr(source_code,1,16)),substr(source_code,1,2)  from RWS_WQ_TEST_RESULTS_TBL where  PREPARED_ON >'01-Apr-"+cYear1+"' Group by substr(source_code,1,2) order by substr(source_code,1,2)";
			 String onesourcetestedtarget="SELECT COUNT(*),DCODE FROM  RWS_COMPLETE_HAB_VIEW GROUP BY DCODE ORDER BY 2" ;
			 Statement stmt70=conn.createStatement();
		//	System.out.println("onesourcetestedtarget******KKKKKK"+onesourcetestedtarget);
				 ResultSet rs70=stmt70.executeQuery(onesourcetestedtarget);
				Hashtable onetestedtarget=new Hashtable();
				while(rs70.next())
				{
					onetestedtarget.put(rs70.getString(2),rs70.getString(1));
					
				}
		
	  stmt3=conn.createStatement();
	  
	  //Printing Report....
	  
	  
	  String distQuery="select d.dcode,d.dname  from rws_district_tbl d where d.dcode<>'16' ";
	  if(dcode!=null && !dcode.equals("")){
		  distQuery+=" and d.dcode='"+dcode+"'";
		}
	  distQuery+=" order by d.dcode";
	  
	  rs3=stmt3.executeQuery(distQuery);
	  double svsH=0,svsT=0;
	  
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  String style="";
	  double d1=0,d2=0,d3=0;
	  int styleCount=0;
	  double gexpper = 0;
		double ghabper = 0;
		double s1=0,s2=0,totexp1=0;
		double san=0,perlab=0,glabtot1=0,ftkac=0,ftktar=0,ftkper=0,tested=0,weight=0,ftkpp=0,ftkweight=0,gpercentageonesource=0,gweightonesource=0;
		int tottested=0;
		
		double  svsHg=0.0,svsTg=0.0;
		Statement sst1=conn.createStatement();
		
		  
	  	
	  while(rs3.next()){
		  
		 // System.out.println("dprlan****111**"+labac);
		  //Total No of Works
		 String labtot=(String)labac.get(rs3.getString(1));
		 if(labtot==null || labtot.equals("null")||labtot.equals("")){
		
			 						 
			 labtot="0";
		 }
		 //target 
		labtarget=Integer.parseInt(labtot)*3600;
		 
		glabtot+=Integer.parseInt(labtot);
		//target tot
		glabtarget+=labtarget;
		
		 //achmt
		
		 String achmtlab="";
		 if(dpr333.get(rs3.getString(1))!=null && !dpr333.get(rs3.getString(1)).equals("null")){
			 achmtlab=(String)dpr333.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 achmtlab="0";
		 }
		 san=Double.parseDouble(achmtlab);
		 //achie total
		  achetot+=Double.parseDouble(achmtlab);
		 
		 
		 
		 
		 if(labtarget>0)
		 {
			 
		 
		 perlab=san/labtarget;
		 perlab=perlab*100;
		 
		 }
		 else
		 {
			 perlab=0;
			 
		 }
		 
		// Weightage
		 weight=(perlab*5)/100;
		 
		 
		 //ftk TARGET
		
		 String targetftk="";
		 if(ftkco.get(rs3.getString(1))!=null && !ftkco.get(rs3.getString(1)).equals("null")){
			 targetftk=(String)ftkco.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 targetftk="0";
		 }
		 ftktar+=Double.parseDouble(targetftk);
		
		 
		 //ftk Ache
		 
		 String achtftk="";
		 if(ftkache.get(rs3.getString(1))!=null && !ftkache.get(rs3.getString(1)).equals("null")){
			 achtftk=(String)ftkache.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 achtftk="0";
		 }
		 ftkac+=Double.parseDouble(achtftk);
		
		// ftk percentage
		
		 if(ftktar>0)
		 {
		 ftkper=(ftkac/ftktar);
		 ftkper=ftkper*100;
		 
		 }
		 else
		 {
			 ftkper=0;
			 
		 }
		
		
		//end
		 
		//at leasted one source tested ACHEIVEMENT
		
		 String onesourcet="";
		 if(onetested.get(rs3.getString(1))!=null && !onetested.get(rs3.getString(1)).equals("null")){
			 onesourcet=(String)onetested.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 onesourcet="0";
		 }
		tottested+=Integer.parseInt(onesourcet);
		 tested+=Double.parseDouble(onesourcet);
		
		//at leasted one source tested TArgeted
			
		 String onesourcettarget="";
		 if(onetestedtarget.get(rs3.getString(1))!=null && !onetestedtarget.get(rs3.getString(1)).equals("null")){
			 onesourcettarget=(String)onetestedtarget.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 onesourcettarget="0";
		 }
		 testedtarget+=Double.parseDouble(onesourcettarget);
		
		 //percentage of onesourcetested
		 onesourcetestedper=((Double.parseDouble(onesourcet))/(Double.parseDouble(onesourcettarget)))*100;
		
		 //percentage of onesourcetested weightage
		 
		   onesourcetestedweight=(onesourcetestedper/100)*5;
		
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		  %>
		  
		  <tr><td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
		  <td class="<%=style %>"  style="text-align: left;"><%=rs3.getString(2) %></td>
		  <td class="<%=style %>" style="text-align: right;"><%=labtot%></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=labtarget%></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=achmtlab%></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(perlab)%></td>
		  
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(weight)%></td>
		
		  
		  <td class="<%=style %>" style="text-align: right;" ><%=targetftk%></td>
		   <td class="<%=style %>" style="text-align: right;" ><%=achtftk%></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(ftkper)%></td>
		  <% ftkweight= (ftkper*5)/100;%>
		 <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(ftkweight)%></td>
		  
		  
		  <td class="<%=style %>" style="text-align: right;" ><%=onesourcettarget%></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=onesourcet%></td>
		 
		 <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(onesourcetestedper)%></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(onesourcetestedweight)%></td>
		  
		
		  <% 
		  
		  pert=achetot/glabtarget;
		  pert=pert*100;
		  
		  weighttot=(pert*5)/100;
		  
		  
		  
		  if(ftktar>0)
		     {
		     ftkpp=(ftkac/ftktar)*100;
		     }else
		     {ftkpp=0;}
		   
		   ftkweighttot=(ftkpp*5)/100;
		   
		   
		   
		   //one source tested percentage
	       percentageonesource=(tested/testedtarget)*100;
	      // gpercentageonesource+=onesourcetestedper;
	       //weightage in one
	      weightonesource=(percentageonesource*5)/100;
	     //  gweightonesource+=weightonesource;
	     
	   
		   
	  }
	  		
			
	  
	  %>
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
	  <td style="text-align: right;"  class="gridhdbg"  ><%=glabtot %></td>
	  <td class="gridhdbg" style="text-align: right;"><%=glabtarget%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=achetot%></td>
	  
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(pert)%></td>
	  
	   <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(weighttot)%></td>
	   
	    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ftktar)%></td>
	    
	     <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ftkac)%></td>
	     
	     <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ftkpp)%></td>
	     
	        <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ftkweighttot)%></td>  
	       <td class="gridhdbg"  style="text-align: right;"><%=testedtarget%></td>
	       <td class="gridhdbg"  style="text-align: right;"><%=tottested%></td>
	       
	        <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(percentageonesource)%></td>
	        <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(weightonesource)%></td>
	     
	  </tr>
	  
	  <% 
	  
	   
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 
 

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
