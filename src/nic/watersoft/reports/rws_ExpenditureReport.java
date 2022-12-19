/*
 * Created on Jun 11, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import java.util.*;
import java.io.*;
import javax.servlet.jsp.*;

/**
 * @author rvkirankumar
 * 
 * Class is that generates expenditure for each work-id
 */
public class rws_ExpenditureReport {
    public float total_expenditure = 0.0f, expd_notpaid = 0.0f;

    double totalmain1 = 0;

    public float expenditureforonework = 0.0f, grandtotal = 0.0f;

    //public float expenditure_previous=0.0f,expenditure_current=0.0f;
    String[] month = { "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December" };

    /*
     * the following method returns a querystring which contains
     * workid,workname,office code
     */

    public rws_ExpenditureReport() {

    }

    public String preparefirstQuery(String dCode, String divCode,
            String subdivCode, String planCode, String workccode,
            String schCode, String aCode, String pCode, String spCode,
            String yearCode) {
        String query = "select distinct nvl(w.WORK_NAME,'-'), nvl(w.work_id,'-'),nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,decode(w.plan_code,'1','PLAN','2','NON-PLAN','-') as plan,decode(w.aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') as Augumentation, decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-') as category,nvl(w.approved_under,'-') as approved_under,nvl(w.AUG_WORKID,'-') as aug_link,substr(w.office_code,4,1),substr(w.office_code,5,2),w.plan_code,w.category_code,w.aug_new_code,a.type_of_asset_code,a.type_of_asset_name,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name  "
                + " from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp where substr(w.work_id,7,2)=a.type_of_asset_code and substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,3,2)=sp.subprogramme_code and p.programme_code=sp.programme_code  ";
        if (dCode != null && !dCode.equals("")) {
            query += " and substr(w.office_code,2,2)='" + dCode + "'";// and
                                                                      // substr(work_id,7,2)='"+schCode+"'
                                                                      // and
                                                                      // admin_date='"+yrCode+"'";
                                                                      // //code
                                                                      // changed
                                                                      // from
                                                                      // prepared_on
                                                                      // field
                                                                      // to
                                                                      // admin_date
                                                                      // field
        }
        if (divCode != null && !divCode.equals("")) {
            query += " and substr(w.office_code,4,1)='" + divCode + "'";// and
                                                                        // substr(office_code,5,2)='"+subdivCode+"'
                                                                        // and
                                                                        // substr(work_id,7,2)='"+schCode+"'
                                                                        // and
                                                                        // admin_date='"+yrCode+"'
                                                                        // ";
        }
        if (subdivCode != null && !subdivCode.equals("")) {
            query += " and  substr(w.office_code,5,2)='" + subdivCode + "'";
        }
        if (planCode != null && !planCode.equals("")) {
            query += " and w.PLAN_CODE='" + planCode + "' ";
        }
        if (workccode != null && !workccode.equals("")) {
            query += " and w.CATEGORY_CODE='" + workccode + "' ";
        }
        if (schCode != null && !schCode.equals("")) {
            query += " and substr(w.work_id,7,2)='" + schCode + "' ";
        }
        if (aCode != null && !aCode.equals("")) {
            query += " and w.AUG_NEW_CODE ='" + aCode + "'  ";
        }
        if (pCode != null && !pCode.equals("")) {
            query += " and substr(w.work_id,1,2)='" + pCode + "' ";
        }
        if (spCode != null && !spCode.equals("")) {
            query += " and substr(w.work_id,3,2)='" + spCode + "' ";
        }
        if (yearCode != null && !yearCode.equals("")) {
            query += " and to_char(w.admin_date,'yyyy')='" + yearCode + "' ";
        }
        query += " order by subStr(w.office_code,4,1),subStr(w.office_code,5,2),w.plan_code,w.category_code,a.type_of_asset_code,w.aug_new_code,p.programme_code,p.programme_name,sp.programme_code,sp.subprogramme_name ";

        return query;
    }

    /*
     * the following method returns a querystring which contains division office
     * code
     */
    public String prepareDivisionOfficeQuery(String office_code, String workid) {
        String queryh;
        if (office_code.substring(4, 6).equals("00")) {
            queryh = "select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and w.work_id='"
                    + workid + "'  ";
        } else {
            queryh = "select div.division_office_code,div.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_WORK_ADMN_TBL w,rws_circle_office_tbl cir,rws_division_office_tbl div,rws_subdivision_office_tbl sd where cir.circle_office_code=div.circle_office_code and cir.circle_office_code=sd.circle_office_code and div.division_office_code=sd.division_office_code and substr(w.office_code,2,2) =cir.circle_office_code and substr(w.office_code,4,1)=div.division_office_code and substr(w.office_code,5,2)=sd.subdivision_office_code and w.work_id='"
                    + workid + "'  ";
        }

        return queryh;
    }

