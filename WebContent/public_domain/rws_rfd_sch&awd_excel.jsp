
<%@page import="nic.watersoft.commons.RwsUtils"%><html xmlns="http://www.w3.org/1999/xhtml">



<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Schools & Anganwadies water facility.xls");

//System.out.println("Ip:"+request.getRemoteAddr());
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);
String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
nYear+=1;
int pYear=Integer.parseInt(cYear);
pYear-=1;
String finYear="";
String currentMonth=RwsUtils.getCurrentMont();
String nextMonth=RwsUtils.getNextMonth();




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
	

	<table width="100%" border="1" cellspacing="0" cellpadding="0">
                                            
                                   <tr >
		<td align="center" class="gridhdbg" colspan=18><font size="2" ">Drinking Water Facilities to Schools & Anganwadies <%=pYear %>-<%=cYear %></font></td>	
	</tr>
		<tr >
		
		<td align="center"  colspan=6><font size="2" >Schools </font></td>
		<td align="center"  colspan=5><font size="2">Anganwadies</font></td>
		</tr>
		<tr>
		<td class="gridhdbg"  align=center>Sl.No</td>
		<td class="gridhdbg"  align=center>District</td>
		<td class="gridhdbg"  align=center>Total Schools</td>
		<td class="gridhdbg"  align=center>Toilet Facilities Available</td>
		<td class="gridhdbg"  align=center>Balance</td>
		
<td class="gridhdbg"  align=center  nowrap >Target</td>
<td class="gridhdbg" align=center >Achievement</td>
<td class="gridhdbg" align=center >Percentage Achievement </td>
<td class="gridhdbg" align=center >Weightage-5 </td>
<td class="gridhdbg"  align=center>Total Anganwadies</td>
<td class="gridhdbg"  align=center>Toilet Facilities Available</td>
<td class="gridhdbg"  align=center>Balance</td>
<td class="gridhdbg"  align=center  nowrap >Target</td>
<td class="gridhdbg" align=center >Achievement </td>
<td class="gridhdbg" align=center >Percentage Achievement </td>
<td class="gridhdbg" align=center >Weightage-5 </td>

</tr>




<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
String programmeNames="",programmeNamesa="";
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  stmt5=conn.createStatement();
	  stmt6=conn.createStatement();
	  
	  int styleCount=0;
	  
//Schools Targets
	  Hashtable schoolTargetHash=new Hashtable();
	  
	  String schTargetQuery="select distinct d.dcode,d.dname,count(*) from rws_school_master_tbl,rws_district_tbl d where substr(hab_code,1,2)=d.dcode and SCHOOL_CATEGORY_CODE <>'01' and COMP_DATE_DW is null and FACILITIES_AVAILABLE='None' or  FACILITIES_AVAILABLE='Sanitation (Urinal Only)' or FACILITIES_AVAILABLE='Sanitation (Both)' or FACILITIES_AVAILABLE='Sanitation (Toilet Only)'  group by d.dcode,d.dname order by d.dcode";
	 // System.out.println("Q1:"+schTargetQuery);
	  rs2=stmt2.executeQuery(schTargetQuery);
	  while(rs2.next()){
		  
		  schoolTargetHash.put(rs2.getString(1),rs2.getString(3));
		  
		  
	  }
	  
	  
	 
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
// Schools Achievement
Hashtable schoolAchHash=new Hashtable();
	  
	  String schAchQuery="select  d.dcode,d.dname,count(*) from rws_school_master_tbl,rws_district_tbl d where substr(hab_code,1,2)=d.dcode and SCHOOL_CATEGORY_CODE <>'01' and COMP_DATE_DW is not null and (FACILITIES_AVAILABLE='None' or  FACILITIES_AVAILABLE='Sanitation (Urinal Only)' or FACILITIES_AVAILABLE='Sanitation (Both)' or FACILITIES_AVAILABLE='Sanitation (Toilet Only)') and (COMP_DATE_DW>='01-apr-2013') group by d.dcode,d.dname order by d.dcode";
	 //System.out.println("Q2:"+schAchQuery);
	  rs3=stmt3.executeQuery(schAchQuery);
	  while(rs3.next()){
		  
		  schoolAchHash.put(rs3.getString(1),rs3.getString(3));
		  
		  
	  }
	  
	  if(rs3!=null)
	  {
		  rs3.close();
	  }
	  if(stmt3!=null){
		  stmt3.close();
	  }
	//total schools and toilet facilities qry
	  Hashtable totschHash=new Hashtable();
	  stmt3=conn.createStatement();
	  	  String totschQuery="select substr(hab_code,1,2),count(SCHOOL_CODE),sum(case when FACILITIES_AVAILABLE in ('Sanitation (Urinal Only)','Sanitation (Toilet Only)') then 1 else 0 end) from RWS_SCHOOL_MASTER_TBL,rws_district_tbl  where substr(hab_code,1,2)=dcode  and SCHOOL_CATEGORY_CODE <>'01' group by substr(hab_code,1,2) order by substr(hab_code,1,2)";
	  	// System.out.println("Q2:"+totschQuery);
	  	  rs3=stmt3.executeQuery(totschQuery);
	  	  while(rs3.next()){
	  		  
	  		  totschHash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3));
	  		  
	  		  
	  	  }
	  	  
	  	  if(rs3!=null)
	  	  {
	  		  rs3.close();
	  	  }
	  	  if(stmt3!=null){
	  		  stmt3.close();
	  	  }

