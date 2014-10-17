package com.hdc.entity;

import java.util.HashSet;
import java.util.Set;

/**
 * Hotel entity. @author MyEclipse Persistence Tools
 */

public class Hotel implements java.io.Serializable {

	// Fields

	private Integer jdbh;
	private String jdmc;
	private String jdzp;
	private String jdjj;
	private String jddz;
	private String lxr;
	private String lxdh;
	private String xzq;
	private String zb;
	private Set userses = new HashSet(0);

	// Constructors

	/** default constructor */
	public Hotel() {
	}

	/** minimal constructor */
	public Hotel(String jdmc, String jdjj, String jddz, String lxr) {
		this.jdmc = jdmc;
		this.jdjj = jdjj;
		this.jddz = jddz;
		this.lxr = lxr;
	}

	/** full constructor */
	public Hotel(String jdmc, String jdzp, String jdjj, String jddz,
			String lxr, String lxdh, String xzq, String zb, Set userses) {
		this.jdmc = jdmc;
		this.jdzp = jdzp;
		this.jdjj = jdjj;
		this.jddz = jddz;
		this.lxr = lxr;
		this.lxdh = lxdh;
		this.xzq = xzq;
		this.zb = zb;
		this.userses = userses;
	}

	// Property accessors

	public Integer getJdbh() {
		return this.jdbh;
	}

	public void setJdbh(Integer jdbh) {
		this.jdbh = jdbh;
	}

	public String getJdmc() {
		return this.jdmc;
	}

	public void setJdmc(String jdmc) {
		this.jdmc = jdmc;
	}

	public String getJdzp() {
		return this.jdzp;
	}

	public void setJdzp(String jdzp) {
		this.jdzp = jdzp;
	}

	public String getJdjj() {
		return this.jdjj;
	}

	public void setJdjj(String jdjj) {
		this.jdjj = jdjj;
	}

	public String getJddz() {
		return this.jddz;
	}

	public void setJddz(String jddz) {
		this.jddz = jddz;
	}

	public String getLxr() {
		return this.lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getLxdh() {
		return this.lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getXzq() {
		return this.xzq;
	}

	public void setXzq(String xzq) {
		this.xzq = xzq;
	}

	public String getZb() {
		return this.zb;
	}

	public void setZb(String zb) {
		this.zb = zb;
	}

	public Set getUserses() {
		return this.userses;
	}

	public void setUserses(Set userses) {
		this.userses = userses;
	}

}