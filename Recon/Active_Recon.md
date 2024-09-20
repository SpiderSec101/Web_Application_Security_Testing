## Active_Reconnaissance

* Active reconnaissance refers to techniques used to gather information about a target system, network, or environment by directly interacting with it.  
* Here I have made a list of tools that helps to recon actively.  
* The list shows what type of informations I am trying to extract and to acheive that what kind of tools I am using. I also guide on how to use a tool.

### 1. Domain Registration Information
  * [<ins>whois</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#whois)
### 2. DNS Lookup and Querying
  * [<ins>dig</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#dig)
  * [<ins>host</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#host)
### 3. DNS Enumeration
  * [<ins>dnsrecon</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#dnsrecon)
  * [<ins>dnsenum</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#dnsenum)
  * [<ins>fierce</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#fierce)
### 4. Web Application Firewall
  * [<ins>wafw00f</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#wafw00f)
### 5. Subdomains and Endpoints
  * [<ins>gospider</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#gospider)
  * [<ins>hakrawler</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#hakrawler)
  * [<ins>katana</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#katana)
  * [<ins>LinkFinder</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#LinkFinder)
  * [<ins>SubDomainizer</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#SubDomainizer)
### 6. Web Clone
  * [<ins>httrack</ins>](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Active_Recon.md#httrack)

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
#### dnsenum
    dnsenum example.com  
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
    katana -u https://example.com
   [Github-Link](https://github.com/projectdiscovery/katana) 
#### LinkFinder
    pytohn3 linkfinder.py -i https:/example.com -d
   [Github-Link](https://github.com/GerbenJavado/LinkFinder) 
#### SubDomainizer
    python3 SubDomainizer.py -u https://example.com
   [Github-Link](https://github.com/nsonaniya2010/SubDomainizer) 
#### httrack
    httrack
   Then it will ask for different options, follow the instructions. 
    

         



