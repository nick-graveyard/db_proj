package com.Company;

import java.sql.Date;

public class Project {
	private String project_id;
	private String title;
	private Double budget;
	private Date start_Date;
	private Date end_date;
	private int director;
	/**
	 * @return the project_id
	 */
	public String getProject_id() {
		return project_id;
	}
	/**
	 * @param project_id the project_id to set
	 */
	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the budget
	 */
	public Double getBudget() {
		return budget;
	}
	/**
	 * @param budget the budget to set
	 */
	public void setBudget(Double budget) {
		this.budget = budget;
	}
	/**
	 * @return the start_Date
	 */
	public Date getStart_Date() {
		return start_Date;
	}
	/**
	 * @param start_Date the start_Date to set
	 */
	public void setStart_Date(Date start_Date) {
		this.start_Date = start_Date;
	}
	/**
	 * @return the end_date
	 */
	public Date getEnd_date() {
		return end_date;
	}
	/**
	 * @param end_date the end_date to set
	 */
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	/**
	 * @return the director
	 */
	public int getDirector() {
		return director;
	}
	/**
	 * @param director the director to set
	 */
	public void setDirector(int director) {
		this.director = director;
	}
	
}
