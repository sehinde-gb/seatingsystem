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
                set i=1
                
                write !, "Loop started"
                write *32
                
                if (line '="") {
                     write !, "Read started"
                     write *32

                     set list=$LISTFROMSTRING(line, delim)
                     write list ,!
                     //set ^answers(count)=$ZSTRIP(list,"="," ") // for only spaces
                     //write ^answers(count) ,!
                     write *32
                    
                     
                     //set ^attempt(count)=^attempt(count)_$ZHEX(($ASCII($LIST(^answers(count)))))
                     //write "Attempt:", ^attempt(count) ,!
                     //set countdown=$LENGTH(line,delim)
                     set i=$INCREMENT(i)
                     set count=$INCREMENT(count)
                }
                      
            }
              
                write !,*32
                
                write !, "Double checking"
                write !,*32
                write !, "1st element of answers array: ", $LIST(^answers(1))
                
                write !, "Import process complete"
                write *32
}

}
