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
            <h3 onClick={DeselectPost} class="hug">Beamed World</h3>
    in
        <header>
            {containerWrap [ heading ]}
        </header>


mainSection : Model -> Html Message
mainSection model =
    let
        articles = List.map postSection model.posts
        splash =
            <div class="container-fluid">
                <div class="row">
                    <div class={containerClass}>
                        <h1>Hello</h1>
                        <p class="lead">Some catchy and enthusiastic line here</p>
                    </div>
                </div>
            </div>
    in
        <main'>
            {splash}
            <div class="container-fluid">
                <div class="row">
                    <div class={containerClass}>
                        {: articles}
                    </div>
                </div>
            </div>
        </main'>

postSection : Post -> Html Message
postSection post =
    <article>
        <h2>{= post.meta.title}</h2>
        <h3>{= post.meta.byline}</h3>
        <small>
            {= post.meta.date}
        </small>
        <p>
            {= post.meta.preview}
        </p>
        <br>
        <a href="#" onClick={SelectPost post}>Read more</a>
    </article>


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


containerWrap : List (Html a) -> Html a
containerWrap children =
    <div class="container-fluid">
        <div class="row">
            <div class={containerClass}>
                {: children}
            </div>
        </div>
    </div>


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