## Active Reconnaissance

* Active reconnaissance refers to techniques used to gather information about a target system, network, or environment by directly interacting with it.  
* Here I have made a list of tools that helps to recon actively.  
* The list shows what type of informations I am trying to extract and to acheive that what kind of tools I am using. I also guide on how to use a tool.
---  

### 1. Domain Registration Information
  * [<ins>whois</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#whois)
### 2. DNS Lookup and Querying
  * [<ins>dig</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#dig)
  * [<ins>host</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#host)
### 3. DNS Enumeration
  * [<ins>dnsrecon</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#dnsrecon)
  * [<ins>fierce</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#fierce)
### 4. Web Application Firewall
  * [<ins>wafw00f</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#wafw00f)
### 5. Subdomains and Endpoints
  * [<ins>gospider</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#gospider)
  * [<ins>hakrawler</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#hakrawler)
  * [<ins>katana</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#katana)
  * [<ins>LinkFinder</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#LinkFinder)
  * [<ins>SubDomainizer</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#SubDomainizer)
### 6. Subdomain Bruteforcing
  * [ffuf](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#ffuf)
  * [dnsenum](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#dnsenum)
### 7. Web Clone
  * [<ins>httrack</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#httrack)
---  

### Tools:  
#### whois
    whois example.com
#### dig
    dig axfr @Name-servername-here example.com
   Here axfr is the protocol and the query requests a full copy of the DNS zone from the specified DNS server.  
#### host  
    host example.com
   It provides the IPs associated with the domain name  
#### dnsrecon 
    dnsrecon -d example.com
#### fierce  
    fierce --domain example.com  
#### wafw00f
    wafw00f -a example.com  
#### gospider  
    gospider -s https://example.com -w -d 0
   This tool used to crawl the webiste recursively. Here -w is used for the adding the subdomains inscope, -d is used for depth control. -d 0 is used for the infinite recurse and by default set to 1.
#### hakrawler 
    echo 'example.com' | hakrawler -subs -d 3
#### katana  
[https://github.com/projectdiscovery/katana](https://github.com/projectdiscovery/katana) 

    katana -u https://example.com
    
#### LinkFinder
[https://github.com/GerbenJavado/LinkFinder](https://github.com/GerbenJavado/LinkFinder) 

    pytohn3 linkfinder.py -i https:/example.com -d

#### SubDomainizer
[https://github.com/nsonaniya2010/SubDomainizer](https://github.com/nsonaniya2010/SubDomainizer) 

    python3 SubDomainizer.py -u https://example.com

#### httrack
    httrack
   Then it will ask for different options, follow the instructions. 

#### ffuf
[https://github.com/ffuf/ffuf](https://github.com/ffuf/ffuf)

    ffuf -u https://example.com -H 'Host: FUZZ.example.com' -w /usr/share/wordlists/...

#### dnsenum

    dnsenum --enum example.com -f /usr/sahre/wordlists/.. -r
* -r is used for the recursive option. If it finds a subdomain like auth.example.com then it will try to find out the subdomain of this subdomain (for example d1.auth.example.com)

    

         



