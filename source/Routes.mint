enum Page {
  Home
  NotFound
}

store Application {
  state page : Page = Page::Home

  fun setPage (page : Page) : Promise(Never, Void) {
    next { page = page }
  }
}

routes {
  / {
    Application.setPage(Page::Home)
  }

  * {
    Application.setPage(Page::NotFound)
  }
}
