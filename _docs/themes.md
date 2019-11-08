---
---

# Themes
{:.no_toc}

* toc
{:toc}

## Syntax highlight

Compile a new rouge stylesheet

```sh
$ rougify style github > assets/css/syntax/github.css
```

Add the new file path in `_config.yml` as a `syntax` property.

```yml
css:
  syntax: filename.css
```