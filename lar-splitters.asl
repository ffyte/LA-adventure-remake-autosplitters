state("Dott","GoG")
{
    float igt: 0x00324338, 0x64;
}

state("Dott","Steam")
{
    float igt: 0x00324338, 0x64;
}

state("Monkey2","Steam")
{
    float igt: 0x001CFC00,0x6C;
}

state("GrimFandango","Steam")
{
    float igt: 0x001CFC00,0x6D;
}

state("MISE","Steam")
{
    float igt: 0x001B9858,0x38;
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
var MD5Hash = exeMD5HashBytes.Select(x =>
x.ToString("X2")).Aggregate((a, b) => a + b);
print("MD5Hash: " + MD5Hash.ToString()); //Lets DebugView show me the MD5Hash of the game executable

if(MD5Hash == "77805e16a4c90262f0badb725ea4e1d7"){
  version ="Gog";
  }

else if (MD5Hash =="9b9fd257777be2233e9458f1174081f0" || MD5Hash =="6e8094e2e93ffe798beb95dfc26280b3"|| MD5Hash =="310dc393dd777812dfa0fa2e99a89b5e" || MD5Hash =="dc7381d94b0d0ffd1a0223e9bafc1a26" ) {
  version = "Steam";
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
//dottr gog: 77805e16a4c90262f0badb725ea4e1d7
//dottr pirate: 9b9fd257777be2233e9458f1174081f0
//dottr steam: ac53d9ffe90a01aa26abb5e0861e6d46
//MISE steam: dc7381d94b0d0ffd1a0223e9bafc1a26
//GFR steam: 310dc393dd777812dfa0fa2e99a89b5e
//MI2SE steam: 6e8094e2e93ffe798beb95dfc26280b3
//GFR gog:
//FTR gog: