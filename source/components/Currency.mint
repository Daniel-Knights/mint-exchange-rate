component Currency {
  style currency {
    display: flex;
    flex-direction: column;
  }

  fun render : Html {
    <div::currency>
      <input
        class="interactive"
        type="number"/>

      <select class="interactive">
        for (currency of Currencies.abbreviations) {
          <option value="#{currency}">
            <{ currency }>
          </option>
        }
      </select>
    </div>
  }
}
