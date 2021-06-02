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
                                        .hidesBottomBarWhenPushed
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

- [Требования](#requirements)
- [В чем смысл?](#-в-чем-смысл)
- [Конфигурация Flow](#%EF%B8%8F-конфигурация-flow)
- [Как использовать?](#как-использовать)
- [Зачем все это нужно?](#-зачем-все-это-нужно-чем-это-лучше-coordinator---паттерна)
- [Установка](#installation)
- [Контакты](#credits)
- [Лицензия](#license)


## Requirements

- iOS 9.0+
- Xcode 10.0+
- Swift 5.0+


## 🤨 В чем смысл?
Навигация - это действие (push, flow, set, и т.д.).\
Действие можно описать ввиде кложура `() -> Void`. Называть его будем просто `Flow`.\
Теперь можем написать фабрику методов для создания `Flow`. В данном фреймворке представлены следующие (базовые) методы:
#### `PushFlow`
[PushFlow.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Push/PushFlow.swift)
```swift
PushFlow(
    in: myNavigationController,
    MyViewController()
)
```
#### `PopFlow`
[PopFlow.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Push/PopFlow.swift)
```swift
PopFlow(in: myNavigationController)

PopFlow(
    in: myNavigationController,
    to: secondViewControlller
)

PopToRootFlow(in: myNavigationController)
```
#### `PresentFlow`
[PresentFlow.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Present/PresentFlow.swift)
```swift
Present(
    in: rootViewController,
    MyModalViewController()
)

// Ищет самый верхний контроллер в окне и презентит в нём.
Present(
    in: window,
    MyModalViewController()
)
```
#### `DismissFlow`
[DismissFlow.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Present/DismissFlow.swift)
```swift
DismissFlow(myViewController)

// Дисмисит контроллер, который презентовал указанный контроллер
DismissFlow(in: presentedViewController)

// Дисмисит самой верхний контроллер в окне
DismissFlow(in: window)
```
#### `SetTabBarItemsFlow`
[SetTabBarItemsFlow.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/SetTabBarItems/SetTabBarItemsFlow.swift)
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
[SetWindowRootFlow.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/SetWindowRoot/SetWindowRootFlow.swift)
```swift
SetWindowRootFlow(
    in: window,
    myRootViewController
)
```

Если этого кажется недостаточным, вы можете написать свою функцию аналогичным образом через глобальные функции возвращающие Flow (т.е. кложур).
Например, флоу с пушем и удалением предыдущего экрана может быть реализован так:
```swift
PushReplacingFlow(
    in: navigationController,
    MyViewController()
)


func PushReplacingFlow(
    in navigationController: UINavigationController,
    animated: Bool = true,
    _ viewController: @autoclosure @escaping UIViewController
) -> Flow { 
    return { 
        var newStack = navigationController.viewControllers
        newStack.removeLast()
        newStack.append(viewController())

        navigationController.setViewControllers(
            viewControllers: newStack,
            animated: animated
        )
    }
}
```


## ⚙️ Конфигурация `Flow`
Каждый `Flow` имеет конфигурацию [`FlowTransitionConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/FlowConfiguration.swift), которая запускается **перед** и **после** выполнения.
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

Фреймфорк уже предоставляет базовый набор конфигураций:
---
 [`PushFlowTransitionConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Push/PushFlowTransitionConfiguration.swift) == `FlowTransitionConfiguration<UINavigationController, UIViewController>`
- `hidesBottomBarWhenPushed`
- `title(String?)`
- `titleView(UIView?)`
- `navigationDelegate(UINavigationControllerDelegate)`
---
[`PresentFlowTransitionConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Present/PresentFlowTransitionConfiguration.swift) == `FlowTransitionConfiguration<UIViewController, UIViewController>`
- `transitionStyle(UIModalTransitionStyle)`
- `presentationStyle(UIModalPresentationStyle)`
- `modalInPresentation`
- `transitionDelegate(UIViewControllerTransitioningDelegate)`
---
[`SetTabBarItemsFlowTransitionConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/SetTabBarItems/SetTabBarItemsFlowTransitionConfiguration.swift) == `FlowTransitionConfiguration<UITabBarController, UIViewController>`
- `titlePositionAdjustment(UIOffset)`
---
[`SetWindowRootFlowTransitionConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/SetWindowRoot/SetWindowRootFlowTransitionConfiguration.swift)== `FlowTransitionConfiguration<UIWindow, UIViewController>`
- `keyAndVisible`
- `animated(duration: TimeInterval, completion: Flow?)`
---
## ⏰ Ленивая инициализация
Презентуемые контроллеры инициализируются **только при запуске `Flow`!**

`Push/Present/Set/...Flow` принимают `() -> ViewController` билдер.
> Для каждого представленного `Flow` есть альтернативная инициализация с `@autoclosure` билдером.
```swift
// контроллер еще не проинициализирован
let flow = PushFlow(
    in: myNavigationController,
    MyViewController()
)
// контроллер проинициализирован и запушен
flow()
```

## 🪆 Рекурсивная навигация
Иногда может возникнуть кейс с бесконечной вложенностью стэка экранов. Например, экран перехода на страницу профиля друга из экрана твоего профиля, а из экрана профиля друга, на экран профиля его друга.

Реализовать такое с FunctionalNavigationFlowKit можно двумя способами.\
1. Вынести флоу профиля в отдельную переменную/функцию и вызывать ее внутри себя(рекурсивно) при открытии профиля друга.
2. Использовать `RecursiveFlow`:
```swift
RecursiveFlow(with: myUserInfo, { (userInfo: UserInfo, profileFlow: (UserInfo) -> Flow) in 
    PushFlow(
        in: navigationController,
        ProfileViewController(
            userInfo: userInfo, 
            friendFlow: profileFlow // принимает кложур (UserInfo) -> Flow
        )
}
```
# Как использовать?

Входной точкой приложения является AppDelegate, потому `Flow` запускается оттуда.
Рассмотрим пример стандартного приложения с авторизацией:
```swift
func application(
    _ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)

    if session.isAuthorized { 
        MainFlow(
            in: window,
            logoutFlow: AuthFlow
        )()
    } else { 
        AuthFlow(
            in: window,
            completionFlow: MainFlow
        )()
    }

    return true
}
```
Пример создания MainFlow:
```swift
func MainFlow(
    in window: UIWindow,
    logoutFlow: @escaping Flow
) -> Flow { 

    // Some shared dependencies
    let imageLoader = ImageLoader()
    
    return SetWindowRootFlow(
        in: window,
        configuration: .makeKeyAndVisible
        DeferredBuild(UINavigationViewController.init) {  navigationController in 

            PushFlow(
                in: navigationController,
                FeedViewController(
                    
                    feedDetailsFlow: { (feed: Feed) in 
                        PushFlow(in: navigationController, FeedDetailsViewController(feed, imageLoader))
                    },

                    profileFlow: (userInfo) -> Flow in 
                        PresentFlow(
                            in: navigationController, 
                            ProfileViewController(
                                userInfo,
                                logoutFlow: logoutFlow
                            )
                        )
                )
            )

        }
    )
}
```

---

## 😑 Зачем все это нужно? Чем это лучше Coordinator - паттерна?
1. Подобный подход позволяет **декларативно** описать **карту навигации**, скрывая детали презентации и сборки экрана.
2. Делает **независимым** навигацию от конкретного экрана. Иными словами, презентуемый и презентующий контроллер не знают (и не должны знать), как будут отображаться в иерархии окон. Такой подход позволяет легко поменять тип презентации и контекст, в котором презентуется экран, без необходимости изменять что-то несвязанное с навигацией...*open/closed principle*  (пересекается с пунктом 1).
3. В `swift` можно писать *вложенные функции*. Учитывая то, что при работе с навигацией **важно иметь доступ ко всей иерархии из любого презентуемого контекста** приложения, вложенные функциии являются удобным решением для описания какого-то внутреннего скоупа навигации. Имея доступ к внешним(глобальном для внутренней фунции) переменменным, пропадает необходимость использования *constructor/property/method injection* из ООП, которая часто используется в `Coordinator`-ах при передаче зависимостей в дочерние(n-ой вложенности) координаторы через дерево/цепочку вызовов, приводящих к созданию транзитивных зависимостей.
4. Глубокая вложенность может показаться чем-то плохим, но в данном случае она описывает столь же глубокую вложенность навигации приложения. Можно вынести что-то в отдельные переменную, но пользы от этого меньше, чем вреда: теряешь доступ ко всей иерархии контроллеров (нижестоящих). Исключением для вынесения может разве что наличие нескольких точек перехода на один и тот же `Flow`. 

---

## Installation

#### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'FunctionalNavigationFlowKit'
end
```

#### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "YOUR_PROJECT_NAME",
  dependencies: [
      .package(url: "https://github.com/Ernest0-Production/FunctionalNavigationFlowKit.git", from: "0.0.2")
  ],
  targets: [
      .target(name: "YOUR_TARGET_NAME", dependencies: ["FunctionalNavigationFlowKit"])
  ]
)
```

### Credits

- [Telegram](https://t.me/Ernest0n)


### License

FunctionalNavigationFlowKit is released under the MIT license. See [LICENSE](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/master/LICENSE.md) for details.
