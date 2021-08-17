Class Missing.Seats Extends %RegisteredObject
{

ClassMethod Import(dir As %String = "/usr/local/day11.txt")
{
            // Open my text file and check it exists
            IF ##class(%File).Exists(dir) '=1 {
            write !, "Unable to Open: "_dir
            QUIT}
            ELSE { write "File: "_dir_" is open"}
            
            // instantiate a new class called file
            set file = ##class(%Stream.FileCharacter).%New()
            // create a new variable called sc
            set sc = file.LinkToFile(dir)
            set count=1
           
            
            /// loop to go through each line and save it to a global that increments
            
            WHILE ('file.AtEnd) 
            {
                set delim=" "
                set line = file.ReadLine()
                set count =1
                
                //write !, "Loop started"
                write *32
                
                if (line '="") {
                     write !, "Read started"
                     write *32

                     set plan(count)=$LISTFROMSTRING(line, delim)
                     write plan(count) ,!
                     //set ^answers(count)=$ZSTRIP(list,"="," ") // for only spaces
                     //write ^answers(count) ,!
                     write *32
                    
                     
                     
                     
                     set count=$INCREMENT(count)
                }
                      
            }
              
                write !,*32
                
                Write ..Count(.plan)
                
                write !, "Import process complete"
                write *32
}

ClassMethod Count(ByRef pArray) As %Integer [ PublicList = pArray ]
{
    set count = 0
    set ref = $Query(pArray(""))
    While (ref '= "") {
        set count = count + 1
        set ref = $query(@ref)
    }
    Quit count
}

/// Description

}
