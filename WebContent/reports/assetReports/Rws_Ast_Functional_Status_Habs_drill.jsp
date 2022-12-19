<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<html:html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css"> 
    </head>      
    <%   
        String asset_code = request.getParameter("asset_code");
    %>
    <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
        <caption>
        <br><br>
            <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
                <a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
                <a href="#" onClick="window.close();">Close</a>
            </table>
            <br>
        </caption>
        <tr  align="center">
            <td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg > </td>
        </tr>
    </table>
    <table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >     
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
            Statement statement = null;
            ResultSet resultSet = null;
            try {
            	int count = 1;
            	int styleCount = 0;
                String style = "";
                String query="select  dname,mname,pname,vname,b.PANCH_CODE,b.PANCH_NAME,b.COVERAGE_STATUS,nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0) as pop from RWS_ASSET_HAB_TBL a,RWS_COMPLETE_HAB_VIEW b where a.HAB_CODE=b.PANCH_CODE and a.ASSET_CODE='"+asset_code+"'";
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()){                	
                	if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;
                %>
                <tr>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(1)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(2)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(3)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(4)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(6)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(5)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("COVERAGE_STATUS")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("pop")%></td>                  
                </tr>
                <%
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
                        //e.printStackTrace();
                    }
                }
            
        	%>
    </table>
</html:html>
