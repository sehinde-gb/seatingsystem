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
           
            set list = "L.LL.LL.LL~LLLLLLL.LL~L.L.L..L..~LLLL.LL.LL~L.LL.LL.LL~L.LLLLL.LL~..L.L.....~LLLLLLLLLL~L.LLLLLL.L~L.LLLLL.LL"
            set SegmentList = $LISTFROMSTRING(list,"~")
            set SegmentCount = $LISTLENGTH(SegmentList)
            set OptionalSegment="N"
            FOR i = 1:1:SegmentCount{
            if $LISTGET(SegmentList,i)= "[" set OptionalSegment = "Y" continue
            if $LISTGET(SegmentList,i)= "]" set OptionaSegment="N" continue
            write !, "Current Segment: "_$LISTGET(SegmentList,i)," ",OptionalSegment
            ;set SegmentFields = $LISTFROMSTRING(object.SegmentSubStructure,"~")
            ;set SegFieldCount = $LISTLENGTH(SegmentFields)
}
            
            // for i=1:1:10{
            //         set line = file.ReadLine()
            //         write count ,!
            //         write line ,!
            //         set id=$PIECE(line, " ",i)
            //         if count=3 {
            //             set extract=$PIECE(line, " ",i)
            //             write extract,!
            //         }
            //         //set extract1=$PIECE(line," ",1)
            //         //write "Extract1:",extract1 ,!
            //         //write !, i
            //         //write "ID:",id(count) ,!
            //         write id ,!
            //         set count = $INCREMENT(count)
            //         write *32
            //         //write i ,!
            //         write *32
            //         //write $LENGTH(line)

            //     }
            // /// loop to go through each line and save it to a global that increments
            
            // WHILE ('file.AtEnd) 
            // {
            //     set delim=" "
            //     set line = file.ReadLine()
            //     //set count =1
            //     //set extracted = ""



            //     write !, "Loop started"
            //     write *32

            // set string = "hel,o,you"

            #; for i=1:1:3 {
            #;     set piece = $PIECE(string, ",",i)
            #;     write "Length:",$LENGTH(string) ,! 
            #;     write "piece equals:",piece ,!

            #; } 

                

                //write id(2) ,!
                    //write *32
                    //write line ,!
                    //set count = count +1 
                    //set extracted(count) = $EXTRACT(line,1,40)
                    //write *32
                    //write count,"Extracted:",extracted(count) ,!

                     
                    //write *32
                    
                    //set count = $INCREMENT(count)     

                    
                //}
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
