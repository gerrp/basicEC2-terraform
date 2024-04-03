# Creación de infraestructura AWS para EC2
#### - VPC                                                                                               
#### - Subnet                                                                              
#### - Internet Gateway                                                                                             
#### - Route Table                                                                                                 
#### - Security group                                                                                                           
#### - Private key / Key pair  
#### - Llave local (local_sensitive_file)
#### - EC2 

## Vagrant
Como primer paso utilicé vagrant con una imagen de **ubuntu** para crear la máquina virtual sobre la cuál voy a trabajar, en ella por medio del **bootstrap.sh** instale:                                                                                                 

**Terraform**

Levantamos la máquina con ``` vagrant up 
                                           ```

Luego nos conectamos con ``` vagrant ssh
                                           ```
## Terraform                                                         
**Es necesario contar con la CLI de AWS instalada y configurada para manejar las credenciales**                                               

Utilizamos ``` terraform init ``` para cargar los providers (AWS-TLS-LOCAL)                                                                  

Creamos la infraestructura con ``` terraform apply -var-file="variables.tfvars" ``` , de esta manera referenciamos a las variables creadas                                                       

Luego de crear la infraestructura vamos a poder visualizar dentro de la carpeta terraform la llave SSH local de la EC2


