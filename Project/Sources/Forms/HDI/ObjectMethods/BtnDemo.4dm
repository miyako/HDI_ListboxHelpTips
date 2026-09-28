//%attributes = {"invisible":true}
//the button already has "accept" standard action
If (Form event code:C388=On Clicked:K2:4)
	
	If (Form:C1466.quit)
		INVOKE ACTION(ak return to design mode)
	Else 
		
		var $window : Integer
		$window:=Open form window:C675("HDI2"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		SET WINDOW TITLE(Get window title(Current form window); $window)
		DIALOG:C40("HDI2"; Form:C1466; *)
		
	End if 
	
End if 
