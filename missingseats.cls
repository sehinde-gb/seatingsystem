Class Missing.Seats Extends %RegisteredObject
{

ClassMethod Insert()
{
           
            set initialStr=##class(%ArrayOfDataTypes).%New()
            do initialStr.SetAt("L.LL.LL.LL","1")
            do initialStr.SetAt("LLLLLLL.LL", "2")
            do initialStr.SetAt("L.L.L..L..", "3")
            do initialStr.SetAt("LLLL.LL.LL", "4")
            do initialStr.SetAt("L.LL.LL.LL", "5")
            do initialStr.SetAt("L.LLLLL.LL", "6")
            do initialStr.SetAt("..L.L.....", "7")
            do initialStr.SetAt("LLLLLLLLLL", "8")
            do initialStr.SetAt("L.LLLLLL.L", "9")
            do initialStr.SetAt("L.LLLLL.LL", "10")
            
            set occupied=##class(%ArrayOfDataTypes).%New()
           
            do occupied.SetAt("#.##.##.##", "1")
            do occupied.SetAt("#######.##", "2")
            do occupied.SetAt("#.#.#..#..", "3")
            do occupied.SetAt("####.##.##", "4")
            do occupied.SetAt("#.##.##.##", "5")
            do occupied.SetAt("#.#####.##", "6")
            do occupied.SetAt("..#.#.....", "7")
            do occupied.SetAt("##########","8")
            do occupied.SetAt("#.######.#", "9")
            do occupied.SetAt("#.#####.##", "10")
            
            // Finding a key
            //write occupied.GetAt("####.##.##") ,!
           
            
            write *32
            write "Count: ",initialStr.Count()
            //set count = initial.Count()

            do ..Main(.initialStr, .count)
}

// 

ClassMethod Process(ByRef initialStr As %String)
{
    

    set initialStr(1)="L.LL.LL.LL"
    set initialStr(2)="LLLLLLL.LL"
    set initialStr(3)="L.L.L..L.."
    set initialStr(4)="LLLL.LL.LL"
    set initialStr(5)="L.LL.LL.LL"
    set initialStr(6)="L.LLLLL.LL"
    set initialStr(7)="..L.L....."
    set initialStr(8)="LLLLLLLLLL"
    set initialStr(9)="L.LLLLLL.L"
    set initialStr(10)="L.LLLLL.LL"


    do ..Main(.initialStr)
}

// Main program calls findnextSeat function to calculate vacant seats

ClassMethod Main(ByRef initialStr As %String)
{
    set counter=0
    
    for {
        kill lastArr
        merge lastArr=initialStr

        write "main" ,!
        
        //do ..findnextSeat(.initialStr)
        do ..findnextSeatChanges(.initialStr)
        quit
        do ..IsIdentical(.initialStr,.lastArr)
        set counter= $INCREMENT(counter)
        set answer=..IsIdentical(.initialStr, .lastArr)
        write "Answer is: ", answer ,!
    }
}

// set up the single string variable and loops through it to extract the occupied characters 

ClassMethod findnextSeat(initialStr As %String)
{
    
    set row = 1
    
    for {
         
        // set a row by ordering the string and if it encounters a blank field quit
        set row = $ORDER(initialStr(row)) quit:row=""
        write "row is :",row ,!
        // pull out a row and set a single row to be the value initial
        set initial = initialStr(row)
     
        // loop find out the length of a single row
        for loc=1:1:$LENGTH(initial){
            set char =$EXTRACT(initial,loc)
            continue:char="."
            // create new variable and assign the array to it
            set occupiedseatsAdj=..occupiedseatsAdj(.initialStr,.loc,.row)

            // check to see if it contains L characters and not next to adjacent seats
            // extract the occupied figures from each line in the string
            if char="L",'occupiedseatsAdj
             {
                 set $EXTRACT(initial,loc)="#"
                 continue
             }
                 if char="#",occupiedseatsAdj>=4 
                 {
                 set $EXTRACT(initial,loc)="L"
                 continue
                }
             }

             
             // set the next row within the string
             set nextStr(row)=initial
         }
    // on completion kill the array and merge it in to next string
     
    kill initialStr
    merge initialStr=nextStr

    write "find next Completed",!
}

// set up the single string variable and loops through it to extract the occupied characters 

ClassMethod findnextSeatChanges(initialStr As %String, ByRef row As %Integer)
{
    set row = 1
    
    for {
         
        // set a row by ordering the string and if it encounters a blank field quit
        set row = $ORDER(initialStr(row)) quit:row=""
        write "row is :",row ,!
        // pull out a row and set a single row to be the value initial
        set initial = initialStr(row)
     
        // loop find out the length of a single row
        for loc=1:1:$LENGTH(initial){
            set char =$EXTRACT(initial,loc)
            continue:char="."
            // create new variable and assign the array to it
            set occupiedseatsChg=..occupiedseatsChg(.initialStr,.loc,.row)

            // check to see if it contains L characters and not next to adjacent seats
            // extract the occupied figures from each line in the string
            if char="L",'occupiedseatsChg
             {
                 set $EXTRACT(initial,loc)="#"
                 continue
             }
                 if char="#",occupiedseatsChg>=4 
                 {
                 set $EXTRACT(initial,loc)="L"
                 continue
                }
             }

             
             // set the next row within the string
             set nextStr(row)=initial
         }
    // on completion kill the array and merge it in to next string
     
    kill initialStr
    merge initialStr=nextStr

    write "find next changes completed",!
}

/// Sorts the initialStr and sets up a single row and then updates the total variable
ClassMethod totaloccupiedSeats(initialStr As %String)
{
    set total=0
    set row=""

     for {
        // set a row by ordering the array and if it encounters a blank field quit
        set row = $ORDER(initialStr(row)) quit:row=""
        // pull out a row and set a single row to be the value initial
        set initial = initialStr(row)

        set total=total+$LENGTH(initial,"#")-1
    }
    quit total
}

// X and Y are passed to the method and this is used to extract these from the initialStr

ClassMethod occupiedseatsAdj(initialStr As %String, X, Y)
{
    set total=0
    for adjX=X-1:1:X+1 {
        for adjY=Y,-1:1:Y+1
        {
            if adjY=Y, adjX=X continue
            if $EXTRACT($GET(initialStr(adjY)),adjX)="#" 
            set total=total+1
        }
    }
    quit total
}

/// Uses the sort function to determine if the strings are idential or
ClassMethod IsIdentical(Str1 As %String, Str2 As %String)
{
    set row=""

    for {
        set row = $ORDER(Str1(row)) quit:row=""
        if Str1(row)'=$GET(Str2(row)) 
        {
        return 0
        }
    }
    quit 1
}

/// Description
ClassMethod occupiedseatsChg(initialStr As %String, X, Y)
{
    set length=$LENGTH(initialStr(Y)), Total=0,LastY=$ORDER(initialStr(""),-1)

    //Left
    set nextY=Y
    for nextX=X-1:-1:1
    {
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Right
    set nextY=Y
    for nextX=X+1:1:length
    {
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Up
    set nextx=X
    for nextY=Y-1:-1:1
    {
        quit:nextY<1
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Down
    set nextx=X
    for nextY=Y+1:1:LastY
    {
        quit:nextY>1
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Left-Up
    set nextY=Y
    for nextx=X-1:-1:1
    {
        set nextY=nextY-1
        quit:nextY<1
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Left-Down
    set nextY=Y
    for nextx=X-1:-1:1
    {
        set nextY=nextY+1
        quit:nextY>LastY
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Right-Up
    set nextY=Y
    for nextx=X+1:-1:length
    {
        set nextY=nextY-1
        quit:nextY<1
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Right-Down
    set nextY=Y
    for nextx=X+1:-1:length
    {
        set nextY=nextY+1
        quit:nextY>LastY
        continue:$EXTRACT(initialStr(nextY),nextX)="."
        set:$EXTRACT(initialStr(nextY),nextX="#") Total=Total+1
        quit

    }

    quit Total
}

/// Description
ClassMethod VerifyData(initialStr As %String, row As %Integer)
{
    set line="", Error=""

   
    For {
        set row = $ORDER(initialStr(row)) quit:row=""
        set initial=initialStr(row)
        
        if $LENGTH($TRANSLATE(initialStr,"L.")) {
            set Error="Incorrect data format at row"_row
            quit
        }
    
    }
}

}
