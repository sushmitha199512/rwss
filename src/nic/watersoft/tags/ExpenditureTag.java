/*
 * Created on Jun 17, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.tags;

import java.io.BufferedReader;
import java.math.BigDecimal;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.JspWriter;
import java.sql.*;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.reports.rws_ExpenditureReport;

/**
 * @author Administrator
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class ExpenditureTag extends TagSupport {

    private String workid;

    float grandtotal = 0.0f;

    double totalmain1 = 0;

    private BufferedReader input;

    int Count = 0, Cnt = 0, slno = 0, sl = 0, Counts = 0, no = 0;

   
    PreparedStatement st2 = null;

    ResultSet rs2 = null, r = null, r1 = null, r2 = null,rss = null ;

  
    ResultSet rs1 = null;

    JspWriter output;

    Connection conn;

    String expendituredata = "";

    rws_ExpenditureReport expend;

    HttpSession session;

    HttpServletRequest request;

    ServletContext servletContext;
    public ExpenditureTag()
    {
   // init();
    }
    
    

    public void init() {
        try {
            
        	conn = RwsOffices.getConn();
          
           // System.out.println("Initializing database....");
        } catch (Exception sqe) {
            sqe.printStackTrace();
        }

    }

    public int  doStartTag() {
        try {
            request = (HttpServletRequest) pageContext.getRequest();
            session = request.getSession();
            output = pageContext.getOut();
            servletContext = session.getServletContext();
            init();
            processBody(workid);
            
        } catch (Exception ioe) {
            ioe.printStackTrace();
        }

        return EVAL_BODY_INCLUDE;

    }

   
      protected void processBody(String content) throws JspTagException { 
          try {
              output.print(showReport(workid));
              closeAll();
      }
      catch(Exception exception) {
      exception.printStackTrace(); }
       // exportWrapper(getDbConnectionWrapper(), content); 
      }
     

    public int doAfterBody() throws JspTagException {
        try {
            closeAll();
        } catch (Exception ioe) {
            ioe.printStackTrace();
        }

        return EVAL_BODY_AGAIN;
    }

    /**
     * @return Returns the workid.
     */
    public String getWorkid() {
        return workid;
    }

    /**
     * @param workid
     *            The workid to set.
     */
    public void setWorkid(String workid) {
        this.workid = workid;
    }
    
    
    public float showReport1(String workid,Connection connn) throws Exception {
        grandtotal = 0.0f;
        int colcount = 4;

        String qury1 = "";
        totalmain1 = 0;
        float total = 0;

        String qury2 = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"
                + workid + "' ";
        st2 = connn.prepareStatement(qury2,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rs2 = st2.executeQuery();
        if (rs2.next()) {
            totalmain1 = rs2.getDouble(1);
        }

        int counttotal = 0;

        int returnval = -1;
        double finalTotal = 0;
        String queryyear = "select distinct year from rws_work_expenditure_tbl where work_id='"
                + workid + "' order by year";
        st2=connn.prepareStatement(queryyear,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rss = st2.executeQuery();
        double yearmonprev = 0.0, yearmondur = 0.0;
        while (rss.next()) {
            returnval++;
            yearmonprev = 0.0;
            yearmondur = 0.0;

            String qurys = "select count(distinct(e.year||e.Month||e.PROGRAMME_CODE)) from rws_work_expenditure_tbl e where  e.work_id='"
                    + workid + "' and year='" + rss.getString(1) + "' and year!='2009-10'";
            //System.out.println("Year is "+rss.getString(1));
            st2=connn.prepareStatement(qurys,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet countrs = st2.executeQuery();

            if (countrs.next()) {
                counttotal = countrs.getInt(1);
            }
            counttotal += 1;

            qury1 = "select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0'),e.month,substr(year,1,4),e.PROGRAMME_CODE  from rws_work_expenditure_tbl e  where  e.work_id='"
                    + workid
                    + "'  and e.year='"
                    + rss.getString(1)
                    + "' and e.year!='2009-10' order by nvl(e.Year,'-'),e.PROGRAMME_CODE ";

            int[] mon = new int[counttotal];
            String[] year = new String[counttotal];
            float[] expd = new float[counttotal];
            float[] valupto = new float[counttotal];
            float[] workd = new float[counttotal];
            int[] mon1 = new int[counttotal];
            int[] mon2 = new int[counttotal];
            int[] mon3 = new int[counttotal];
            int[] yearStart = new int[counttotal];
            int[] sort1 = new int[counttotal - 1];
            int loopval[] = new int[counttotal];
            String[] programme_nam = new String[counttotal];

           
            int val = 0;
            st2=connn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            while (rs1.next()) {
                Counts = rs1.getRow();
            }
            int Counts1 = Counts;
            st2=connn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            int loop = 0;

            while (rs1.next()) {
                year[val] = rs1.getString(1);
                expd[val] = rs1.getFloat(3);
                valupto[val] = rs1.getFloat(4);
                workd[val] = rs1.getFloat(5);
                mon[val] = rs1.getInt(6);
                sort1[val] = rs1.getInt(6);
                yearStart[val] = rs1.getInt(7);
                programme_nam[val] = getProgrammeName1(isNull(rs1.getString(8)),connn);
                loop++;

                val++;
            }
            expend = new rws_ExpenditureReport();

            grandtotal += expend.caliculateTotalFreeExpenditure(year, mon,
                    expd, valupto, workd, programme_nam, colcount);

        }

        grandtotal = grandtotal + (new Float(totalmain1)).floatValue();
        BigDecimal bd = new BigDecimal(Double.toString(grandtotal));
        bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
        grandtotal = Float.parseFloat("" + bd);
        return grandtotal;

    }//end of main while

    
    public float showReport2(String workid,Connection connn) throws Exception {
        grandtotal = 0.0f;
        int colcount = 4;

        String qury1 = "";
        totalmain1 = 0;
        float total = 0;

        //String qury2 = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"
          //      + workid + "' and year=='2009-10' ";
        //st2 = conn.prepareStatement(qury2,ResultSet.TYPE_SCROLL_SENSITIVE,
            ///    ResultSet.CONCUR_UPDATABLE);
        //rs2 = st2.executeQuery();
        //if (rs2.next()) {
         //   totalmain1 = rs2.getDouble(1);
        //}

        int counttotal = 0;

        int returnval = -1;
        double finalTotal = 0;
        String queryyear = "select distinct year from rws_work_expenditure_tbl where work_id='"
                + workid + "' and  year='2009-10' order by year ";
        st2=connn.prepareStatement(queryyear,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        //System.out.println("year::"+queryyear);
        rss = st2.executeQuery();
        double yearmonprev = 0.0, yearmondur = 0.0;
        while (rss.next()) {
            returnval++;
            yearmonprev = 0.0;
            yearmondur = 0.0;

            String qurys = "select count(distinct(e.year||e.Month||e.PROGRAMME_CODE)) from rws_work_expenditure_tbl e where  e.work_id='"
                    + workid + "'  and year='2009-10'";
            //System.out.println("YEAR STRING "+qurys);
            st2=connn.prepareStatement(qurys,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet countrs = st2.executeQuery();

            if (countrs.next()) {
                counttotal = countrs.getInt(1);
            }
            counttotal += 1;

            qury1 = "select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0'),e.month,substr(year,1,4),e.PROGRAMME_CODE  from rws_work_expenditure_tbl e  where  e.work_id='"
                    + workid
                    + "'  and e.year='2009-10'  order by nvl(e.Year,'-'),e.PROGRAMME_CODE ";

            int[] mon = new int[counttotal];
            String[] year = new String[counttotal];
            float[] expd = new float[counttotal];
            float[] valupto = new float[counttotal];
            float[] workd = new float[counttotal];
            int[] mon1 = new int[counttotal];
            int[] mon2 = new int[counttotal];
            int[] mon3 = new int[counttotal];
            int[] yearStart = new int[counttotal];
            int[] sort1 = new int[counttotal - 1];
            int loopval[] = new int[counttotal];
            String[] programme_nam = new String[counttotal];

           
            int val = 0;
            st2=connn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            while (rs1.next()) {
                Counts = rs1.getRow();
            }
            int Counts1 = Counts;
            st2=connn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            int loop = 0;

            while (rs1.next()) {
                year[val] = rs1.getString(1);
                expd[val] = rs1.getFloat(3);
                valupto[val] = rs1.getFloat(4);
                workd[val] = rs1.getFloat(5);
                mon[val] = rs1.getInt(6);
                sort1[val] = rs1.getInt(6);
                yearStart[val] = rs1.getInt(7);
                programme_nam[val] = getProgrammeName1(isNull(rs1.getString(8)),connn);
                loop++;

                val++;
            }
            expend = new rws_ExpenditureReport();

            grandtotal += expend.caliculateTotalFreeExpenditure(year, mon,
                    expd, valupto, workd, programme_nam, colcount);

        }

        grandtotal = grandtotal + (new Float(totalmain1)).floatValue();
        BigDecimal bd = new BigDecimal(Double.toString(grandtotal));
        bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
        grandtotal = Float.parseFloat("" + bd);
        return grandtotal;

    }//end of main while

    
    
    
    
    
    
    
    
    
    

    public float showReport(String workid) throws Exception {
        grandtotal = 0.0f;
        int colcount = 4;

        String qury1 = "";
        totalmain1 = 0;
        float total = 0;

        String qury2 = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"
                + workid + "' ";
        st2 = conn.prepareStatement(qury2,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rs2 = st2.executeQuery();
        if (rs2.next()) {
            totalmain1 = rs2.getDouble(1);
        }

        int counttotal = 0;

        int returnval = -1;
        double finalTotal = 0;
        String queryyear = "select distinct year from rws_work_expenditure_tbl where work_id='"
                + workid + "' order by year";
        st2=conn.prepareStatement(queryyear,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rss = st2.executeQuery();
        double yearmonprev = 0.0, yearmondur = 0.0;
        while (rss.next()) {
            returnval++;
            yearmonprev = 0.0;
            yearmondur = 0.0;

            String qurys = "select count(distinct(e.year||e.Month||e.PROGRAMME_CODE)) from rws_work_expenditure_tbl e where  e.work_id='"
                    + workid + "' and year='" + rss.getString(1) + "'";
            //System.out.println("Year is "+rss.getString(1));
            st2=conn.prepareStatement(qurys,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet countrs = st2.executeQuery();

            if (countrs.next()) {
                counttotal = countrs.getInt(1);
            }
            counttotal += 1;

            qury1 = "select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0'),e.month,substr(year,1,4),e.PROGRAMME_CODE  from rws_work_expenditure_tbl e  where  e.work_id='"
                    + workid
                    + "'  and e.year='"
                    + rss.getString(1)
                    + "' order by nvl(e.Year,'-'),e.PROGRAMME_CODE ";

            int[] mon = new int[counttotal];
            String[] year = new String[counttotal];
            float[] expd = new float[counttotal];
            float[] valupto = new float[counttotal];
            float[] workd = new float[counttotal];
            int[] mon1 = new int[counttotal];
            int[] mon2 = new int[counttotal];
            int[] mon3 = new int[counttotal];
            int[] yearStart = new int[counttotal];
            int[] sort1 = new int[counttotal - 1];
            int loopval[] = new int[counttotal];
            String[] programme_nam = new String[counttotal];

           
            int val = 0;
            st2=conn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            while (rs1.next()) {
                Counts = rs1.getRow();
            }
            int Counts1 = Counts;
            st2=conn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            int loop = 0;

            while (rs1.next()) {
                year[val] = rs1.getString(1);
                expd[val] = rs1.getFloat(3);
                valupto[val] = rs1.getFloat(4);
                workd[val] = rs1.getFloat(5);
                mon[val] = rs1.getInt(6);
                sort1[val] = rs1.getInt(6);
                yearStart[val] = rs1.getInt(7);
                programme_nam[val] = getProgrammeName(isNull(rs1.getString(8)));
                loop++;

                val++;
            }
            expend = new rws_ExpenditureReport();

            grandtotal += expend.caliculateTotalFreeExpenditure(year, mon,
                    expd, valupto, workd, programme_nam, colcount);

        }

        grandtotal = grandtotal + (new Float(totalmain1)).floatValue();
        BigDecimal bd = new BigDecimal(Double.toString(grandtotal));
        bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
        grandtotal = Float.parseFloat("" + bd);
        return grandtotal;

    }//end of main while
    public static Connection getConn()
	{
		Connection conn2=null;
		try {
			conn2 = RwsOffices.getConn();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			Debug.println("error in getConn() in RWSOffices:"+e.getMessage());
		}
		return conn2;
		
	}
    public ArrayList findExpForOneWork(String workid) {
    	Connection connn = getConn();
    	//Debug.println("in findExpForOneWork:"+workid);
    	ArrayList exp = new ArrayList();
    	Statement yearst=null,progst=null,expyearprogst = null;
    	ResultSet yearrs=null,progrs=null,expyearprogrs=null;
    	try
    	{
    			String qury1 = "",query="";
    			double expenditure_upto_the_pre_year = 0;

    			String qury2 = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"+ workid + "' ";
    			if(rs2!=null)rs2.close();
    			if(st2!=null)st2.close();
    			st2 = connn.prepareStatement(qury2);
    			rs2 = st2.executeQuery();
    			expenditure_upto_the_pre_year = 0;
    			if (rs2.next()) {
    				expenditure_upto_the_pre_year = rs2.getDouble(1);
    			}
    			double finalTotal = 0;
    			String queryyear = "select distinct year from rws_work_expenditure_tbl where work_id='"+ workid + "' and year<>'2009-10' order by year";
    			if(yearrs!=null)yearrs.close();
    			if(yearst!=null)yearst.close();
    			yearst = connn.createStatement();
    			
    			yearrs = yearst.executeQuery(queryyear);
    			float expyearprogprevmon=0.0f,expyearprogdurmon=0.0f;
    			float expyearprogtotprevmon=0.0f,expyearprogtotdurmon=0.0f;
    			float expallyearprogtotprevmon=0.0f,expallyearprogtotdurmon=0.0f;
    			float totalprevyearexp=0.0f,totalcurryearexp=0.0f,expyearprogtotfurmon=0.0f;
    			//calculation upto previous year starts
    			//Debug.println("Before getting Years"+queryyear);
    			while(yearrs.next())
    		{
    				//Debug.println("After getting Years"+queryyear);
    				query = "select a.programme_code,programme_name from rws_work_admn_tbl a,rws_programme_tbl p where a.programme_code=p.programme_code and a.work_id='"+ workid + "' union select a.programme_code,programme_name from RWS_WORK_ADMN_PROG_LNK_TBL a,rws_programme_tbl p where a.programme_code=p.programme_code and a.work_id='"+ workid + "' and a.programme_code not in(select programme_code from rws_work_admn_tbl where work_id='"+ workid + "')";
    				if(progrs!=null)progrs.close();
    				if(progst!=null)progst.close();
    				progst = connn.createStatement();
    				//Debug.println("progst query:"+query);
					progrs = progst.executeQuery(query);
    				//Debug.println("after metod call");
					expyearprogtotprevmon = 0;expyearprogtotdurmon = 0;
    				while(progrs.next())
    			{
    				qury1 = "select * from rws_work_expenditure_tbl e where e.work_id = '"+ workid + "' and e.year = '" + yearrs.getString(1) + "' and  e.PROGRAMME_CODE='"+progrs.getString(1)+"'";
    				//Debug.println("expyearprogst query:"+qury1);
    				if(expyearprogrs!=null)expyearprogrs.close();
    				if(expyearprogst!=null)expyearprogst.close();
    				expyearprogst=connn.createStatement();
    				expyearprogrs = expyearprogst.executeQuery(qury1);
    				expyearprogprevmon = 0;
    				expyearprogdurmon = 0;
    				while(expyearprogrs.next())
    				{
    					expyearprogprevmon=expyearprogrs.getFloat(4);
    					expyearprogdurmon=expyearprogrs.getFloat(5);
    				}
    				expyearprogtotprevmon+=expyearprogprevmon;
    				expyearprogtotdurmon+=expyearprogdurmon;
    			}
    				expallyearprogtotprevmon+=expyearprogtotprevmon;
    				expallyearprogtotdurmon+=expyearprogtotdurmon;
    		}
    			 BigDecimal bd = new BigDecimal(Double.toString(expallyearprogtotprevmon+expallyearprogtotdurmon+expenditure_upto_the_pre_year));
    		        bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
    		        totalprevyearexp = Float.parseFloat("" + bd);
    		       
    			
    		//totalprevyearexp = expallyearprogtotprevmon + expallyearprogtotdurmon+expenditure_upto_the_pre_year;
    		      /*  BigDecimal bdd = new BigDecimal(Double.toString(totalprevyearexp));
    		        bdd = bdd.setScale(2s, BigDecimal.ROUND_HALF_UP);
    		        grandtotal = Float.parseFloat("" + bdd);*/
    		exp.add(new Float(totalprevyearexp));
    		//Debug.println("1st over:"+new Float(totalprevyearexp));
    				//calculation upto previous year ends
    				//calculation current year starts

    		query = "select a.programme_code,programme_name from rws_work_admn_tbl a,rws_programme_tbl p where a.programme_code=p.programme_code and a.work_id='"+ workid + "' union select a.programme_code,programme_name from RWS_WORK_ADMN_PROG_LNK_TBL a,rws_programme_tbl p where a.programme_code=p.programme_code and a.work_id='"+ workid + "' and a.programme_code not in(select programme_code from rws_work_admn_tbl where work_id='"+ workid + "')";
    		//Debug.println("1");
    		if(progrs!=null)progrs.close();
    		//Debug.println("2");
    		if(progst!=null)progst.close();
    		//Debug.println("3");
    		progst = connn.createStatement();
    		progrs = progst.executeQuery(query);
    		//Debug.println("4"); 
    		expyearprogtotprevmon = 0;expyearprogtotdurmon=0;
    		expallyearprogtotprevmon = 0;expallyearprogtotdurmon = 0;
    			while(progrs.next())
    			{
    				//Debug.println("5");
    				qury1 = "select * from rws_work_expenditure_tbl e where e.work_id = '"+ workid + "' and e.year = '2009-10' and  e.PROGRAMME_CODE='"+progrs.getString(1)+"'";
    				//Debug.println("5.1");
    				if(expyearprogrs!=null)expyearprogrs.close();
    				//Debug.println("5.2");
    				if(expyearprogst!=null)expyearprogst.close();
    				//Debug.println("5.3");
    				expyearprogst=connn.createStatement();
    				expyearprogrs = expyearprogst.executeQuery(qury1);
    				expyearprogprevmon = 0;
    				expyearprogdurmon = 0;
    				while(expyearprogrs.next())
    				{
    				//	Debug.println("6");
    					expyearprogprevmon=expyearprogrs.getFloat(4);
    				//	Debug.println("7");
    					expyearprogdurmon=expyearprogrs.getFloat(5);
    				//	Debug.println("8");
    				}
    				expyearprogtotprevmon+=expyearprogprevmon;
    				expyearprogtotdurmon+=expyearprogdurmon;
    				//expyearprogrs.close();
    			}
    				expallyearprogtotprevmon+=expyearprogtotprevmon;
    				expallyearprogtotdurmon+=expyearprogtotdurmon;

    		totalcurryearexp = expallyearprogtotprevmon + expallyearprogtotdurmon;
    		
    		 bd = new BigDecimal(Double.toString(totalcurryearexp));
		     bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
    		 totalcurryearexp = Float.parseFloat("" + bd);
		    
    		 yearst.close();
    		/* BigDecimal bddd = new BigDecimal(Double.toString(totalcurryearexp));
		        bddd = bddd.setScale(2, BigDecimal.ROUND_HALF_UP);
		        grandtotal = Float.parseFloat("" + bddd);*/
    		exp.add(new Float(totalcurryearexp));
    		//Debug.println("2nd over"+new Float(totalcurryearexp));
    		//yearrs.close();
    		//yearst.close();
    	}
    	catch (Exception e)
    	{
    		Debug.println("in findExpForOneWork:"+e.getMessage());
    		e.printStackTrace();  
    		
    	}
    	finally
		{
    		try
			{
    			if(yearrs!=null){yearrs.close();yearrs=null;}
            	if(progrs!=null){progrs.close();progrs=null;}
            	if(expyearprogrs!=null){expyearprogrs.close();expyearprogrs=null;}
            	if(yearst!=null){yearst.close();yearst=null;}
            	if(progst!=null){progst.close();progst=null;}
            	if(expyearprogst!=null){expyearprogst.close();expyearprogst=null;}
            	if(connn!=null){connn.close();connn=null;}
			}
    		catch(Exception e){Debug.println("closing:"+e.getMessage());}
    		System.gc();
		}
    		
    	//calculation current year ends
    	//Debug.println("exp 0"+exp.get(0));
    	//Debug.println("exp 1"+exp.get(1));
    	
        return exp;

        }
    
    public float showReportfinal(String workid,Connection connn) throws Exception {
        grandtotal = 0.0f;
        int colcount = 4;

        String qury1 = "";
        totalmain1 = 0;
        float total = 0;

        String qury2 = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"
                + workid + "' ";
        st2 = connn.prepareStatement(qury2,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rs2 = st2.executeQuery();
        if (rs2.next()) {
            totalmain1 = rs2.getDouble(1);
        }

        int counttotal = 0;

        int returnval = -1;
        double finalTotal = 0;
        String queryyear = "select distinct year from rws_work_expenditure_tbl where work_id='"
                + workid + "' order by year";
        st2=connn.prepareStatement(queryyear,ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        rss = st2.executeQuery();
        double yearmonprev = 0.0, yearmondur = 0.0;
        while (rss.next()) {
            returnval++;
            yearmonprev = 0.0;
            yearmondur = 0.0;

            String qurys = "select count(distinct(e.year||e.Month||e.PROGRAMME_CODE)) from rws_work_expenditure_tbl e where  e.work_id='"
                    + workid + "' and year='" + rss.getString(1) + "'";
            //System.out.println("Year is "+rss.getString(1));
            st2=connn.prepareStatement(qurys,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet countrs = st2.executeQuery();

            if (countrs.next()) {
                counttotal = countrs.getInt(1);
            }
            counttotal += 1;

            qury1 = "select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0'),e.month,substr(year,1,4),e.PROGRAMME_CODE  from rws_work_expenditure_tbl e  where  e.work_id='"
                    + workid
                    + "'  and e.year='"
                    + rss.getString(1)
                    + "' order by nvl(e.Year,'-'),e.PROGRAMME_CODE ";

            int[] mon = new int[counttotal];
            String[] year = new String[counttotal];
            float[] expd = new float[counttotal];
            float[] valupto = new float[counttotal];
            float[] workd = new float[counttotal];
            int[] mon1 = new int[counttotal];
            int[] mon2 = new int[counttotal];
            int[] mon3 = new int[counttotal];
            int[] yearStart = new int[counttotal];
            int[] sort1 = new int[counttotal - 1];
            int loopval[] = new int[counttotal];
            String[] programme_nam = new String[counttotal];

           
            int val = 0;
            st2=connn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            while (rs1.next()) {
                Counts = rs1.getRow();
            }
            int Counts1 = Counts;
            st2=connn.prepareStatement(qury1,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs1 = st2.executeQuery();
            int loop = 0;

            while (rs1.next()) {
                year[val] = rs1.getString(1);
                expd[val] = rs1.getFloat(3);
                valupto[val] = rs1.getFloat(4);
                workd[val] = rs1.getFloat(5);
                mon[val] = rs1.getInt(6);
                sort1[val] = rs1.getInt(6);
                yearStart[val] = rs1.getInt(7);
                programme_nam[val] = getProgrammeName1(isNull(rs1.getString(8)),connn);
                loop++;

                val++;
            }
            expend = new rws_ExpenditureReport();

            grandtotal += expend.caliculateTotalFreeExpenditure(year, mon,
                    expd, valupto, workd, programme_nam, colcount);

        }

        grandtotal = grandtotal + (new Float(totalmain1)).floatValue();
        BigDecimal bd = new BigDecimal(Double.toString(grandtotal));
        bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
        grandtotal = Float.parseFloat("" + bd);
        
        return grandtotal;

    }
    
    
    public String isNull(String nstr) {
        if (nstr != null) {
            return nstr;
        } else {
            return "";
        }

    }

    public String getProgrammeName(String code) throws Exception {
        String programme_name;
        if (code.length() == 0) {
            return code;
        } else {
            String qury = "select distinct programme_name from rws_programme_tbl p where programme_code='"
                    + code + "'";
            st2=conn.prepareStatement(qury,ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            r = st2.executeQuery();
            r.next();
            programme_name = r.getString(1);
            return isNull(programme_name);
        }

    }
    public String getProgrammeName1(String code,Connection conn1) 
    {
    	String programme_name="";
    	try
		{
            if (code.length() == 0) {
                return code;
            } else {
                String qury = "select distinct programme_name from rws_programme_tbl p where programme_code='"
                        + code + "'";
                //Debug.println("1");
                st2=conn1.prepareStatement(qury);
                //Debug.println("2");
                //r.next();
               // Debug.println("3");
                r = st2.executeQuery();
                r.next();
                programme_name = r.getString(1);
            }
		}
        catch(Exception e)
		{
        	Debug.println("error in getProgramme name1:"+e.getMessage());
		}
        finally
		{
        	try
			{
        		if(r!=null)r.close();
                r = null;
                if(st2!=null)st2.close();
                st2 = null;
			}
        	catch(Exception ee)
			{
        		
			}
		}
        return isNull(programme_name);

    }

    public void closeAll() {
        //System.out.println("++CLosing alll**");
        try {
            st2 = null;
          //  s = null;
           // st1 = null;
            //stmt3 = null;
            rs2 = null;
            r = null;
            r1 = null;
            r2 = null;            
            rss = null;
            rs1 = null;
            conn = null;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.gc();
        }
    }

}
