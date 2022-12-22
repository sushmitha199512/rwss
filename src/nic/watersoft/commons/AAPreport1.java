package nic.watersoft.commons;

import java.io.Serializable;

public class AAPreport1 implements Serializable {
private String workid;
private String habcode;
private String status;
private String type;
private double sanamnt;
private double probamnt;
private String habtype;
private int scpop;
private int stpop;
private int plainpop;
private int totalpop;

public int getScpop() {
	return scpop;
}
public void setScpop(int scpop) {
	this.scpop = scpop;
}
public int getStpop() {
	return stpop;
}
public void setStpop(int stpop) {
	this.stpop = stpop;
}
public int getPlainpop() {
	return plainpop;
}
public void setPlainpop(int plainpop) {
	this.plainpop = plainpop;
}
public int getTotalpop() {
	return totalpop;
}
public void setTotalpop(int totalpop) {
	this.totalpop = totalpop;
}
public String getWorkid() {
	return workid;
}
public void setWorkid(String workid) {
	this.workid = workid;
}
public String getHabcode() {
	return habcode;
}
public void setHabcode(String habcode) {
	this.habcode = habcode;
}
public String getStatus() {
	return status;
}
public void setStatus(String status) {
	this.status = status;
}
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}
public double getSanamnt() {
	return sanamnt;
}
public void setSanamnt(double sanamnt) {
	this.sanamnt = sanamnt;
}
public double getProbamnt() {
	return probamnt;
}
public void setProbamnt(double probamnt) {
	this.probamnt = probamnt;
}
public String getHabtype() {
	return habtype;
}
public void setHabtype(String habtype) {
	this.habtype = habtype;
}

}
