# <leader>
```
默认的 <Leader> 是 \
```

# 自动更新
```
  [options]
automatic_update = true
```

# 启动主题
```
  [options]
colorscheme = "molokai"

  [[layers]]
name = "colorscheme"
```

# 更新插件(plug)
```
  :SPUpdate
```

# 查看日志(log)
```
:SPDebugInfo!
```

# 界面元素切换(interface)
## SPC t
```
SPC t 8 高亮所有超过 80 列的字符
SPC t f 高亮临界列
SPC t hh 高亮当前行
SPC t hi 高亮代码对其线
SPC t hc 高亮光标所在列
SPC t hs 启动语法高亮
SPC t n 显示隐藏行号
SPC t b 切换背景色
SPC t c 切换 conceal 模式
SPC t p 切换 paste 模式
SPC t t Tab 管理器

SPC t mb 电池
SPC t mM 文件类型
SPC t mt 时间
SPC t md 日期
SPC t mT 状态栏
SPC t mv 版本控制

SPC t 8 高亮指定列后的所有字符
SPC t f 高亮指定列字符
SPC t s 语法检查
SPC t S 拼写检查
```

## SPC T
```
SPC T ~ 显示/隐藏 Buffer 结尾/行首的~
SPC T f 显示隐藏边框
SPC T m 显示隐藏菜单
SPC T t 显示隐藏工具栏
```

# 切换 window
```
SPC [1-9]
```

# 切换 tag
```
\ [1-9]
g r 跳前一个 tag
```

# 搜索计数
```
[layers]
name = "incsearch"
```

# 状态栏分隔符(statusline)
```
[options]
statusline_separator = 'arrow'
```

# 标签管理器(tags manager)
```
o 展开/关闭标签目录
r 重命名标签
n 新建标签
N 新建匿名标签
x 删除标签
enter 跳转到标签
```

# 文件树(nerd tree)
```
F3 & SPC f t & SPC f T 切换文件树

N 新建文件
yy 复制文件路径
yY 复制文件
p 粘贴
. 显示隐藏
sv 分屏
sg 分屏
p 预览文件
i 文件修改历史
v 快速查看
< 放大缩小
g x 使用相关程序执行
' 标记
V 清除所有标记
Ctrl+r 刷新'
```

# 光标(cursor)
```
jkjh
H 屏幕顶部
L 屏幕底部

右移动文本
< 左移动文本
} 后移动段落
{ 前移动段落
ctrl + f/d 向下翻页
ctrl + b/u 向上翻页
ctrl + e/j 向下滚屏
ctrl + y/k 向上滚屏
ctrl + c 复制绝对路径
ctrl + x 切换窗口文件
ctrl + shift + up 向上移动当前行
ctrl + shift + down 向下移动当前行
```

# SPC x a 对齐(Align)
``` 
SPC x a 各种对齐
SPC x j 各种对齐
```

# SPC x 文本处理(Text)
```
SPC x c 统计单词
SPC x d w 删除空白
SPC x g t 翻译
SPC x u 小写
SPC x U 大写
SPC x tc 字符前提
SPC x tC 字符后提
```

# 文本插入(Text insert)
```
SPC i ll list
SPC i lp paragh
SPC i ls sentence
SPC i p1 password
SPC i p2 password2
SPC i p3 password3
SPC i pp easy password
SPC i pn numerical password
SPC i U UUID
SPC n +/- 数字加减
```

# 注释(Comment)
```
SPC ; 进入注释操作模式
SPC c h 隐藏/显示注释
SPC c l 注释/反注释当前行
SPC c L 注释行
SPC c u 反注释行
SPC c p 注释/反注释段落
SPC c P 注释段落
SPC c s 使用完美格式注释
SPC c t 注释/反注释到行
SPC c T 注释到行
SPC c y 注释/反注释同时复制(TODO)
SPC c Y 复制到未命名寄存器后注释
SPC c $ 从光标位置开始注释当前行
```

# 语法树(ctags)
```
Terminal >>> sudo apt-get install ctags
F2 触发语法树
``` 

