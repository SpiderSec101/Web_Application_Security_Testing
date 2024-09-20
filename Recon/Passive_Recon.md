## Passive Reconnaissance  
* Passive reconnaissance is the process of gathering information about a target system or organization without directly interacting with the target.
* Here I have made a list which helps me in passive recon.
* I have metioned what we want to extract and different processes and tool to do so.
---  
### 1. Acquisitions
  * [Crunchbase](https://www.crunchbase.com/)
### 2. ASN (Auonomous System Numbers)
It is a unique identifier assigned to an Autonomous System (AS), which is a collection of IP networks under a single administrative entity, such as an ISP or a large organization.
  * [Hurricane Electric BGP Toolkit](https://bgp.he.net/)
  * [BGP View API](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#bgp-view-api)
  * [Nmap](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#nmap)
### 3. Apex Domains and Subdomains    
  * [amass intel](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#amass-intel)
  * [shodan](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#shodan)
  * [shosubgo]()


---  
### Tools:
#### BGP View API
    curl -s https://api.bgpview.io/search?query_term=<company_name> | jq -r | grep -i asn
#### Nmap  
    nmap -sV --script=target-asn -T3 -Pn example.com
Nmap provides a script called tergets-asn which is used to enumerate teh ASN  
#### amass intel
    amass intel -asn 1234
#### shodan
    shodan domain -D example.com -S
Scanning a domain
#### shosubgo
    shosubgo -d example.com -s shodan_api_key_here
   [Github Link](https://github.com/incogbyte/shosubgo)
#### karma_v2
  * Setting-up the api key in the same directory of karma_v2 bash file
    ``` echo 'shodan_api_key' > .token```
  * Running the bash script
    ``` bash karmav2 -d example.com -l -1 -deep```
  * Some bash commands to extract desirable information
    ``` jq -r '.domains, .hostnames' <file_name_here> | tr -d ',[]"' | sort | uniq >> ../../../target_domains.txt ```
    ``` awk -F '::' {(for i=0, i<=NF, i++) print $i} ```
    [https://github.com/Dheerajmadhukar/karma_v2](https://github.com/Dheerajmadhukar/karma_v2)                       
    

    
