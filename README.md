# Практическое задание с самопроверкой «Система мониторинга Zabbix»  Абанина Максима

## Задание 1

Установите Zabbix Server с веб-интерфейсом.

Процесс выполнения

Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.


[вход в веб-интерфейс zabbix-сервера](https://github.com/Bespochadny/8-03-hw/blob/main/img/1.png)

---

## Задание 2

Добавьте в Zabbix два хоста и задайте им имена.

Установите Zabbix Agent на два хоста.

Процесс выполнения

Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

[добавление агентов с именами Ubuntu и Kali](https://github.com/Bespochadny/8-03-hw/blob/main/img/2.png);
[добавление zabbix сервера в список разрешенных для агентов](https://github.com/Bespochadny/8-03-hw/blob/main/img/3.png);
[добавление агентов в раздел Configuration > Hosts](https://github.com/Bespochadny/8-03-hw/blob/main/img/4.png);
[получение метрик с агентов](https://github.com/Bespochadny/8-03-hw/blob/main/img/5.png).

---
















