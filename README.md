# Copy VHD image with SAS url to a local storage account

| Variable | Description |
| ------------- | ------------- 
|IMAGEURI|Image Uri with SAS token to copy from|
|SA|Destination storage account|
|CONTAINER|Destination Container inside the storage account|
|BLOBNAME|Destination Blobname of the image inside the container|
|SAKEY|Key to access the destination storage account|


```bash
docker run -e IMAGEURI="https:/url/image.vhd?sastoken" -e SA=mystorageaccount -e CONTAINER=mycontainer -e BLOBNAME=myimage.vhd -e SAKEY="12345" dfalkner/azure-copy-image-sas
```` 