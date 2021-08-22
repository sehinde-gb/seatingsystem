Class Missing.Seats Extends %RegisteredObject
{

ClassMethod Insert()
{
           
            set initialArr=##class(%ArrayOfDataTypes).%New()
            do initialArr.SetAt("L.LL.LL.LL","1")
            do initialArr.SetAt("LLLLLLL.LL", "2")
            do initialArr.SetAt("L.L.L..L..", "3")
            do initialArr.SetAt("LLLL.LL.LL", "4")
            do initialArr.SetAt("L.LL.LL.LL", "5")
            do initialArr.SetAt("L.LLLLL.LL", "6")
            do initialArr.SetAt("..L.L.....", "7")
            do initialArr.SetAt("LLLLLLLLLL", "8")
            do initialArr.SetAt("L.LLLLLL.L", "9")
            do initialArr.SetAt("L.LLLLL.LL", "10")
            
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
            write "Count: ",initialArr.Count()
            //set count = initial.Count()

            do ..whattoDo(.initialArr, .count)
}

// 

ClassMethod Process(ByRef initialArr As %ArrayOfDataTypes, ByRef count As %Integer)
{
    // output the results of processing the list
    for i=1:1:initialArr.Count()
        { write !, i, " = ", initialArr.GetAt(i)
    }
}

/// Description
ClassMethod whattoDo(ByRef initialArr As %ArrayOfDataTypes, ByRef count As %Integer)
{

    for {
        write "hello" ,!
        //kill lastArr
        //merge lastArr=initialArr
        do ..findnextSeat(.initialArr, .count)
        quit
        do ..IsIdent(.initialArr,.lastArr)
        

    }
}

ClassMethod findnextSeat(initialArr As %ArrayOfDataTypes, ByRef count As %Integer)
{
    
    write "hello again" ,!
    // set up the row variable
    set row = ""
    for {
        write "hello hello again" ,!
        zw initialArr
        // set a row by ordering the array and if it encounters a blank field quit
        set row = $ORDER(initialArr(row)) quit:row=""
        write "row is :",row ,!
        // pull out a row and set a single row to be the value initial
        set initial = initialArr(row)
     
   
        // loop find out the length of a single row
        for loc=1:1:$LENGTH(initial){
            set char =$EXTRACT(initial,loc)
            continue:char="."
            // create new variable and assign the array to it
            
           
            //do ..occupiedseatsAdj(.initialArr,loc,row)
            set occupiedseatsAdj=..occupiedseatsAdj(.initialArr,.loc,.row)

            // check to see if it contains L characters and not next to adjacent seats
            // extract the occupied figures from each line in the array
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
        // set the next row within the array
        //set nextArr(row)=initial
    }
    // on completion kill the array and merge it in to nextArr
    write "hello hello hello again" ,!
    kill initialArr
    merge initialArr=nextArr
}

/// Description
ClassMethod totaloccupiedSeats(initialArr As %ArrayOfDataTypes)
{
    set total=0
    set row=""

     for {
        // set a row by ordering the array and if it encounters a blank field quit
        set row = $ORDER(initialArr(row)) quit:row=""
        // pull out a row and set a single row to be the value initial
        set initial = initialArr(row)

        set total=total+$LENGTH(initial,"#")-1
    }
    quit total
}

ClassMethod occupiedseatsAdj(initialArr As %ArrayOfDataTypes, X, Y)
{
    set total=0
    for adjX=X-1:1:X+1 {
        for adjY=Y,-1:1:Y+1
        {
            if adjY=Y, adjX=X continue
            if $EXTRACT($GET(initialArr(adjY)),adjX)="#" 
            set total=total+1
        }
    }
    quit total
    do ..findnextSeat(initialArr,adjX,adjY)
}

/// Description 
ClassMethod IsIdent(Arr1 As %ArrayOfDataTypes, Arr2 As %ArrayOfDataTypes)
{
    set row=""

    for {
        set row = $ORDER(Arr1(row)) quit:row=""
        if Arr1(row)'=$GET(Arr2(row)) 
        {
        return 0
        }
    }
    quit 1
}

}
