package com.hdc.entity;

/**
 * News entity. @author MyEclipse Persistence Tools
 */

public class News implements java.io.Serializable {

	// Fields

	private Integer xwbh;
	private Users users;
	private String xwbt;
	private String xwnr;
	private String fbsj;
	private Integer xs;
	private Integer sh;

	// Constructors

	/** default constructor */
	public News() {
	}

	/** full constructor */
	public News(Users users, String xwbt, String xwnr, String fbsj, Integer xs,
			Integer sh) {
		this.users = users;
		this.xwbt = xwbt;
		this.xwnr = xwnr;
		this.fbsj = fbsj;
		this.xs = xs;
		this.sh = sh;
	}

	// Property accessors

	public Integer getXwbh() {
		return this.xwbh;
	}

	public void setXwbh(Integer xwbh) {
		this.xwbh = xwbh;
	}

	public Users getUsers() {
		return this.users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

	public String getXwbt() {
		return this.xwbt;
	}

	public void setXwbt(String xwbt) {
		this.xwbt = xwbt;
	}

	public String getXwnr() {
		return this.xwnr;
	}

	public void setXwnr(String xwnr) {
		this.xwnr = xwnr;
	}

	public String getFbsj() {
		return this.fbsj;
	}

	public void setFbsj(String fbsj) {
		this.fbsj = fbsj;
	}

	public Integer getXs() {
		return this.xs;
	}

	public void setXs(Integer xs) {
		this.xs = xs;
	}

	public Integer getSh() {
		return this.sh;
	}

	public void setSh(Integer sh) {
		this.sh = sh;
	}

}