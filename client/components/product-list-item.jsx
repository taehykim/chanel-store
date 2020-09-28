import React from 'react';

class ProductListItem extends React.Component {
  render() {
    return (
      <div
        className="card justify-content-center align-items-center m-3"
        style={{ width: '28%', height: '500px' }}
      >
        <div style={{ width: '100%', height: '100%' }}>
          <div
            style={{
              height: '60%',
              backgroundImage: `url(${this.props.product.image})`,
              backgroundSize: 'contain',
              backgroundRepeat: 'no-repeat',
              backgroundPosition: 'center'
            }}
          ></div>
          <div className="card-body">
            <h5 className="card-title">{this.props.product.name}</h5>
            <p className="card-text">
              ${(this.props.product.price / 100).toFixed(2)}
            </p>
            <p className="card-text">{this.props.product.shortDescription}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default ProductListItem;
