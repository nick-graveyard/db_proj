package com.Job;

public class Position {
	private String position_code;
	// TODO separate position and job
	private String title;
	private String description;
	/**
	 * @return the position_code
	 */
	public String getPosition_code() {
		return position_code;
	}
	/**
	 * @param position_code the position_code to set
	 */
	public void setPosition_code(String position_code) {
		this.position_code = position_code;
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
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

}
