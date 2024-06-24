# Приложение клиент по вселенной MARVEL
![iOS Version Shield](https://img.shields.io/badge/iOS-15%2B-green?logo=apple)

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/665b0100-5208-47aa-9600-4e586c3b6a41" width="100">
</div>

## Содержание <!-- omit in toc -->

- [О приложении](#о-приложении)
- [Сетевой слой](#сетевой-слой)
- [Архитектура](#архитектура)
- [Хранение данных](#хранение-данных)
- [Скриншоты](#скриншоты)
- [Оригинальный дизайн](#оригинальный-дизайн)

## О приложении

<div align="center">
<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/1fa5e8d9-b644-4e78-b5b3-404d98e6818a" width="200">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/3254151c-5e55-489e-9187-c33acab1129c" width="200">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/ef7ebd44-7cfd-4911-8c58-c9330d94fd55" width="200">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/1561e874-6dbd-4b2b-abef-a5521e3fbf06" width="200">
</div>
</div>

Приложение написано на `UIKit` по архитектуре `MVP` с использованием `Coordinator` и `Router`.

В приложении можно просматривать списки персонажей, комиксы, авторов, ивенты и серии. Списки или детальную информацию по выбранному контенту.
Навигация построена по принципу _Wikipedia style_ с возможностью перехода с одного экрана вглубь на большое количество уровней (от комикса к персонажу, от персонажа к автору и так далее).

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/eaa41d7c-e87b-4ed2-9400-d7394057d439" width="700">
</div>


## Сетевой слой
Сетевой слой написан на `URLSession`. Для ограничения занимаемой оперативной памяти приложения и улучшения _Performance_, ограничен кэш, формируемый при работе с сетью и с загружаемым контентом. В случае отсутствия интернета, пользователю будет показан алерт.


## Архитектура
Приложение написано на архитектуре `MVP` с использованием `Coordinator` и `Router` для навигации. Поделено на модули, состоящие из `Assembly builder`, `Router`, `DataSource`, `Models` включая модели уровня `view`,  сами `Views` и `Presenter`. Координаторы разделены на два флоу в зависимости от того был ли просмотрен _Onboarding_ или нет. Чтобы не тянуть `Combine` для изменения флага в `AppDelegate` из дочернего координатора `OnboaringCoordinator` используется `Observable<T>`.

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/355c3e92-af54-4503-bfcf-215566a565c3" width="700">
</div>


## Хранение данных
В приложении реализован функционал сохранения контента в избранное используя `CoreData`. Сохранение в БД происходит в бэкграунд контексте. На экране избранных, данные подгружаются только после изменений в БД, это позволяет повысить _performance_ этого экрана и приложения в целом, т.к. не вызываются постоянно затратные `fetch` методы у `CoreDataService`. 

Реализовано отслеживание состояния контента, т.е. если одновременно в разных табах `UITabBarController` открыты два одинаковых экрана контента, и если на одном из табов добавить контент в избранное, то `UI` (закрашенное сердечко) поменяется и у того, который на втором табе.

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/5aa650d8-263c-4de5-b3e2-b63748fdbc00" width="700">
</div>


## Скриншоты

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/3075cc2c-4b2f-4992-89c7-98e036cd00b6" width="900">
</div>

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/cd45d9df-53bb-4260-b546-9f15a51afd1d" width="900">
</div>

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/be3aa3be-e56a-42c2-876a-a5fab64a2a3c" width="900">
</div>

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/6f28a7f1-6ca3-416d-9058-54dd7a9c0797" width="900">
</div>

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/09e62074-3224-447a-83b1-cd576251eaed" width="900">
</div>

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/5ebbcb29-a700-4959-a8d3-e6fae4e2bb47" width="900">
</div>

<div align="center">
<img src="https://github.com/rafbull/MarvelApp/assets/148709354/a8857bd8-6028-41f1-b2d9-6103bd0bd960" width="900">
</div>


## Оригинальный дизайн
Автор оригинального дизайна [Artiom Gulyuta](https://www.behance.net/artiomgulyuta)
