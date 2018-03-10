module Main exposing (..)

import Html exposing (Html, beginnerProgram)
import Element
import Element.Attributes exposing (..)
import Element.Input
import Style exposing (..)
import Style.Font as Font
import Style.Color as Color
import Style.Border
import Style.Color
import Color exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }



-- Model


type alias Model =
    { searchText : String }


init : Model
init =
    Model ""



-- Update


type Msg
    = SetSearchText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetSearchText value ->
            { model | searchText = value }


type MyStyles
    = Header
    | Footer
    | Page
    | Body
    | Results
    | Config
    | ConfigBox
    | Content
    | Form
    | FormBox
    | FormElements
    | Intro
    | ConfigHeader
    | FormItem
    | None



-- We define our stylesheet


type alias AppColors =
    { textBase : Color
    , headerBackground : Color
    , bodyBackground : Color
    }


colors : AppColors
colors =
    { textBase = Color.rgba 53 56 61 1
    , headerBackground = Color.rgba 175 237 255 1
    , bodyBackground = Color.rgba 237 241 244 1
    }


stylesheet : StyleSheet MyStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style Header
            [ Color.text colors.textBase
            , Color.background colors.headerBackground
            , Font.typeface [ Font.sansSerif ]
            , Font.size 64
            ]
        , Style.style Footer
            [ Color.text colors.textBase
            , Color.background colors.headerBackground
            , Font.typeface [ Font.sansSerif ]
            , Font.size 18
            ]
        , Style.style Body
            [ Color.text colors.textBase
            , Font.typeface [ Font.sansSerif ]
            , Color.background colors.bodyBackground
            , Font.size 16
            ]
        , Style.style Intro
            [ Color.text colors.textBase
            , Font.typeface [ Font.sansSerif ]
            , Font.size 16
            ]
        , Style.style ConfigHeader
            [ Color.text colors.textBase
            , Font.typeface [ Font.sansSerif ]
            , Font.size 24
            , Font.bold
            ]
        , Style.style Form
            [ Style.Border.solid
            , Style.Border.all 1
            , Style.Color.border black
            ]
        , Style.style Config
            [ Style.Border.solid
            , Style.Border.all 1
            , Style.Color.border black
            ]
        , Style.style Results
            [ Style.Border.solid
            , Style.Border.all 1
            , Style.Color.border black
            ]
        ]


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        Element.column Page
            []
            [ header model
            , body model
            , footer model
            ]


header : Model -> Element.Element MyStyles variation Msg
header model =
    Element.row Header
        [ width (percent 100)
        , paddingLeft 50
        , paddingTop 20
        , paddingBottom 20
        ]
        [ Element.el None [ center ] (Element.text "Elm Sifter Demo")
        ]


footer : Model -> Element.Element MyStyles variation Msg
footer model =
    Element.row Footer
        [ width (percent 100)
        , paddingLeft 50
        , paddingTop 20
        , paddingBottom 20
        ]
        [ Element.el None [ center ] (Element.text "footer")
        ]


introText : String
introText =
    """
  Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus
  """


body : Model -> Element.Element MyStyles variation Msg
body model =
    Element.column Body
        [ paddingLeft 50
        , paddingRight 50
        , paddingBottom 30
        ]
        [ Element.paragraph Intro [ paddingTop 20 ] [ Element.text introText ]
        , formElements model
        , mainContent model
        ]


formElements : Model -> Element.Element MyStyles variation Msg
formElements model =
    Element.column FormElements
        [ paddingTop 30 ]
        [ Element.el ConfigHeader [] (Element.text "Config Editor")
        , Element.row FormBox
            [ spacing 30
            , alignLeft
            , paddingTop 5
            ]
            [ formItem model
            , formItem model
            , formItem model
            ]
        ]


formItem : Model -> Element.Element MyStyles variation Msg
formItem model =
    Element.column Form
        [ width (percent 30)
        , padding 7
        ]
        [ Element.el FormItem [] (Element.text "form element")
        , Element.el FormItem [] (Element.text "form element")
        , Element.el FormItem [] (Element.text "form element")
        ]


mainContent : Model -> Element.Element MyStyles variation Msg
mainContent model =
    Element.row Content
        [ alignLeft
        , spacing 30
        , paddingTop 40
        ]
        [ config model
        , results model
        ]


config : Model -> Element.Element MyStyles variation Msg
config model =
    Element.column ConfigBox
        [ width (percent 50) ]
        [ Element.el ConfigHeader [] (Element.text "Config")
        , Element.column Config
            [ padding 7 ]
            [ Element.el None [] (Element.text "config")
            , Element.el None [] (Element.text "config")
            , Element.el None [] (Element.text "config")
            , Element.el None [] (Element.text "config")
            , Element.el None [] (Element.text "config")
            , Element.el None [] (Element.text "config")
            ]
        ]


results : Model -> Element.Element MyStyles variation Msg
results model =
    Element.column ConfigBox
        [ width (percent 50) ]
        [ Element.Input.text None
            []
            { label =
                Element.Input.placeholder
                    { label =
                        Element.Input.labelLeft
                            (Element.el None [ verticalCenter ] (Element.text "Search For:"))
                    , text = ""
                    }
            , onChange = SetSearchText
            , options = []
            , value = ""
            }
        , Element.el ConfigHeader [ paddingTop 10 ] (Element.text "Search Results")
        , Element.column Config
            [ padding 7 ]
            [ Element.el None [] (Element.text "results")
            , Element.el None [] (Element.text "results")
            , Element.el None [] (Element.text "results")
            , Element.el None [] (Element.text "results")
            , Element.el None [] (Element.text "results")
            ]
        ]
