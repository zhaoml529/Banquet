package com.hdc.entity;

import java.util.HashSet;
import java.util.Set;

/**
 * Users entity. @author MyEclipse Persistence Tools
 */

public class Users implements java.io.Serializable {

	// Fields

	private Integer yhbh;
	private Hotel hotel;
	private String yhm;
	private String mm;
	private String xm;
	private Integer jx;
	private String dhhm;
	private Set newses = new HashSet(0);

	// Constructors

	/** default constructor */
	public Users() {
	}

	/** minimal constructor */
	public Users(String yhm, String mm, String xm, Integer jx) {
		this.yhm = yhm;
		this.mm = mm;
		this.xm = xm;
		this.jx = jx;
	}

	/** full constructor */
	public Users(Hotel hotel, String yhm, String mm, String xm, Integer jx,
			String dhhm, Set newses) {
		this.hotel = hotel;
		this.yhm = yhm;
		this.mm = mm;
		this.xm = xm;
		this.jx = jx;
		this.dhhm = dhhm;
		this.newses = newses;
	}

	// Property accessors

	public Integer getYhbh() {
		return this.yhbh;
	}

	public void setYhbh(Integer yhbh) {
		this.yhbh = yhbh;
	}

	public Hotel getHotel() {
		return this.hotel;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	public String getYhm() {
		return this.yhm;
	}

	public void setYhm(String yhm) {
		this.yhm = yhm;
	}

	public String getMm() {
		return this.mm;
	}

	public void setMm(String mm) {
		this.mm = mm;
	}

	public String getXm() {
		return this.xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public Integer getJx() {
		return this.jx;
	}

	public void setJx(Integer jx) {
		this.jx = jx;
	}

	public String getDhhm() {
		return this.dhhm;
	}

	public void setDhhm(String dhhm) {
		this.dhhm = dhhm;
	}

	public Set getNewses() {
		return this.newses;
	}

	public void setNewses(Set newses) {
		this.newses = newses;
	}

}