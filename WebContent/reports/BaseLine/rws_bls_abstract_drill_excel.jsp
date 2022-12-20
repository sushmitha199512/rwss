

<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<form>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "base line survey drill.xls");

String type=(String)session.getAttribute("type");
String dcode=(String)session.getAttribute("dcode");
String mcode=(String)session.getAttribute("mandal");
int gtot=0,gtot1=0,gtot2=0,gtot3=0;	
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="85%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	
	    
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Base Line Survey - Detailed Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation /<Br>Habitation Code </td>
  <%  
    if(type.equals("3")){
  %>
    <td class=gridhdbg rowspan=2>Building Name </td>
    <td class=gridhdbg rowspan=2>Latrine Facility<br>(Yes)</td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
  <% 
   }
   else if(type.equals("4")){
   %>
    <td class=gridhdbg rowspan=2>Building Name </td>
    <td class=gridhdbg rowspan=2>Latrine Facility<br>(No) </td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
    <%
   }
   else if(type.equals("5")){
    %>
    <td class=gridhdbg rowspan=2>Building Name </td>
    <td class=gridhdbg rowspan=2>Water Facility<br>(Yes) </td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
   <%
   }
   else if(type.equals("6")){
   %>
    <td class=gridhdbg rowspan=2>Building Name </td>
    <td class=gridhdbg rowspan=2>Water Facility<br>(No) </td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
    <%
   }
     else if(type.equals("7")){
    %>
    <td class=gridhdbg rowspan=2>VWSC is Formed <br>(Yes)</td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
   <%
    }
    else if(type.equals("8")){
   %>
    <td class=gridhdbg rowspan=2>VWSC is Formed <br>(No)</td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
    <%
    }
    else if(type.equals("9")){
	  %>
      <td class=gridhdbg rowspan=2>VWSC is Functional<br>(Yes) </td>
	 <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	 }
	else if(type.equals("10")){
	 %>
    <td class=gridhdbg rowspan=2>VWSC is Functional	<br>(No) </td>
	<td class=gridhdbg rowspan=2>Survey Date </td>
	 <%
	   }
   else if(type.equals("11")){
     %>
    <td class=gridhdbg rowspan=2>Total CSC Constructed </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
   <%
     }	    
  else if(type.equals("12")){
   %>
   <td class=gridhdbg rowspan=2>Total Functional CSC</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	 }
  else if(type.equals("13")){
	 %>
   <td class=gridhdbg rowspan=2>Total Defunct CSC </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("14")){
	 %>
   <td class=gridhdbg rowspan=2>No.of Additional CSC Required</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("15")){
     %>
   <td class=gridhdbg rowspan=2>NGOS<br>(Yes) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
   <%
     }	    
  else if(type.equals("16")){
   %>
     <td class=gridhdbg rowspan=2>NGOS<br>(No) </td>
     <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	 }
  else if(type.equals("17")){
	 %>
   <td class=gridhdbg rowspan=2>SHGS<br>(Yes) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("18")){
	 %>
   <td class=gridhdbg rowspan=2>SHGS<br>(No) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("19")){
     %>
   <td class=gridhdbg rowspan=2>Women Groups <br>(Yes) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
   <%
     }	    
  else if(type.equals("20")){
   %>
   <td class=gridhdbg rowspan=2>Women Groups<br>(No) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	 }
  else if(type.equals("21")){
	 %>
   <td class=gridhdbg rowspan=2>Other Groups /<br>(Yes) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("22")){
	 %>
   <td class=gridhdbg rowspan=2>Other Groups /<br>(No) </td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
   }
   else if(type.equals("23")){
     %>
   <td class=gridhdbg rowspan=2>Total StandPosts  </td>
   <td class=gridhdbg rowspan=2>Seasonal </td>
   <td class=gridhdbg rowspan=2>Through out Year</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
   <%
     }	    
  else if(type.equals("24")){
   %>
   <td class=gridhdbg rowspan=2>Total Households  </td>
   <td class=gridhdbg rowspan=2>Seasonal </td>
   <td class=gridhdbg rowspan=2>Through out Year</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
   <% 
	 }
  else if(type.equals("25")){
	 %>
   <td class=gridhdbg rowspan=2>Total Multi StandPost  </td>
   <td class=gridhdbg rowspan=2>Seasonal </td>
   <td class=gridhdbg rowspan=2>Through out Year</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
   <% 
	}
   else if(type.equals("26")){
	 %>
   <td class=gridhdbg rowspan=2>Total Multi Households</td>
   <td class=gridhdbg rowspan=2>Seasonal </td>
   <td class=gridhdbg rowspan=2>Through out Year</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("27")){
	 %>
   <td class=gridhdbg rowspan=2>Total Pumps </td>
   <td class=gridhdbg rowspan=2>Seasonal </td>
   <td class=gridhdbg rowspan=2>Through out Year</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   else if(type.equals("28")){
	 %>
  <td class=gridhdbg rowspan=2>Total OpenWell	 </td>
   <td class=gridhdbg rowspan=2>Seasonal </td>
   <td class=gridhdbg rowspan=2>Through out Year</td>
   <td class=gridhdbg rowspan=2>Survey Date </td>
	<%
	}
   %>
    
	</tr>
	<tr>
       </tr>
       
<%
try
{
	


   //main qry
   Statement stmt3=null;
   ResultSet rs3=null;
   int sno=1;
   stmt3=conn.createStatement();
 //Water Facility queries
   
   if(type.equals("23")){
	   String waterfacqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_STANDPOSTS,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl  b where a.panch_code=b.habitation_code  ";

	    if(dcode!=null && !dcode.equals("00")){
	      waterfacqry+="and dcode='"+dcode+"'";
	    }
	    waterfacqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs3=stmt3.executeQuery(waterfacqry);
	   }
   if(type.equals("24")){
	   String waterfacqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_HOUSEHOLDS,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl  b where a.panch_code=b.habitation_code  ";

	    if(dcode!=null && !dcode.equals("00")){
	      waterfacqry+="and dcode='"+dcode+"'";
	    }
	    waterfacqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs3=stmt3.executeQuery(waterfacqry);
	   }
   if(type.equals("25")){
	   String waterfacqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_MULTI_STANDPOST,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl  b where a.panch_code=b.habitation_code  ";

	    if(dcode!=null && !dcode.equals("00")){
	      waterfacqry+="and dcode='"+dcode+"'";
	    }
	    waterfacqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs3=stmt3.executeQuery(waterfacqry);
	   }
   if(type.equals("26")){
	   String waterfacqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_MULTI_HOUSEHOLDS,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl  b where a.panch_code=b.habitation_code  ";

	    if(dcode!=null && !dcode.equals("00")){
	      waterfacqry+="and dcode='"+dcode+"'";
	    }
	    waterfacqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs3=stmt3.executeQuery(waterfacqry);
	   }
   if(type.equals("27")){
	   String waterfacqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_PUMPS,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl  b where a.panch_code=b.habitation_code  ";

	    if(dcode!=null && !dcode.equals("00")){
	      waterfacqry+="and dcode='"+dcode+"'";
	    }
	    waterfacqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs3=stmt3.executeQuery(waterfacqry);
	   }
   if(type.equals("28")){
	   String waterfacqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_OPENWELL,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl  b where a.panch_code=b.habitation_code  ";

	    if(dcode!=null && !dcode.equals("00")){
	      waterfacqry+="and dcode='"+dcode+"'";
	    }
	    waterfacqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs3=stmt3.executeQuery(waterfacqry);
	   }
     
 //govt queries
 if(type.equals("3")){
 String govtqry="select dname,mname,pname,vname,panch_name,panch_code,BLDG_NAME,LATRINE_FACILITY,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,RWS_BLS_GOVTBLDG_INGP_TBL  b where a.panch_code=b.habitation_code and LATRINE_FACILITY='Yes' ";

  if(dcode!=null && !dcode.equals("00")){
	govtqry+="and dcode='"+dcode+"'";
  }
govtqry+="order by dcode,mcode,pcode,vcode,panch_code";
 rs3=stmt3.executeQuery(govtqry);
 }

 if(type.equals("4")){
	 String govtqry="select dname,mname,pname,vname,panch_name,panch_code,BLDG_NAME,LATRINE_FACILITY,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,RWS_BLS_GOVTBLDG_INGP_TBL  b where a.panch_code=b.habitation_code and LATRINE_FACILITY='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		govtqry+="and dcode='"+dcode+"'";
	  }
	govtqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(govtqry);
	 }	 
	
 if(type.equals("5")){
	 String govtqry="select dname,mname,pname,vname,panch_name,panch_code,BLDG_NAME,WATER_FACILITY,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,RWS_BLS_GOVTBLDG_INGP_TBL  b where a.panch_code=b.habitation_code and WATER_FACILITY='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		govtqry+="and dcode='"+dcode+"'";
	  }
	govtqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(govtqry);
	 }	 
 
 if(type.equals("6")){
	 String govtqry="select dname,mname,pname,vname,panch_name,panch_code,BLDG_NAME,WATER_FACILITY,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,RWS_BLS_GOVTBLDG_INGP_TBL  b where a.panch_code=b.habitation_code and WATER_FACILITY='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		govtqry+="and dcode='"+dcode+"'";
	  }
	govtqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(govtqry);
	 }	
 
 ///vwm qry
 if(type.equals("7")){
	 String vwmqry="select dname,mname,pname,vname,panch_name,panch_code,VWSC_FORMED,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_vwm_comm_tbl b where a.panch_code=b.habitation_code and VWSC_FORMED='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		  vwmqry+="and dcode='"+dcode+"'";
	  }
	  vwmqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(vwmqry);
	 }	 
 if(type.equals("8")){
	 String vwmqry="select dname,mname,pname,vname,panch_name,panch_code,VWSC_FORMED,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_vwm_comm_tbl b where a.panch_code=b.habitation_code and VWSC_FORMED='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		  vwmqry+="and dcode='"+dcode+"'";
	  }
	  vwmqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(vwmqry);
	 }	
 if(type.equals("9")){
	 String vwmqry="select dname,mname,pname,vname,panch_name,panch_code,VWSM_FUNCTIONAL,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_vwm_comm_tbl b where a.panch_code=b.habitation_code and VWSM_FUNCTIONAL='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		  vwmqry+="and dcode='"+dcode+"'";
	  }
	  vwmqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(vwmqry);
	 }	
 if(type.equals("10")){
	 String vwmqry="select dname,mname,pname,vname,panch_name,panch_code,VWSM_FUNCTIONAL,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_vwm_comm_tbl b where a.panch_code=b.habitation_code and VWSM_FUNCTIONAL='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		  vwmqry+="and dcode='"+dcode+"'";
	  }
	  vwmqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(vwmqry);
	 }	
 
 //Community Sanitation qry
 if(type.equals("11")){
	 String commsantnqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_CSC_CONSTRUCTED,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_comm_sani_comp_tbl b where a.panch_code=b.habitation_code  ";

	  if(dcode!=null && !dcode.equals("00")){
		  commsantnqry+="and dcode='"+dcode+"'";
	  }
	  commsantnqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(commsantnqry);
	 }	
 if(type.equals("12")){
	 String commsantnqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_FUNCTIONAL_CSC,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_comm_sani_comp_tbl b where a.panch_code=b.habitation_code  ";

	  if(dcode!=null && !dcode.equals("00")){
		  commsantnqry+="and dcode='"+dcode+"'";
	  }
	  commsantnqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(commsantnqry);
	 }	
 if(type.equals("13")){
	 String commsantnqry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_DEFUNCT_CSC,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_comm_sani_comp_tbl b where a.panch_code=b.habitation_code ";

	  if(dcode!=null && !dcode.equals("00")){
		  commsantnqry+="and dcode='"+dcode+"'";
	  }
	  commsantnqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(commsantnqry);
	 }	
 if(type.equals("14")){
	 String commsantnqry="select dname,mname,pname,vname,panch_name,panch_code,NO_OFF_ADDL_CSC_REQ,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_comm_sani_comp_tbl b where a.panch_code=b.habitation_code ";

	  if(dcode!=null && !dcode.equals("00")){
		  commsantnqry+="and dcode='"+dcode+"'";
	  }
	  commsantnqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(commsantnqry);
	 }	
 
 //other orns qry
 
 if(type.equals("15")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,ngos,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and ngos='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 if(type.equals("16")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,ngos,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and ngos='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 if(type.equals("17")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,shgs,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and shgs='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 if(type.equals("18")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,shgs,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and shgs='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 if(type.equals("19")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,women_grps,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and women_grps='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 if(type.equals("20")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,women_grps,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and women_grps='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 if(type.equals("21")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,other_grps,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and other_grps='Yes' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 
 if(type.equals("22")){
	 String othrorgqry="select dname,mname,pname,vname,panch_name,panch_code,other_grps,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl b where a.panch_code=b.habitation_code and other_grps='No' ";

	  if(dcode!=null && !dcode.equals("00")){
		  othrorgqry+="and dcode='"+dcode+"'";
	  }
	  othrorgqry+="order by dcode,mcode,pcode,vcode,panch_code";
	 rs3=stmt3.executeQuery(othrorgqry);
	 }	
 //Other orgn qry
 
 
 
 
   while(rs3.next())
   {
   	
		
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(1)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(2)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(3)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(4)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(5)%>/<br>&nbsp;<%=rs3.getString(6)%></br></td>
 <%
  if(type.equals("3")||type.equals("4")||type.equals("5")||type.equals("6"))
  {
 %>  
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(7)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(8)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(9)%></td> 
<% 
}
  else if(type.equals("7")||type.equals("8")||type.equals("9")||type.equals("10")||type.equals("11")||type.equals("12")||type.equals("13")||type.equals("14")||type.equals("15")||type.equals("16")||type.equals("17")||type.equals("18")||type.equals("19")||type.equals("20")||type.equals("21")||type.equals("22"))
  {
 %>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(7)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(8)%></td>
<%
  }
  else if(type.equals("23")||type.equals("24")||type.equals("25")||type.equals("26")||type.equals("27")||type.equals("28"))
  {
 %>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(7)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(8)!=null && rs3.getString(8).equals("NULL")?"0":rs3.getString(8)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(9)!=null && rs3.getString(9).equals("NULL")?"0":rs3.getString(9)%></td> 
<td  class="<%=style%> "style="text-align: left;"> <%=rs3.getString(10)%></td> 
<%
  }
%>

 </tr>
 <% 
 if(type.equals("11")||type.equals("12")||type.equals("13")||type.equals("14"))
 {
gtot+=Integer.parseInt(rs3.getString(7)); 
 }
 if(type.equals("23")||type.equals("24")||type.equals("25")||type.equals("26")||type.equals("27")||type.equals("28"))
 {
gtot1+=Integer.parseInt(rs3.getString(7)); 
gtot2+=Integer.parseInt(rs3.getString(8)!=null && rs3.getString(8).equals("NULL")?"0":rs3.getString(8)); 
gtot3+=Integer.parseInt(rs3.getString(9)!=null && rs3.getString(9).equals("NULL")?"0":rs3.getString(9)); 
 }
}
   
 //Other orgn qry
   
	
 if(type.equals("11")||type.equals("12")||type.equals("13")||type.equals("14"))
 {

 
	 %>
 
<tr>
	<td align="center" class="gridhdbg" colspan="6">Grand Total</td>
	<td style="text-align: left;" class="gridhdbg" colspan="2"><%=gtot%></td>   	
 </tr>	
 
<%
 }
 if(type.equals("23")||type.equals("24")||type.equals("25")||type.equals("26")||type.equals("27")||type.equals("28"))
 {

 
	 %>
 
<tr>
	<td align="center" class="gridhdbg" colspan="6">Grand Total</td>
	<td style="text-align: left;" class="gridhdbg"><%=gtot1%></td>
	<td style="text-align: left;" class="gridhdbg"><%=gtot2%></td>
	<td style="text-align: left;" class="gridhdbg" colspan="2"><%=gtot3%></td>   	
 </tr>	
 
<%
 }
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>


</center></form>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>