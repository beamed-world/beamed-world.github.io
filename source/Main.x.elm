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


mainSection : Html a
mainSection =
    let
        article1 = articlePreview "Title 1"
        article2 = articlePreview "Title 2"
        article3 = articlePreview "Title 3"
    in
        <main'>
            <div class="container-fluid">
                <div class="row">
                    <div class={containerClass}>
                        <h1>Hello</h1>
                        <p class="lead">Some catchy and enthusiastic line here</p>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class={containerClass}>
                        {: [article1, article2, article3]}
                    </div>
                </div>
            </div>
        </main'>


articlePreview : String -> Html a
articlePreview title =
    <article>
        <h2>{= title}</h2>
        <h3>Some sort of byline that describes more</h3>
        <small>
            5 days ago @ 2016-10-03 14:40:45
        </small>
        <p>
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna
            aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper ...
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
