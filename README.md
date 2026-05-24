# Домашнее задание к занятию "Что такое DevOps. СI/СD" - Абанина Максима

## Задание 1

Что нужно сделать:

Установите себе jenkins по инструкции из лекции или любым другим способом из официальной документации. Использовать Docker в этом задании нежелательно.
Установите на машину с jenkins golang.
Используя свой аккаунт на GitHub, сделайте себе форк репозитория. В этом же репозитории находится дополнительный материал для выполнения ДЗ.
Создайте в jenkins Freestyle Project, подключите получившийся репозиторий к нему и произведите запуск тестов и сборку проекта go test . и docker build ..

[установленный Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/2.jpg)
[запуск теста и сборка проекта в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/3.jpg)
[запуск теста и сборка проекта в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/4.jpg)

---

## Задание 2

Что нужно сделать:

Создайте новый проект pipeline.
Перепишите сборку из задания 1 на declarative в виде кода.

[запуск теста и сборка проекта pipeline в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/5.jpg)
[запуск теста и сборка проекта pipeline в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/6.jpg)

---

## Задание 3

Что нужно сделать:

Установите на машину Nexus.
Создайте raw-hosted репозиторий.
Измените pipeline так, чтобы вместо Docker-образа собирался бинарный go-файл. Команду можно скопировать из Dockerfile.
Загрузите файл в репозиторий с помощью jenkins.

[установка Nexus и создание в нем raw-hosted репозитория](https://github.com/Bespochadny/8-03-hw/edit/main/img/7.jpg)
[запуск теста и сборка проекта с синхронизацией Nexus в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/8.jpg)
[запуск теста и сборка проекта с синхронизацией Nexus в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/9.jpg)
[запуск теста и сборка проекта с синхронизацией Nexus в Jenkins](https://github.com/Bespochadny/8-03-hw/edit/main/img/10.jpg)
