###
  Store an object in `localStorage`, LZ compressed to Base 64. The key si the string {{ site.github.repository_url }}
  @example
  // Initialize storage in localStorage, called the first `get` or `set`
  storage.init()
  @example
  // Set a value for a key
  storage.set(key, value)
  @example
  // Get a key's value or whole object
  storage.get([key])
  @example
  // Remove a key value pair or clear whole object
  storage.clear([key])
  @example
  // Low level compression and storage
  storage.store(obj)
###
storage = {
  key: () ->
    return "{{ site.github.repository_nwo }}"
  init: () ->
    if !localStorage.getItem(storage.key())? then storage.store {
      "storage":
        "created": new Date()
        "tag": "{{ site.github.latest_release.tag_name }}"
        "build": "{{ site.github.build_revision }}"
      "repository":
        "url": "{{ site.github.repository_url }}"
    }
    true
  clear: (key) ->
    obj = storage.get()
    if key?
      storage.prop key, null, obj
      storage.store obj
    else
      localStorage.removeItem storage.key()
    true
  # https://stackoverflow.com/a/6394197
  set: (key, value) ->
    storage.init()
    obj = storage.get()
    storage.prop key, value, obj
    storage.store obj
    return storage # for multiple storage
  prop: (key, value, obj) ->
    key_array = key.split "."
    final = key_array.pop()
    while k = key_array.shift()
      if !obj[k]? then obj[k] = {}
      obj = obj[k]
    return if value then obj[final] = value else delete obj[final]
  get: (key) ->
    storage.init()
    return if key?
      key.split(".").reduce (data, i) =>
        return if data?[i] then data[i] else false
      , storage.get()
    else
      JSON.parse LZString.decompressFromBase64 localStorage.getItem storage.key()
  store: (obj) ->
    localStorage.setItem storage.key(), LZString.compressToBase64 JSON.stringify obj
    return obj
}
