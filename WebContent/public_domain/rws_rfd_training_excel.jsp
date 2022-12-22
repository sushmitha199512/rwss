<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="nic.watersoft.commons.RwsUtils"%><html xmlns="http://www.w3.org/1999/xhtml">



<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Trainings.xls");

//System.out.println("Ip:"+request.getRemoteAddr());
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);

String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
nYear+=1;
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
	<!-- Grid Table Starts -->                                      

					<table width="100%" border="1" cellspacing="0" cellpadding="0">
                                            
                                   <tr >
		<td align="center" colspan=18><font >TRAININGS</font></td>	
	</tr>
		<tr >
		
		<td align="center"  colspan=6><font >VWSC Members</font></td>
		<td align="center"  colspan=5><font >Usage of FTK kits</font></td>
		</tr>
		<tr>
		<td  align=center>Sl.No</td>
		<td  align=center>District</td>
<td align=center  nowrap >Target</td>
<td align=center >Achievement</td>
<td align=center >Percentage  </td>
<td align=center >Weightage-5 </td>
<td align=center  nowrap >Target</td>
<td align=center >Achievement </td>
<td align=center >Percentage  </td>
<td align=center >Weightage-5 </td>

</tr>

<%
Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs2=null,rs3=null,rs4=null;
String programmeNames="",programmeNamesa="";
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	 
	  int styleCount=0;
	  
//Query for targets(both vwsc members and Usage of FTK kits) using rws_work_sch_target_tbl
	  Hashtable vwscftkTargetHash=new Hashtable();
	  
	  String vwscftkTargetQuery="select dcode,NO_OF_VWSC_TRAINED,TRAINING_TO_FTK_KITS from rws_work_sch_target_tbl order by dcode";
	  //System.out.println("Q1:"+vwscftkTargetQuery);
	  rs2=stmt2.executeQuery(vwscftkTargetQuery);
	  while(rs2.next()){
		  
		  vwscftkTargetHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
//Query for Achievement (both vwsc members and Usage of FTK kits) using RWS_WQ_TRAINING_TBL
Hashtable vwscftkAchHash=new Hashtable();
	  
	  String vwscftkAchQuery="select dcode,sum(VWSC_MEMBERS_TRAINED),sum(USAGE_OF_FTK_KITS ) from RWS_WQ_TRAINING_TBL group by dcode order by dcode";
	 

	 // System.out.println("Q2:"+vwscftkAchQuery);
	  rs3=stmt3.executeQuery(vwscftkAchQuery);
	  while(rs3.next()){
		  
		  vwscftkAchHash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3));
		  //System.out.println("rs3.getString(1)"+rs3.getString(1));	  
		  
	  }
	 
	  
	  if(rs3!=null)
	  {
		  rs3.close();
	  }
	  if(stmt3!=null){
		  stmt3.close();
	  }
	  


	  //Printing Report....
	  
	  
	  String distQuery="select distinct d.dcode,d.dname from rws_district_tbl d  where dcode<>16 order by dcode";
	  //System.out.println("distq"+distQuery);
	  
	  rs4=stmt4.executeQuery(distQuery);
      int  vwsctrgttot=0,ftktrgttot=0,vwscachtot=0,ftkachtot=0;
      double vwscpertot=0.0,vwscwttot=0.0,ftkpertot=0.0,ftkwttot=0.0;
	  
	
	  String style="";
	 
	  while(rs4.next()){
		 int vwsctrgt=0,ftktrgt=0,vwscach=0,ftkach=0;
		 String vwscftktargets=(String)vwscftkTargetHash.get(rs4.getString(1));
		 if(vwscftktargets!=null){
		 String vwscftkvalues[]=vwscftktargets.split("@");
		 vwsctrgt=Integer.parseInt(vwscftkvalues[0]);
		 ftktrgt=Integer.parseInt(vwscftkvalues[1]);
		 }
		 
		 
		 String vwscftktach=(String)vwscftkAchHash.get(rs4.getString(1));
		 if(vwscftktach!=null){
		  String vwscftktachvalues[]=vwscftktach.split("@");
		 vwscach=Integer.parseInt(vwscftktachvalues[0]);
		  ftkach=Integer.parseInt(vwscftktachvalues[1]); 
		 
		 }
		 
		 double   vwscper=((double)vwscach*100/(double)vwsctrgt);
		 double  ftkper=((double)ftkach*100/(double)ftktrgt);
		
		 
		
		  %>
		  
		  <tr>
		  <td style="text-align: left;" ><%=count++ %></td>
		  <td style="text-align: left;" ><%=rs4.getString(2) %></td>
		  <td style="text-align: right;" ><%=vwsctrgt %></td>
		  <td style="text-align: right;" ><%=vwscach %></td>
		  <td style="text-align: right;" ><%=ndf.format(vwscper) %></td>
		  <td style="text-align: right;" ><%=ndf.format((vwscper*5)/100)%></td>
		  
		  
		  <% 
		  
		
		// int awdper=(awdAch*100/awdTarget);
		 
	   %>
       
       <td style="text-align: right;"  ><%=ftktrgt%></td>
       <td style="text-align: right;"   ><%=ftkach%></td>
       <td style="text-align: right;"  ><%=ndf.format(ftkper) %> </td>
        <td style="text-align: right;" ><%=ndf.format((ftkper*5)/100)%></td>
       </tr>
   
      <% 
      vwsctrgttot+=vwsctrgt;  
      ftktrgttot+=ftktrgt; 
      vwscachtot+=vwscach;
      ftkachtot+=ftkach;
      vwscpertot=((double)(vwscachtot*100)/(double)vwsctrgttot);
      vwscwttot=(vwscpertot*5)/100;
      ftkpertot=((double)(ftkachtot*100)/(double)ftktrgttot);
      ftkwttot=(ftkpertot*5)/100;
	  }
	  
	 %>
	  <tr><td  style="text-align: center;"  colspan="2">Total </td>
	  <td style="text-align: right;" ><%=vwsctrgttot%></td>
	  <td style="text-align: right;"  ><%=vwscachtot%></td>
	  <td style="text-align: right;"  ><%=ndf.format(vwscpertot)%></td>
	  <td style="text-align: right;" ><%=ndf.format(vwscwttot)%></td> 
	  <td style="text-align: right;" ><%=ftktrgttot%></td>
	  <td style="text-align: right;"  ><%=ftkachtot%></td>
	  <td style="text-align: right;" ><%=ndf.format(ftkpertot)%></td>
	  <td style="text-align: right;"  ><%=ndf.format(ftkwttot)%></td> 


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
	