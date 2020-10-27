import React from 'react';

class CardSummaryItem extends React.Component {
  constructor(props) {
    super(props);
    this.onRemoveClick = this.onRemoveClick.bind(this);
  }

  onRemoveClick() {
    const cartItemId = this.props.groupedItem.item.cartItemId;

    fetch(`/api/cart/${cartItemId}`, { method: 'DELETE', headers: { 'Content-Type': 'application/json' } })
      .then()
      .then(data => {
        this.props.updateCart();
      })
      .catch(err => console.error(err));
  }

  render() {
    return (
      <div className="card mb-3 border-0 cart-summary-card">
        <div className="row no-gutters justify-content-around align-items-center">
          <div className="col-md-3">
            <img src={this.props.groupedItem.item.image} className="card-img" />
          </div>
          <div className="col-md-3">
            <div className="card-body p-0 d-flex flex-column justify-content-center align-items-stretch">
              <span className="card-title text-uppercase product-detail-title my-3 border-0">{this.props.groupedItem.item.name}</span>
              <p className="card-text my-3">{this.props.groupedItem.item.shortDescription}</p>
              <p className="card-text my-3 price">${this.props.formatPrice(this.props.groupedItem.item.price / 100)}</p>
              <p className="card-text my-3">Quantity {this.props.groupedItem.count}</p>
              <div className="text-uppercase d-flex">
                <p className="m-0 remove-btn" onClick={this.onRemoveClick}>Remove</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default CardSummaryItem;
