
#user="venkat2286"
#pat="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"
org_name="venkat2286Org"
repo_file_name="repos.txt"
repos_with_api="repos-with-api.txt"


rm -rf output.txt
rm -rf reports
rm -rf repos
rm -rf temp

mkdir reports
mkdir temp

cd temp

echo "Script executed from the directory: ${PWD}"

 
# curl -s -u "$user":"$pat" -H 'Accept: application/vnd.github.v3+json' https://api.github.com/orgs/venkat2286Org/repos
#curl -s -u "$user":"$pat" -H 'Accept: application/vnd.github.v3+json' https://api.github.com/orgs/venkat2286Org/repos | grep "full_name" >> "$repo_file_name"
# curl -s -u venkat2286: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  https://api.github.com/orgs/venkat2286Org/repos?per_page=5 | grep "full_name" >> repos.txt
curl -s  https://api.github.com/orgs/venkat2286Org/repos?per_page=5 | grep "full_name" >> repos.txt

sed -i -e "s/full_name//g"  "$repo_file_name"

sed -i -e 's/\"//g' "$repo_file_name"
sed -i -e 's/\,//g' "$repo_file_name" 
sed -i -e 's/\://g' "$repo_file_name" 
sed -i -e 's/^[ \t]*//' "$repo_file_name"
sed -i -e "s/"$org_name"//g"  "$repo_file_name"
sed -i -e 's/\///g' "$repo_file_name" 


cat "$repo_file_name" | while read line || [[ -n $line ]];
do
   echo $line | xargs
   reponame="$(echo -e "${line}" | sed -e 's/[[:space:]]*$//')"
   echo "*************************************"
   echo "Cloning the repo :"$reponame
   echo "*************************************"

   #git clone "https://github.com/"$reponame".git"
   git clone "https://github.com/"$org_name"/"$reponame".git"
   echo "------------------------------------"
   echo "Searching rest api end points in the repo : "$reponame
   echo "------------------------------------"
   cat ../conf/identifiers.txt | while read identifier || [[ -n $identifier ]];
   do
    echo $identifier | xargs
	printf "."
     operation="$(echo -e "${identifier}" | sed -e 's/[[:space:]]*$//')"

	grep -Riw $reponame/ -e $operation >> ../reports/api-detailed-info.txt

   done
   echo ""

done



echo "------------------------------------"
   echo "I am almost done .Please wait... i am generating reports"
   echo "------------------------------------"
while read in;
do
printf "."
REPONAME=$( cut -d '/' -f 1 <<< "$in" )
echo "$REPONAME" >> ../reports/output1.txt
#FILENAME=$( cut -d '@' -f 1 <<< "$in" )
#echo "$FILENAME" >> api-info.txt
#ENDPOINT=$( cut -d '@' -f 2 <<< "$in" )
#echo "$ENDPOINT" >> api-info.txt
done < ../reports/api-detailed-info.txt
cat -n ../reports/output1.txt | sort -uk2 | sort -nk1 | cut -f2- >> ../reports/"$repos_with_api"
rm -rf ../reports/output1.txt
echo ""
echo "Reports generated.Please check ..reports/..."

  # grep -Riw $reponame/ -e '@GetMapping' >>../reports/api-detailed-info.txt  
   #grep -Riw $reponame/ -e '@GetMapping,@RequestMapping,@PostMapping'>> api-info.txt
   #grep -Riw $reponame/ -e '@RequestMapping'>> api-info.txt
   #grep -Riw $reponame/ -e 'PostMapping'>> api-info.txt
