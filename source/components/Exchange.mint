component Exchange {
  connect Conversion.Store exposing { result, setStatusMessage, requestConversion }

  style base {
    display: flex;
    align-items: center;
    flex-direction: column;
    position: relative;
  }

  style currencies {
    display: flex;
  }

  state baseValues : InputValues = InputValues("0", "GBP")
  state compareLocale : String = "USD"

  fun updateBaseValues (values : InputValues) : Promise(Never, Void) {
    next { baseValues = values }
  }

  fun updateCompareLocale (values : InputValues) : Promise(Never, Void) {
    next { compareLocale = values.locale }
  }

  fun handleSubmit (e : Html.Event) {
    sequence {
      Html.Event.preventDefault(e)

      if (baseValues.amount == "0") {
        setStatusMessage("Invalid amount")
      } else {
        requestConversion("#{baseValues.locale}/#{compareLocale}/#{baseValues.amount}")
      }
    }
  }

  fun render : Html {
    <form::base onSubmit={handleSubmit}>
      <div::currencies>
        <Currency
          onDataChange={updateBaseValues}
          placeholder="Amount"/>

        ":"

        <Currency
          onDataChange={updateCompareLocale}
          readonly={true}
          placeholder=""
          result={result}
          defaultLocale="USD"/>
      </div>

      <button class="interactive">
        "CONVERT"
      </button>
    </form>
  }
}
