//%attributes = {"invisible":true}
var $mouseX; $mouseY; $mouseZ; $column; $row : Integer
var $tip : Text

Case of 
		
	: (Form event code:C388=On Mouse Enter:K2:33)
		
		SET DATABASE PARAMETER:C642(Tips delay:K37:80; 1)  // 1/60th of sec
		
	: (Form event code:C388=On Mouse Move:K2:35)
		
		MOUSE POSITION:C468($mouseX; $mouseY; $mouseZ)
		LISTBOX GET CELL POSITION:C971(*; "LB"; $mousex; $mousey; $column; $row)  // four parameters syntax
		
		If ($row#0)
			GOTO SELECTED RECORD:C245([DICO:2]; $row)
			If ($column=1)
				OBJECT SET HELP TIP:C1181(*; "LB"; [DICO:2]Definition:3)
			Else 
				$tip:=Localized string("HDI2_TipGoToDefinition")
				$tip:=Replace string:C233($tip; "{word}"; [DICO:2]Word:2)
				OBJECT SET HELP TIP:C1181(*; "LB"; $tip)
			End if 
		Else 
			OBJECT SET HELP TIP:C1181(*; "LB"; "")
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		LISTBOX GET CELL POSITION:C971(*; "LB"; $column; $row)  // two parameters syntax
		
		If ($row#0) & ($column=2)
			GOTO SELECTED RECORD:C245([DICO:2]; $row)
			OPEN URL:C673([DICO:2]Link:4)
		End if 
		
	: (Form event code:C388=On Mouse Leave:K2:34)
		
		SET DATABASE PARAMETER:C642(Tips delay:K37:80; 2*60)  // 2 seconds
		
End case 
