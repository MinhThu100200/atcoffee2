package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "type")
public class TypeEntity extends BaseEntity implements Serializable {

	private static final long serialVersionUID = -1664557373960746806L;

	@Column(name = "name")
	private String name;
	private int point;
	
	@OneToMany(mappedBy = "type")
	private List<UserEntity> users = new ArrayList<>();

	public TypeEntity() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public List<UserEntity> getUsers() {
		return users;
	}

	public void setUsers(List<UserEntity> users) {
		this.users = users;
	}

}
