import React from 'react';

class DisclaimerModal extends React.Component {
  render() {
    let modalClassName = 'modal';
    if (this.props.agreeStatus) {
      modalClassName += ' fade';
    } else {
      modalClassName += ' d-block';
    }

    return (
      <div
        className={modalClassName}
        id="exampleModalCenter"
        role="dialog"
        style={{ backgroundColor: 'rgba(209, 209, 209, 0.6)' }}
      >
        <div className="modal-dialog modal-dialog-centered" role="document">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title" id="exampleModalLongTitle">
                Disclaimer
              </h5>
            </div>
            <div className="modal-body">
              <p className="text-justify">
                By clicking the <b>Agree and Continue</b> button below, I hearby
                understand the following terms: <br />
              </p>
              <ul>
                <li>
                  This website is a simple <a href="https://www.chanel.com/us/" target="_blank" rel="noopener noreferrer" style={{ color: 'black' }}>Chanel</a> store clone for demonstration purposes.
                </li>
                <li>
                  I understand that the content provided in this website is for
                  <b> demonstration </b>
                  purposes only, and thus no real purchases can be made.
                </li>
                <li>
                  I understand that I must <b>not</b> provide my real payment
                  information in the checkout page.
                </li>
              </ul>
            </div>
            <div className="modal-footer">
              <button
                type="button"
                className="btn btn-dark"
                onClick={this.props.onAgreeClick}
              >
                Agree and Continue
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default DisclaimerModal;
