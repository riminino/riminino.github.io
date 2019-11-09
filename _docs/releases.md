---
weight: 5
---

# Releases
{:.no_toc}

* toc
{:toc}

## List

{% for r in site.github.releases %}- {{ r | inspect}}
{% endfor %}

{% include widgets/releases.html %}

Create a release on GitHub [New release]({{ site.github.repository_url }})