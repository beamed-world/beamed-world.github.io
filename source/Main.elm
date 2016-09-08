module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Html.App
import Http
import Markdown
import Task
import Json.Decode as Json exposing ((:=))
import Debug
import Markdown
import WebGLExperiments

type alias Posts = List (Post)

type alias Post =
    { meta : Meta
    , content : String
    }

type alias Meta =
    { title : String
    , date : String
    , byline : String
    , preview : String
    }


type alias Model =
    { posts : Posts
    , selectedPost : Maybe Post
    }


type Message
    = NoOp
    | DeselectPost
    | SelectPost Post
    | SetPosts (Posts)


main : Program Never
main = WebGLExperiments.main
main_ = Html.App.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


init : (Model, Cmd Message)
init =
    ( { posts = [], selectedPost = Nothing }
    , Task.perform (always NoOp) SetPosts getData
    )


getData : Task.Task Http.Error Posts
getData = Http.get dataDecoder "/data.json"


dataDecoder : Json.Decoder Posts
dataDecoder =
    Json.object1 identity
        ("posts" := Json.list (
            Json.object2 Post
                ("meta" := Json.object4 Meta
                    ("title" := Json.string)
                    ("date" := Json.string)
                    ("byline" := Json.string)
                    ("preview" := Json.string)
                )
                ("content" := Json.string)
        ))


subscriptions : Model -> Sub Message
subscriptions model = Sub.none


update : Message -> Model -> (Model, Cmd Message)
update message model = -- (model, Cmd.none)
    case message of
        SetPosts posts ->
            ( { model | posts = posts }, Cmd.none)

        SelectPost post ->
            ( { model | selectedPost = Just post }, Cmd.none)

        DeselectPost ->
            ( { model | selectedPost = Nothing }, Cmd.none)

        NoOp ->
            (model, Cmd.none)


view : Model -> Html Message
view model =
    let
        index model =
            div []
                [ headerSection
                , mainSection model
                , footerSection ]
        article post =
            div []
                [ headerSection
                , containerWrap [(Markdown.toHtml [] post.content)]
                , footerSection ]

    in
        case model.selectedPost of
            Nothing -> index model

            Just post -> article post

headerSection : Html Message
headerSection =
    let
        heading =
            Html.h3 [Html.Events.onClick (DeselectPost), Html.Attributes.attribute "class" "hug"] [Html.text "Beamed World"]
    in
        Html.header [] [
            containerWrap [ heading ]
        ]


mainSection : Model -> Html Message
mainSection model =
    let
        articles = List.map postSection model.posts
        splash =
            Html.div [Html.Attributes.attribute "class" "container-fluid"] [
                Html.div [Html.Attributes.attribute "class" "row"] [
                    Html.div [Html.Attributes.attribute "class" (containerClass)] [
                        Html.h1 [] [Html.text "Hello"]
                        , Html.p [Html.Attributes.attribute "class" "lead"] [Html.text "Some catchy and enthusiastic line here"]
                    ]
                ]
            ]
    in
        Html.main' [] [
            splash
            , Html.div [Html.Attributes.attribute "class" "container-fluid"] [
                Html.div [Html.Attributes.attribute "class" "row"] [
                    Html.div [Html.Attributes.attribute "class" (containerClass)] ([
                        ] ++  articles ++ [
                    ])
                ]
            ]
        ]

postSection : Post -> Html Message
postSection post =
    Html.article [] [
        Html.h2 [] [Html.text  post.meta.title]
        , Html.h3 [] [Html.text  post.meta.byline]
        , Html.small [] [
            Html.text  post.meta.date
        ]
        , Html.p [] [
            Html.text  post.meta.preview
        ]
        , Html.br [] []
        , Html.a [Html.Attributes.attribute "href" "#", Html.Events.onClick (SelectPost post)] [Html.text "Read more"]
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


greetings : List (String)
greetings =
    [ "Hello"
    , "Hey"
    , "Sup"
    , "Welcome"
    , "Greetings"
    , "Hi"
    , "G'day"
    ]


leads : List (String)
leads = 
    [ "Some catchy and enthusiastic line here"
    , "Remember, no matter where you go, there you are"
    , "This is lead text, hopefully it says something interesting"
    , "All of this is random. Really"
    , "I can't believe people make these things static, such useful realestate"
    ]