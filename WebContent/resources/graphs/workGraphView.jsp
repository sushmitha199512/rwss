<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<!doctype html>
<html>
    <%
        if(session.getAttribute("habCovMap")==null || session.getAttribute("habSancMap")==null || session.getAttribute("distMap")==null)
        {
            response.sendRedirect("http://core.ap.gov.in/");
            return;
        }
        DecimalFormat ndf = new DecimalFormat("####.00");
        HashMap habCovMap = (HashMap) session.getAttribute("habCovMap");
        HashMap habSancMap = (HashMap) session.getAttribute("habSancMap");
        HashMap workCovMap = (HashMap) session.getAttribute("workCovMap");
        HashMap workSancMap = (HashMap) session.getAttribute("workSancMap");
        HashMap costEstMap = (HashMap) session.getAttribute("costEstMap");
        HashMap costExpMap = (HashMap) session.getAttribute("costExpMap");
        HashMap distMap = (HashMap) session.getAttribute("distMap");
        
        //String astArray[] = {"\"CPWS\"","\"PWS\"","\"MPWS\"","\"DP\"","\"HP\"","\"SHP\"","\"OW\"","\"-\"","\"POND\""};
        
        String distCode = request.getParameter("dcode");
        String mode = request.getParameter("mode");
        
        long habToCover = Long.parseLong(habSancMap.get(distCode).toString()) - Long.parseLong(habCovMap.get(distCode).toString());
        long workToCover = Long.parseLong(workSancMap.get(distCode).toString()) - Long.parseLong(workCovMap.get(distCode).toString());
        double costToCover = Double.parseDouble(costEstMap.get(distCode).toString()) - Double.parseDouble(costExpMap.get(distCode).toString());
        
         String distBars = "";
         String habPie = "[[\"Sanctioned Habs\","+habSancMap.get(distCode)+"],"+"[\"Covered Habs\","+habCovMap.get(distCode)+"],"+"[\"To Be Covered\","+habToCover+"]]";
         String workPie = "[[\"Sanctioned Works\","+workSancMap.get(distCode)+"],"+"[\"Completed Works\","+workCovMap.get(distCode)+"],"+"[\"To Be Completed\","+workToCover+"]]";
         
         //System.out.println("cost est:  "+costEstMap.get(distCode));
         //System.out.println("cost exp:  "+costExpMap.get(distCode));
         
         
         String costPie = "[[\"Est. Cost\","+costEstMap.get(distCode)+"],"+"[\"Total Exp.\","+costExpMap.get(distCode)+"],"+"[\"Bal.Est.Cost\","+ndf.format(costToCover)+"]]";
         
