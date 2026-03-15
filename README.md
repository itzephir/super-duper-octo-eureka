Фишечное название предложил github

# News Reader

iOS-приложение для чтения новостей, построенное на UIKit без Storyboard.

## Архитектура

Проект использует **VIPER** (View — Interactor — Presenter — Entity — Router).

```
uikit-hw5/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Models/
│   ├── ArticleModel.swift        # Модель статьи (Decodable)
│   └── NewsPage.swift            # Модель страницы с массивом новостей
├── Services/
│   ├── ArticleManager.swift      # Хранилище статей (Singleton)
│   └── ImageLoader.swift         # Загрузка и кэширование изображений
├── Extensions/
│   └── UIView+Pin.swift          # Auto Layout DSL
└── Modules/
    ├── News/
    │   ├── NewsProtocols.swift    # Контракты VIPER
    │   ├── NewsAssembly.swift     # Сборка модуля
    │   ├── NewsViewController.swift
    │   ├── NewsInteractor.swift
    │   ├── NewsPresenter.swift
    │   ├── NewsRouter.swift
    │   ├── ArticleWorker.swift    # Сетевой слой модуля
    │   ├── NewsArticleCell.swift  # Ячейка таблицы
    │   └── ShimmerView.swift      # Shimmer-анимация загрузки
    └── WebDetail/
        └── WebViewController.swift # Просмотр статьи через WKWebView
```

## Функциональность

- Лента новостей в `UITableView` с изображением, заголовком и описанием
- Загрузка новостей из Seldon News API с пагинацией
- Shimmer-эффект при загрузке изображений
- Переход к полной статье через `WKWebView`
- Свайп влево по ячейке — кнопка «Поделиться» через VK
- Асинхронная загрузка изображений с кэшированием через `NSCache`
- Защита от подмены изображений при переиспользовании ячеек

## API

[Seldon News](https://news.myseldon.com/api/Section?rubricId=4&pageSize=8&pageIndex=1) — REST API, возвращающий массив новостей в формате JSON.

## Стек

- Swift, UIKit
- VIPER
- URLSession
- WKWebView
- NSCache
