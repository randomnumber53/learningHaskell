import Data.List

-- Problem 1 --

myLast :: [a] -> a
myLast [] = error "Can't call myLast on an empty list."
myLast [x] = x
myLast (_:xs) = myLast xs

-- Problem 2 --

myButLast :: [a] -> a
myButLast [] = error "Can't call myButLast on an empty list."
myButLast [_] = error "Can't call myButLast on a one-element list."
myButLast [x,_] = x
myButLast (_:xs) = myButLast xs

-- Problem 3 --

elementAt :: (Integral a) => [b] -> a -> b
elementAt [] _ = error "Index out of range."
elementAt (x:_) 1 = x
elementAt (_:xs) n
    | n <  1 = error "Index must be >= 1."
    | n >= 1 = elementAt xs (n - 1)

-- Problem 4 --

myLength :: (Num b) => [a] -> b
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

-- Problem 5 --

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- Problem 6 --

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = (xs == reverse xs)

-- Problem 7 --

data NestedList a = Elem a
                  | List [NestedList a]
                  deriving (Show, Read)

flatten :: NestedList a -> [a]
flatten (List []) = []
flatten (Elem a) = [a]
flatten (List (x:xs)) = flatten x ++ flatten (List xs)

-- Problem 8 --

compress :: (Eq a) => [a] -> [a]
compress [] = []
compress (x:xs) = x:compress (dropWhile (== x) xs)

-- Problem 9 --

pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack all@(x:xs) = (takeWhile (== x) all) : pack (dropWhile (== x) xs)

-- Problem 10 --

encode :: (Eq a) => [a] -> [(Int, a)]
encode xs = map (\xs -> (length xs, head xs)) $ pack xs

-- Problem 11 --

data Element a = Single a | Multiple Int a deriving (Show)

encodeOne :: [a] -> Element a
encodeOne [x] = Single x
encodeOne xs = Multiple (length xs) (head xs)

encodeModified :: (Eq a) => [a] -> [Element a]
encodeModified xs = map encodeOne $ pack xs

-- Problem 12 --

decodeModified :: (Eq a) => [Element a] -> [a]
decodeModified xs = concat $ map decodeOne xs
    where
        decodeOne (Single x) = [x]
        decodeOne (Multiple l x) = replicate l x

-- Problem 13 --

-- Not sure what the problem statement means.

-- Problem 14 --

dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = x:x:(dupli xs)

-- Problem 15 --

repli :: [a] -> Int -> [a]
repli [] _ = []
repli (x:xs) n = replicate n x ++ repli xs n

-- Problem 16 --

dropEvery :: [a] -> Int -> [a]
dropEvery xs n
    | length xs < n  = xs
    | length xs == n = init xs
    | otherwise      = take (n-1) xs ++ dropEvery (drop n xs) n

-- Problem 17 --

split :: [a] -> Int -> [[a]]
split xs n = [take n xs] ++ [drop n xs]

-- Problem 18 --

-- slice is inclusive --
slice :: [a] -> Int -> Int -> [a]
slice xs a b
    | b >= a    = take (b-a+1) $ drop (a-1) xs
    | otherwise = error "Not a valid slice."

-- Problem 19 --

rotate :: [a] -> Int -> [a]
rotate xs n = let bottom = n `mod` (length xs) + (length xs) + 1
                  top = bottom + (length xs) - 1
              in slice (cycle xs) bottom top

-- Problem 20 --

removeAt :: Int -> [a] -> (a, [a])
removeAt index xs = (xs !! (index-1),
                     take (index-1) xs ++ drop index xs)

-- Problem 21 --

insertAt :: a -> [a] -> Int -> [a]
insertAt e xs index = let [first, last] = split xs (index-1)
                      in first ++ e:last

-- Problem 22 --

range a b = [a..b]

-- Problem 23 --

-- Skipped, will learn how to do radomness in Haskell later

-- Problem 24 --

-- Skipped, will learn how to do radomness in Haskell later

-- Problem 25 --

-- Skipped, will learn how to do radomness in Haskell later

-- Problem 26 --

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs
    | length xs <  n = [[]]
    | length xs == n = [xs]
    | otherwise      = let loseIt = combinations n (tail xs) 
                           useIt  = map ((head xs):)
                                        (combinations (n-1) (tail xs))
                       in useIt ++ loseIt

-- Problem 27 --

giveGroups :: (Eq a) => [Int] -> [a] -> [[[a]]]
giveGroups [] [] = [[[]]]
giveGroups [n] choices = if length choices == n
                         then [[choices]]
                         else error "Group sizes don't work."
giveGroups (x:xs) choices =
    let starts = combinations x choices
        combos = [(used, (choices \\ used)) | used <- starts]
    in concat [(map ([start] ++ ) (giveGroups xs left)) |
               (start, left) <- combos]


-- Problem 28 --

lsort :: [[a]] -> [[a]]
lsort xs = sortBy (\x y -> length x `compare` length y) xs