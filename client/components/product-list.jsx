import React from 'react';
import ProductListItem from './product-list-item';

class ProductList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { products: [] };
    this.getProducts = this.getProducts.bind(this);
  }

  componentDidMount() {
    const storeId = this.props.storeId ? this.props.storeId : null;
    this.getProducts(storeId);
  }

  getProducts(storeId) {
    if (storeId) {
      fetch(`/api/store/products/${storeId}`)
        .then(res => res.json())
        .then(data => {
          this.setState({ products: data });
        })
        .catch(err => console.error(err));
    } else {
      fetch('/api/products')
        .then(res => res.json())
        .then(data => {
          this.setState({ products: data });
        })
        .catch(err => console.error('Error:', err));
    }
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (this.props.storeId !== prevProps.storeId) {
      this.getProducts(this.props.storeId);
    }
  }

  render() {
    return (
      <div className="row justify-content-center py-4">
        {this.state.products.map(product => (
          <ProductListItem
            key={product.productId}
            product={product}
            setView={this.props.setView}
            store={this.props.store}
          />
        ))}
      </div>
    );
  }
}

export default ProductList;
