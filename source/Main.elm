module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html a
main =
    div []
        [ headerSection
        , mainSection
        , Html.div [Html.Attributes.attribute "class" "break"] []
        , footerSection ]


headerSection : Html a
headerSection =
    let
        heading =
            Html.div [Html.Attributes.attribute "class" "col-xs"] [
                Html.h3 [Html.Attributes.attribute "class" "hug"] [Html.text "Beamed World"]
            ]
    in 
        Html.header [] [
            Html.br [] []
            , containerWrap [ heading ]
            , Html.br [] []
        ]


mainSection : Html a
mainSection =
    Html.main' [] [
        Html.div [Html.Attributes.attribute "class" "container-fluid"] [
            Html.div [Html.Attributes.attribute "class" "row"] [
                Html.div [Html.Attributes.attribute "class" "col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3 main"] [

                Html.article [] [

                    Html.h1 [] [Html.text "Main Title"]

                    , Html.p [Html.Attributes.attribute "class" "lead"] [Html.text "
                        This is lead text, it should probably say something important
                    "]

                    , Html.h2 [] [Html.text "Article Title"]

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
                

                , Html.h2 [] [Html.text "Different Title"]

                , Html.h3 [] [Html.text "Different text"]

                , Html.p [] [Html.text "
                    Cu idque ridens possit vel, placerat fabellas invenire cu ius! Illud apeirian ad mea, pri in ipsum molestie! At mea eros
                    nobis ceteros. Mea ullum epicuri salutandi cu, eu vix insolens ocurreret, eam no tale partiendo molestiae? Has
                    ex malorum mediocrem! Et sit lorem officiis lobortis, dicit aliquam inciderint quo ea ...
                "]

                , Html.br [] []

                , Html.a [Html.Attributes.attribute "href" "#"] [Html.text "Read more"]

                ]
            ]
        ]
    ]


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
