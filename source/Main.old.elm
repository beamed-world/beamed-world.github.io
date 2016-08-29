module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html a
main =
    header'


header' : Html a
header' = Html.header [] [Html.text "Its a header"]

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
