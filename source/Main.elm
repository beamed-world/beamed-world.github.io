module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Http
import Markdown


type alias Post =
    { title : String
    , content : String
    }


type alias Model =
    { posts : List Post
    }


type Message
    = NoOp
    | SetPosts (List Post)


main : Program Never
main = Html.App.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


init : (Model, Cmd Message)
init =
    ( { posts = [] }
    , Cmd.none
    )


subscriptions : Model -> Sub Message
subscriptions model = Sub.none


update : Message -> Model -> (Model, Cmd Message)
update message model = (model, Cmd.none)


view : Model -> Html message
view model =
    div []
        [ headerSection
        , mainSection
        , Html.div [Html.Attributes.attribute "class" "break"] []
        , footerSection ]


headerSection : Html a
headerSection =
    let
        heading =
            Html.h3 [Html.Attributes.attribute "class" "hug"] [Html.text "Beamed World"]
    in
        Html.header [] [
            containerWrap [ heading ]
        ]


mainSection : Html a
mainSection =
    let
        article1 = articlePreview "Title 1"
        article2 = articlePreview "Title 2"
        article3 = articlePreview "Title 3"
    in
        Html.main' [] [
            Html.div [Html.Attributes.attribute "class" "container-fluid"] [
                Html.div [Html.Attributes.attribute "class" "row"] [
                    Html.div [Html.Attributes.attribute "class" (containerClass)] [
                        Html.h1 [] [Html.text "Hello"]
                        , Html.p [Html.Attributes.attribute "class" "lead"] [Html.text "Some catchy and enthusiastic line here"]
                    ]
                ]
            ]
            , Html.div [Html.Attributes.attribute "class" "container-fluid"] [
                Html.div [Html.Attributes.attribute "class" "row"] [
                    Html.div [Html.Attributes.attribute "class" (containerClass)] ([
                        ] ++  [article1, article2, article3] ++ [
                    ])
                ]
            ]
        ]


articlePreview : String -> Html a
articlePreview title =
    Html.article [] [
        Html.h2 [] [Html.text  title]
        , Html.h3 [] [Html.text "Some sort of byline that describes more"]
        , Html.small [] [Html.text "
            5 days ago @ 2016-10-03 14:40:45
        "]
        , Html.p [] [Html.text "
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna
            aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ...
        "]
        , Html.br [] []
        , Html.a [Html.Attributes.attribute "href" "#"] [Html.text "Read more"]
    ]


footerSection : Html a
footerSection =
    Html.footer [] [
        Html.div [Html.Attributes.attribute "class" "container-fluid"] [
            Html.div [Html.Attributes.attribute "class" "row"] [
                Html.div [Html.Attributes.attribute "class" (containerClass)] [
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


containerWrap : List (Html a) -> Html a
containerWrap children =
    Html.div [Html.Attributes.attribute "class" "container-fluid"] [
        Html.div [Html.Attributes.attribute "class" "row"] [
            Html.div [Html.Attributes.attribute "class" (containerClass)] ([
                ] ++  children ++ [
            ])
        ]
    ]


containerClass : String
containerClass =
    "col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3"