    /* the following method returns a querystring which contains scheme code */
    public String prepareSchemeQuery(String workid) {
        String queryscheme = "select distinct a.type_of_asset_code,a.type_of_asset_name from RWS_WORK_ADMN_TBL w,rws_asset_type_tbl a where substr(w.work_id,7,2)=a.type_of_asset_code and w.work_id='"
                + workid + "'";
        return queryscheme;
    }

    /*
     * the following method returns a querystring which contains
     * programmecode,programme name,subprogrammecode
     */
    public String prepareProgrammeQuery(String workid) {
        String queryhh = "select p.programme_code,p.programme_name,sp.subprogramme_code,sp.subprogramme_name from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl sp where p.programme_code=sp.programme_code and p.programme_code=substr(w.work_id,1,2) and sp.subprogramme_code=substr(w.work_id,3,2) and w.work_id='"
                + workid + "'";
        return queryhh;
    }

    /*
     * public String prepareReportProgrammeQuery(String workid) { String
     * queryprog = "select distinct e.programme_code,p.programme_name from
     * rws_work_expenditure_tbl e,rws_programme_tbl p where
     * e.programme_code=p.programme_code and e.work_id='" + workid + "' and
     * rownum=1"; return queryprog; }
     */
    /* The following query string contain previous year expenditure */

    public String previousYearExpenditureQuery(String workid) {
        String query = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"
                + workid + "'";
        return query;
    }

    /* The following query string contain unique year for workid */

    public String distinctYearQuery(String workid) {
        String query = "select distinct year from rws_work_expenditure_tbl where work_id='"
                + workid + "' order by year";
        return query;
    }

    /* The following query string contain no of months for year and workid */

    public String countMonths(String workid, String year) {
        String query = "select count(distinct(e.year||e.Month||e.PROGRAMME_CODE)) from rws_work_expenditure_tbl e where  e.work_id='"
                + workid + "' and year='" + year + "'";
        return query;
    }

    /*
     * The following query string contains month,year,previous month
     * expenditre,current year expenditure workid
     */

    public String getexpenditureQuery(String workid, String year) {
        String query = "select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0'),e.month,substr(year,1,4),e.PROGRAMME_CODE  from rws_work_expenditure_tbl e  where  e.work_id='"
                + workid
                + "'  and e.year='"
                + year
                + "'order by nvl(e.Year,'-'),e.PROGRAMME_CODE ";

        return query;
    }

