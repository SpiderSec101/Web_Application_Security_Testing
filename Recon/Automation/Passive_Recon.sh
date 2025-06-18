#!/bin/bash
#toilet -f future --metal "Hello"
#toilet -f future --gay "Hello"


animation_1() {
    local frames=('/' '-' '\' '|')
    while :; do
        for frame in "${frames[@]}"; do
            printf "\rPlease wait, now processing......%s" "$frame" 
            sleep 0.1
        done
    done
}

# Target Details

read -p "Enter the target company domain (EG: tesla.com) : " target_domain
read -p "Enter the target company name (EG: Tesla) : " target_company

mkdir "$target_company"
cd "$target_company"
echo '>> Generating the directory structure' | lolcat
echo "Creating a directory named 'Downloads_for_Recon'"
mkdir Downloads_for_Recon
echo "Creating a directory named 'Passive_Recon'"
mkdir Passive_Recon

# API Keys and Cookies

read -p "Enter the Shodan API Key : " shodan_api_key
read -p "Enter the cookie of your 'https://pro.builtwith.com' account: " builtwith_api_key
echo 'Get your chaos api key from ==> https://chaos.projectdiscovery.io/' | lolcat
read -p 'Enter your chaos api key ==> ' chaos_api_key
#read -p 'Enter your facebook api key ==> ' facebook_api_key
read -p 'Enter your openai api key ==> ' openai_api_key
#read -p 'Enter your censys api secret ==> ' PassiveTotal_api_secret
echo 'Get your Github API key from https://github.com/settings/tokens' | lolcat
read -p 'Enter your Github API key ==>' github_api_key
echo 'Get your whoxy api key from https://whoxy.com'
read -p 'Do you have whoxy_api_key ? (y/n)' whoxy_answer
if ["$whoxy_answer" = 'y' ]; then
    read -p 'Enter your whoxy_api_key ==> ' whoxy_api_key
else 
    echo Skipped.......
fi    

# config file setup

echo 
read -p '>> Have you created the config.ini file for amass and bbot? (y/n)=> ' the_config_answer
<<SKIP1
mkdir ./.config
mkdir ./.config/amass
cat <<EOF > ./.config/amass/config.ini
[datasources]
; Add your API keys under the relevant sections
; Example: 
; Chaos
virustotal = "$chaos_api_key"
; Shodan
shodan = "$shodan_api_key"
;openai
openai = "$openai_api_key"
; Github
spyse = "$github_api_key"
EOF
echo 'Done'
SKIP1
echo 'You can add more API keys as you want'

# Python virtual environment setup

echo 
echo 'We have to set a virtual python environment' | lolcat
read -p 'Do you have any python virtual environment ? (y/n)=> ' python_answer
if [ "$python_answer" = 'y' ]; then 
    read -p 'Enter the full path with virtual env. name => ' python_path
    echo 'Activating.....'
    source "$python_answer"/bin/activate
elif [ "$python_answer" = 'n' ]; then
    python3 -m venv my_env_new
    source ./my_env_new/bin/activate
fi


# Files and tools for the script

echo
cd Downloads_for_Recon
echo 'Downloading different tools for this script, in Downloads_for_Recon' | lolcat
echo 'Downloading getrelationship.py from https://raw.githubusercontent.com/m4ll0k/BBTz/refs/heads/master/getrelationship.py'
wget https://raw.githubusercontent.com/m4ll0k/BBTz/refs/heads/master/getrelationship.py
echo 'Downloading subrecongpt.py from https://raw.githubusercontent.com/jhaddix/SubreconGPT/refs/heads/main/subrecongpt.py'
wget https://raw.githubusercontent.com/jhaddix/SubreconGPT/refs/heads/main/subrecongpt.py

read -p 'Do you want to download chaos client from https://github.com/projectdiscovery/chaos-client ? (y/n) => ' chaos_client
if [ "$chaos_client" = 'y' ]; then
    go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
else 
    echo 'Skipping'
fi

read -p 'Do you want me to install puredns (https://github.com/d3mondev/puredns)? (y/n)=> ' puredns_answer
if [ "$puredns_answer" = 'y' ];then
        git clone https://github.com/blechschmidt/massdns.git
        cd massdns
        make
        sudo make install
        echo 'Done'
fi
read -p 'Do you want me to install shuffledns (https://github.com/projectdiscovery/shuffledns)? (y/n)=> ' shuffledns_install_answer
if [" $shuffledns_install_answer" = 'y' ];then
    go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
    echo 'Done'
fi

#bbot

read -p 'Do you want me to download bbot (https://github.com/blacklanternsecurity/bbot)? (y/n)=> ' bbot_answer
if [ "$bbot_answer" = 'y' ]; then 
    pipx install bbot
    echo 'For temporary uses doing => export PATH=$PATH:~/.local/bin'
    export PATH=$PATH:~/.local/bin
    source ~/.zshrc
fi

# resolvers.txt

echo 
echo 'resolvers.txt is a file that contains a list of DNS resolvers (i.e., DNS servers) that differen tools will use to perform DNS lookups'
read -p 'Do you want to download resolvers.txt from https://github.com/blechschmidt/massdns/blob/master/lists/resolvers.txt ? (y/n)=> ' resolver_answer
cd Downloads_for_recon
if [ "$resolver_answer" = "y" ]; then
    wget https://raw.githubusercontent.com/blechschmidt/massdns/refs/heads/master/lists/resolvers.txt 
else 
    read -p 'Enter your path/to/resolvers.txt' resolver_path
    cp "$resolver_path" .
fi
cd ..

# Wordlist

echo 
echo '>> Choose a wordlist for the subdomain bruteforce attack (suggested => https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056)' | lolcat
read -p 'Enter the wordlist path: ' wordlist_path

# ASN

echo
echo ">> Extracting the ASN (Autonomous System Numbers)" | lolcat
echo "Method 1 => BGP View API"
pwd
touch Passive_Recon/asn_numbers
curl -s https://api.bgpview.io/search?query_term=$target_company | jq -r | grep -i '"asn"' | cut -d : -f2 | tr -d ' ,' > Passive_Recon/asn_numbers
echo "Method 2 => bgp.he.net"
curl -sS -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36" https://bgp.he.net/search?search%5Bsearch%5D=$target_company | sed -n 's/.*AS\([0-9]\+\).*/\1/p' >> Passive_Recon/asn_numbers
touch Passive_Recon/ASN
sort -u Passive_Recon/asn_numbers > Passive_Recon/ASN
rm Passive_Recon/asn_numbers
echo "Output saved to file named 'ASN'"

# amass intel

echo ">> Extracting Apex Domains and Subdomains from the ASN" | lolcat
echo 'Using amass intel'
animation_1 &
animation_1_pid=$!
for i in $(cat Passive_Recon/ASN)
do
    output=$(amass intel -asn "$i")
    echo "$output" >> Passive_Recon/asndomains.txt
done
kill "$animation_1_pid" 2>/dev/null
printf "\rProcessing completed!\n"
sort -u Passive_Recon/asndomains.txt > Passive_Recon/asn_domains.txt
rm Passive_Recon/asndomains.txt
echo "Output saved to asn_domains.txt"

# shodan cli

cd Passive_Recon
echo ">> Extracting the subdomains from the Shodan CLI" | lolcat
shodan init "$shodan_api_key"
animation_1 &
animation_1_pid=$!
echo 'Running .....'
shodan domain -D $target_domain -S
kill "$animation_1_pid" 2>/dev/null
printf "\rProcessing completed!\n"
gzip -d "$target_domain"*.gz
jq -r '.domains, .hostnames' "$target_domain"-*.json | tr -d ',[]"' | sort | uniq > shodan_cli_subdomains.txt
cd ..

# shosubgo

echo ">> Running the tool shosubgo " | lolcat
echo ":: You can get the tool from => https://github.com/incogbyte/shosubgo" | lolcat
shosubgo -d $target_domain -s $shodan_api_key > Passive_Recon/shosubgo_domains
echo "This task is done, output is saved to shosubgo_domains"

# Cloud [kaeferjager.gay]
pwd

echo 
echo '>> Enumerating data from cloud [https://kaeferjager.gay]' | lolcat
platforms=("google" "amazon" "digitalocean" "oracle" "microsoft")
for i in ${platforms[@]}; do
    echo "Downloading ipv4_merged_sni.txt for ${i}" | lolcat
    mkdir Downloads_for_Recon/cloud
    mkdir Downloads_for_Recon/cloud/${i}
    cd Downloads_for_Recon/cloud/${i}
    wget https://kaeferjaeger.gay/sni-ip-ranges/${i}/ipv4_merged_sni.txt
    cd ../../
done
echo "Extracting data from the downloaded text files....."
cd cloud
animation_1 &
animation_1_pid=$!
touch cloud.subdomains.txt
cat amazon/ipv4_merged_sni.txt digitalocean/ipv4_merged_sni.txt google/ipv4_merged_sni.txt microsoft/ipv4_merged_sni.txt oracle/ipv4_merged_sni.txt | grep -F ".${target_domain}" | awk -F'-- ' '{print $2}' | tr ' ' '\n' | tr -d '[]' | grep -F ".${target_domain}" | sort -u > cloud.subdomains.txt
mv cloud.subdomains.txt ../../Passive_Recon/.
kill "$animation_1_pid" 2>/dev/null
printf "\rProcess completed!"
echo  'Output is saved to clouds.subdomains.txt'
cd ../../
pwd

# Ad / Analytic Tracker Code

echo 
echo '>> Tracking Add and Analytic codes' | lolcat
touch Passive_Recon/ad_analytic_tracker
python3 Downloads_for_Recon/getrelationship.py ${target_domain} ${builtwith_cookie} > Passive_Recon/ad_analytic_tracker
echo 'Done. Saved to ad_analytic_tracker'

# SubreconGPT

echo
echo '>> SubreconGPT' | lolcat
echo 'Do you have chaos client installed? If not Download it from ==> https://github.com/projectdiscovery/chaos-client'
echo 'Now working ....'
export PDCP_API_KEY=${chaos_api_key}
touch Passive_Recon/subrecongpt_domains
chaos -d ${target_domain} --key ${chaos_api_key} | python3 Downloads_for_Recon/subrecongpt.py --apikey ${openai_api_key} > Passive_Recon/subrecongpt_domains
echo 'Done, output saved to subrecongpt_domains'

sleep 2
# whoxy.com

echo 
echo '>> Extracting informations from whoxy.com' | lolcat
if [ "$whoxy_answer" = 'y' ] && [ -z "$whoxy_api_key" ]; then 
    curl "https://api.whoxy.com/?key=$whoxy_api_key&reverse=whois&keyword=$target_company&mode=domains"
else 
    echo 'Error, skipping this part'
fi

# Github Dorks

echo ">> Generating the Github Dorks " | lolcat
read -p 'Have you downloaded the script from https://github.com/RobinRana/githubRecon/blob/main/Gdorklinks.sh ? (y/n)=> ' g_d_q_1
touch Passive_Recon/github_dorks
if [ "$g_d_q_1" = 'y' ]; then
    read -p 'Enter the location of your script => ' g_d_q_path
    bash $g_d_q_path $target_domain > Passive_Recon/github_dorks 
elif [ "$g_d_q_1" = 'n' ]; then
    cd Downloads_for_Recon
    wget https://raw.githubusercontent.com/RobinRana/githubRecon/refs/heads/main/Gdorklinks.sh
    cd ..
    bash Downloads_for_Recon/Gdorklinks.sh $target_domain > Passive_Recon/github_dorks 
else
    echo 'Error :('    
fi
echo "Output is saved to github_dorks"
echo "Go through every links manually and try to find for interesting data like credentials, api toekns, api keys, source codes, etc."

pwd
# Github Subdomains 

echo '>> Using the tool github-subdomains from ==> https://github.com/gwen001/github-subdomains' | lolcat
echo 'Processing...'
touch Passive_Recon/github_subdomains.txt
github-subdomains -d "$target_domain" -t github_api_key -o Passive_Recon/github_subdomains.txt
echo 'Done:) and saved to github_subdomains.txt '

# crt.sh

echo 
echo '>> Extracting informations from crt.sh' | lolcat
touch Passive_Recon/crt.subdomains.txt
curl -s "https://crt.sh/?q=%.$target_domain&output=json" | jq . | grep 'common_name' | tr -d ',":' | awk '{print $2}' | sort -u > Passive_Recon/crt.subdomains.txt
echo Done %."$target_domain"
curl -s "https://crt.sh/?q=%.%.$target_domain&output=json" | jq . | grep 'common_name' | tr -d ',":' | awk '{print $2}' | sort -u >> Passive_Recon/crt.subdomains.txt
echo Done %.%."$target_domain"
curl -s "https://crt.sh/?q=%.%.%.$target_domain&output=json" | jq . | grep 'common_name' | tr -d ',":' | awk '{print $2}' | sort -u >> Passive_Recon/crt.subdomains.txt
echo Done %.%.%."$target_domain"
curl -s "https://crt.sh/?q=%.%.%.%.$target_domain&output=json" | jq . | grep 'common_name' | tr -d ',":' | awk '{print $2}' | sort -u >> Passive_Recon/crt.subdomains.txt
echo Done %.%.%.%."$target_domain"
curl -s "https://crt.sh/?q=%.%.%.%.%.$target_domain&output=json" | jq . | grep 'common_name' | tr -d ',":' | awk '{print $2}' | sort -u >> Passive_Recon/crt.subdomains.txt
echo Done %.%.%.%.%."$target_domain"
echo 'Resolving domains with IPs'
for i in $(cat Passive_Recon/crt.subdomains.txt); do host $i | grep 'has address' | awk '{print $1,"==>", $4}'; done > Passive_Recon/crt.ipv4.txt
echo Done

# Running amass

echo 
echo '>> Running amass enum to extract apex domains and subdomains' | lolcat
echo 'Starting...'
touch Passive_Recon/amass_subdomains.txt
animation_1 &
animation_1_pid=$!
amass enum -d "$target_domain" > ./Passive_Recon/amass_subdomains.txt
kill "$animation_1_pid" 2>/dev/null
printf "\rProcess completed!"
echo 'File saved as amass_subdomains.txt'
pwd

# subfinder

echo 
echo '>> Running subfinder ' | lolcat
touch Passive_Recon/subfinder_subdomains.txt
subfinder -d "$target_domain" -o Passive_Recon/subfinder_subdomains.txt
echo 'Done'

# bbot

echo 
echo 'Running the tool bbot (Make sure you have downloaded bbot).......' | lolcat
touch Passive_Recon/bbot_subdomains.txt
bbot -m otx -t "$target_domain" > ./Passive_Recon/bbot_subdomains
cat ./Passive_Recon/bbot_subdomains | awk '{print $2}' > ./Passive_Recon/bbot_subdomains.txt
rm ./Passive_Recon/bbot_subdomains
echo 'Done, saved to bbot_subdomains.txt'

# puredns

echo 
echo '>> Running the tool puredns (https://github.com/d3mondev/puredns)' | lolcat
touch Passive_Recon/puredns_subdomains.txt
puredns bruteforce "$wordlist_path" "$target_domain" -r Downloads_for_Recon/resolvers.txt -w ./Passive_Recon/puredns_subdomains.txt
echo 'Done'

# shuffledns

echo
echo 'Running the tool shuffledns (https://github.com/projectdiscovery/shuffledns)' | lolcat
touch Passive_Recon/shuffledns_subdomains.txt
shuffledns -d "$target_domain" -w "$wordlist_path" -r Downloads_for_Recon/resolvers.txt -mode bruteforce > ./Passive_Recon/shuffledns_subdomains.txt
echo 'Done'

# dnsgen

echo 
echo 'Running the tool dnsgen' | lolcat
cd ./Passive_Recon
cat * | dnsgen - | puredns resolve -r ../Downloads_for_Recon/resolvers.txt > ./dnsgen_subdomains.txt
