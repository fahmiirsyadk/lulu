module Core = {
    let render = (tag, attrs, children) => {
        let el = children === [] ? "" : List.fold_left((a, b) => a ++ b, List.hd(children), List.tl(children));
        let at = attrs === [] ? "" : List.fold_left((a, b) => {j|$a $b|j}, List.hd(attrs), List.tl(attrs));
        ({j|<$tag $at>$el</$tag>|j});
    };
    let attrFormat = (attr: string, prop: string) => {j|$attr="$prop"|j};
    let textAttr = (attr: string, prop: string): string => attrFormat(attr, prop);
    let boolAttr = (attr: string, prop: bool): string => prop -> string_of_bool |> attrFormat(attr);
};