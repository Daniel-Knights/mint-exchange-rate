component Currency {
  style currency {
    display: flex;
    flex-direction: column;
  }

  property onDataChange : Function(InputValues, Promise(Never, Void))
  property readonly : Bool = false
  property placeholder : String
  property result = 0
  property defaultLocale : String = "GBP"

  state amount : String = ""
  state locale : String = "GBP"

  fun setStateAndEmit (e : Html.Event) {
    sequence {
      isInput =
        Dom.matches("input", e.target)

      value =
        e.target
        |> Dom.getValue

      case (isInput) {
        true => next { amount = value }
        false => next { locale = value }
        => next {  }
      }

      onDataChange(InputValues(amount, locale))
    }
  }

  fun render : Html {
    <div::currency>
      if (readonly) {
        <input
          class="interactive"
          type="number"
          readonly={true}
          onInput={setStateAndEmit}
          value="#{result}"
          step="0.01"/>
      } else {
        <input
          class="interactive"
          type="number"
          placeholder={placeholder}
          onInput={setStateAndEmit}
          validate="false"
          step="0.01"/>
      }

      <select
        onChange={setStateAndEmit}
        class="interactive">

        for (currency of Currencies.abbreviations) {
          if (currency == defaultLocale) {
            <option
              value={currency}
              selected="true">

              <{ currency }>

            </option>
          } else {
            <option value={currency}>
              <{ currency }>
            </option>
          }
        }

      </select>
    </div>
  }
}
