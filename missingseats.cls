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

            do ..Process(.initialArr, .count)
}

// 

ClassMethod Process(ByRef initialArr As %ArrayOfDataTypes, ByRef count As %Integer)
{
    // output the results of processing the list
    #; for i=1:1:initial.Count()
    #;     { write !, i, " = ", initial.GetAt(i)
    #; }

    do ..findnextSeat(.initialArr, .count)
}

ClassMethod findnextSeat(ByRef initialArr As %ArrayOfDataTypes, ByRef count As %Integer)
{
    // set up the row variable
    set row = ""

    // set a row by ordering the array and if it encounters a blank field quit
    set row = $ORDER(initialArr(row)) quit:row=""
    // pull out a row and set a single row to be the value initial
    set initial = initialArr(row)

    // loop find out the length of a single row
    for loc=1:1:$length(initial){
        
        continue:char="."

    }
}

}
