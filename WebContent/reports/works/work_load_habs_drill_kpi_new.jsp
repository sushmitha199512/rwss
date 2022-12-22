<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<html:html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>   
<style type="text/css">
    body, body a {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 13px !important;
    }
    .btext {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 12px !important;
    }
    .rightPad td {
        padding-right: 3px !important;
    }    
</style>
    <%  String populationType = request.getParameter("populationType");
    	DecimalFormat ndf = new DecimalFormat("####.00");
        String ccode = request.getParameter("ccode");
        String cname = request.getParameter("cname");
        String programme = request.getParameter("programme");
        String programmeName = request.getParameter("programmeName");
        String mode = request.getParameter("mode");
       // System.out.println("mode   "+mode);
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String year = request.getParameter("year");
        String divcode=request.getParameter("divCode");
        //System.out.println("divcode"+divcode);
        String subdivcode=request.getParameter("subdivcode");
        String divname=request.getParameter("divname");
        String subdivname=request.getParameter("subdivname");
        String workid=request.getParameter("workid");
        WorksData1 data1 = new WorksData1();
        int cyear = Calendar.getInstance().get(Calendar.YEAR);
        int nmonth= Calendar.getInstance().get(Calendar.MONTH) +2;
        int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
        int lMonth = Calendar.getInstance().get(Calendar.MONTH);
        int day = Calendar.getInstance().get(Calendar.DATE);
        String currentMonth = data1.getCurrentMonth(month);
        // System.out.println("currentMonth"+currentMonth);
        String nextMonth="";
