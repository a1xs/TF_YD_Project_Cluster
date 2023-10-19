# Infrastructure


## Getting started
```shell
export ACCESS_KEY=<your_key>
export SECRET_KEY=<your_key>
export TOKEN=<your_token>
export FOLDER=export TOKEN=<your_folder_id>
```
## Install Y CLI
```shell
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a
exec -l $SHELL
```
## Confiure YCloud
```shell
yc config set folder-id $FOLDERye
yc config set token $TOKEN

yc config profile create prod

yc iam service-account create --name sa-gc-tfstate

yc iam service-account list

yc storage bucket create \
--name gc-tfstate-backet \
--default-storage-class STANDARD \
--max-size 10485760

yc ydb database create state-lock-db --serverless

yc resource-manager folder add-access-binding --service-account-name sa-gc-tfstate --role editor $FOLDER

yc iam access-key create --service-account-name sa-gc-tfstate
```
Создать таблицу ```state-lock-table``` Тип таблицы ```Документная```. Добавить колонку  тип строка ```LockID``` отметить ```Ключ партицирования```

## TF
Создать файл ```variables.tfvars``` c содержимым
```
# YCloud
token = ""
cloud_id = ""
folder_id = ""

#S3 credentials
bucket_name = "gc-bucket"

#PG credentials
pg_user = ""
pg_password = ""
pg_cluster_name = "cluster-database"
```

## TF
```shell
terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
```
```shell
terraform plan -var-file=variables.tfvars
```
```shell
terraform apply -var-file=variables.tfvars
```
```shell
terraform destroy -var-file=variables.tfvars
```
