package com.hdc.entity;

/**
 * Order entity. @author MyEclipse Persistence Tools
 */

public class Order implements java.io.Serializable {

	// Fields

	private Integer bh;
	private Integer jdbh;
	private String zt;
	private String jdmc;
	private String yhtmz;
	private String kssj;
	private String jssj;
	private Short qt;
	private String lxfs;
	private String bz;

	// Constructors

	/** default constructor */
	public Order() {
	}

	/** full constructor */
	public Order(Integer jdbh, String zt, String jdmc, String yhtmz,
			String kssj, String jssj, Short qt, String lxfs, String bz) {
		this.jdbh = jdbh;
		this.zt = zt;
		this.jdmc = jdmc;
		this.yhtmz = yhtmz;
		this.kssj = kssj;
		this.jssj = jssj;
		this.qt = qt;
		this.lxfs = lxfs;
		this.bz = bz;
	}

	// Property accessors

	public Integer getBh() {
		return this.bh;
	}

	public void setBh(Integer bh) {
		this.bh = bh;
	}

	public Integer getJdbh() {
		return this.jdbh;
	}

	public void setJdbh(Integer jdbh) {
		this.jdbh = jdbh;
	}

	public String getZt() {
		return this.zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getJdmc() {
		return this.jdmc;
	}

	public void setJdmc(String jdmc) {
		this.jdmc = jdmc;
	}

	public String getYhtmz() {
		return this.yhtmz;
	}

	public void setYhtmz(String yhtmz) {
		this.yhtmz = yhtmz;
	}

	public String getKssj() {
		return this.kssj;
	}

	public void setKssj(String kssj) {
		this.kssj = kssj;
	}

	public String getJssj() {
		return this.jssj;
	}

	public void setJssj(String jssj) {
		this.jssj = jssj;
	}

	public Short getQt() {
		return this.qt;
	}

	public void setQt(Short qt) {
		this.qt = qt;
	}

	public String getLxfs() {
		return this.lxfs;
	}

	public void setLxfs(String lxfs) {
		this.lxfs = lxfs;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

}