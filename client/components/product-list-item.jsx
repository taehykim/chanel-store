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
      <div className="card-group m-auto two-col" style={{ flexBasis: '30%' }} onClick={this.handleCardClick}>
        <div className="card border-0">
          <img src={this.props.product.image} className="card-img-top product-img" />
          <div className="card-body text-center">
            <h5 className="card-title text-uppercase">{this.props.product.productName}</h5>
            <p className="card-text">${this.props.formatPrice(this.props.product.price / 100)}</p>
            <p className="card-text text-uppercase">{this.props.product.shortDescription}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default ProductListItem;