if (currentMonth.equals("DEC")) {
	nextMonth = "JAN-" + (cyear + 1);
} else {
	nextMonth = data1.getCurrentMonth(nmonth) + "-" + cyear;
}
        String lastMonth = "";
        if (currentMonth.equals("JAN")) {
            lastMonth = "DEC-" + (cyear - 1);
        } else {
            lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
        }
        String cDate = day + "-" + currentMonth + "-" + cyear;
        int ys = 0;
        int ye = 0;
        int nextYear=0;
        if (month <= 3) {
        	ys = cyear - 1;
            ye = cyear;
        } else {
        	ys = cyear;
            ye = cyear + 1;
        } 
        nextYear = ye+1;
        
        if(request.getParameter("yearStart") != null && !request.getParameter("yearStart").equals("0"))
        	ys = Integer.parseInt(request.getParameter("yearStart"));
        if(request.getParameter("yearEnd") != null && !request.getParameter("yearEnd").equals("0")){
        	ye = Integer.parseInt(request.getParameter("yearEnd"));
        	nextYear = ye+1;
        }
        	
           %>
    <br/><br/>
       <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>
            <br/>
           <%if(mode.equals("tarFC")){ %>
            Target FC Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarPC4")){ %>
            Target PC4 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarPC3")){ %>
            Target PC3 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarPC2")){ %>
            Target PC2 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarPC1")){ %>
            Target PC1 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNC")){ %>
            Target NC Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarQA")){ %>
            Target QA Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tar")){ %>
            Target Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYFC")){ %>
            Target FC Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYPC4")){ %>
            Target PC4 Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYPC3")){ %>
            Target PC3 Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYPC2")){ %>
            Target PC2 Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYPC1")){ %>
           Target PC1 Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYNC")){ %>
            Target NC Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNYQA")){ %>
            Target QA Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("tarNY")){ %>
            Target Habitations (<%=ye %>-<%=nextYear %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYFC")){ %>
            Achieved FC Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYPC4")){ %>
            Achieved PC4 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYPC3")){ %>
            Achieved PC3 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYPC2")){ %>
            Sactioned PC2 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYPC1")){ %>
            Achieved PC1 Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYNC")){ %>
            Achieved NC Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCYQA")){ %>
            Achieved QA Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achCY")){ %>
            Achieved Habitations (<%=ys %>-<%=ye %>) in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }
            if(workid==null){}
            else{%>
           	 And Work Id : <%=workid%>
            <%}  %>
            <br/> </b></font>
            <!-- <br/><br/><font color="#889900" face="Maiandra GD" size="3px">(Amount in Lakhs)</font> -->
        </center>
    <br/>
            <table align="center" style="margin-top: -35px !important; width: 1200px !important;  text-align: center !important;">
                <tr>
                    <td style="width: 1000px !important;"></td>
                    <td style="width: 100px !important;" align="right">
                        <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="30px"/></a>&nbsp;&nbsp; 
                    </td> 
                    <td style="width: 100px !important;" align="right">
                        <a href="#" onClick="window.close();"><img src="/pred/resources/graphs/close.png" height="30px"/></a>&nbsp;&nbsp; 
                    </td>
                </tr>
            </table>
     
          <table width="1200px" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
           <tr align=center>
            <td class=gridhdbg ><b>SNO</b></td>
            <td class=gridhdbg ><b>District</b></td>
            <td class=gridhdbg ><b>Mandal</b></td>
            <td class=gridhdbg ><b>Panchayat</b></td>
            <td class=gridhdbg ><b>Village</b></td>
            <td class=gridhdbg ><b>Habitation Code</b></td>
            <td class=gridhdbg ><b>Habitation Name</b></td>
            <td class=gridhdbg ><b>Coverage Status</b></td>
            <td class=gridhdbg ><b>Total Population</b></td>
        </tr>
        <%
        String schemes = "'01','02','03','10'";
            Statement statement = null;
            ResultSet resultSet = null;
            try {
             if(mode.equals("tarFC")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
		       }else if(mode.equals("tarPC4")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		       }else if(mode.equals("tarPC3")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		       }else if(mode.equals("tarPC2")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
		       }else if(mode.equals("tarPC1")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		       }else if(mode.equals("tarNC")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		       }else if(mode.equals("tarQA")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
		       }else if(mode.equals("tar")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"')  and TARGET_DATE_COMP>='01-APR-"+ys+"' and TARGET_DATE_COMP<='31-MAR"+ye+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		       }else if(mode.equals("tarNYFC")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
		       }else if(mode.equals("tarNYPC4")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		       }else if(mode.equals("tarNYPC3")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		       }else if(mode.equals("tarNYPC2")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
		       }else if(mode.equals("tarNYPC1")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		       }else if(mode.equals("tarNYNC")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		       }else if(mode.equals("tarNYQA")){ 
		    	   query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
				}else if(mode.equals("tarNY")){ 
			 		query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"+ye+"' and  TARGET_DATE_COMP<='31-MAR-"+nextYear+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		 		}else if(mode.equals("achCYFC")){ 
			 		query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
		 		}else if(mode.equals("achCYPC4")){ 
			 		query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
		 		}else if(mode.equals("achCYPC3")){ 
		 			query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
		 		}else if(mode.equals("achCYPC2")){ 
		 			query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
				}else if(mode.equals("achCYPC1")){ 
					query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
		 		}else if(mode.equals("achCYNC")){ 
		 			query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
		 		}else if(mode.equals("achCYQA")){ 
		 			query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
				}else if(mode.equals("achCY")){ 
					query = "select distinct b.hab_code from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"+ys+"' and DATE_OF_COMPLETION<='31-MAR-"+ye+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"+ys+"' and partial_date_of_completion <='31-MAR-"+ye+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
				}
		 		 if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
      		   	   query += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
         			}	
                 if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
              	   query += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
         			}
                 if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
              	   query += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
         			}
               if(ccode!=null){
               	query+=" and substr(a.office_code,2,2)='"+ccode+"'";
           		}
               if(divcode!=null){
           		query+="  and substr(a.office_code,4,1)='"+divcode+"'";
           		}
               if(subdivcode!=null){
           		query+="  and substr(a.office_code,5,2)='"+subdivcode+"'";
           		}
              if(workid==null){}
              else{
             	 query+=" and a.work_id='"+workid+"'";
              }	
			//System.out.println(query);
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {
                    String hab_code = rs1.getString(1);
                    String habDetails = "select sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),COVERAGE_STATUS from rws_habitation_directory_tbl where hab_code='"
                            + hab_code + "' group by COVERAGE_STATUS";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habDetails);
                    int population = 0;
                    String covStatus = "";
                    if (resultSet.next()) {
                        population = resultSet.getInt(1);
                        covStatus = resultSet.getString(2);
                    }
                    resultSet.close();
                    statement.close();
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;

                    /* String details = "select dname,mname,pname,vname,panch_code,panch_name  from rws_complete_hab_view where panch_code='" + hab_code + "'"; */
                    String details="select dname,mname,pname,vname,panch_name,panch_code from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c,rws_village_tbl d,rws_panchayat_raj_tbl e where a.dcode=b.dcode and a.dcode=c.dcode and a.dcode=d.dcode and a.dcode=substr(e.panch_code,1,2) and b.mcode=c.mcode and b.mcode=d.mcode and b.mcode=substr(e.panch_code,6,2) and c.pcode=d.pcode and c.pcode=substr(e.panch_code,13,2) and d.vcode=substr(e.panch_code,8,3) and e.panch_code='"+hab_code+"'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(details);

                    if (resultSet.next()) {
        %>

        <tr>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(1)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(4)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(5)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(6)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=covStatus%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=population%></td>
        </tr>

        <%
                        } else {
                           // System.out.println(hab_code);
                        }
                        statement.close();
                        resultSet.close();
                    }
                    st.close();
                    rs1.close();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
        %>
    </table>

</html:html>
