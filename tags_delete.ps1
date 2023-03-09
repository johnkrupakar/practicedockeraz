# Set the ACR name and maximum number of tags to keep
$acrName = "pacticetest"
$acrRepository = "pacticetest/pacticetest"
$maxTags = 1

az acr login -n $acrName
#Get the number of tags
$tagsCount = (az acr repository show-tags --name $acrName --repository $acrRepository).length-2

if ($tagsCount -gt $maxTags){
	az acr repository show-tags -n $acrName --repository $acrRepository --orderby time_asc --top 1 --query "[0]" --output tsv | 
	foreach { 
		az acr repository delete --name $acrName --image ${acrRepository}:$_ --yes 
	}
}

