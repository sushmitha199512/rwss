<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<!doctype html>
<html>
    <%
        if(session.getAttribute("distInfo")==null || session.getAttribute("covInputs")==null || session.getAttribute("distInputMap")==null || session.getAttribute("distInputStr")==null)
        {
            response.sendRedirect("http://core.ap.gov.in/");
            return;
        }
        HashMap mapCov = (HashMap) session.getAttribute("covInputs");
        HashMap mapDist = (HashMap) session.getAttribute("distInputMap");
        String distInputs = (String) session.getAttribute("distInputStr");
        String statePie = (String) session.getAttribute("statePie");
        HashMap mapDistDet = (HashMap) session.getAttribute("distInfo");
        
        String distArray[] = {"\"SKLM\"","\"VZM\"","\"VSP\"","\"EG\"","\"KRI\"","\"GTR\"","\"PRK\"","\"NLR\"","\"CTR\"","\"KDP\"","\"ATP\"","\"KNL\""};
        String covArray[] = {"\"FC\"","\"PC4\"","\"PC3\"","\"PC2\"","\"PC1\"","\"NC\"","\"NSS\""};
        
        String distCode = request.getParameter("dcode");
        String covCode = request.getParameter("cov");
        String mode = request.getParameter("mode");
        
         String covBars = (String) mapCov.get(distCode);
         
         System.out.println("1111111111111111111CovBar: "+covBars);
         
         String distPie = "";
         String covPie = "";
         if(mode.equals("Pie"))
         {
            String distBars = (String) mapDist.get(covCode);
            String distInputsArray[] = distBars.split(",");
            for(int i=0;i<distArray.length;i++)
            {
                distPie += "["+distArray[i]+","+distInputsArray[i].substring(1,distInputsArray[i].length()-1)+"],";
            }
           distPie = "["+distPie.substring(0,distPie.length()-1)+"]";
         }
         
        String covInputsArray[] = covBars.split(",");
         for(int i=0;i<covArray.length;i++)
         {
             covPie += "["+covArray[i]+","+covInputsArray[i].substring(1,covInputsArray[i].length()-1)+"],";
         }
        covPie = "["+covPie.substring(0, covPie.length()-1)+"]";
        
        
        
         Set keySet2 = mapDistDet.keySet();
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
       /*       .distbar ul li span {
                background-color: #ff3800 !important;
            }
            .distbar ul li:hover span {
                box-shadow:0 0 0 4px #ff3800 !important;
            } */
            
            /* page specific styles*/

        </style>
        <script>
            $(document).ready(function() {
                    $("#dcode option[value='<%=distCode%>']").prop('selected', true);
                    $("#cov option[value='<%=covCode%>']").prop('selected', true);
                    $("#dcode").change(function() {
                        $("#graphParams").submit();
                    });
                    $("#cov").change(function() {
                        $("#graphParams").submit();
                    });
            });
        </script>

    </head>
    <body>
        <form id="graphParams" name="graphParams" action="graphView.jsp">
            <input type="hidden" id="mode" name="mode" value="<%=mode%>"/>
        <div class="wrap" style="margin-top: -30px !important; width: 1300px !important; text-align: center !important;">
            <div class="desc" style="text-align: center; font-weight: bold;">
                <br/><br/>
                <font color="#663899" face="Maiandra GD" size="6px"><b>Habitation Coverage - Yearly Status</b></font>
                <br/><br/>
            </div>

            <%
                if(mode.equals("Bar"))
                {
            %>
            
            <div id="distChart" style=" padding-left: 30px;  padding-bottom: 50px;   padding-top: 20px; border : 1px double #c67; border-radius: 8px;">
                <p style="font-weight: normal; text-align: center;">
                    <span style="background-color: #728C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;FC (Fully Covered)&nbsp;&nbsp;&nbsp;&nbsp;
                   <span style="background-color: #F88017;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;PC (Partially Covered)&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;NSS (No Safe Source)
                </p>
                <br/>
                <div class="chart" style="left: 30px !important; ">
                    <ul id="distChartUL" class="bar-chart" data-bars="<%=distInputs%>" data-max="" data-unit="" data-width="9"></ul>
                    <p style="transform: rotate(270deg);position: relative;top: 70px; left: -480px;font-weight: bold;	margin-left: -40px !important;";>HABITATIONS COUNT</p>
                    <p style="margin-left: 5px !important;">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                    SKLM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    VZM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    VSP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    EG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    WG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    KRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    GTR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    PRK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    NLR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    CTR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    KDP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   ATP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    KNL</p>
                </div>
            </div>
                    <br/>
            <div id="covChart" style="border : 1px double #c67; border-radius: 8px; padding-bottom: 20px !important;">
                <div id="distDiv" style="text-align: center; font-weight: bold; margin-top: 20px !important; ">
                    District Wise Coverage Status:&nbsp;
                    <select name="dcode" id="dcode" style="width: 120px !important;">
                        <%
                            for(Object key: keyList)
                            {
                                %>
                                <option value="<%=key%>"><%=mapDistDet.get(key)%></option>
                                <%
                            }
                        %>
<!--                        <option value="12">ANANTAPUR</option>
                        <option value="10">CHITTOR</option>-->
                    </select>&nbsp;&nbsp;
                </div>
                <br/><br/>
                <div class="chart" style="position: relative; display: inline-block; width: 650px !important; margin-left: 100px !important;">
                    <ul id="covChartUL" class="bar-chart distbar" data-bars="<%=covBars%>" data-max="" data-unit="" data-width="15"></ul>
                    <p style="transform: rotate(270deg); position: relative;top: 70px;font-weight: bold; margin-left: -500px !important;">HABITATIONS COUNT</p>
                    <p style="margin-left: 0px !important; margin-top: 190px !important; font-size: 12px; text-align: left !important;">
                        FC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        PC4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        PC3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        PC2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        PC1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        NS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        NSS<br/></p>
                </div>
                <div style=" width: 250px; vertical-align: top; margin-left: 50px; position: relative; display: inline-block;">
                    <fieldset style="text-align: left !important; padding: 10px; padding-left: 20px; letter-spacing: 0.5px; line-height: 25px;">
                        FC: Fully Covered<br/>
                        PC4: Partially Covered-4<br/>
                        PC3: Partially Covered-3<br/>
                        PC2: Partially Covered-2<br/>
                        PC1: Partially Covered-1<br/>
                        NC: Not Covered<br/>
                        NSS: No Safe Source
                    </fieldset>
                </div>
            </div>
            <%
                }
                else if(mode.equals("Pie"))
                {
            %>
            <br/>
            <div id="pieChart" style=" padding-bottom: 130px; padding-top: 20px; border : 1px double #c67; border-radius: 8px; vertical-align: top !important;">
                <table style="vertical-align: top !important;">
                    <tr style="vertical-align: top !important;">
                        <td style="vertical-align: center !important; ">
                            <h3 style="margin-top: 30px !important;">State Coverage</h3>
                            <div class="chart" style="width:300px !important; margin-left: 10px !important; margin-top: 20px !important;">
                                <div class="pie-thychart" data-set='<%=statePie%>' data-colors="#87B713,#6C2773,#C00">
                                </div>
                            </div>
                        </td>
                        <td style="vertical-align: top !important; margin-top: 20px !important;">
                            <br/><br/><br/>
                            <div id="covPieDiv" style="margin-left: 40px !important; width:480px !important; text-align: center; font-weight: bold;">
                                All Districts Coverage Status:&nbsp;
                                <select name="cov" id="cov" style="width: 50px !important;">
                                    <option value="FC">FC</option>
                                    <option value="PC">PC</option>
<!--                                    <option value="PC4">PC4</option>
                                    <option value="PC3">PC3</option>
                                    <option value="PC2">PC2</option>
                                    <option value="PC1">PC1</option>
                                    <option value="NC">NC</option>-->
                                    <option value="NSS">NSS</option>
                                </select>
                            </div>
                            <br/><br/>
                            <div class="chart" style=" width:250px !important; margin-left: 160px !important;">
                                <div class="pie-thychart" data-set='<%=distPie%>' data-colors="#57D517,#06D2E7,#87B713,#4F2919,#261EA2,#648367,#0CC53D,#77C9FC,#22045A,#E61E5A,#F0D7C3,#C6F003,#3C342A">
                                </div>
                            </div>
                        </td>
                        <td style="vertical-align: top !important; margin-top: -50px !important;">
                            <div id="distPieDiv" style="margin-left: -30px !important; width:480px !important; text-align: center; font-weight: bold; margin-top: 50px !important;">
                                District Wise Coverage Status:&nbsp;
                                <select name="dcode" id="dcode" style="width: 120px !important;">
                                    <%
                                        for(Object key: keyList)
                                        {
                                            %>
                                            <option value="<%=key%>"><%=mapDistDet.get(key)%></option>
                                            <%
                                        }
                                    %>
                                </select>&nbsp;&nbsp;
                            </div>
                            <br/><br/>
                            <div class="chart" style="width:250px !important; margin-left: 50px !important;">
                                <div class="pie-thychart" data-set='<%=covPie%>' data-colors="#87B713,#6C2773,#A380B4,#3EDF5E,#C1D1FC,#6597BE,#C00">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <%
                }
            %>
        </div>
        </form>
        <table height="20px" align="center">
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