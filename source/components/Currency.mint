record InputValues {
  amount : String,
  locale : String
}

component Currency {
  style currency {
    display: flex;
    flex-direction: column;
  }

  property onDataChange : Function(InputValues, Promise(Never, Void))
  property readonly : Bool = false
  property placeholder : String
  property result = 0

  state amount : String = "0"
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
          readonly={readonly}
          placeholder={placeholder}
          onInput={setStateAndEmit}
          value="#{result}"/>
      } else {
        <input
          class="interactive"
          type="number"
          placeholder={placeholder}
          onInput={setStateAndEmit}/>
      }

      <select
        onChange={setStateAndEmit}
        class="interactive">

        for (currency of Currencies.abbreviations) {
          <option value="#{currency}">
            <{ currency }>
          </option>
        }

      </select>
    </div>
  }
}
