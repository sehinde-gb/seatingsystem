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
                //set count =1
                //set extracted = ""



                write !, "Loop started"
                write *32
                
                for i=1:1:10{
                    set id(i)=$PIECE(line, " ",i)
                    //set extract1=$PIECE(line," ",1)
                    //write "Extract1:",extract1 ,!
                    write !, id(i)
                    set i = $INCREMENT(i)
                    write *32
                    write i ,!
                    write *32
                    //write $LENGTH(line)

                }

                //write id(2) ,!
                    //write *32
                    //write line ,!
                    //set count = count +1 
                    //set extracted(count) = $EXTRACT(line,1,40)
                    //write *32
                    //write count,"Extracted:",extracted(count) ,!

                     
                    write *32
                    
                    //set count = $INCREMENT(count)     

                    
                //}
}
                write !, "Loop ended"
                write !,*32
                //write "Extracted again:",^extracted(3)
                //Write ..Count(.plan)
                
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