//         System.out.println("Habs: "+habPie);
//         System.out.println("Works:  "+workPie);
//         System.out.println("Cost:  "+costPie);
         
        Set keySet2 = distMap.keySet();
         List keyList = new ArrayList(keySet2);
         Collections.sort(keyList);
         
    %>
    <head>
        <meta charset="utf-8">
        <meta name="description" content="A jquery plugin to create simple donut, bar or line charts with dom nodes, style with css.">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>

        <script src="jquery.min.js"></script>
        <link rel="stylesheet" href="cssCharts.css">
        <script src="jquery.chart.js"></script>

        <style>
            /* page specific styles*/
            h1{text-align:center;font-family:sans-serif;font-size:28px;color:#333;padding:40px 0 0 0;}
            h2{text-align:center;font-family:sans-serif;font-size:18px;color:#333;padding:40px 0 0 0;}
            hr{width:60%;height:1px;background:none;border:none;border-bottom:1px dashed rgba(0,0,0,0.1);outline:none;margin:40px auto 60px auto;}

            .desc p{text-align:center;font-size:16px;color:rgba(0,0,0,0.6);padding:20px 0 0 0;font-family:sans-serif;}
            .desc a{color:blue;}
            .wrap{margin:0 auto;width:640px;padding-bottom:100px;}
            #line{width:400px;}
            
          .distbar ul {
                margin-right: 10px !important;
            }
            
            .chart.pie .pie-legend {
                margin-right: 20px !important;
                margin-top: 180px !important;
            }

        </style>
        <script>
            $(document).ready(function() {
                    $("#dcode option[value='<%=distCode%>']").prop('selected', true);
                    $("#dcode").change(function() {
                        $("#graphParams").submit();
                    });
            });
        </script>

    </head>
    <body>
        <form id="graphParams" name="graphParams" action="workGraphView.jsp">
            <input type="hidden" id="mode" name="mode" value="<%=mode%>"/>
        <div class="wrap" style="margin-top: -30px !important; width: 1300px !important; text-align: center !important;">
            <div class="desc" style="text-align: center; font-weight: bold;">
                <br/><br/>
                <font color="#663899" face="Maiandra GD" size="6px"><b>Work Progress Abstract</b></font>
                <br/><font color="#889900" face="Maiandra GD" size="3px">( District: <%=distMap.get(distCode)%> )</font>
                <br/>
            </div>

            <%
                if(mode.equals("Bar"))
                {
            %>
                    <br/>
            <div id="covChart" style="border : 1px double #c67; border-radius: 8px; padding-bottom: 20px !important;">
                <div id="distDiv" style="text-align: center; font-weight: bold; margin-top: 20px !important; ">
                    District Wise Asset Count:&nbsp;
                    <select name="dcode" id="dcode" style="width: 120px !important;">
                        <%
                            for(Object key: keyList)
                            {
                                %>
                                <option value="<%=key%>"><%=distMap.get(key)%></option>
                                <%
                            }
                        %>
                    </select>&nbsp;&nbsp;
                </div>
                <br/><br/><br/>
                <div class="chart" style="position: relative; display: inline-block; width: 650px !important; margin-left: 100px !important; color: #000000 !important;">
                    <ul id="covChartUL" class="bar-chart distbar" data-bars="<%=distBars%>" data-max="" data-unit="" data-width="15"></ul>
                    <p style="transform: rotate(270deg); position: relative;top: 70px;font-weight: bold; margin-left: -600px !important;">ASSET COUNT</p>
                    <p style="margin-left: -10px !important; margin-top: 190px !important; font-size: 12px; text-align: left !important;">
                        CPWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        PWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        MPWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        DP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        HP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        SHP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        OW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        POND<br/></p>
                </div>
                    <br/><br/>
            </div>
            <%
                }
                else if(mode.equals("Pie"))
                {
            %>
            <br/>
            <div id="pieChart" style="padding-bottom: 130px;  border : 1px double #c67; border-radius: 8px; vertical-align: top !important;">
                    <div id="distPieDiv" style=" margin-left: 380px !important;width:480px !important; text-align: center !important; font-weight: bold; margin-top: 50px !important;">
                        District Wise Work Progress : &nbsp;
                        <select name="dcode" id="dcode" style="width: 120px !important;">
                            <%
                                for(Object key: keyList)
                                {
                                    %>
                                    <option value="<%=key%>"><%=distMap.get(key)%></option>
                                    <%
                                }
                            %>
                        </select>&nbsp;&nbsp;
                    </div>
                    <br/>
                    <table>
                        <tr>
                            <td>
                                <h3>Hab Progress</h3>
                                <div class="chart" style="width:250px !important; margin-left: 30px !important; text-align: left !important; ">
                                    <div class="pie-thychart" data-set='<%=habPie%>' data-colors="#6C2773,#728C00,#06D2E7">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h3 style="margin-left: 120px !important;">Work Progress</h3>
                                <div class="chart" style="width:250px !important; margin-left: 180px !important; text-align: left !important;">
                                    <div class="pie-thychart" data-set='<%=workPie%>' data-colors="#6C2773,#728C00,#06D2E7">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h3 style="margin-left: 120px !important;">Expenditures<br/>(Amount in Lakhs)</h3>
                                <div class="chart" style="width:250px !important; margin-left: 180px !important; text-align: left !important;">
                                    <div class="pie-thychart" data-set='<%=costPie%>' data-colors="#6C2773,#728C00,#06D2E7">
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
<!--                    <div class="chart" style="width:250px !important; margin-left: 80px !important; text-align: left !important;">
                        <div class="pie-thychart" data-set='<%=habPie%>' data-colors="#902542,#06D2E7,#6C2773,#4F2919,#57D517,#648367,#0CC53D,#77C9FC">
                        </div>
                    </div>-->
            </div>
            <%
                }
            %>
        </div>
        </form>
        <table height="20px" align="center" style="margin-top: -65px !important;">
            <tr height="1%">
                <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                    Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
                </td>
            </tr>
        </table>
        
        <script>
            $(function () {
                $('.bar-chart').cssCharts({type: "bar"});
                $('.donut-chart').cssCharts({type: "donut"}).trigger('show-donut-chart');
                $('.line-chart').cssCharts({type: "line"});
                $('.pie-thychart').cssCharts({type: "pie"});
            });
        </script>
    </body>
</html>