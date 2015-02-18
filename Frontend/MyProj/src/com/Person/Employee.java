package com.Person;

public class Employee extends Person{
	private String pay_type;
	private Double pay_rate;
	private String job_code;
	private String position;
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
	 * @return the pay_rate
	 */
	public Double getPay_rate() {
		return pay_rate;
	}
	/**
	 * @param pay_rate the pay_rate to set
	 */
	public void setPay_rate(Double pay_rate) {
		this.pay_rate = pay_rate;
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

}
