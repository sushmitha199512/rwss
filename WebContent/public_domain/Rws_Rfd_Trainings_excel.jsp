<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="nic.watersoft.commons.*"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Rfd_Trainings.xls");
//Percentage = (Obtained score x 100) / Total Score
//percentage = (score * 100/ total);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
StringBuffer loggedUser =new StringBuffer();
loggedUser.append(user.getUserId());
StringBuffer dcode=new StringBuffer();
if(loggedUser.toString().substring(0,3).equals("col")){
	dcode.append(String.valueOf(session.getAttribute("district")));    
   }
//22/08/2013
System.out.println("Server Date:"+w.getServerDate());
StringBuffer style=new StringBuffer();

StringBuffer cYear=new StringBuffer(w.getServerDate().substring(6,10));

StringBuffer currentMonth=new StringBuffer(RwsUtils.getCurrentMont().toUpperCase());

if(currentMonth.toString()!=null&& !(currentMonth.toString().equals("APR") || currentMonth.toString().equals("MAY") || currentMonth.toString().equals("JUN")
		|| currentMonth.toString().equals("JUL")
		|| currentMonth.toString().equals("AUG")
		|| currentMonth.toString().equals("SEP")
		|| currentMonth.toString().equals("OCT")
		|| currentMonth.toString().equals("NOV")
		|| currentMonth.toString().equals("DEC")

)){
	int tempYear=Integer.parseInt(cYear.toString());
	tempYear-=1;
	cYear.delete(0,cYear.length());
	cYear.append(String.valueOf(tempYear));
	
}




int cYear1=Integer.parseInt(cYear.toString())+1;
String fin_year=cYear.toString()+"-"+cYear1;
System.out.println("cYear Date:"+fin_year);

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
	

<!-- Grid Table Starts -->                                      

					<table width="100%" border="1" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="gridhdbg" colspan=13><font color="white"><b>Water Quality Trained Members Details for <%=fin_year %></b></font></td>	
	</tr>
		<tr>
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
		<td class="gridhdbg"  align=center colspan="4">VWSC members</td>
		<td class="gridhdbg" align=center colspan="4">Usage of FTK kits</td>
</tr>
<tr>

<td class="gridhdbg"  align=center >Target <%= fin_year %></td>
<td class="gridhdbg" align=center >Achievement <%=fin_year %> </td>
<td class="gridhdbg" align=center >Percentage Achieved</td>
<td class="gridhdbg" align=center >weightage-5</td>

<td class="gridhdbg"  align=center>Target <%=fin_year %></td>
<td class="gridhdbg" align=center >Achievement <%=fin_year  %></td>
<td class="gridhdbg" align=center >Percentage Achieved</td>
<td class="gridhdbg" align=center >weightage-5</td>

 	
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


	</tr>