//Anganwadies Targets 
	  
	  
	  Hashtable awdTargetHash=new Hashtable();
	  String awdTargetQuery="select distinct d.dcode,d.dname,count(*) from rws_school_master_tbl,rws_district_tbl d where substr(hab_code,1,2)=d.dcode and SCHOOL_CATEGORY_CODE ='01' and COMP_DATE_DW is null and FACILITIES_AVAILABLE='None' or  FACILITIES_AVAILABLE='Sanitation (Urinal Only)' or FACILITIES_AVAILABLE='Sanitation (Both)' or FACILITIES_AVAILABLE='Sanitation (Toilet Only)'  group by d.dcode,d.dname order by d.dcode";
	 // System.out.println("Q3:"+awdTargetQuery);
	  rs4=stmt4.executeQuery(awdTargetQuery);
	  while(rs4.next()){
		  
		  awdTargetHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
//Anganwadies Achievement
	  Hashtable awdAchHash=new Hashtable();
	  String awdAchQuery="select distinct d.dcode,d.dname,count(*) from rws_school_master_tbl,rws_district_tbl d where substr(hab_code,1,2)=d.dcode and SCHOOL_CATEGORY_CODE ='01' and COMP_DATE_DW is not null and (FACILITIES_AVAILABLE='None' or  FACILITIES_AVAILABLE='Sanitation (Urinal Only)' or FACILITIES_AVAILABLE='Sanitation (Both)' or FACILITIES_AVAILABLE='Sanitation (Toilet Only)')  and (COMP_DATE_DW>='01-apr-2013') group by d.dcode,d.dname order by d.dcode";
	//  System.out.println("Q4:"+awdAchQuery);
	  rs5=stmt5.executeQuery(awdAchQuery);
	  while(rs5.next()){
		  
		  awdAchHash.put(rs5.getString(1),rs5.getString(3));
		  
		  
	  }
	
	  if(rs5!=null)
	  {
		  rs5.close();
	  }
	  if(stmt5!=null){
		  stmt5.close();
	  }
	//total Anganwadies and toilet facilities qry
	  Hashtable totangHash=new Hashtable();
	  stmt3=conn.createStatement();
	  	  String totangQuery="select substr(hab_code,1,2),count(SCHOOL_CODE),sum(case when FACILITIES_AVAILABLE in ('Sanitation (Urinal Only)','Sanitation (Toilet Only)') then 1 else 0 end) from RWS_SCHOOL_MASTER_TBL,rws_district_tbl  where substr(hab_code,1,2)=dcode  and SCHOOL_CATEGORY_CODE ='01' group by substr(hab_code,1,2) order by substr(hab_code,1,2)";
	  	 //System.out.println("Q2:"+totangQuery);
	  	  rs3=stmt3.executeQuery(totangQuery);
	  	  while(rs3.next()){
	  		  
	  		  totangHash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3));
	  		  
	  		  
	  	  }
	  	  
	  	  if(rs3!=null)
	  	  {
	  		  rs3.close();
	  	  }
	  	  if(stmt3!=null){
	  		  stmt3.close();
	  	  }
	  //Printing Report....
	  
	  
	  String distQuery="select  distinct d.dcode,d.dname from rws_district_tbl d , rws_school_master_tbl t where substr(t.hab_code,1,2)=d.dcode order by dcode";
	 // System.out.println("distq"+distQuery);
	  
	  rs6=stmt6.executeQuery(distQuery);
      int  schtargettot=0,schachtot=0,awdtargettot=0,awdachtot=0,totsch=0,schtoiletfac=0,totang=0,angtoiletfac=0;
      double schpertot=0.0,schwttot=0.0,awdpertot=0.0,awdwttot=0.0;
	  
      int gtotsch=0,gtoiletfac=0,gschbal=0, gtotang=0,gangtoiletfac=0,gangbal=0;
	  String style="";
	  
	

	  
	  
	  while(rs6.next()){
		  
		  if(totschHash.get(rs6.getString(1))!=null){
				String totalSchools = (String) totschHash.get(rs6.getString(1));
				String totschvalues[]=totalSchools.split("@");
		
				if(totschvalues[0]==null||totschvalues[0].equals("null"))
				{
				totsch =0;
				}
				else
				{
					totsch = Integer.parseInt(totschvalues[0]);
				}
				
				if(totschvalues[1]==null||totschvalues[1].equals("null"))
				{
					schtoiletfac=0;
				}
				else
				{
					schtoiletfac= Integer.parseInt(totschvalues[1]);
				}
		 }
		 int schbal=totsch-schtoiletfac;
		
		 String schTargetHabs=(String)schoolTargetHash.get(rs6.getString(1));
		 String  schAchHabs=(String)schoolAchHash.get(rs6.getString(1));
		 if(schAchHabs==null)
		 {
			 schAchHabs="0";
		 }
		 
		 int schTarget=Integer.parseInt(schTargetHabs);
		 int schAch=Integer.parseInt(schAchHabs);
		 double  schper=((double)schAch*100/(double)schTarget);

		 
		
		  %>
		<tr>
		  <td style="text-align: left;" class=<%=style %>><%=count++ %></td>
		  <td style="text-align: left;" class=<%=style %> ><%=rs6.getString(2) %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=totsch %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=schtoiletfac %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=schbal %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=schTarget %></td>
		  <td style="text-align: right;" class=<%=style %> > <%=schAch %></td>
		  <td style="text-align: right;" class=<%=style %>><%=ndf.format(schper) %></td>
		  <td style="text-align: right;" class=<%=style %>><%=ndf.format((schper*5)/100)%></td>
		  
		  
		  <% 
		  
		  
	
//Anganwadies

			if(totangHash.get(rs6.getString(1))!=null){
					String totalang = (String) totangHash.get(rs6.getString(1));
					
					String totangvalues[]=totalang.split("@");
					if(totangvalues[0]==null||totangvalues[0].equals("null"))
					{
					totang =0;
					}
					else
					{
						totang = Integer.parseInt(totangvalues[0]);
					}
					if(totangvalues[1]==null||totangvalues[1].equals("null"))
					{
						angtoiletfac=0;
					}
					else
					{

						angtoiletfac= Integer.parseInt(totangvalues[1]);
					}
					
			}
		
			 int angbal=totang-angtoiletfac;
			 
	 
	     
		 String awdTargetHabs=(String)awdTargetHash.get(rs6.getString(1));
		 String awdAchHabs=(String)awdAchHash.get(rs6.getString(1));
		
		 if(awdAchHabs==null)
		 {
			 awdAchHabs="0";
		 }
		 
		 int awdTarget=Integer.parseInt(awdTargetHabs);
		 int awdAch=Integer.parseInt(awdAchHabs);
		
		 double awdper=(double)((double)awdAch*100/(double)awdTarget);
		 
	   %>
       
         <td style="text-align: right;" class=<%=style %> ><%=totang %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=angtoiletfac %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=angbal %></td>
       <td style="text-align: right;" class=<%=style %> ><%=awdTarget%></td>
       <td style="text-align: right;" class=<%=style%>  ><%=awdAch %></td>
       <td style="text-align: right;" class=<%=style %> > <%=ndf.format(awdper) %></td>
        <td style="text-align: right;" class=<%=style %> ><%=ndf.format((awdper*5)/100) %></td>
       </tr>
   
      <% 
      gtotsch+=totsch;
	  gtoiletfac+=schtoiletfac;
	  gtotang+=totang;
	  gangtoiletfac+=angtoiletfac;
	  gschbal=gtotsch-gtoiletfac;
      gangbal=gtotang-gangtoiletfac;
      schtargettot+=schTarget;  
      schachtot+=schAch; 
      awdtargettot+=awdTarget;
      awdachtot+=awdAch;
      schpertot=((double)(schachtot*100)/(double)schtargettot);
      schwttot=(schpertot*5)/100;
      awdpertot=((double)(awdachtot*100)/(double)awdtargettot);
      awdwttot=(awdpertot*5)/100;
	  }
	  
	 %>
	  <tr><td class="gridhdbg" style="text-align: center;"  colspan="2">Total </td>
	    <td style="text-align: right;" class="gridhdbg" ><%=gtotsch %></td>
		  <td style="text-align: right;" class="gridhdbg" ><%=gtoiletfac %></td>
		  <td style="text-align: right;" class="gridhdbg"  ><%=gschbal %></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=schtargettot%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=schachtot%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format(schpertot)%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format(schwttot)%></td> 
	  
	  <td style="text-align: right;" class="gridhdbg" ><%=gtotang %></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=gangtoiletfac %></td>
	  <td style="text-align: right;" class="gridhdbg"  ><%=gangbal %></td>
	  
	  <td style="text-align: right;" class="gridhdbg" ><%=awdtargettot%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=awdachtot%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format(awdpertot)%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format(awdwttot)%></td></tr>
<%
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 

</table>	
                                        <!-- Grid Table Ends -->


			<!-- 	    Please Click Here to View Graph<a href="<rws:context page='/public_domain/rws_rfd_sch_target_ach_graph.jsp' />" target="_new"><img src="<rws:context page='/images/chart.png' />"  width="40" height="40"/></a></td> -->
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
 
</body>
</html>
