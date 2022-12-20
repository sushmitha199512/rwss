<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<html:html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css"> 
    </head>      
    <%   
        String asset_code = request.getParameter("asset_code");
    	String typeOfasset=request.getParameter("typeOfasset");
    	
    %>
    <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
        <caption>
        <br>
        <br>
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
    <table  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >     
        <tr align=center>
            <td class=gridhdbg ><b>SNO</b></td>
            <td class=gridhdbg ><b>District</b></td>
            <td class=gridhdbg ><b>Mandal</b></td>
            <td class=gridhdbg ><b>Panchayat</b></td>
            <td class=gridhdbg ><b>Village</b></td>
            <td class=gridhdbg ><b>Habitation Code&nbsp;/</b><br>Habitation Name</td>
            <td class=gridhdbg><b>Source Code&nbsp;/</b><br>Source Name</b></td>		
            <td class=gridhdbg><b>Status</b></td>	
			<td class=gridhdbg><b>Prepared&nbsp;On </b></td>
			<td class=gridhdbg><b>Fluoride</b></td>
			<td class=gridhdbg><b>Iron</b></td>
			<td class=gridhdbg><b>Salinity</b></td>
			<td class=gridhdbg><b>Nitrate</b></td>       
        </tr>
        	<%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
            	int count = 1;
            	int styleCount = 0;
                String style = "";
                String query="";
               // System.out.println("nbjbdfjkdsfjnh"+typeOfasset);
               if(typeOfasset.equals("04")){
                	query="select dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,HP_CODE as SOURCE_CODE,'Handpump' as SOURCE_NAME,decode(STATUS,'W','Working','N','Not Working','D','DRIED','S','SEASONAL','C','CONDEMED') as status from RWS_HP_SUBCOMP_PARAM_TBL b,RWS_COMPLETE_HAB_VIEW c where substr(b.HP_CODE,1,16)=c.PANCH_CODE and b.ASSET_CODE='"+asset_code+"'";
    			}else if(typeOfasset.equals("05")){
    				query="select dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,SHALLOWHP_CODE as SOURCE_CODE,'Shallow Handpump' as SOURCE_NAME,decode(STATUS,'W','Working','N','Not Working','D','DRIED','S','SEASONAL','C','CONDEMED') as status from RWS_SHALLOWHANDPUMPS_TBL b,RWS_COMPLETE_HAB_VIEW c where substr(b.SHALLOWHP_CODE,1,16)=c.PANCH_CODE and b.ASSET_CODE='"+asset_code+"'";
    			}else{		   			
		   			query="select dname,mname,pname,vname,PANCH_CODE,PANCH_NAME,SOURCE_CODE,nvl(SOURCE_NAME,'SOURCE') as SOURCE_NAME,decode(STATUS,'W','Working','N','Not Working','D','DRIED','S','SEASONAL','C','CONDEMED') as status from RWS_SOURCE_TBL b,RWS_COMPLETE_HAB_VIEW c where b.hab_code=c.PANCH_CODE and b.ASSET_CODE='"+asset_code+"'";
    			} 
                
                System.out.println("typeOfasset "+query);
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()){                	
                	if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;   
                    
                    String mxDateQry="select nvl(to_char(max(prepared_on),'dd/mm/yyyy'),'--') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code='"+rs1.getString("SOURCE_CODE")+"' order by max(prepared_on) desc";
                    System.out.println("gfhhgh"+mxDateQry);
                    Statement stmt1 = conn.createStatement();
                    ResultSet rs2 = stmt1.executeQuery(mxDateQry);
                    String maxDate="";
                    String flouride="",iron="",nitrate="",Salinity="";
                    if(rs2.next()){                    	
                    	maxDate=rs2.getString(1);
                    	if(!maxDate.equals("--")){
                    	String testQry="SELECT A.TESTING_PARAMETER_CODE,nvl(A.TESTING_PARAMETER_VALUE,'0') as TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1'  AND SOURCE_CODE='"+rs1.getString("SOURCE_CODE")+"' AND B.PREPARED_ON=to_date('"+rs2.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE in('13','16','15','05')";
                    	System.out.println(rs2.getString(1));
                    	Statement stmt2 = conn.createStatement();
                        ResultSet rs3 = stmt2.executeQuery(testQry);
                        while(rs3.next()){
                        	if(rs3.getString("TESTING_PARAMETER_CODE").equals("13")){
                        		flouride=rs3.getString("TESTING_PARAMETER_VALUE");
                        	}else if(rs3.getString("TESTING_PARAMETER_CODE").equals("16")){
                        		iron=rs3.getString("TESTING_PARAMETER_VALUE");
                        	}else if(rs3.getString("TESTING_PARAMETER_CODE").equals("15")){
                        		nitrate=rs3.getString("TESTING_PARAMETER_VALUE");
                        	}else if(rs3.getString("TESTING_PARAMETER_CODE").equals("05")){
                        		Salinity=rs3.getString("TESTING_PARAMETER_VALUE");
                        	}
                        }rs3.close();
                        stmt2.close();
                    	}
                    }rs2.close();
                    stmt1.close();                          
                %>
                <tr>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("dname")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("mname")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("pname")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("vname")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("PANCH_CODE")%>&nbsp;/<br><%=rs1.getString("PANCH_NAME")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("SOURCE_CODE")%>&nbsp;/<br><%=rs1.getString("SOURCE_NAME")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("status") %></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=maxDate %></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=flouride %></td>  
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=iron %></td>  
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=Salinity %></td>  
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=nitrate %></td>                  
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
                        e.printStackTrace();
                    }
                }
            
        	%>
    </table>
</html:html>
