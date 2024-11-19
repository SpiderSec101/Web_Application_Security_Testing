## Application Analysis

By analyzing an application's different aspects we can understand and find out the most probable areas of an applications that can be vulnerable some how. This way we narrow down our testing vectors.

---

### 1. Favicon
  * [favfreak](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Application%20Analysis/Readme.md#favfreak)
  * [Murmur Hash](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Application%20Analysis/Readme.md#murmur-hash)


















#### favfreak
[https://github.com/devanshbatham/FavFreak](https://github.com/devanshbatham/FavFreak)

It is a python based tool that used to search for favicon.ico files and calculate murmur hash. Then it has a list of known hash values. If the calculated hash value match with any of them, it shows it as output. Then one can easily use shodan dorks to find domain related data.

    echo 'example.com' | python3 favfreak.py -o output

    http.favicon.hash:YOUR_HASH_VALUE

#### Murmur Hash
 * From karmav2 you will get some of the favicon files as favicon.ico, or you can download the favicon of the target website
 * Using a python module ```mmh3``` to find the murmur hash

       cat favicon.ico | base64 | python3 -c "import mmh3,sys; print(mmh3.hash(sys.stdin.buffer.read()))"
   
 * Search for the hash value in the Shodan

       http.favicon.hash:<hashvalue_here>
   
 * All together

         curl -s <path_to_the_favicon.ico_file> | base64 | python3 -c 'import mmh3, sys;print(mmh3.hash(sys.stdin.buffer.read()))' | xargs -I{} shodansearch http.favicon.hash:{} --fields hostnames | tr ";" "\n"
