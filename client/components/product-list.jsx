import React from 'react';
import ProductListItem from './product-list-item';

class ProductList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { products: [] };
    this.getProducts = this.getProducts.bind(this);
  }

  componentDidMount() {
    this.getProducts();
  }

  getProducts() {
    fetch('/api/products')
      .then(res => res.json())
      .then(data => {
        this.setState({ products: data });
      })
      .catch(err => console.error('Error:', err));
  }

  render() {
    return (
      <div className="row justify-content-center bg-light py-4">
        {this.state.products.map(product => (
          <ProductListItem key={product.productId} product={product} />
        ))}
      </div>
    );
  }
}

export default ProductList;
