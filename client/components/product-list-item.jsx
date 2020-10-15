import React from 'react';

class ProductListItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleCardClick = this.handleCardClick.bind(this);
  }

  handleCardClick() {
    this.props.setView('details', this.props.product.productId);
  }

  render() {
    return (
      <div
        className="card justify-content-center align-items-center m-3 coffee-card"
        style={{
          width: '500px',
          height: '300px',
          borderRadius: '50px'
        }}
        onClick={this.handleCardClick}
      >
        <div
          className="d-flex p-3"
          style={{
            width: '100%',
            height: '100%'
          }}
        >
          <div
            style={{
              height: '100%',
              backgroundImage: `url(${this.props.product.image})`,
              backgroundSize: 'contain',
              backgroundRepeat: 'no-repeat',
              backgroundPosition: 'center',
              flexBasis: '100%'
            }}
          ></div>
          <div className="card-body">
            <h5 className="card-title h5">{this.props.product.productName}</h5>
            <p className="card-text h5">
              PRICE: ${(this.props.product.price / 100).toFixed(2)}
            </p>
            <p className="card-text">{this.props.product.shortDescription}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default ProductListItem;
