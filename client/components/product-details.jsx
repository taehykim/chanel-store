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
      <>
        <div
          className="row d-flex justify-content-center align-items-start py-5 body-custom"
          style={{ minHeight: '100vh' }}
        >
          <div className="card mb-3 border-0">
            <div className="row no-gutters justify-content-around align-items-center">
              <div className="col-md-5">
                <img src={this.state.product.image} className="card-img" />
              </div>
              <div className="col-md-4">
                <div className="card-body p-0 d-flex flex-column justify-content-center align-items-stretch">
                  <span className="card-title text-uppercase product-detail-title my-3">{this.state.product.productName}</span>
                  <p className="card-text my-3">{this.state.product.shortDescription}</p>
                  <p className="feature text-uppercase">Features</p>
                  <p className="card-text mb-3">{this.state.product.longDescription}</p>
                  <p className="card-text my-3 price">${this.props.formatPrice(this.state.product.price / 100)}</p>
                  <button
                    type="button"
                    className="btn btn-dark add-to-cart d-flex justify-content-center p-2"
                    onClick={this.handleAddBtn}
                  >
                    <p className="text-uppercase m-0">Add to Cart</p>
                  </button>
                  <button className="btn my-3 text-center p-2 bold-border text-uppercase custom-btn d-flex justify-content-center" onClick={this.onBackToCatalogClick}>
                    <p className="m-0">Continue Shopping</p>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </>
    ) : null;
  }
}

export default ProductDetails;
