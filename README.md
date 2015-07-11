## weilefood

###项目名称
__味了美食__


###公司信息
__公司名称__:四川至尚信和科技有限公司<br>
__营业执照号码__:510110000023535<br>
__组织机构代码__:34308654-7<br>
__公司地址__:四川省成都市天府新区华阳街道利通路99号37栋2层13号<br>
__联系人__:陈俞霖<br>
__手机号码__:13880123367<br>
<br><br>
__官方邮箱__:2917188331@qq.com


####注册用邮箱
用户:307531815@qq.com<br>
密码:198405177953710
<br><br>
用户:3262791991@qq.com<br>
密码:duangduangwei
<br><br>
用户:2917188331@qq.com<br>
密码:duangduangwei
####微信开放平台
用户:3262791991@qq.com<br>
密码:Rikki1234%
####QQ开放平台
用户:307531815@qq.com<br>
密码:198405177953710
####微博开放平台
用户:3262791991@qq.com<br>
密码:Rikki1234%
####支付宝
用户:3262791991@qq.com<br>
密码:duangduangwei123<br>
Duang123


### 项目结构
├── Project<br>
│   ├── Main: 放AppDelegate文件，整个应用的入口文件<br>
│   ├── UI: Controller和View，按功能划分。Common为相对独立的UI对象<br>
│   │   ├── Common 公共<br>
│   │   ├── Login 登录<br>
│   │   ├── Home 主页<br>
│   │   ├── Setting 设置<br>
│   │   └── ... 其它功能<br>
│   ├── Helper: 逻辑模块(PNXxxxxxHelper)或公共方法(PNStringHelper)<br>
│   │   └── Network: 网络请求相关的东西<br>
│   ├── Model: 数据类(PNXxxxxxModel)<br>
│   ├── Macro: 宏定义(PNXxxxxxMacro)<br>
│   │   ├── AppMacro.h app相关的宏定义<br>
│   │   ├── NotificationMacro.h 通知相关的宏定义<br>
│   │   ├── VendorMacro.h 一些第三方常量<br>
│   │   ├── UtilsMacro.h 公共方法宏定义<br>
│   │   └── ...<br>
│   ├── Category: 对象扩展<br>
│   ├── Vendor: 第三方类库(不在CocoaPods里的，或是是需要修改代码的)<br>
│   └── Resource: 资源文件（配置文件、Images.xcassets）<br>
└── Pods: 项目使用了https://cocoapods.org/这个类库管理工具(命令后面带 --verbose --no-repo-update 参数可不更新库提升速度)<br>

ViewController代码结构请看./Documents/ViewController_CodeStructure

### Xcode插件
####__Alcatraz__ 
Xcode插件管理工具<br>
https://github.com/supermarin/Alcatraz
####__XAlign__				
代码对齐工具<br>
https://github.com/qfish/XAlign
####__VVDocumenter-Xcode__	
自动完成方法注释格式<br>
https://github.com/onevcat/VVDocumenter-Xcode

