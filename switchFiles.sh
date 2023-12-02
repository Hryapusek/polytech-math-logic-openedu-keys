#!/bin/zsh
# This script puts files from pdfs/ to hw[1-11] directories respectively.
# Also it DELETES everything in hw[1-11] dirs and puts in hwOLD backups before deleting
set -e

createBackupDir() {
  backupDir="hwOLD/$(date +%s)"
  mkdir -p "$backupDir"
  for i in $(seq 1 11)
  do
    mkdir $backupDir/hw$i
  done
  echo -n $backupDir
}

resultPdfs=(pdfs/hw[0-9].pdf(N))
resultPdfs+=(pdfs/hw1[0-1].pdf(N))
if [[ ${#resultPdfs[@]} -eq 0 ]]
then
  echo "No result pdf found. Nothing to swtich places"
  exit 1
fi

echo "Creating backup directory"
backupDir=$(createBackupDir)
echo "Directory with name \"$backupDir\" created"
cp pdfs "$backupDir/" -r

for i in $(seq 1 11)
do
  curHw=hw${i}
  echo "Processing $curHw..."
  pdfList=($curHw/*.pdf(N))
  if [[ ${#pdfList[@]} -eq 0 ]]
  then
    echo "No .pdf files found. Skipping dir"
    continue
  fi
  echo "List: $pdfList"

  echo "Copying pdfs to the $backupDir/$curHw"
  cp $pdfList $backupDir/$curHw
  echo "Copied successfully!"

  echo "Exitting directory $curHw"
  echo
done

for i in $(seq 1 11)
do
  curHw=hw${i}
  echo "Processing $curHw..."
  pdfList=($curHw/*.pdf(N))
  if [[ ${#pdfList[@]} -eq 0 ]]
  then
    echo "No .pdf files found. Skipping dir"
    continue
  fi
  echo "List: $pdfList"

  echo "Removing files from $curHw"
  rm -f $pdfList
  echo "Successfully removed!"

  echo "Exitting directory $curHw"
  echo
done

for i in $(seq 1 11)
do  
  curHw=hw${i}
  echo "Processing $curHw..."

  echo "Copying pdfs/$curHw.pdf to $curHw/"
  cp "pdfs/$curHw.pdf" "$curHw/"
  echo "Copied successfully!"

  echo "Exitting directory $curHw"
  echo
done

for i in $(seq 1 11)
do  
  curHw=hw${i}
  echo "Processing $curHw..."

  echo "Removing pdfs/$curHw.pdf"
  rm "pdfs/$curHw.pdf"
  echo "Removed successfully!"

  echo "Exitting directory $curHw"
  echo
done