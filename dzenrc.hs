import Control.Concurrent (threadDelay)
import Data.Time
import Data.Time.Clock

sleepToNextMinute :: IO ()
sleepToNextMinute = do t <- getCurrentTime
                       let secs = round (realToFrac $ utctDayTime t) `rem` 60
                       threadDelay $ 1000

main = myLoop
    where
        myLoop :: IO( )
        myLoop = do
            --print "Hi"
            t <- getCurrentTime
            let secs = round (realToFrac $ utctDayTime t) `rem` 60
            print secs
            threadDelay $ 1000
            myLoop
