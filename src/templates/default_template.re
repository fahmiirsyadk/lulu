let index = () => {j|
# LULU
statis site generator
|j};

let layout = () => {j|
module S = Silica.HTML;
module P = Silica.Property;

let head =
  S.head(
    [],
    [
      S.meta([P.language("id")], []),
      S.meta([P.name("author"), P.content("aerogel")], []),
      S.meta([P.charset("utf-8")], []),
      S.meta(
        [
          P.name("keyword"),
          P.content("reasonml static-site-generator aerogel nodejs"),
        ],
        [],
      ),
    ],
  );

let template = (body: string): string => {
  S.html([], [head, S.body([], [body])]);
};

let render = template;
|j};