package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * Form bean for a Struts application.
 * Users may access 3 fields on this form:
 * <ul>
 * <li>plan - [your comment here]
 * <li>workCat - [your comment here]
 * <li>wrktype - [your comment here]
 * </ul>
 * @version 	1.0
 * @author  
 */
public class rws_work_categoryForms extends ActionForm

{

    private String plan = null;

    private String workCategory = null;

    private String wrktype = null;
    
    private String mode=null;
    
    private String programme=null;
    private String program;
    
    private String plancode=null;
    private String workcode=null;
    private String categorycode=null;
    private String programcode=null;
	 private int count = 0;
    
	public String getCategorycode() {
		return categorycode;
	}
	public void setCategorycode(String categorycode) {
		this.categorycode = categorycode;
	}
	public String getPlancode() {
		return plancode;
	}
	public void setPlancode(String plancode) {
		this.plancode = plancode;
	}
	public String getProgramcode() {
		return programcode;
	}
	public void setProgramcode(String programcode) {
		this.programcode = programcode;
	}
	public String getWorkcode() {
		return workcode;
	}
	public void setWorkcode(String workcode) {
		this.workcode = workcode;
	}
   
    /**
     * Get plan
     * @return String
     */
    public String getPlan() {
        return plan;
    }

    /**
     * Set plan
     * @param <code>String</code>
     */
    public void setPlan(String p) {
        this.plan = p;
    }

    /**
     * Get workCat
     * @return String[]
     */
    public String getWorkCategory() {
        return workCategory;
    }

    /**
     * Set workCat
     * @param <code>String[]</code>
     * 
     */
    public void setWorkCategory(String w) {
        this.workCategory = w;
        }
    
    public void setProgrammes(String p) {
        this.programme = p;
    }

    public String getProgrammes() {
        return programme;
    }

    /**
     * Set workCat
     * @param <code>String[]</code>
     */
   
    
    
    /**
     * Get wrktype
     * @return String
     */
    public String getWrktype() {
        return wrktype;
    }

    /**
     * Set wrktype
     * @param <code>String</code>
     */
    public void setWrktype(String w) {
        this.wrktype = w;
    }

    public void reset(ActionMapping mapping, HttpServletRequest request) {

        // Reset values are provided as samples only. Change as appropriate.

        plan = null;
        workCategory= null;
        wrktype = null;
        program=null;

    }

    public ActionErrors validate(ActionMapping mapping,
            HttpServletRequest request) {

        ActionErrors errors = new ActionErrors();
        // Validate the fields in your form, adding
        // adding each error to this.errors as found, e.g.

        // if ((field == null) || (field.length() == 0)) {
        //   errors.add("field", new org.apache.struts.action.ActionError("error.field.required"));
        // }
        return errors;

    }
    
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String getProgram() {
		return program;
	}
	public void setProgram(String program) {
		this.program = program;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
