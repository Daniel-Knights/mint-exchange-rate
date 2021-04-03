component Status {
  connect Conversion.Store exposing { statusMessage }

  style base {
    position: fixed;
    bottom: 20px;
    right: 25px;
    padding: 10px;
    font-size: 25px;
    color: #ff0000;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 15px -10px #000;
    animation: status-in 0.15s, status-in 0.15s 4.85s reverse forwards;

    @keyframes status-in {
      from {
        bottom: -100px;
      }
    }
  }

  fun render : Html {
    <div::base>
      <{ statusMessage }>
    </div>
  }
}
