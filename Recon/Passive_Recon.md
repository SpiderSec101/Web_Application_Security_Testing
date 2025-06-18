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
  * [shosubgo](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#shosubgo)
  * [karma_v2](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#karma_v2)
  * [Cloud](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#Cloud)
  * [whoxy](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#whoxy)
  * [Ad/Analytics Tracker Code](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#adanalytics-tracker-code)
  * [Github](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#github)
  * [SubreconGPT](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#subrecongpt)
  * [crt.sh](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#crtsh)
### 4. Dorks
  * [Github Dorks](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#github-dorks)
### 5. Subdomain Scraping
  * [Config File](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#config-file)
  * [amass enum](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#amass-enum)
  * [subfinder](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#subfinder)
  * [bbot](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#bbot)
### 6. Subdomain Bruteforcing
  * [wordlists.txt](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#wordliststxt)
  * [resolvers.txt](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#resolverstxt)
  * [amass enum](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#amass-enum)
  * [puredns](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#puredns)
  * [shuffledns](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#shuffledns)
### 7. Permuted Scanning
  * [dnsgen](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#dnsgen)
### 8. Live Subdomains
  * [httprobe](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#murmur-hash)
### 9. Backend Technologies
  * [wappalyzer Extension](https://chromewebstore.google.com/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg?hl=en)
  * [built-with Extension](https://chromewebstore.google.com/detail/builtwith-technology-prof/dapjbgnjinbpoindlpdmhochffioedbn?hl=en)
  * [whatruns Extension](https://chromewebstore.google.com/detail/whatruns/cmkdbmfndkfgebldhnkbfhlneefdaaip?hl=en)
  * [webanalyze](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Recon/Passive_Recon.md#webanalyze)
### 10. Others
  * [dnsdumpster.com](https://dnsdumpster.com)
  * [sitereport.netcraft.com](https://sitereport.netcraft.com/)
  * [hackertarget.com](https://hackertarget.com/domain-profiler/)


---  
### Tools:
#### BGP View API
    curl -s https://api.bgpview.io/search?query_term=<company_name> | jq -r | grep -i '"asn"' | cut -d : -f2 | tr -d ','

    
#### Nmap  
  * Scripts for scanning the ASN

        ls /usr/share/nmap/scripts | grep -i asn
  * Then you can choose any one script as,

          
        nmap --script=asn-query.nse -T2 -Pn example.com
Nmap provides a script called targets-asn.nse which also can be used to enumerate the ASN.  

#### amass intel
  * You can use this command to extract the domains
  * Every ASN has associated IP ranges, amass used to look that ranges
  * Then it performs a reverse DNS lookup, check the domain and subdomain names pointing to an IP
  * It also used to look through OSINT sources, Certificate Transparency Logs, DNS Databases, Registry Informations etc.
    
        amass intel -asn 1234
  * I have written a bash script to automate this process a little bit. Save the numbers like AS1234 or ASN1234 in a file named ASN and run this script in the same directory.

        #!/bin/bash

        for i in $(cat ASN)
        do
            x=$(echo "$i" | tr -d 'ASN')
            output=$(amass intel -asn "$x")
            echo "$output"
        done

#### shodan
    shodan domain -D example.com -S
    jq -r '.domains, .hostnames' <file_name_here> | tr -d ',[]"' | sort | uniq 
  -S is used to specify the search query or filter the scan 

#### shosubgo  
   [https://github.com/incogbyte/shosubgo](https://github.com/incogbyte/shosubgo)  
   
       shosubgo -d example.com -s shodan_api_key_here

#### karma_v2  
[https://github.com/Dheerajmadhukar/karma_v2](https://github.com/Dheerajmadhukar/karma_v2)  
  * Setting-up the api key in the same directory of karma_v2 bash file

        echo 'shodan_api_key' > .token
  * Running the bash script

        bash karmav2 -d example.com -l -1 -deep
  * Some bash commands to extract desirable information

        jq -r '.domains, .hostnames' <file_name_here> | tr -d ',[]"' | sort | uniq 

        awk -F '::' '{for (i=0, i<=NF, i++) print $i}' <file_name_here>

        # For extracting only IPv4
    
        awk -F '::' '{for (i=1; i<=NF; i++) if ($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $i}' <file_name_here>

        # For extracting only domains and subdomains
    
        awk -F '::' '{for (i=1; i<=NF; i++) if ($i ~ /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/) print $i}' <file_name_here>



#### Cloud
[https://kaeferjaeger.gay/](https://kaeferjaeger.gay/)
  * This site scan all the data of wellknown cloud service providers every week and pull down IPs SSL Certificates
  * To download, scroll down and select the ```sni-ip-ranges```
  * Then you can see all the well known cloud service providers, select one of them and go to the ```ipv4_merged_sni.txt```
  * To download make a directory with the name of the cloud service provider and use wget

        wget https://kaeferjaeger.gay/sni-ip-ranges/amazon/ipv4_merged_sni.txt
  * After downloading the text file you can apply these bash scripts to extract data out of it

          cat *.txt | grep -F ".example.com" | awk -F'-- ' '{print $2}' | tr ' ' '\n' | tr -d '[]' | grep -F ".example.com" | sort -u

    
          cat amazon/ipv4_merged_sni.txt digitalocean/ipv4_merged_sni.txt google/ipv4_merged_sni.txt microsoft/ipv4_merged_sni.txt oracle/ipv4_merged_sni.txt | grep -F ".example.com" | awk -F'-- ' '{print $2}' | tr ' ' '\n' | tr -d '[]' | grep -F ".example.com" | sort -u > cloud.subdomains.txt

#### whoxy
[whoxy.com](https://www.whoxy.com/)

    https://api.whoxy.com/?key=<your_api_key_here>&reverse=whois&keyword=<company_name_here>&mode=domains

#### Ad/Analytics Tracker Code  

[https://github.com/m4ll0k/BBTz/blob/master/getrelationship.py](https://github.com/m4ll0k/BBTz/blob/master/getrelationship.py)  
You are going to need the cookie of your [https://pro.builtwith.com/](https://pro.builtwith.com/) account.

    python3 getrelationship.py example.com <the-builwith-cookie>
    
#### Github
[https://github.com/gwen001/github-subdomains](https://github.com/gwen001/github-subdomains)    

Here I am using a command line tool which uses a github api key and search the public github repositries for the subdomains of the target domain. It look through all of the hard coded data into the github repositries.

Your can get your github api key from ```https://github.com/settings/tokens```

    github-subdomains -d example.com -t github_api_key_here -o outputfile.txt
You can checkout other github enumerating tools from here [https://10degres.net/github-tools-collection/](https://10degres.net/github-tools-collection/)

#### SubreconGPT
  * First install the chaos-client from here [https://github.com/projectdiscovery/chaos-client](https://github.com/projectdiscovery/chaos-client)
  * Then download the python script from here [https://github.com/jhaddix/SubreconGPT](https://github.com/jhaddix/SubreconGPT)

        pip install openai==0.28

        # Now get the chaos api key from https://chaos.projectdiscovery.io/
        export PDCP_API_KEY="your_chaos_key_here"

        chaos -d example.com --key your_chaos_key_here | python subrecongpt.py --apikey YOUR_OPENAI_API_KEY

#### Github Dorks
[https://github.com/RobinRana/githubRecon/blob/main/Gdorklinks.sh](https://github.com/RobinRana/githubRecon/blob/main/Gdorklinks.sh)

    bash Gdorklink.sh example.com 
#### crt.sh

  * crt.sh used to find subdomians by scanning SSL/TLS certificates
  * When an organisation sets a SSL / TLS certificate for their domain they may include other domains and subdomains under the same certificate
  * SSL certificates have a field SAN (Subject Alternative Name) which holds additional domain and subdomain names that the certificate covers.
  * To search for subdomains can use % as your subdomain level requirement

        %.%.%.example.com
  * Search for subdomains with keywords like internal, api, auth, admin etc.
  * You can extract information from terminal by using curl and the json ouput format

        curl -s https://crt.sh/\?q=<company_domain_name>\&output=json | jq . | grep 'common_name' | tr -d ',":' | awk '{print $2}' | sort -u
  * This will extract a list of subdomains and wildcards.
  * Then one can use the host command to resolve the IP with the domains.

        for i in $(cat file_name); do host $i | grep 'has address' | awk '{print $1,"==>", $4}'; done

#### Config File  
Configuring the APIs for the tools increases their efficiancy by up to 50%
  * Places to get the free API keys are [Projectdiscovery.io](https://chaos.projectdiscovery.io/#/)(chaos) , Shodan, GitHub, X Api, FacebookCT, etc.
  * Here is a blog => https://www.hahwul.com/2020/09/23/amass-go-deep-in-the-sea-with-free-apis/  . It helps to understand how one can work with amass using free and paid APIs.
  * Setup the config file

        mkdir -p ~/.config/amass
        touch ~/.config/amass/config.ini
  * Open the ```config.ini``` and edit as shown below

        [datasources]
        ; Add your API keys under the relevant sections
        ; Example: 
        
        ; Chaos
        virustotal = your_chaos_api_key
        
        ; Shodan
        shodan = your_shodan_api_key
        
        ; Github
        spyse = your_github_api_key
        
        ; Facebook
        securitytrails = your_facebook_api_key
        
        ; PassiveTotal
        censys = your_PassiveTotal_api_secret

#### amass enum

  * Amass has some of the by defaul available APIs, you can see it from

        amass enum -list
    
  * To find amass unabled apis 

        amass enum -list | grep -v '\*'

  * You can specify the config.ini file with ```-config``` flag

        amass enum -d example.com -config ~/Desktop/my_configfile/config.ini
    
  * Or one can save the conig.ini file at the default config file location. With change in operating systems the location of the file varies.
  * For Linux / Unix systems it is => $XDG_CONFIG_HOME/amass/config.ini or $HOME/.config/amass/config.ini
  * Now you can use amass without apecifying the ```-config``` option

        amass enum -d example.com
    
    Here the ```enum``` stands for enumeration. It used to enumerate subdomains by using passive DNS queries, scraping web services and also used the scan certificates
    
  * Subdomain Bruteforcing

        amass enum -brute -d example.com -w wordlists.txt -r resolvers.txt  
    
#### subfinder
    subfinder -d example.com -o output.txt

#### bbot 
[https://github.com/blacklanternsecurity/bbot](https://github.com/blacklanternsecurity/bbot)
  * Setting Up

        # for permanent

        echo "export PATH=$PATH:~/.local/bin" >> ~/.zshrc
        source ~/.zshrc
        
        # for temporary
        
        export PATH=$PATH:~/.local/bin
        source ~/.zshrc
    
  * Running bbot

        bbot -m otx -t example.com
This command is used to run a BBOT scan with the OTX module enabled against the target example.com. The OTX module is designed to query the Open Threat Exchange (OTX) for threat intelligence data related to the target

#### resolvers.txt
   * resolvers.txt is a file that contains a list of DNS resolvers (i.e., DNS servers) that differen tools will use to perform DNS lookups. Each line in the file represents the IP address of a DNS resolver.  
  * You can download the text file from here [https://github.com/blechschmidt/massdns/blob/master/lists/resolvers.txt](https://github.com/blechschmidt/massdns/blob/master/lists/resolvers.txt)

#### wordlists.txt
  * SecLists
  * all.txt from [https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056](https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056)

#### puredns
[https://github.com/d3mondev/puredns](https://github.com/d3mondev/puredns)  

    puredns bruteforce wordlists.txt example.com -r resolvers.txt -w output.txt

#### shuffledns    
[https://github.com/projectdiscovery/shuffledns](https://github.com/projectdiscovery/shuffledns)

    shuffledns -d company.com -w wordlist.txt -r resolvers.txt -mode bruteforce

#### dnsgen   
Provide all of the subdomains and apex domains you enumerated to the dnsgen.

    cat sub-domain-file.txt | dnsgen - | puredns resolve -r resolvers.txt 
    
#### httprobe
    cat all_subdomains.txt | httprobe > live_domains.txt
This tool helps to filter out the live domains.

#### webanalyze
[https://github.com/rverton/webanalyze](https://github.com/rverton/webanalyze)

    webanalyze -host www.linkedin.com -crawl 1

    
    
    



    
    

     
    
    
    

    