    public float caliculateTotalFreeExpenditure(String year12[], int mon12[],
            float expd12[], float valupto12[], float workd12[],
            String programme_name12[], int colcount) {

        String current_programme_name = "";
        ArrayList expedprevious = new ArrayList();
        ArrayList expedcurrent = new ArrayList();
        ArrayList programmename = new ArrayList();
        ArrayList monthsexpd = new ArrayList();
        ArrayList years = new ArrayList();
        ArrayList valnotpaid = new ArrayList();
        grandtotal = 0.0f;
        HashSet uniqueprogrammename = new HashSet();

        try {
            for (int i = 0; i < year12.length; i++) {

                if (year12[i] != null) {

                    programmename.add(programme_name12[i]);
                    expedprevious.add(new Float(expd12[i]));
                    expedcurrent.add(new Float(valupto12[i]));
                    monthsexpd.add(month[mon12[i] - 1]);
                    years.add(year12[i]);
                    valnotpaid.add(new Float(workd12[i]));
                    uniqueprogrammename.add(programme_name12[i]);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        expenditureforonework = 0.0f;
        expenditureforonework = findExpenditure(expedprevious, expedcurrent,
                programmename, monthsexpd, years, valnotpaid,
                uniqueprogrammename);
        grandtotal += expenditureforonework;
        return grandtotal;

    }

    /*
     * Which displays report for each workid having attributes year
     * ,month,programmename previous month expenditure current month expenditure
     */

    public float caliculateTotalExpenditure(JspWriter out, String year12[],
            int mon12[], float expd12[], float valupto12[], float workd12[],
            String programme_name12[], int colcount) {

        String current_programme_name = "";

        ArrayList expedprevious = new ArrayList();
        ArrayList expedcurrent = new ArrayList();
        ArrayList programmename = new ArrayList();
        ArrayList monthsexpd = new ArrayList();
        ArrayList years = new ArrayList();
        ArrayList valnotpaid = new ArrayList();
        grandtotal = 0.0f;
        HashSet uniqueprogrammename = new HashSet();

        try {
            for (int i = 0; i < year12.length; i++) {

                if (year12[i] != null) {

                    programmename.add(programme_name12[i]);
                    expedprevious.add(new Float(expd12[i]));
                    expedcurrent.add(new Float(valupto12[i]));
                    monthsexpd.add(month[mon12[i] - 1]);
                    years.add(year12[i]);
                    valnotpaid.add(new Float(workd12[i]));
                    uniqueprogrammename.add(programme_name12[i]);
					String td = "\t\t<td><font face=verdana size=2 nowrap>";
					String td1 = "\t\t<td><font face=verdana size=2>";
                    out.write("\t\t<td colspan=");
                    out.print(colcount);
                    out.write("></td>\r\n");

                    //out.write("<td>");
                    out.write(td);
                    out.print(isNull(programme_name12[i]));
                    out.write("</td>\r\n");
                    out.write("\r\n");
                    out.write(td);
                    out.print(year12[i]);
                    out.write("</td>\r\n");
                    out.write(td1);
                    out.print(month[mon12[i] - 1]);
                    out.write("</td>\r\n");
                    out.write(td1);
                    out.print(expd12[i]);
                    out.write("</td>\r\n");
                    out.write(td1);
                    out.print(valupto12[i]);
                    out.write("</td>\r\n");
                    out.write(td1);
                    out.print(workd12[i]);
                    out.write("</td>\r\n");
                    out.write("\t\t");
                    out.write("\r\n");
                    out.write("\r\n");
                    out.write("\t</tr>\r\n");
                    out.write("\t");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        expenditureforonework = 0.0f;
        expenditureforonework = findExpenditure(expedprevious, expedcurrent,
                programmename, monthsexpd, years, valnotpaid,
                uniqueprogrammename);
        grandtotal += expenditureforonework;
        return grandtotal;

    }

    public String isNull(String nstr) {
        if (nstr != null) {
            return nstr;
        } else {
            return "";
        }
    }

    /*
     * Caliculates expenditure yearwise,monthwise,programme wise
     *  
     */

    public float findExpenditure(ArrayList expedprevious,
            ArrayList expedcurrent, ArrayList programmename,
            ArrayList monthsexpd, ArrayList years, ArrayList valnotpaid,
            HashSet uniqueprogrammename) {
        Float expend_prevyearprogrwise[] = new Float[uniqueprogrammename.size()];
        Float expd_curyearprogwise[] = new Float[uniqueprogrammename.size()];
        Float expd_valofexpnotpaid[] = new Float[uniqueprogrammename.size()];
        float expenditure_previous = 0.0f, expenditure_current = 0.0f;

        ArrayList sortedprograms = new ArrayList();
        Iterator expenditerator = uniqueprogrammename.iterator();
        int updateyearcount = 0, programcount = 0;

        int no_of_programmes = programmename.size();
        programmename.add("dummy");
        for (int yearcount = updateyearcount; yearcount < no_of_programmes; yearcount++) {

            String cprogram = (String) programmename.get(yearcount);
            String nprogram = (String) programmename.get(yearcount + 1);

            if (!cprogram.equals(nprogram)) {
                expend_prevyearprogrwise[programcount] = (Float) expedprevious
                        .get(yearcount);
                expd_curyearprogwise[programcount] = (Float) expedcurrent
                        .get(yearcount);
                expd_valofexpnotpaid[programcount] = (Float) valnotpaid
                        .get(yearcount);
                updateyearcount = yearcount;
                //System.out.println("Current program"+cprogram+"Next
                // program"+nprogram+"updateyear
                // count"+updateyearcount+"Expenditure
                // "+expend_prevyearprogrwise[programcount]);
                programcount++;

            }
        }

        for (int totalexp = 0; totalexp < expend_prevyearprogrwise.length; totalexp++) {
            expenditure_previous += expend_prevyearprogrwise[totalexp]
                    .floatValue();
            expenditure_current += expd_curyearprogwise[totalexp].floatValue();
            //expd_notpaid+=expd_valofexpnotpaid[totalexp].floatValue();
        }

        return (expenditure_previous + expenditure_current);

    }

}