# 窗口(window)
```
SPC w = window
SPC w . 启用窗口临时快捷键
SPC w 在同一标签内进行窗口切换
SPC w = 对齐分离的窗口
SPC w c 进入阅读模式，浏览当前窗口 (需要 tools 模块)
SPC w C 选择某一个窗口，并且进入阅读模式 (需要 tools 模块)
SPC w d 删除一个窗口
SPC w D 选择一个窗口并关闭
SPC w F 新建一个新的标签页
SPC w h 移至左边窗口
SPC w H 将窗口向左移动
SPC w j 移至下方窗口
SPC w J 将窗口向下移动
SPC w k 移至上方窗口
SPC w K 将窗口向上移动
SPC w l 移至右方窗口
SPC w L 将窗口向右移动
SPC w m 最大化/最小化窗口（最大化相当于关闭其它窗口）
SPC w M 选择窗口进行替换
SPC w o 按序切换标签页
SPC w p m 使用弹窗打开消息
SPC w p p 关闭当前弹窗窗口
SPC w r 顺序切换窗口
SPC w R 逆序切换窗口
SPC w s/- 水平分割窗口
SPC w S 水平分割窗口，并切换至新窗口
SPC w u 恢复窗口布局
SPC w U 撤销恢复窗口布局
SPC w v// 垂直分离窗口
SPC w V 垂直分离窗口，并切换至新窗口
SPC w w 切换至前一窗口
SPC w W 选择一个窗口
```

# 缓冲区(buffer)
```
SPC 切换至前一缓冲区，常用于两个缓冲区来回切换
SPC b . 启用缓冲区临时快捷键
SPC b b 通过模糊搜索工具进行缓冲区切换，需要启用一个模糊搜索工具模块
SPC b d 删除当前缓冲区，但保留编辑窗口
SPC b D 选择一个窗口，并删除其缓冲区
SPC b c 删除其它已保存的缓冲区
SPC b C-d 删除其它所有缓冲区
SPC b e 清除当前缓冲区内容，需要手动确认
SPC b h 打开欢迎界面， 等同于快捷键 SPC a s
SPC b n 切换至下一个缓冲区，排除特殊插件的缓冲区
SPC b m 打开消息缓冲区
SPC b p 切换至前一个缓冲区，排除特殊插件的缓冲区
SPC b P 使用系统剪切板内容替换当前缓冲区
SPC b R 从磁盘重新读取当前缓冲区所对应的文件
SPC b w 切换只读权限
SPC b Y 将整个缓冲区复制到系统剪切板
SPC b N h 在左侧新建一个窗口，并在其中新建空白 buffer
SPC b N j 在下方新建一个窗口，并在其中新建空白 buffer
SPC b N k 在上方新建一个窗口，并在其中新建空白 buffer
SPC b N l 在右侧新建一个窗口，并在其中新建空白 buffer
SPC b N n 在当前窗口新建一个空白 buffer
```

# 文件操作(file)
```
SPC f v d 打开spacevim配置文件init.toml
SPC f / 使用 find 命令查找文件，支持参数提示
SPC f b 跳至文件书签
SPC f C d 修改文件编码 unix -> dos
SPC f C u 修改文件编码 dos -> unix
SPC f D 删除文件以及 buffer，需要手动确认
SPC f f 打开文件
SPC f F 打开光标下的文件
SPC f o 代开文件树，并定位到当前文件
SPC f R rename the current file(TODO)
SPC f s / Ctrl-s 保存文件 (:w)
SPC f W 使用管理员模式保存
SPC f S 保存所有文件
SPC f r 打开文件历史
SPC f t 切换侧栏文件树
SPC f T 打开文件树侧栏
SPC f d Windows 下显示/隐藏磁盘管理器
SPC f y 复制并显示当前文件的绝对路径
```

# SPACE VIM
```
SPC f v v 复制并显示当前 SpaceVim 的版本
SPC f v d 打开 SpaceVim 的用户配置文件
```

# 错误处理(error)
```
SPC t s 切换语法检查器
SPC e c 清除所有错误
SPC e h describe a syntax checker
SPC e l 切换显示错误/警告列表
SPC e n 跳至下一错误
SPC e p 跳至上一个错误
SPC e v 验证语法检查器设置
SPC e . 错误暂态
```

# quickfix
```
<leader> q l 打开 quickfix 列表窗口
<leader> q c 清除 quickfix 列表
<leader> q n 跳到 quickfix 列表中下一个位置
<leader> q p 跳到 quickfix 列表中上一个位置
q 退出 quickfix
```

# 跳动到定义代码块
```
g d
```

# 关闭当前 buffer
```
SPC b d
```
