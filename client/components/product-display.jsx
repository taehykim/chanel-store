import React from 'react';

class ProductDisplay extends React.Component {
  render() {
    return (
      <div id="carouselExampleControls" className="carousel slide border-bottom" data-ride="carousel">
        <div><h1 className="text-uppercase text-center mt-3">summer 2020 collection</h1></div>
        <div className="carousel-inner d-flex justify-content-center">
          {this.props.products ? <div className="carousel-item carousel-custom m-0 active">
            <img className="d-block w-100" src={this.props.products[0].image} />
          </div> : <></>}
          {this.props.products ? this.props.products.slice(1).map(product => (
            <div className="carousel-item carousel-custom m-0" key={product.productId}>
              <img className="d-block w-100" src={product.image} />
            </div>
          )) : <></>}
        </div>
        <a className="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
          <span className="carousel-control-prev-icon" aria-hidden="true"></span>
          <span className="sr-only">Previous</span>
        </a>
        <a className="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
          <span className="carousel-control-next-icon" aria-hidden="true"></span>
          <span className="sr-only">Next</span>
        </a>
      </div>
    );
  }
}

export default ProductDisplay;
