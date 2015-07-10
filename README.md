# weilefood
为了美食

### 项目结构
├── Project
│   ├── Main: 放AppDelegate文件，整个应用的入口文件
│   ├── UI: Controller和View，按功能划分。Common为相对独立的UI对象
│   │   ├── Common 公共
│   │   ├── Login 登录
│   │   ├── Home 主页
│   │   ├── Setting 设置
│   │   └── ... 其它功能
│   ├── Helper: 逻辑模块(PNXxxxxxHelper)或公共方法(PNStringHelper)
│   │   └── Network: 网络请求相关的东西
│   ├── Model: 数据类(PNXxxxxxModel)
│   ├── Macro: 宏定义(PNXxxxxxMacro)
│   │   ├── AppMacro.h app相关的宏定义
│   │   ├── NotificationMacro.h 通知相关的宏定义
│   │   ├── VendorMacro.h 一些第三方常量
│   │   ├── UtilsMacro.h 公共方法宏定义
│   │   └── ...
│   ├── Category: 对象扩展
│   ├── Vendor: 第三方类库(不在CocoaPods里的，或是是需要修改代码的)
│   └── Resource: 资源文件（配置文件、Images.xcassets）
└── Pods: 项目使用了https://cocoapods.org/这个类库管理工具(命令后面带 --verbose --no-repo-update 参数可不更新库提升速度)

ViewController代码结构请看./Documents/ViewController_CodeStructure

### Xcode插件
Alcatraz			Xcode插件管理工具		https://github.com/supermarin/Alcatraz
XAlign				代码对齐工具			https://github.com/qfish/XAlign
VVDocumenter-Xcode	自动完成方法注释格式	https://github.com/onevcat/VVDocumenter-Xcode