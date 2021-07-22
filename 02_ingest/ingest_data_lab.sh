curl https://www.bts.dot.gov/sites/bts.dot.gov/files/docs/legacy/additional-attachment-files/ONTIME.TD.201501.REL02.04APR2015.zip --output data.zip

unzip data.zip
head ontime.td.201501.asc

ls -ltr

for month in `seq -w 1 12`; do
	unzip 2015$month.zip
	mv *ONTIME.csv 2015$month.csv
	rm 2015$month.zip
done


head 201503.csv

head -2 201503.csv | tail -1 | sed 's/.//g' | wc -w

wc -1 *.csv

for month in `seq -w 1 12`; do
	sed 's/,$//g' 2015$month.csv | sed 's/" //g' > tmp
	mv tmp 2015$month.csv
done

head 201503.csv 

export PROJECT_ID=(gcloud --info --format='value(config.project)')
gsutil mb gs://$(PROJECT_ID)-ml
gsutil -m cp *.csv gs://$(PROJECT_ID)-ml/flights/raw/


