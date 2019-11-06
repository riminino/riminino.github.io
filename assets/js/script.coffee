---
---

# Includes
{% include scripts/storage.coffee %}
{% include scripts/login.coffee %}
{% include scripts/datetime.coffee %}
{% include scripts/commits.coffee %}
{% comment %}
{% include scripts/create.coffee %}
{% include scripts/modal_alert.coffee %}
{% include scripts/commit.coffee %}
{% include scripts/yaml.coffee %}
{% endcomment %}

# Init or get storage
console.log storage.get()