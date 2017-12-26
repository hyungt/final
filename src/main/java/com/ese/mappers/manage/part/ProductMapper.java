package com.ese.mappers.manage.part;

import java.util.List;

import com.ese.vo.product.Product;

public interface ProductMapper {
	List<Product> getProducts(String divisionId);
}
