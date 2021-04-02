component Exchange {
  style base {
    display: flex;
    align-items: center;
    flex-direction: column;
  }

  style currencies {
    display: flex;
  }

  state baseValues : InputValues = InputValues("0", "GBP")
  state compareValues : InputValues = InputValues("0", "GBP")

  fun updateBaseValues (values : InputValues) : Promise(Never, Void) {
    next { baseValues = values }
  }

  fun updateCompareValues (values : InputValues) : Promise(Never, Void) {
    next { compareValues = values }
  }

  fun render : Html {
    <form::base
      onSubmit={
        (e : Html.Event) {
          sequence {
            Html.Event.preventDefault(e)
            Conversion.Store.requestConversion("#{baseValues.locale}/#{compareValues.locale}/#{baseValues.amount}")
          }
        }
      }>

      <div::currencies>
        <Currency
          onDataChange={updateBaseValues}
          placeholder="Amount"/>

        ":"

        <Currency
          onDataChange={updateCompareValues}
          readonly={true}
          placeholder="Result"
          result={Conversion.Store.result}/>
      </div>

      <button class="interactive">
        "Convert"
      </button>

    </form>
  }
}
