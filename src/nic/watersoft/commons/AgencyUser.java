package nic.watersoft.commons;
import java.io.Serializable;

public class AgencyUser implements Serializable{
	

		private String isEmailRegistered;
		private String userType;
		private String userId;
		private String scopeOfAccess;
		private String permissions;
		private String agencyCode;
		private String headOfficeCode;
		private String headOfficeName;
		private String circleOfficeCode;
		private String circleOfficeName;
		private String districtOfficeName;
		private String divisionOfficeCode;
		private String divisionOfficeName;
		private String subdivisionOfficeName;
		private String subdivisionOfficeCode;

		private java.lang.Exception exception = null;
		private String errorMessage;

		private boolean authenticated;
		private boolean headOfOffice;
		
		public String getAgencyCode() {
			return agencyCode;
		}

		public void setAgencyCode(String agencyCode) {
			this.agencyCode = agencyCode;
		}

		public String getScopeOfAccess() {
			return scopeOfAccess;
		}

		public String getIsEmailRegistered() {
			return isEmailRegistered;
		}

		public void setIsEmailRegistered(String isEmailRegistered) {
			this.isEmailRegistered = isEmailRegistered;
		}

		// Accessors for userId property
		public void setUserId(String userId) {
			this.userId = userId;
		}

		public String getUserId() {
			return userId;
		}

		/*// Accessors for officeCode property
		public void setOfficeCode(String officeCode) {
			this.officeCode = officeCode;
		}

		public String getOfficeCode() {
			return officeCode;
		}

		// Accessors for officeName property
		public void setOfficeName(String officeName) {
			this.officeName = officeName;
		}

		public String getOfficeName() {
			return officeName;
		}

		// Accessors for designationCode property
		public void setDesignationCode(String designationCode) {
			this.designationCode = designationCode;
		}

		public String getDesignationCode() {
			return designationCode;
		}

		// Accessors for designationName property
		public void setDesignationName(String designationName) {
			this.designationName = designationName;
		}

		public String getDesignationName() {
			return designationName;
		}*/

		// Accessors for scopeOfAccess property
		public void setScopeOfAccess(String scopeOfAccess) {
			this.scopeOfAccess = scopeOfAccess;
		}

		public String setScopeOfAccess() {
			return scopeOfAccess;
		}

		// Accessors for permissions property
		public void setPermissions(String permissions) {
			this.permissions = permissions;
		}

		public String getPermissions() {
			return permissions;
		}

		// Accessors for headOfficeCode property
		public void setHeadOfficeCode(String headOfficeCode) {
			this.headOfficeCode = headOfficeCode;
		}

		public String getHeadOfficeCode() {
			return headOfficeCode;
		}

		// Accessors for headOfficeName property
		public void setHeadOfficeName(String headOfficeName) {
			this.headOfficeName = headOfficeName;
		}

		public String getHeadOfficeName() {
			return headOfficeName;
		}

		// Accessors for circleOfficeCode property
		public void setCircleOfficeCode(String circleOfficeCode) {
			this.circleOfficeCode = circleOfficeCode;
		}

		public String getCircleOfficeCode() {
			return circleOfficeCode;
		}

		// Accessors for circleOfficeName property
		public void setCircleOfficeName(String circleOfficeName) {
			this.circleOfficeName = circleOfficeName;
		}

		public String getCircleOfficeName() {
			return circleOfficeName;
		}

		// Accessors for divisionOfficeCode property
		public void setDivisionOfficeCode(String divisionOfficeCode) {
			this.divisionOfficeCode = divisionOfficeCode;
		}

		public String getDivisionOfficeCode() {
			return divisionOfficeCode;
		}

		// Accessors for divisionOfficeName property
		public void setDivisionOfficeName(String divisionOfficeName) {
			this.divisionOfficeName = divisionOfficeName;
		}

		public String getDivisionOfficeName() {
			return divisionOfficeName;
		}

		// Accessors for subdivisionOfficeCode property
		public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
			this.subdivisionOfficeCode = subdivisionOfficeCode;
		}

		public String getSubdivisionOfficeCode() {
			return subdivisionOfficeCode;
		}

		// Accessors for subdivisionOfficeName property
		public void setSubdivisionOfficeName(String subdivisionOfficeName) {
			this.subdivisionOfficeName = subdivisionOfficeName;
		}

		public String getSubdivisionOfficeName() {
			return subdivisionOfficeName;
		}

		// Accessors for authenticated property.
		public void setAuthenticated(boolean authenticated) {
			this.authenticated = authenticated;
		}

		// We can check whether the rws user is authenticated or not using the
		// isAuthenticated() method.
		// It returns <code>true</code> if the user is currently authenticated
		// (i.e., logged in)
		public boolean isAuthenticated() {
			return authenticated;
		}

		// Accessors for headOfOffice property
		public void setHeadOfOffice(boolean headOfOffice) {
			this.headOfOffice = headOfOffice;
		}

		public boolean isHeadOfOffice() {
			return headOfOffice;
		}

		public java.lang.Exception getException() {
			return exception;
		}

		public void setException(java.lang.Exception exception) {
			this.exception = exception;
		}

		public String getErrorMessage() {
			return errorMessage;
		}

		public void setErrorMessage(String errorMessage) {
			this.errorMessage = errorMessage;
		}

		public String getDistrictOfficeName() {
			return districtOfficeName;
		}

		public void setDistrictOfficeName(String districtOfficeName) {
			this.districtOfficeName = districtOfficeName;
		}

		public void setUserType(String userType) {
			this.userType = userType;
		}

		public String getUserType() {
			return userType;
		}
	

}
