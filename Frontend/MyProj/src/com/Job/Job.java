package com.Job;

public class Job {
	private String company_code;
	// TODO separate position and job
	private String company_name;
	private String position;
	private String job_code;
	private int pay_rate;
	private String pay_type;
	private String status;
	/**
	 * @return the company_code
	 */
	public String getCompany_code() {
		return company_code;
	}
	/**
	 * @param company_code the company_code to set
	 */
	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}
	/**
	 * @return the position
	 */
	public String getPosition() {
		return position;
	}
	/**
	 * @param position the position to set
	 */
	public void setPosition(String position) {
		this.position = position;
	}
	/**
	 * @return the job_code
	 */
	public String getJob_code() {
		return job_code;
	}
	/**
	 * @param job_code the job_code to set
	 */
	public void setJob_code(String job_code) {
		this.job_code = job_code;
	}
	/**
	 * @return the pay_rate
	 */
	public int getPay_rate() {
		return pay_rate;
	}
	/**
	 * @param pay_rate the pay_rate to set
	 */
	public void setPay_rate(int pay_rate) {
		this.pay_rate = pay_rate;
	}
	/**
	 * @return the pay_type
	 */
	public String getPay_type() {
		return pay_type;
	}
	/**
	 * @param pay_type the pay_type to set
	 */
	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}
	/**
	 * @return the company_name
	 */
	public String getCompany_name() {
		return company_name;
	}
	/**
	 * @param company_name the company_name to set
	 */
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	
}
