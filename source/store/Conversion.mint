record Response {
  conversionResult : Number using "conversion_result",
  baseCode : String using "base_code",
  conversionRate : Number using "conversion_rate",
  documentation : String,
  result : String,
  targetCode : String using "target_code",
  termsOfUse : String using "terms_of_use",
  timeLastUpdateUnix : Number using "time_last_update_unix",
  timeLastUpdateUtc : String using "time_last_update_utc",
  timeNextUpdateUnix : Number using "time_next_update_unix",
  timeNextUpdateUtc : String using "time_next_update_utc"
}

store Conversion.Store {
  state result = 0
  state statusMessage = ""

  fun setStatusMessage (msg : String) {
    sequence {
      next { statusMessage = msg }

      Timer.timeout(5000, "")

      next { statusMessage = "" }
    }
  }

  fun setErrorStatus {
    setStatusMessage("Unable to run conversion, please try again")
  }

  fun requestConversion (query : String) : Promise(Never, Void) {
    sequence {
      response =
        "https://v6.exchangerate-api.com/v6/303eeb76b19731bb236c2771/pair/" + query
        |> Http.get()
        |> Http.send()

      try {
        object =
          Json.parse(response.body)
          |> Maybe.toResult("")

        decodedObject =
          decode object as Response

        next { result = decodedObject.conversionResult }
      } catch String => error {
        sequence {
          Debug.log(error)
          setErrorStatus()
        }
      } catch Object.Error => error {
        sequence {
          Debug.log(error)
          setErrorStatus()
        }
      }
    } catch Http.ErrorResponse => error {
      sequence {
        Debug.log(error)
        setErrorStatus()
      }
    }
  }
}