<%
Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null;
//StringBuffer programmeNames="";
int vmsctar=0,ftktar=0,vmscachmt=0,ftkachmt=0;
int count=1;
int styleCount=0;
String vmsc[]=null;
String ftk[]=null;
double tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0;
double vmscper=0.0,achmtper=0.0,vmscwght=0.0,ftkper=0.0,ftkwght=0.0;
StringBuffer qry=new StringBuffer();
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();	  
	
	  
	  Hashtable Q1Hash=new Hashtable();
	  qry.delete(0,qry.length());
	  qry.append("select distinct a.dcode,no_of_vwsc_trained,training_to_ftk_kits from rws_work_sch_target_tbl a  where a.fin_year='"+fin_year+"' order by a.dcode");
	 System.out.println("Q1:"+qry);
	  rs2=stmt2.executeQuery(qry.toString());
	  while(rs2.next()){
		  
		  Q1Hash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  /**********************************************/
	  
	  Hashtable Q2Hash=new Hashtable();
	  qry.delete(0,qry.length());
	  qry.append("select distinct a.dcode,sum(VWSC_MEMBERS_TRAINED),sum(USAGE_OF_FTK_KITS) from rws_wq_training_tbl a where fin_year='"+fin_year+"' group by a.dcode,a.fin_year order by a.dcode");
	System.out.println("Q2:"+qry);
	  rs4=stmt4.executeQuery(qry.toString());
	  while(rs4.next())
	  {
		  
		 Q2Hash.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3));
		  
		  
	  }
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }

	  
	  //Printing Report....
	  
	  qry.delete(0,qry.length());
	  qry.append("select d.dcode,d.dname from rws_district_tbl d  where dcode<>'16' ");
	  if(dcode.toString()!=null && !dcode.toString().equals("")){
		  qry.append(" and d.dcode='"+dcode.toString()+"'");
		}
	  qry.append(" order by d.dcode");
	  rs3=stmt3.executeQuery(qry.toString());
	  
	  //String style="";
	
	      Statement sst1=conn.createStatement();
		  Statement sst=conn.createStatement();
		  
		  StringBuffer cnt1=new StringBuffer();
		  StringBuffer cnt2=new StringBuffer();
	  while(rs3.next())
	   {
		  
		  cnt1.delete(0,cnt1.length());
		  cnt1.append(String.valueOf(Q1Hash.get(rs3.getString(1))));
		 if(cnt1.toString()!=null && !cnt1.toString().equals("null") && !cnt1.toString().equals(""))
		 {
			
			 vmsc=cnt1.toString().split("@");
			 vmsctar=Integer.parseInt(vmsc[0]);
			 ftktar=Integer.parseInt(vmsc[1]);
			
			 
		 }
		 else
		 {
			 vmsctar=0;
			 ftktar=0;
			 
		 }
		 
		 cnt2.delete(0,cnt2.length());
		 cnt2.append(String.valueOf(Q2Hash.get(rs3.getString(1))));
		 if(cnt2.toString()!=null &&  !cnt2.toString().equals("null") && !cnt2.toString().equals(""))
		 {   
			 ftk=cnt2.toString().split("@");
			 vmscachmt=Integer.parseInt(ftk[0]);
			 ftkachmt=Integer.parseInt(ftk[1]);
			 
		  
				
		 }
		 else
		 {
			 vmscachmt=0;
			 ftkachmt=0;
			
			
		 }
		 
		 
		
		 
		 
		 
		 
		 
		 if(vmsctar>0)
		 {
		    
		 	 vmscper=((double)vmscachmt * 100  / (double)vmsctar);
			 vmscwght=(vmscper/100)*5;
		 }
		 else{
			 vmsctar=0;
		 }
		 
		 
		 if(ftktar>0)
		 {
			 ftkper=((double)ftkachmt * 100  / (double)ftktar);
			 ftkwght=(ftkper/100)*5;
		 }
		 else
		 {
			 ftktar=0; 
		 }
			 style.delete(0,style.length());
				
		if(styleCount%2==0)
		 {
			 style.append("gridbg1");
		 }else{
			 style.append("gridbg2");
		 }
		 styleCount++;
		 
		
		 
		 
		%>
		
   	  <tr>
   	  
   	  <td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
   	  <td class="<%=style %>"  style="text-align: left;"><%=rs3.getString(2) %></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=vmsctar%></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=vmscachmt%></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(vmscper) %></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(vmscwght)%></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=ftktar%></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=ftkachmt%></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(ftkper) %></td>
   	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(ftkwght)%></td>
   	 
   	  </tr>
	<% 
		 tot1+=vmsctar;
		 tot2+=vmscachmt;
		 tot3+=ftktar;
		 tot4+=ftkachmt;
		 if(tot1>0)
		 {
		 tot5=(tot2*100)/tot1;		 
		 tot6=(tot5/100)*5;
		 }
		 else
		 {
			 tot1=0;
		 }
		 if(tot4>0)
		 {
		 tot7=(tot4*100)/tot3;		 
		 tot8=(tot7/100)*5;
		 }
		 else
		 {
			 tot4=0;
		 }
		 
		 vmsctar=0;
			vmscachmt=0;
			ftktar=0;
			ftkachmt=0;
			
				   
	
       }
  }
  catch(Exception e)
  {
  e.printStackTrace();
}

 %>
 
   <tr>
    <td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot1)%></td>
    <td class="gridhdbg" style="text-align: right;"><%=ndf.format(tot2)%></td>
    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot5)%></td>
    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot6)%></td>
    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot3)%></td>
    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot4)%></td>
	<td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot7)%></td>
    <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(tot8)%></td>
		  
	  </tr>
	
 
</table>
                                        <!-- Grid Table Ends -->


	</td>
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
