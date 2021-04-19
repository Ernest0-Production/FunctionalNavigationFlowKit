# FunctionalNavigationFlowKit

Функциональный способ описания UI навигации.

## 🗺 Пример
```swift
SetWindowRootFlow(
    in: window,
    configuration: .combine(.keyAndVisible, .animated(duration: 0.3)),
    DeferredBuild(MainTabBarController.init, with: {  rootController in

        SetTabBarItemsFlow(
            in: rootController,
            configuration: .titlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: -4.0)),
            items: [

                DeferredBuild(UINavigationController.init, with: { navigationController in

                    PushFlow(
                        in: navigationController: navigationController,
                        animated: false,
                        configuration: .title("Feed"),
                        FeedViewController(

                            searchFlow: PushFlow(
                                in: navigationController,
                                SearchViewController()
                            ),

                            itemFlow: { item in
                                PushFlow(
                                    in: navigationController,
                                    configuration: .combine(
                                        .title(item.name),
                                        hidesBottomBarWhenPushed
                                    ),
                                    ItemDetailsViewController(
                                        with: item,
                                        commentsFlow: PresentFlow(
                                            in: navigationController,
                                            CommentsViewController(item: item)
                                        )
                                    )
                                )
                            }

                        )
                    )

                }),

                DeferredBuild(UINavigationController.init, with: { navigationController in

                    PushFlow(
                        in: navigationController,
                        configuration: .title("Profile"),
                        ProfileViewController(

                            settingsFlow: PushFlow(
                                in: navigationController,
                                configuration: .title("Settings"),
                                SettingsViewController(
                                    saveCompletionFlow: PopFlow(in: navigationController)    
                                )
                            ),

                            logoutFlow: AuthorizationFlow

                        )
                    )

                }

            ]
        )

    })
)

```

## Overview

