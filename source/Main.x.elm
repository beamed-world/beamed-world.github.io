module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html a
main =
    div []
        [ headerSection
        , mainSection
        , <div class="break"></div>
        , footerSection ]


headerSection : Html a
headerSection =
    let
        heading =
            <div class="col-xs">
                <h3 class="hug">Beamed World</h3>
            </div>
    in 
        <header>
            <br/>
            {containerWrap [ heading ]}
            <br/>
        </header>


mainSection : Html a
mainSection =
    <main'>
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3 main">

                <article>

                    <h1>Main Title</h1>

                    <p class='lead'>
                        This is lead text, it should probably say something important
                    </p>

                    <h2>Article Title</h2>

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
                

                <h2>Different Title</h2>

                <h3>Different text</h3>

                <p>
                    Cu idque ridens possit vel, placerat fabellas invenire cu ius! Illud apeirian ad mea, pri in ipsum molestie! At mea eros
                    nobis ceteros. Mea ullum epicuri salutandi cu, eu vix insolens ocurreret, eam no tale partiendo molestiae? Has
                    ex malorum mediocrem! Et sit lorem officiis lobortis, dicit aliquam inciderint quo ea ...
                </p>

                <br>

                <a href="#">Read more</a>

                </div>
            </div>
        </div>
    </main'>


footerSection : Html a
footerSection =
    <footer>
        <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
                <!--Made with love, in the absence of fear-->
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
