import Network.Curl
import Control.Monad 
import Control.Applicative
import Text.XML.Light
import Data.List.Split(splitOn)

url = "http://api.openweathermap.org/data/2.5/weather?q=Voronez,ru"

desc_template = "\"description\""
findData template s = foldl (++) "" lst
    where lst = filter (\x -> (take (length template) x) == template) . splitOn "," $ s

main
    = do
        putStr . findData desc_template . snd =<< curlGetString url []

