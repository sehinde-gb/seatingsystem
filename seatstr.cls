Class Missing.SeatStr Extends %String
{

    Property seatStr As %ArrayOfDataTypes;
    Property occupied As %ArrayOfDataTypes;


// Set up the seat and occupied arrays for use
ClassMethod SetArray(ByRef seatStr As %ArrayOfDataTypes,ByRef occupied As %ArrayOfDataTypes) As %Status
{
           
            
            do seatStr.SetAt("L.LL.LL.LL","1")
            do seatStr.SetAt("LLLLLLL.LL", "2")
            do seatStr.SetAt("L.L.L..L..", "3")
            do seatStr.SetAt("LLLL.LL.LL", "4")
            do seatStr.SetAt("L.LL.LL.LL", "5")
            do seatStr.SetAt("L.LLLLL.LL", "6")
            do seatStr.SetAt("..L.L.....", "7")
            do seatStr.SetAt("LLLLLLLLLL", "8")
            do seatStr.SetAt("L.LLLLLL.L", "9")
            do seatStr.SetAt("L.LLLLL.LL", "10")
            
            
           
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
            
            
           
            
            write *32
            write "Count: ",seatStr.Count()
            

            do ..Main(.seatStr, .count)
}

// 

ClassMethod processString(ByRef seatStr As %String) As %Status
{
    

    set seatStr(1)="L.LL.LL.LL"
    set seatStr(2)="LLLLLLL.LL"
    set seatStr(3)="L.L.L..L.."
    set seatStr(4)="LLLL.LL.LL"
    set seatStr(5)="L.LL.LL.LL"
    set seatStr(6)="L.LLLLL.LL"
    set seatStr(7)="..L.L....."
    set seatStr(8)="LLLLLLLLLL"
    set seatStr(9)="L.LLLLLL.L"
    set seatStr(10)="L.LLLLL.LL"


    do ..Main(.seatStr)
}

// Main program calls findnextSeat function to calculate vacant seats

ClassMethod Main(ByRef seatStr As %String) As %Status
{
    set counter=0
    
    for {
        kill lastArr
        merge lastArr=seatStr

        write "main" ,!
        
        do ..findnextSeatChanges(.seatStr)
        quit
        do ..IsIdentical(.seatStr,.lastArr)
        set counter= $INCREMENT(counter)
        set answer=..IsIdentical(.seatStr, .lastArr)
        write "Answer is: ", answer ,!
    }
}

// set up the single string variable and loops through it to extract the occupied characters 

ClassMethod findnextSeat(seatStr As %String) As %Status
{
    
    set row = 1
    
    for {
         
        // set a row by ordering the string and if it encounters a blank field quit
        set row = $ORDER(seatStr(row)) quit:row=""
        write "row is :",row ,!
        // pull out a row and set a single row to be the value initial
        set initial = seatStr(row)
     
        // loop find out the length of a single row
        for loc=1:1:$LENGTH(initial){
            set char =$EXTRACT(initial,loc)
            continue:char="."
            // create new variable and assign the array to it
            set occupiedseatsAdj=..occupiedseatsAdj(.seatStr,.loc,.row)

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
     
    kill seatStr
    merge seatStr=nextStr

    write "find next Completed",!
}

// set up the single string variable and loops through it to extract the occupied characters 

ClassMethod findnextSeatChanges(seatStr As %String, ByRef row As %Integer) As %Status
{
    set row = 1
    
    for {
         
        // set a row by ordering the string and if it encounters a blank field quit
        set row = $ORDER(seatStr(row)) quit:row=""
        write "row is :",row ,!
        // pull out a row and set a single row to be the value initial
        set initial = seatStr(row)
     
        // loop find out the length of a single row
        for loc=1:1:$LENGTH(initial){
            set char =$EXTRACT(initial,loc)
            continue:char="."
            // create new variable and assign the array to it
            set occupiedseatsChg=..occupiedseatsChg(.seatStr,.loc,.row)

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
     
    kill seatStr
    merge seatStr=nextStr

    write "find next changes completed",!
}

/// Sorts the seatStr and sets up a single row and then updates the total variable
ClassMethod totaloccupiedSeats(seatStr As %String) As %Status
{
    set total=0
    set row=""

     for {
        // set a row by ordering the array and if it encounters a blank field quit
        set row = $ORDER(seatStr(row)) quit:row=""
        // pull out a row and set a single row to be the value initial
        set initial = seatStr(row)

        set total=total+$LENGTH(initial,"#")-1
    }
    quit total
}

// X and Y are passed to the method and this is used to extract these from the seatStr

ClassMethod occupiedseatsAdj(seatStr As %String, X, Y) As %Status
{
    set total=0
    for adjX=X-1:1:X+1 {
        for adjY=Y,-1:1:Y+1
        {
            if adjY=Y, adjX=X continue
            if $EXTRACT($GET(seatStr(adjY)),adjX)="#" 
            set total=total+1
        }
    }
    quit total
}

/// Uses the sort function to determine if the strings are idential or
ClassMethod IsIdentical(Str1 As %String, Str2 As %String) As %Status
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

/// Set the areas of seating to the direction of seating , extract the seat type and update the total
ClassMethod occupiedseatsChg(seatStr As %String, X, Y)
{
    set length=$LENGTH(seatStr(Y)), Total=0,LastY=$ORDER(seatStr(""),-1)

    //Left
    set nextY=Y
    for nextX=X-1:-1:1
    {
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Right
    set nextY=Y
    for nextX=X+1:1:length
    {
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Up
    set nextx=X
    for nextY=Y-1:-1:1
    {
        quit:nextY<1
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Down
    set nextx=X
    for nextY=Y+1:1:LastY
    {
        quit:nextY>1
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Left-Up
    set nextY=Y
    for nextx=X-1:-1:1
    {
        set nextY=nextY-1
        quit:nextY<1
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Left-Down
    set nextY=Y
    for nextx=X-1:-1:1
    {
        set nextY=nextY+1
        quit:nextY>LastY
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Right-Up
    set nextY=Y
    for nextx=X+1:-1:length
    {
        set nextY=nextY-1
        quit:nextY<1
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    //Right-Down
    set nextY=Y
    for nextx=X+1:-1:length
    {
        set nextY=nextY+1
        quit:nextY>LastY
        continue:$EXTRACT(seatStr(nextY),nextX)="."
        set:$EXTRACT(seatStr(nextY),nextX="#") Total=Total+1
        quit

    }

    quit Total
}

/// Set up a loop to order the seating rows and then check to see if the length of the seats has the correct data format within the row
ClassMethod VerifyData(seatStr As %String, row As %Integer)
{
    set line="", Error=""

   
    For {
        set row = $ORDER(seatStr(row)) quit:row=""
        set initial=seatStr(row)
        
        if $LENGTH($TRANSLATE(seatStr,"L.")) {
            set Error="Incorrect data format at row"_row
            quit
        }
    
    }
}

}
