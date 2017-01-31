#!/bin/bash
echo "Copy Azure VHS with SAS Url to a storage account"
echo ""
if [ ! -v IMAGEURI ]
then
    echo "Error: Please provide the Image Uri with SAS token as IMAGEURI"
    exit 1
fi

if [ ! -v SA ]
then
    echo "Error: Please provide the the destination storage account as SA"
    exit 1
fi

if [ ! -v CONTAINER ]
then
    echo "Error: Please provide the the destination container inside the storage account as CONTAINER"
    exit 1
fi

if [ ! -v BLOBNAME ]
then
    echo "Error: Please provide the the destination blob name inside the storage container as BLOBNAME"
    exit 1
fi

if [ ! -v SAKEY ]
then
    echo "Error: Please provide the the destination storage account key as SAKEY"
    exit 1
fi

echo "Creating container $CONTAINER"
azure storage container create --container $CONTAINER -a $SA -k $SAKEY
echo ""
echo "Start copy job VHD to storage account $SA"
azure storage blob copy start --source-uri $IMAGEURI --dest-container $CONTAINER --dest-blob $BLOBNAME -a $SA -k $SAKEY
echo ""
echo "Copying: "
while :
do
        echo -n "."
        azure storage blob copy show --container $CONTAINER --blob $BLOBNAME -a $SA -k $SAKEY 2> /dev/null | grep -q pending
        if [ $? -ne 0 ]
        then
                echo ""
                azure storage blob copy show --container $CONTAINER --blob $BLOBNAME -a $SA -k $SAKEY
                break
        fi
done