import React from 'react';

class ProductDetails extends React.Component {
  constructor(props) {
    super(props);
    this.state = { product: null };
    this.onBackToCatalogClick = this.onBackToCatalogClick.bind(this);
    this.handleAddBtn = this.handleAddBtn.bind(this);
  }

  componentDidMount() {
    fetch(`api/products/${this.props.productId}`)
      .then(res => res.json())
      .then(data => {
        this.setState({ product: data });
      })
      .catch(err => console.error(err));
  }

  onBackToCatalogClick() {
    this.props.setView(this.props.prevView.name, this.props.prevView.params);
  }

  handleAddBtn() {
    this.props.addToCart(this.state.product);
  }

  render() {
    return this.state.product ? (
      <div
        className="row d-flex justify-content-center align-items-start py-5 body-custom"
        style={{ minHeight: '100vh' }}
      >
        <div className="card regular-card" style={{ width: '85%' }}>
          <div className="card-body" style={{ height: '100%' }}>
            <div className="back" onClick={this.onBackToCatalogClick}>
              &lt; Back to catalog
            </div>
            <div className="d-flex mobile-detail-card">
              <div
                className="m-3"
                style={{
                  height: '250px',
                  width: '350px',
                  backgroundImage: `url(${this.state.product.image})`,
                  backgroundSize: 'contain',
                  backgroundRepeat: 'no-repeat',
                  backgroundPosition: 'center'
                }}
              ></div>
              <div className="p-3">
                <h5 className="card-title">{this.state.product.productName}</h5>
                <p className="card-text">
                  Price: ${(this.state.product.price / 100).toFixed(2)}
                </p>
                <p className="card-text">
                  {this.state.product.shortDescription}
                </p>
                <button
                  type="button"
                  className="btn btn-primary"
                  onClick={this.handleAddBtn}
                >
                  Add to Cart
                </button>
              </div>
            </div>
            <div>
              <p className="card-text">{this.state.product.longDescription}</p>
            </div>
          </div>
        </div>
      </div>
    ) : null;
  }
}

export default ProductDetails;
