commits = {
  div: $("#commits tbody")
  init: () ->
    $.ajax "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/commits",
      method: "GET"
      headers: {"Authorization": "token #{storage.get 'login.token'}"}
      success: commits.success
      error: commits.error
    true
  error: (request, status, error) ->
    alert "Commits #{status}: #{error}"
    true
  success: (data, status, token) ->
    data.forEach (c) ->
      commits.div.append(
        $("<tr/>").append "<td>#{c.commit.message}</td><td><img src='#{c.author.avatar_url}' width='40'></td><td>#{c.commit.author.date}</td>"
      )
      true
    true
}

commits.init()