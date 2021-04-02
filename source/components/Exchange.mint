component Exchange {
  style base {
    display: flex;
    align-items: center;
    flex-direction: column;
  }

  style currencies {
    display: flex;
  }

  fun render : Html {
    <form::base onSubmit={Html.Event.preventDefault()}>
      <div::currencies>
        <Currency/>
        ":"
        <Currency/>
      </div>

      <button class="interactive">
        "Convert"
      </button>
    </form>
  }
}
