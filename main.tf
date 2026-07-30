terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

# Провайдер Яндекс Облака
# Токен, cloud_id и folder_id лучше передавать через переменные окружения (YC_TOKEN, YC_CLOUD_ID, YC_FOLDER_ID)
# provider "yandex" {
#  zone = "ru-central1-a" # Зона по умолчанию
# }

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = file("~/authorized_key.json")
}

# Объявление переменных
variable "token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

# Переменные
variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Yandex Cloud default zone"
  default     = "ru-central1-a"
}

# 1. Сетевая инфраструктура (если еще не создана)
resource "yandex_vpc_network" "net" {
  name = "net-lb-task"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet-lb-task"
  zone           = var.zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# 2. Создание 2-х идентичных виртуальных машин с использованием count
resource "yandex_compute_instance" "vm" {
  count = 2 # Создаем 2 машины

  name        = "nginx-vm-${count.index + 1}"
  zone        = var.zone
  platform_id = "standard-v3"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # ID образа Ubuntu 22.04 LTS. Если в вашем каталоге другой стандартный образ, замените ID.
      image_id = "fd8ingbofbh3j5h7i8ll"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    # NAT нужен, так как, без него до веб-сервера не достучаться.
    nat = true
  }

  # Установка и запуск Nginx через user-data (bash скрипт при старте ВМ)
  metadata = {
    user-data = <<-EOT
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      systemctl start nginx
      systemctl enable nginx
    EOT
  }
}

# 3. Создание целевой группы (Target Group) и добавление в неё ВМ
resource "yandex_lb_target_group" "tg" {
  name      = "tg-nginx"
  region_id = "ru-central1"

  # Добавляем первую ВМ (индекс 0)
  target {
    subnet_id = yandex_vpc_subnet.subnet.id
    address   = yandex_compute_instance.vm[0].network_interface[0].ip_address
  }

  # Добавляем вторую ВМ (индекс 1)
  target {
    subnet_id = yandex_vpc_subnet.subnet.id
    address   = yandex_compute_instance.vm[1].network_interface[0].ip_address
  }
}

# 4. Создание сетевого балансировщика нагрузки (NLB)
resource "yandex_lb_network_load_balancer" "nlb" {
  name = "nlb-nginx"
  type = "external" # Внешний балансировщик, чтобы получить публичный IP

  attached_target_group {
    target_group_id = yandex_lb_target_group.tg.id

    # Настройка Healthcheck
    healthcheck {
      name = "http-healthcheck"
      http_options {
        port = 80
        path = "/"
      }
    }
  }

  # Настройка Listener (слушателя)
  listener {
    name     = "listener-http"
    port     = 80
    protocol = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }
}

# Выводим внешний IP балансировщика в консоль после применения
output "nlb_external_ip" {
  value = [
    for listener in tolist(yandex_lb_network_load_balancer.nlb.listener) :
    tolist(listener.external_address_spec)[0].address
  ][0]
}
