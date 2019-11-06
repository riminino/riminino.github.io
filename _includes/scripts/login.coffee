###
  Need:
  - Login link with id="login-button"
###
login = {
  link: $ "#login-button"
  init: () ->
    if storage.get("login.token") and login.link.text() == "Login"
      login.link.text 'Logout'
        .off "click"
        .on "click", login.logout
    else
      login.link.on "click", login.serve
    true
  serve: (e) ->
    token = prompt "Paste a GitHub personal token"
    if token
      storage.set "login.token", token
      login.link.prop "disabled", true
      $.ajax "{{ site.github.api_url }}/user",
        method: "GET"
        headers: {"Authorization": "token #{token}"}
        success: login.success
        error: login.error
        complete: login.complete
    true
  complete: (request, status) ->
    login.link.prop "disabled", false
  success: (data, status, token) ->
    storage.set "login.user", data.login
      .set "login.created", new Date()
    alert "Logged as #{data.login}"
    login.link.text "Logout"
      .off "click"
      .on "click", login.logout
    true
  error: (request, status, error) ->
    storage.clear "login"
    alert "#{status}: #{error}"
    true
  logout: (e) ->
    storage.clear()
    alert "Logged out"
    $(e.target).text "Login"
      .off "click"
      .on "click", login.serve
    true
}
login.init()