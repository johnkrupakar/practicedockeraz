$envValues = Get-Content ".\.env" | ForEach-Object { $_.Split('=')[1].Trim() }

$az_username = $envValues[0];
$az_password = $envValues[1];
$acr_username = $envValues[2];
$acr_password = $envValues[3];

sudo az login --username $az_username --password $az_password
sudo az acr login -n pacticetest --username $acr_username --password $acr_password
acrName = "pacticetest"
$acrRepository = "pacticetest/pacticetest"
$maxTags = 10
$tagsCount = (sudo az acr repository show-tags --name $acrName --repository $acrRepository).length-2
if ($tagsCount -gt $maxTags){ sudo az acr repository show-tags -n $acrName --repository $acrRepository --orderby time_asc --top 1 --query "[0]" --output tsv | foreach { sudo az acr repository delete --name $acrName --image ${acrRepository}:$_ --yes } }
# Delete the untagged manifest
#sudo az acr repository show-manifests -n $acrName --repository $acrRepository --query "[?tags[0]==null].digest" -o tsv | %{ az acr repository delete -n $acrName -t ${acrRepository}@$_  --yes }
