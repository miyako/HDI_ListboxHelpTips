//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($ps; $win)
C_OBJECT:C1216($options)
C_TEXT:C284($cr)

Case of 
	: (Count parameters:C259=0)
		
		var $dataClass; $project; $path : Text
		For each ($dataClass; ds:C1482)
			If (ds:C1482[$dataClass].getCount()=0)
				$path:=File:C1566("/RESOURCES/"+$dataClass+".4ie").platformPath
				If (Test path name:C476($path)=Is a document:K24:1)
					$project:=File:C1566("/RESOURCES/"+$dataClass+".4si").getText()
					IMPORT DATA:C665($path; $project)
				End if 
			End if 
		End for each 
		
		If (Application version:C493<"1650")  // 16R5 // DO NOT CHANGE THIS !!!
			ALERT:C41("Sorry, this \"How do I\" (HDI) example must be used with a newer version of 4D (v16 R5 and above)"; "Quit")
			QUIT 4D:C291
		Else 
			$ps:=New process:C317(Current method name:C684; 0; Current method name:C684; 0)
		End if 
		
	Else 
		
		$cr:=Char:C90(Carriage return:K15:38)
		
		If (Shift down:C543)  //  for debug purpose only
			$win:=Open form window:C675("HDI"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		Else 
			$win:=Open form window:C675("HDI"; Pop up form window:K39:11; Horizontally centered:K39:1; Vertically centered:K39:4)
		End if 
		
		$options:=New object:C1471
		
		$options.title:="Set up list box help tips?"+" For each column or row?"
		
		$options.blog:="blog.4d.com"
		
		$options.minimumVersion:="1650"  // 1650 means 16R5   1601 means 16.1 (do not use !)
		
		DIALOG:C40("HDI"; $options)
		CLOSE WINDOW:C154
		
		If ($options.quit=True:C214)
			QUIT 4D:C291
		Else 
			
			$win:=Open form window:C675("HDI2"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("HDI2")
			CLOSE WINDOW:C154
			
		End if 
End case 

