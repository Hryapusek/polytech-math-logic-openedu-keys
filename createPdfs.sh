#!/bin/zsh
# This script unites pdfs and puts these right into the pdfs/ directory
# NOTE: ZSH is needed to work properly.
set -e

resultPdfs=(pdfs/hw[0-9].pdf(N))
resultPdfs+=(pdfs/hw1[0-1].pdf(N))
if [[ ${#resultPdfs[@]} -ne 0 ]]
then
  echo "WARNING: pdfs directory is not empty. Creating backup directory."
  backupDir="pdfsOLD/$(date +%s)"
  mkdir -p "$backupDir"
  cp pdfs/* "$backupDir" -r
  echo "Backup created. Press any key to continue..."
  read
fi

for i in $(seq 1 11)
do
  curHw=hw${i}
  echo "Processing $curHw..."
  pdfList=($curHw/*.pdf)
  echo -n "List: "
  for pdfName in "${pdfList[@]}"
  do
    echo -n "\"$pdfName\" "
  done
  echo
  echo "Creating pdf..."
  echo "Command: pdfunite $pdfList \"pdfs/$curHw.pdf\""
  pdfunite $pdfList "pdfs/$curHw.pdf" 1>/dev/null
  echo "Exitting directory $curHw"
  echo
done