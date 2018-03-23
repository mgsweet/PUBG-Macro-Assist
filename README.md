# PUBG-Macro-Assist
*Some macros coded by Autohotkey.祝大家吃鸡愉快*

## warning
2018/01/26 第一个号被BAN了
2018/03/23 弄了个号调试了一波...

## Latest Edition:
## V1.22 本版本删掉了大量过时功能，保留了一个精简版，此版本适合调了游戏右键长按开镜的玩家，具体见代码。

### V1.21
1. 增加了自动适配显示器大小的功能，细节调整可自行修改225-226行
2. 增加了需要按瞄准（按着鼠标右键）才有补偿的效果，默认开启，为了提供更好的仍手雷体验，若喜欢腰射压枪的朋友可以通过修改第十八行代码，或者使用ENTER键进行切换。

### V1.2
1. 本次更新新增了新的全自动压枪方式，现在可以直接使用游戏里面的全自动了。原理是根据两发子弹的间隔时间x,设定每X秒补偿一次实现压枪（实现中加了0.001秒随机浮动减少被判作弊风险）。不过，我没有废弃旧的快速单点模拟全自动的方式，这是因为用游戏里面的全自动需要的补偿值要远大于用快速单点需要的补偿，当你开局只有一把手枪的时候，新的补偿值会过度压枪（例如在我的电脑里面，本来补偿为8就可以压的枪，现在需要25才能压了），导致操作及其不方便，而且该全自动压枪模式不适用于M16，推荐将小键盘的2键绑定到鼠标侧键上进行切换新旧模式。由于不同枪的射速不同，子弹间隔不同，为了精准压枪，请使用小键盘切换相应的枪支，详细操作请看Usage，我目前提供的有M4\M16\SCAL\GROZA\UMP，参考数据：https://pubg.me/weapons/assault-rifles
2. 删除了补偿模式这个设定，默认使用者就是想要用补偿的，你可以通过按0键或直接退出该脚本关闭补偿。
3. 由于官方提供快速开镜的功能，现在默认不使用快速开镜，而且只有快速开镜功能和大跳功能的绿色版本已被我移到废弃文件夹中
4. 提供了快捷切换大小补偿值的方法，小键盘3键，会分别记录你的两个补偿值并在其中切换，便于打高倍镜

### V1.1
1. 增加了带少量随机值的压枪补偿值版本，希望能有效避免检测，但其实发现DLL命令好像只能接受整型，这个有待讨论。
2. 同时B键不再提供切换全自动单点，所以大家游戏里的全自动还是可以切换回B，然后直接通过按小键盘2键去切换（我将那个键绑定到鼠标侧键上了），但这个大家可以参照之前的代码改回来，这只是我的操作习惯而已。
3. 由于版本经常改动，所以不提供EXE版本，但若要使用压枪版，请用.exe的去运行，尽量降低封号风险。

### v1.0
1. 保留了除了补偿和高速单点外的所有功能的版本
2. 现在游泳按空格能浮起来了
3. 现在跳跃开镜不会再卡在瞄准状态了

## Usage
1. Download **Autohotkey** from: [https://www.autohotkey.com/download/](https://www.autohotkey.com/download/)
2. `git@github.com:mgsweet/PUBG-Macro-Assist.git` or download the `.zip`
3. run the `superJump.ahk`(only super Jump macro) or `green_Assist.ahk`(more macro but  riskier).
4. use Fullscreen (Windowed) to run your game.

### Usage for  `PUBG_Assist(1080p)_adv.ahk` (new edition, find it in `/banned` or use the tool.exe)
1. Crouch Jumping: All of your `space` click will become super jump, just jump as usual.
2. Autofire: you can use single-fire mode of the gun to fire as the autofire mode, which will make you fire more stable. 
3. Fast Aiming: aim faster in the game. A nice tool I suggest you to use. 
4. Compensation: The most powerful tool I think. Which will help you fire stably. But you need to change the value of it to suit the gun you use. For example, M4A1 and M16's  compensation value is close to 8. Just try!
5. Some hotkey you should know:
	1. `NumPad1`: change ADS setting
	2. `NumPad2`: change AutoFire setting
	3. `NumPad3`: change comp between weak and strong
	4. `NumPad4`: set interval to the time between shot of M4
	5. `NumPad5`: set interval to the time between shot of UMP
	6. `NumPad6`: set interval to the time between shot of SCAL
	7. `NumPad7`: set interval to the time between shot of AK
	8. `NumPad9`: set interval to the time between shot of GORZA
	9. `NumPad8`: set compensation value to 8
	10. `NumpadAdd`: add 1 to  compensation value
	11. `NumpadSub`: sub 1 to  compensation value
	12. `NumpadEnter`: change grenade mode setting
	13. `NumPad0`: set compensation value to 0

## Development
I will try to create some macros to help you fire better.
Welcome to join and pull request to me.
