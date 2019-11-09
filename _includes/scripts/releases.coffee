releases = {
  div: $("#releases")
  body: $("#releases tbody")
  init: () ->
    header = if storage.get("login.token") then {"Authorization": "token #{storage.get 'login.token'}"} else {}
    if releases.div.length then $.ajax "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/releases",
      method: "GET"
      headers: header
      success: releases.success
      error: releases.error
    true
  error: (request, status, error) ->
    alert "Releases #{status}: #{error}"
    true
  success: (data, status, token) ->
    data.forEach (r) ->
      checkbox = { type: "checkbox" }
      if r.draft then checkbox.checked = true
      releases.body.append(
        $("<tr/>").append([
          $("<td/>").append(
            $("<input/>", checkbox)
          ),
          $("<td/>",{ text: "#{r.name}" }),
          $("<td/>",{ text: "#{r.body}" }),
          $("<td/>").append(
            $("<span/>",{
              text: "#{r.created_at}"
              datetime: "#{r.created_at}"
              "data-replace": true
            })
          ),
          $("<td/>").append(
            $("<a/>", {
              href: "#{r.html_url.replace /\/tag\//gi, '/edit/'}"
              text: "Edit"
            })
          )
        ])
      )
      true
    $("#releases tbody [datetime]").each -> dateTime @
    true
}

releases.init()