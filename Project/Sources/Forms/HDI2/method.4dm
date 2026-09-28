//%attributes = {"invisible":true}
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		READ ONLY:C145(*)
		
		ALL RECORDS:C47([DICO:2])
		ALL RECORDS:C47([INFO:1])
		
		GOTO SELECTED RECORD:C245([INFO:1]; 1)
		vDescription1:=[INFO:1]Description:2
		
		GOTO SELECTED RECORD:C245([INFO:1]; 2)
		vDescription2:=[INFO:1]Description:2
		
		
End case 

