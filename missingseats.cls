Class Missing.Seats Extends %RegisteredObject
{

ClassMethod Insert()
{
           
            set initial=##class(%ListOfDataTypes).%New()
            do initial.Insert("L.LL.LL.LL")
            do initial.Insert("LLLLLLL.LL")
            do initial.Insert("L.L.L..L..")
            do initial.Insert("LLLL.LL.LL")
            do initial.Insert("L.LL.LL.LL")
            do initial.Insert("L.LLLLL.LL")
            do initial.Insert("..L.L.....")
            do initial.Insert("LLLLLLLLLL")
            do initial.Insert("L.LLLLLL.L")
            do initial.Insert("L.LLLLL.LL")
            
            set initial=##class(%ArrayOfDataTypes).%New()
           
            #; do occupied.SetAt("1","#.##.##.##")
            #; do occupied.SetAt("2","#######.##")
            #; do occupied.SetAt("3","#.#.#..#..")
            #; do occupied.SetAt("4","####.##.##")
            #; do occupied.SetAt("5","#.##.##.##")
            #; do occupied.SetAt("6","#.#####.##")
            #; do occupied.SetAt("7","..#.#.....")
            #; do occupied.SetAt("8","##########")
            #; do occupied.SetAt("9","#.######.#")
            #; do occupied.SetAt("10","#.#####.##")
            
            // Finding a key
            //write occupied.GetAt("####.##.##") ,!
           
            
            write *32
            write "Count: ",initial.Count()
            set count = initial.Count()

            do ..Process(.initial, .count)
}

// 

ClassMethod Process(ByRef initial As %ListOfDataTypes, ByRef count As %Integer)
{
    // output the results of processing the list
    for i=1:1:initial.Count()
        { write !, i, " = ", initial.GetAt(i)}
}

}
