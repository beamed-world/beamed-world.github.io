# Elmx

<!--{{{
  "title" : "Elmx",
  "date" : "2016-08-29T03:04:21.983Z",
  "byline": "React has come to the Elm language",
  "preview": "Elmx is a pre compiler for the Elm programming language. If you don't know about Elm, do some reading first, because Elmx targets an edge case, and knowing the mapping between a conventional Elm virtual DOM call and one set up with Elmx is critical."
}}}-->

Elmx is a pre compiler for the Elm programming language. If you don't know about
Elm, do some reading first, because Elmx targets an edge case, and knowing the
mapping between a conventional Elm virtual DOM call and one set up with Elmx is
critical.

Elmx is to Elm as JSX is to Javascript, and TSX is to TypeScript. If you are the
type of person who groks things with code, here is a sample to get you started.

```elmx
containerClass : String
containerClass =
    "col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3"


footerSection : Html a
footerSection =
    <footer>
        <div class="container-fluid">
            <div class="row">
                <div class={containerClass}>
                    <p>Made with</p>
                    <ul class="hug">
                        <li>flexboxgrid</li>
                        <li>normalize.css</li>
                        <li>typebase.css</li>
                        <li>Source Code Pro</li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
```

This is then mapped to the following plain Elm code

```elm
footerSection : Html a
footerSection =
    Html.footer [] [
        Html.div [Html.Attributes.attribute "class" "container-fluid"] [
            Html.div [Html.Attributes.attribute "class" "row"] [
                Html.div [Html.Attributes.attribute "class" "col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3"] [
                    Html.p [] [Html.text "Made with"]
                    , Html.ul [Html.Attributes.attribute "class" "hug"] [
                        Html.li [] [Html.text "flexboxgrid"]
                        , Html.li [] [Html.text "normalize.css"]
                        , Html.li [] [Html.text "typebase.css"]
                        , Html.li [] [Html.text "Source Code Pro"]
                    ]
                ]
            ]
        ]
    ]
```