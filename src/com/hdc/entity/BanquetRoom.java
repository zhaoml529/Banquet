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
 * BanquetRoom entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "yhtb", catalog = "banquet")
public class BanquetRoom implements java.io.Serializable {

	// Fields

	private Integer yhtbh;
	private Hotel hotel;
	private String yhtmc;
	private Integer zs;
	private Integer mzrs;
	private String yhtjj;
	private String yhttp;

	// Constructors

	/** default constructor */
	public BanquetRoom() {
	}

	/** minimal constructor */
	public BanquetRoom(Hotel hotel) {
		this.hotel = hotel;
	}

	/** full constructor */
	public BanquetRoom(Hotel hotel, String yhtmc, Integer zs, Integer mzrs,
			String yhtjj, String yhttp) {
		this.hotel = hotel;
		this.yhtmc = yhtmc;
		this.zs = zs;
		this.mzrs = mzrs;
		this.yhtjj = yhtjj;
		this.yhttp = yhttp;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "YHTBH", unique = true, nullable = false)
	public Integer getYhtbh() {
		return this.yhtbh;
	}

	public void setYhtbh(Integer yhtbh) {
		this.yhtbh = yhtbh;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "JDBH", nullable = false)
	public Hotel getHotel() {
		return this.hotel;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	@Column(name = "YHTMC", length = 100)
	public String getYhtmc() {
		return this.yhtmc;
	}

	public void setYhtmc(String yhtmc) {
		this.yhtmc = yhtmc;
	}

	@Column(name = "ZS")
	public Integer getZs() {
		return this.zs;
	}

	public void setZs(Integer zs) {
		this.zs = zs;
	}

	@Column(name = "MZRS")
	public Integer getMzrs() {
		return this.mzrs;
	}

	public void setMzrs(Integer mzrs) {
		this.mzrs = mzrs;
	}

	@Column(name = "YHTJJ", length = 65535)
	public String getYhtjj() {
		return this.yhtjj;
	}

	public void setYhtjj(String yhtjj) {
		this.yhtjj = yhtjj;
	}

	@Column(name = "YHTTP", length = 200)
	public String getYhttp() {
		return this.yhttp;
	}

	public void setYhttp(String yhttp) {
		this.yhttp = yhttp;
	}

}