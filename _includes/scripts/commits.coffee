commits = {
  div: $("#commits")
  body: $("#commits tbody")
  init: () ->
    header = if storage.get("login.token") then {"Authorization": "token #{storage.get 'login.token'}"} else {}
    data = {}
    if commits.div.data "path" then data.path = commits.div.data "path"
    if commits.div.data "author" then data.author = commits.div.data "author"
    if commits.div then $.ajax "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/commits",
      method: "GET"
      headers: header
      data: data
      success: commits.success
      error: commits.error
    true
  error: (request, status, error) ->
    alert "Commits #{status}: #{error}"
    true
  success: (data, status, token) ->
    data.forEach (c) ->
      commits.body.append(
        $("<tr/>").append([
          $("<td/>",{ text: "#{c.commit.message}" }),
          $("<td/>").append(
            $("<img/>",{ src: "#{c.author.avatar_url}", width: 40 })
          ),
          $("<td/>",{ text: "#{c.commit.comment_count}" }),
          $("<td/>").append(
            $("<span/>",{
              text: "#{c.commit.author.date}"
              datetime: "#{c.commit.author.date}"
              "data-embed": true
            })
          )
        ])
      )
      true
    $("#commits tbody [datetime]").each -> dateTime @
    true
}

commits.init()