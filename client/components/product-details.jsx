import React from 'react';

class ProductDetails extends React.Component {
  constructor(props) {
    super(props);
    this.state = { product: null };
    this.onBackToCatalogClick = this.onBackToCatalogClick.bind(this);
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
    this.props.setView('catalog', {});
  }

  render() {
    return this.state.product ? (
      <div className="d-flex justify-content-center align-items-center py-5">
        <div className="card" style={{ width: '85%' }}>
          <div className="card-body">
            <div className="back" onClick={this.onBackToCatalogClick}>
              &lt; Back to catalog
            </div>
            <div className="d-flex">
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
              {/* <img src={this.state.product.image} /> */}
              <div className="p-3">
                <h5 className="card-title">{this.state.product.name}</h5>
                <p className="card-text">
                  ${(this.state.product.price / 100).toFixed(2)}
                </p>
                <p className="card-text">
                  {this.state.product.shortDescription}
                </p>
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
