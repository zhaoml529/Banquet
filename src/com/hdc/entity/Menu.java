package com.hdc.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Menu entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "cpb", catalog = "banquet")
public class Menu implements java.io.Serializable {

	// Fields

	private Integer tcbh;
	private Hotel hotel;
	private String tcmc;
	private String tcjj;
	private Float jg;
	private Float zk;
	private String cdlb;
	private String zttp;

	// Constructors

	/** default constructor */
	public Menu() {
	}

	/** minimal constructor */
	public Menu(Hotel hotel, String tcmc, Float jg) {
		this.hotel = hotel;
		this.tcmc = tcmc;
		this.jg = jg;
	}

	/** full constructor */
	public Menu(Hotel hotel, String tcmc, String tcjj, Float jg, Float zk,
			String cdlb, String zttp) {
		this.hotel = hotel;
		this.tcmc = tcmc;
		this.tcjj = tcjj;
		this.jg = jg;
		this.zk = zk;
		this.cdlb = cdlb;
		this.zttp = zttp;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "TCBH", unique = true, nullable = false)
	public Integer getTcbh() {
		return this.tcbh;
	}

	public void setTcbh(Integer tcbh) {
		this.tcbh = tcbh;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "JDBH", nullable = false)
	public Hotel getHotel() {
		return this.hotel;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	@Column(name = "TCMC", nullable = false, length = 100)
	public String getTcmc() {
		return this.tcmc;
	}

	public void setTcmc(String tcmc) {
		this.tcmc = tcmc;
	}

	@Column(name = "TCJJ", length = 65535)
	public String getTcjj() {
		return this.tcjj;
	}

	public void setTcjj(String tcjj) {
		this.tcjj = tcjj;
	}

	@Column(name = "JG", nullable = false, precision = 12, scale = 0)
	public Float getJg() {
		return this.jg;
	}

	public void setJg(Float jg) {
		this.jg = jg;
	}

	@Column(name = "ZK", precision = 12, scale = 0)
	public Float getZk() {
		return this.zk;
	}

	public void setZk(Float zk) {
		this.zk = zk;
	}

	@Column(name = "CDLB", length = 65535)
	public String getCdlb() {
		return this.cdlb;
	}

	public void setCdlb(String cdlb) {
		this.cdlb = cdlb;
	}

	@Column(name = "ZTTP", length = 200)
	public String getZttp() {
		return this.zttp;
	}

	public void setZttp(String zttp) {
		this.zttp = zttp;
	}

}