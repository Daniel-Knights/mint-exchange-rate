component Pages.NotFound {
  style base {
    text-align: center;
  }

  fun render : Html {
    <div::base>
      <h1>"404"</h1>
      <p>"Page not found"</p>
    </div>
  }
}
