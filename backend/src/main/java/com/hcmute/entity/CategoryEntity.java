package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;


@Entity
@Table(name = "category")
public class CategoryEntity extends BaseEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Column(unique = true, nullable = false)
	private String name;
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinTable(name = "category_product",
			joinColumns = @JoinColumn(name = "category_id"),
			inverseJoinColumns = @JoinColumn(name = "product_id"))
	private List<ProductEntity> products = new ArrayList<>();
	
	public CategoryEntity() {
		super();
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<ProductEntity> getProducts() {
		return products;
	}
	public void setProducts(List<ProductEntity> products) {
		for (ProductEntity product : products) {
			this.products.add(product);
			product.getCategories().add(this);
		}
	}
	
}
