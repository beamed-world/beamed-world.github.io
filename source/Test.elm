import Html exposing (..)
import Json.Decode as Json exposing ((:=))
import Debug

type alias Data =
    { posts : Posts }

type alias Posts = List (Post)

type alias Post =
    { meta : Meta
    , content : String
    }

type alias Meta =
    { title : String
    , data : String
    , byline : String
    }

main = text (toString (Json.decodeString myDecoder dataJson))


myDecoder : Json.Decoder Posts
myDecoder =
    Json.object1 identity
        ("posts" := Json.list (
            Json.object2 Post
                ("meta" := Json.object3 Meta
                    ("title" := Json.string)
                    ("date" := Json.string)
                    ("byline" := Json.string)
                )
                ("content" := Json.string)
        ))


dataJson = """
{"posts":[{"meta":{"title":"Ebike fly wheel","date":"2016-08-29T03:04:21.983Z","byline":"Past meets future"},"content":""},{"meta":{"title":"Elmx","date":"2016-08-29T03:04:21.983Z","byline":"React has come to the Elm language"},"content":""},{"meta":{"title":"Lorem Ipsum","date":"2016-08-29T03:04:21.983Z","byline":"Why Lorem Ipsum still hasn't gone out of fashion"},"content":""},{"meta":{"title":"Markdown front matter","date":"2016-08-29T03:04:21.983Z","byline":"YAML is too easy for my human eyes"},"content":""},{"meta":{"title":"Universal visualizer","date":"2016-08-29T03:04:21.983Z","byline":"93 bilion lightyears, nearly 14 billion years, someone has to do something"},"content":""},{"meta":{"title":"Universal visualizer","date":"2016-08-29T03:04:21.983Z","byline":"93 bilion lightyears, nearly 14 billion years, someone has to do something"},"content":""}]}
"""