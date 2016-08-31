module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Http
import Markdown
import Task
import Json.Decode as Json exposing ((:=))
import Debug
import Markdown

type alias Data =
    { posts : Posts }

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
    | SetPosts (Posts)


main : Program Never
main = Html.App.program
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

        NoOp ->
            (model, Cmd.none)


view : Model -> Html message
view model =
    div []
        [ headerSection
        , mainSection model
        , <div class="break"></div>
        , footerSection ]


headerSection : Html a
headerSection =
    let
        heading =
            <h3 class="hug">Beamed World</h3>
    in
        <header>
            {containerWrap [ heading ]}
        </header>


mainSection : Model -> Html a
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

postSection : Post -> Html a
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
        <a href="#">Read more</a>
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
