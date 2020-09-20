let getMd = {|---
title: My first page
---

# Hello world
|}
let getHtml =
  {j|
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ matter.title }}</title>
</head>
<body>
  {{ children }}
</body>
</html>
|j}
