component Main {
  connect Application exposing { page }

  style base {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    height: 100vh;
    width: 100vw;
    font-family: 'Asap Condensed', sans-serif;
    font-size: 50px;
    color: #fff;
    background: linear-gradient(#3CA470, #1C97C6);
  }

  fun render : Html {
    <div::base>
      case (page) {
        Page::Home =>
          <Home/>

        Page::NotFound =>
          <NotFound/>
      }
    </div>
  }
}
