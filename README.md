# FunctionalNavigationFlowKit

A framework for describing application screens navigation in a declarative way as **navigation map** 🗺

## 🗺 Example
```swift
Flow.setWindowRoot(
    in: window,
    with: .zip(
        .keyAndVisible, 
        .animated(duration: 0.3)
    ),
    MainTabBarController().withFlow({  (rootController: MainTabBarController) in
        Flow.setTabs(
            in: rootController,
            with: .titlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: -4.0)),
            [
                UINavigationController().withFlow({ navigationController in
                    Flow.push(
                        in: navigationController: navigationController,
                        animated: false,
                        with: .title("Feed"),
                        FeedViewController(
                            searchFlow: Flow.push(
                                in: navigationController,
                                SearchViewController()
                            ),
                            itemFlow: { item in
                                Flow.push(
                                    in: navigationController,
                                    with: .zip(
                                        .title(item.name),
                                        .hidesBottomBarWhenPushed
                                    ),
                                    ItemDetailsViewController(
                                        with: item,
                                        commentsFlow: Flow.present(
                                            in: navigationController,
                                            CommentsViewController(item: item)
                                        )
                                    )
                                )
                            }
                        )
                    )
                }),

                UINavigationController().withFlow({ navigationController in
                    Flow.push(
                        in: navigationController,
                        with: .title("Profile"),
                        ProfileViewController(
                            settingsFlow: PushFlow(
                                in: navigationController,
                                with: .title("Settings"),
                                SettingsViewController(
                                    saveCompletionFlow: Flow.pop(in: navigationController)    
                                )
                            ),
                            logoutFlow: <#Authorization Flow#>
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
- [Proposal](#-Proposal)
- [Конфигурация Flow](#%EF%B8%8F-конфигурация-flow)
- [Как использовать?](#как-использовать)
- [Зачем все это нужно?](#-зачем-все-это-нужно-чем-это-лучше-coordinator---паттерна)
- [Установка](#installation)
- [Контакты](#credits)
- [Лицензия](#license)


## Requirements

- iOS 9.0+
- Xcode 10.0+
- Swift 4.0+


## 💡 Proposal
Navigation - is an action (like push, flow, set, etc.)\
The action can be described as a closure `() -> Void`. Let's just call it `Flow`.\
Now we can write a method factory to create `Flow`. This framework provides basic factory methods:
#### `Flow.push`
[Flow.push.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Flow/Extensions/UIKit/NavigationStack/Flow+push.swift)
```swift
Flow.push(
    in: myNavigationController,
    MyViewController()
)
```
#### `Flow.pop`
[Flow+pop.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Flow/Extensions/UIKit/NavigationStack/Flow+pop.swift)
```swift
Flow.pop(in: myNavigationController)

Flow.pop(
    in: myNavigationController,
    to: secondViewControlller
)

Flow.pop(
    in: myNavigationController,
    from: secondViewControlller
)

Flow.popToRoot(in: myNavigationController)
```
#### `Flow.present`
[Flow+present.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Flow/Extensions/UIKit/Modal/Flow+present.swift)
```swift
Flow.present(
    in: rootViewController,
    MyModalViewController()
)

// Looks for the topmost viewController and calls the present flow in itself
Flow.present(
    inTopmost: window.rootViewContoller!,
    MyModalViewController()
)
```
#### `Flow.dismiss`
[Flow+dismiss.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Flow/Extensions/UIKit/Modal/Flow+dismiss.swift)
```swift
Flow.dismiss(myViewController)

Flow.dismiss(to: rootViewController)
```
#### `Flow.setTabs`
[Flow+setTabs.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Flow/Extensions/UIKit/TabBar/Flow+setTabs.swift)
```swift
Flow.setTabs(
    in: tabBarController,
    [
        FeedViewController(),
        ProfileViewController(),
    ]
)
```
#### `Flow.setWindowRoot`
[Flow+setWindowRoot.swift](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Flow/Extensions/UIKit/Window/Flow+setWindowRoot.swift)
```swift
Flow.setWindowRoot(
    in: window,
    myRootViewController
)
```

if that doesn't seem enough, you can write yourself `Flow` extension like this.
For example, lets make push and replace last item on the navigation stack:
```swift
// Design
Flow.swapPush(
    in: navigationController,
    MyViewController()
)

// Implementation
extension Flow { 
    func swapPush(
        in navigationStack: UINavigationController,
        animated: Bool = true,
        _ itemFactory: @autoclosure @escaping () -> UIViewController
    ) -> Flow {
         Flow.just({
            let item = itemFactory()

            var stackItems = navigationController.viewControllers
            _ = stackItems.popLast()
            stackItems.append(item)

            navigationStack.setViewControllers(stackItems, animated: animated)
        })
    }
}
```


## ⚙️ `Flow` configuration
Every UIKit `Flow` can have configuration [`FlowConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/FlowConfiguration/FlowConfiguration.swift), that intercept start and end of flow execution.
```swift
let configuration = FlowConfiguration<UINavigationController, UIViewController>(
    preparation: { navigationController, viewController in  
        navigationController.setNavigationBarHidden(true, animated: false)
    },
    completion: { navigationController, viewController in
        Analytics.track(.openScreen(String(description: viewController)))
    }
)

return Flow.push(
    in: navigationController,
    with: configuration,
    SubscriptionViewController()
)
```

The framework already provides basic configurations factory:
---
 [`PushFlowConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Push/PushFlowConfiguration.swift) == `FlowConfiguration<UINavigationController, UIViewController>`
- `hidesBottomBarWhenPushed`
- `title(String?)`
- `titleView(UIView?)`
- `navigationDelegate(UINavigationControllerDelegate)`
---
[`PresentFlowConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/Present/PresentFlowConfiguration.swift) == `FlowConfiguration<UIViewController, UIViewController>`
- `transitionStyle(UIModalTransitionStyle)`
- `presentationStyle(UIModalPresentationStyle)`
- `modalInPresentation`
- `transitionDelegate(UIViewControllerTransitioningDelegate)`
---
[`SetTabBarItemsFlowConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/SetTabBarItems/SetTabBarItemsFlowConfiguration.swift) == `FlowConfiguration<UITabBarController, UIViewController>`
- `titlePositionAdjustment(UIOffset)`
---
[`SetWindowRootFlowConfiguration`](https://github.com/Ernest0-Production/FunctionalNavigationFlowKit/blob/main/Sources/FunctionalNavigationFlowKit/SetWindowRoot/SetWindowRootFlowConfiguration.swift)== `FlowConfiguration<UIWindow, UIViewController>`
- `keyAndVisible`
- `animated(duration: TimeInterval, completion: Flow?)`
---
## ⏰ Lazy view controller initialization
Passed presented/pushed view controller in the flow will only be initialized when the flow is executed.

`push/present/set/...Flow` take `@escaping @autoclosure () -> ViewController` signature into argument.
```swift
// Controller not yet initialized
let flow = Flow.push(
    in: myNavigationController,
    MyViewController()
)
// Controller alredy initialized
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
