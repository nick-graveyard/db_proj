package com.Person;

import java.sql.Date;

public class Person {
	private int person_id;
	private String fName;
	private String lName;
	private String street_address;
	private int zip;
	private String city;
	private String state;
	private String email;
	private String gender;
	private Date DOB;
	private String Designation;
	/**
	 * @return the person_id
	 */
	public int getPerson_id() {
		return person_id;
	}
	/**
	 * @param person_id the person_id to set
	 */
	public void setPerson_id(int person_id) {
		this.person_id = person_id;
	}
	/**
	 * @return the street_address
	 */
	public String getStreet_address() {
		return street_address;
	}
	/**
	 * @param street_address the street_address to set
	 */
	public void setStreet_address(String street_address) {
		this.street_address = street_address;
	}
	/**
	 * @return the zip
	 */
	public int getZip() {
		return zip;
	}
	/**
	 * @param zip the zip to set
	 */
	public void setZip(int zip) {
		this.zip = zip;
	}
	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}
	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}
	/**
	 * @return the dOB
	 */
	public java.sql.Date getDOB() {
		return DOB;
	}
	/**
	 * @param dOB the dOB to set
	 */
	/*public void setDOB(Date dOB) {
		DOB = dOB;
	}*/
	public void setDOB(String dOB) {
		//TODO StringUtil.isNullOrEmpty()
		DOB = (dOB!=null && !dOB.isEmpty())?java.sql.Date.valueOf(dOB):null;
	}
	/**
	 * @return the designation
	 */
	public String getDesignation() {
		return Designation;
	}
	/**
	 * @param designation the designation to set
	 */
	public void setDesignation(String designation) {
		Designation = designation;
	}
	/**
	 * @return the fName
	 */
	public String getfName() {
		return fName;
	}
	/**
	 * @param fName the fName to set
	 */
	public void setfName(String fName) {
		this.fName = fName;
	}
	/**
	 * @return the lName
	 */
	public String getlName() {
		return lName;
	}
	/**
	 * @param lName the lName to set
	 */
	public void setlName(String lName) {
		this.lName = lName;
	}
}
