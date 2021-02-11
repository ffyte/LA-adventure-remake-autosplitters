//Note: It is not recommended to run multiple games at the same time! (O'rly?)

state("Dott","GoG")
{
	float igt: 0x00324338, 0x64;
}

state("Dott","Steam")
{
	float igt: 0x003244B0, 0x64;
}

state("Dott","Pirate")
{
	float igt: 0x0031C0F0, 0x64;
}

state("Monkey2","Steam")
{
	float igt: 0x001CFC00, 0x6C;
}

state("Monkey2","GoG")
{
	float igt: 0x001CFC00, 0x6C;
}

state("MISE","Steam")
{
	float igt: 0x001B9858, 0x38;
}
state("MISE","GoG")
{
	float igt: 0x001B9858, 0x38;
}


init
{
	byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
			{
			exeMD5HashBytes = md5.ComputeHash(s); 
			} 
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	print("MD5Hash: " + MD5Hash.ToString()); //Lets DebugView show me the MD5Hash of the game executable
	//Dottr gog
	if(MD5Hash =="77805E16A4C90262F0BADB725EA4E1D7"){
		version = "GoG";
	}
	//Dottr steam
	else if(MD5Hash =="AC53D9FFE90A01AA26ABB5E0861E6D46"){
		version = "Steam";
	}
	//Dottr pirate
	else if(MD5Hash =="9B9FD257777BE2233E9458F1174081F0"){
		version = "Pirate";
	}
	//MI2SE steam
	else if(MD5Hash =="6E8094E2E93FFE798BEB95DFC26280B3"){
		version = "Steam";
	}
	//MISE steam
	else if(MD5Hash =="DC7381D94B0D0FFD1A0223E9BAFC1A26"){
		version = "Steam";
	}
	//MISE pirate
	else if(MD5Hash =="0CF52A122DC51BB94C33BA1B28B5005E"){
		version = "GoG";
	}
	//MISE2 pirate
	else if (MD5Hash =="8327619F8697B7F0524B77DC568C6A53"){
		version = "GoG";
	}
	else {
		version = "Unknown, contact developer";
	}
}

start
{
	return old.igt == 0 && current.igt > 0;
}
	
reset
{
	return current.igt = -1;
}
		
   
gameTime 
{
	if(current.igt != old.igt) {
	return TimeSpan.FromSeconds(current.igt);
	}
}
		
//MD5s
//dottr gog:    77805E16A4C90262F0BADB725EA4E1D7
//dottr pirate: 9B9FD257777BE2233E9458F1174081F0
//dottr steam:  AC53D9FFE90A01AA26ABB5E0861E6D46
//MISE steam:   DC7381D94B0D0FFD1A0223E9BAFC1A26
//GFR steam:    310DC393DD777812DFA0FA2E99A89B5E
//MI2SE steam:  6E8094E2E93FFE798BEB95DFC26280B3
//GFR gog:      84FB9411963702AD48B2E5F716CF43CD
//FTR gog:      E9564071A1BEBFD1C46645269EAF3919
//MISE gog & pirate:  0CF52A122DC51BB94C33BA1B28B5005E
//MI2SE gog & pirate: 8327619F8697B7F0524B77DC568C6A53