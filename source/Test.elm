module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html a
main =
    header'


header' : Html a
header' =
    Html.header [] [
        Html.br [] []
        , Html.div [Html.Attributes.attribute "class" "container-fluid"] [
            Html.div [Html.Attributes.attribute "class" "row"] [
                Html.div [Html.Attributes.attribute "class" (containerClass)] [
                    Html.div [Html.Attributes.attribute "class" "row"] [
                        Html.div [Html.Attributes.attribute "class" "col-xs"] [
                            Html.h3 [Html.Attributes.attribute "class" "hug"] [Html.text "Beamed World"]
                        ]
                    ]
                ]
            ]
        ]
        , Html.br [] []
    ]

{--
    header []
        [ br [] []
        , divClass "container-fluid"
            [ divClass "row"
                [ divClass containerClass
                    [ divClass "row"
                        [ divClass "col-xs"
                            [ h3 [ class "hug" ] [ text "Beamed World" ]
                            ]
                        ]
                    ]
                ]
            ]
        , br [] []
        ]
--}


divClass : String -> List (Html a) -> Html a
divClass s =
    div [ class s ]


containerClass : String
containerClass =
    "col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3"