- [Requirements](#requirements)
- [В чем смысл?](#-в-чем-смысл)
- [Конфигурация Flow](#%EF%B8%8F-конфигурация-flow)
- [Зачем все это нужно?](#-зачем-все-это-нужно-чем-это-лучше-coordinator---паттерна)
- [Installation](#installation)
- [Credits](#credits)
- [License](#license)


## Requirements

- iOS 8.0+
- Xcode 10.0+
- Swift 5.0+


## 🤨 В чем смысл?
Навигация - это действие (push, flow, set, и т.д.).\
Действие можно описать ввиде кложура `() -> Void`. Называть его будем просто `Flow`.\
Теперь мы можем написать фабрику методов для создания `Flow`. В данном фреймворке представлены следующие (глобальные) методы:
#### `PushFlow`
```swift
PushFlow(
    in: myNavigationController,
    MyViewController()
)
```
#### `PopFlow`
```swift
PopFlow(in: myNavigationController)

PopFlow(
    in: myNavigationController,
    to: secondViewControlller
)

PopToRootFlow(in: myNavigationController)
```
#### `PresentFlow`
```swift
Present(
    in: rootViewController,
    MyModalViewController()
)

// Ищет самый верхний контроллер и презентит в нём.
Present(
    in: window,
    MyModalViewController()
)
```
#### `DismissFlow`
```swift
DismissFlow(myViewController)

// Дисмисит контроллер, который презентовал указанный контроллер
DismissFlow(in: presentedViewController)

// Дисмисит самой верхний контроллер в окен
DismissFlow(in: window)
```
#### `SetTabBarItemsFlow`
```swift
SetTabBarItemsFlow(
    in: tabBarController,
    items: [
        FeedViewController(),
        ProfileViewController(),
    ]
)
```
#### `SetWindowRootFlow`
```swift
SetWindowRootFlow(
    in: window,
    myRootViewController
)
```
#### `AlertFlow`
```swift
AlertFlow(
    in: myViewController,
    title: "Hello",
    message: "A you sure?"
)

// Ищет самый верхний контроллер и презентит в нём.
AlertFlow(
    in window: window
    title: "Hello",
    message: "A you sure?"
)

```

Если этого кажется недостаточным, вы можете написать свою функцию похожим образом.

## ⚙️ Конфигурация `Flow`
Каждый `Flow` имеет конфигурацию `FlowTransitionConfiguration`, которая запускается **перед** и **после** выполнения.
```swift
let configuration = FlowTransitionConfiguration<UINavigationController, UIViewController>(
    prepare: { navigationController, viewController in  
        navigationController.setNavigationBarHidden(true, animated: false)
    },
    completion: { navigationController, viewController in
        Analytics.track(.openScreen(String(description: viewController)))
    }
)

return PushFlow(
    in: navigationController,
    configuration: configuration,
    SubscriptionViewController()
)
```

Фреймфорк уже предоставляет основной набор конфигураций:
---
 `PushFlowTransitionConfiguration` == `FlowTransitionConfiguration<UINavigationController, UIViewController>`
- `hidesBottomBarWhenPushed`
- `title(String?)`
- `titleView(UIView?)`
- `navigationDelegate(UINavigationControllerDelegate)`
---
`PresentFlowTransitionConfiguration` == `FlowTransitionConfiguration<UIViewController, UIViewController>`
- `transitionStyle(UIModalTransitionStyle)`
- `presentationStyle(UIModalPresentationStyle)`
- `modalInPresentation`
- `transitionDelegate(UIViewControllerTransitioningDelegate)`
---
`SetTabBarItemsFlowTransitionConfiguration` == `FlowTransitionConfiguration<UITabBarController, UIViewController>`
- `titlePositionAdjustment(UIOffset)`
---
`SetWindowRootFlowTransitionConfiguration`== `FlowTransitionConfiguration<UIWindow, UIViewController>`
- `keyAndVisible`
- `animated(duration: TimeInterval, completion: Flow?)`
---
`AlertFlowTransitionConfiguration` == `FlowConfiguration<UIViewController, UIAlertController>``
- `actions([UIAlertAction])`
- `action(UIAlertAction)`
---
## ⏰ Ленивая инициализация
Презентуемые контроллеры инициализируются **только при запуске `Flow`!**

`Push/Present/Set/...Flow` принимают `() -> ViewController` билдер.
> Для каждого представленного `Flow` есть альтернативная инициализация с `@autoclosure` билдером.


## 😑 Зачем все это нужно? Чем это лучше Coordinator - паттерна?
1. Подобный подход позволяет **декларативно** описать **карту навигации**, скрывая детали презентации и сборки экрана.
2. Делает **независимым** навигацию от конкретного экрана. Иными словами, презентуемый и презентующий контроллер не знают (и не должны знать), как будут отображаться в иерархии окон. Такой подход позволяет легко поменять тип презентации и контекст, в котором презентуется экран, без необходимости изменять что-то несвязанное с навигацией...*open/closed principle*  (пересекается с пунктом 1).
3. В `swift` можно писать *вложенные функции*. Учитывая то, что при работе с навигацией **важно иметь доступ ко всей иерархии из любого презентуемого контекста** приложения, вложенные функциии являются удобным решением для описания какого-то внутреннего скоупа навигации. Имея доступ к внешним(глобальном для внутренней фунции) переменменным, пропадает необходимость использования *constructor/property/method injection* паттернов ООП, которая часто используется в `Coordinator`-ах при передаче зависимостей в дочерние(n-ой вложенности) координаторы через дерево/цепочку вызовов, приводящих к созданию транзитивных зависимостей.


## Installation

#### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'FunctionalNavigationFlowKit'
end
```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```

#### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.

```swift
// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "YOUR_PROJECT_NAME",
  dependencies: [
      .package(url: "https://github.com/Ernest0-Production/DeclarativeLayoutKit.git", from: "1.0.0")
  ],
  targets: [
      .target(name: "YOUR_TARGET_NAME", dependencies: ["FunctionalNavigationFlowKit"])
  ]
)
```

### Credits

- [Telegram](https://t.me/Ernest0n)
- [Twitter](https://twitter.com/Ernest0N)


### License

DeclarativeLayoutKit is released under the MIT license. See [LICENSE](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/master/LICENSE.md) for details.

---
