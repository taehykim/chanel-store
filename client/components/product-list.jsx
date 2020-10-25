import React from 'react';
import ProductListItem from './product-list-item';

class ProductList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { products: [] };
    this.getProducts = this.getProducts.bind(this);
  }

  componentDidMount() {
    const categoryId = this.props.categoryInfo ? this.props.categoryInfo.categoryId : null;
    this.getProducts(categoryId);
  }

  getProducts(categoryId) {
    if (categoryId) {
      fetch(`/api/category/products/${categoryId}`)
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
    if (this.props.categoryInfo !== prevProps.categoryInfo) {
      if (this.props.categoryInfo) {
        this.getProducts(this.props.categoryInfo.categoryId);
      } else {
        this.getProducts(null);
      }
    }
  }

  render() {
    let categoryTitleClass = 'h1 text-uppercase text-center';
    let categoryTitle;
    if (!this.props.categoryInfo) {
      categoryTitleClass += ' d-none';
    } else {
      categoryTitle = this.props.categoryInfo.name;
    }
    return (
      <>
        <div className={categoryTitleClass}>{categoryTitle}</div>
        <div className="row justify-content-center py-4 body-custom product-list-div">
          {this.state.products.map(product => (
            <ProductListItem
              key={product.productId}
              product={product}
              setView={this.props.setView}
              store={this.props.store}
            />
          ))}
        </div>
      </>
    );
  }
}

export default ProductList;
