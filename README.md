## 安装python3.7

## 安装ODPS的pip && Python依赖

 * install pip

 curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

 python get-pip.py

 * Upgrading pip On Linux or macOS:

 sudo pip install --upgrade pip

 * Upgrading pip On Windows: 

 python -m pip install -U pip

 * 安装pyodps

 pip install pyodps
 
* 依赖强制覆盖

 sudo pip install numpy --ignore-installed numpy
 
## 使用
* 密码
  12345
* 阿里文档
 https://help.aliyun.com/document\_detail/34615.html?spm=a2c4g.11186631.6.692.FoZVDT
 https://help.aliyun.com/document_detail/34615.html?spm=a2c4g.11186623.6.694.4eAs1k

 
* 查看表结构

```
from odps.inter import enter
room = enter()
o = room.odps
o.get_table('qc_user_action_log')

# 结果示例显示
odps.Table
  name: default_123412.`qc_user_action_log`
  schema:",
       "    id                    : string      # uuid",
       "    created_at            : string      # 创建时间",
       "    equipment             : string      # 设备信息",
       "    app_version           : string      # app版本",
       "    page_id               : string      # 页面标示",
       "    action                : string      # 行为",
       "    label_name            : string      # 控件",
       "    form_data             : string      # 表单数据",
       "    user_id               : string      # 用户标示",
       "    sys_name              : string      # 终端系统类型",
       "    sys_version           : string      # 终端版本",
       "    extra_info            : string      # 附加扩展信息",
       "    url                   : string      # 链接",
       "    path                  : string      # app页面路径",
       "    pre_page_id           : string      # 来源页,refer",
       "    env                   : string      # 环境",
       "  partitions:",
       "    ds                    : string      # -",
       "    hh                    : string      # -",
       "    mm                    : string      # -"
```
## 查询数据

* 准备

```

from odps.inter import enter
room = enter()
o=room.odps 
```

* 查看表结构

```
t=o.get_table('qc_user_action_log')
# 结果示例显示
odps.Table
  name: dpdefault_123412.`qc_user_action_log`
  schema:
    id                    : string      # uuid
    created_at            : string      # 创建时间
    equipment             : string      # 设备信息
    app_version           : string      # app版本
    page_id               : string      # 页面标示
    action                : string      # 行为
    label_name            : string      # 控件
    form_data             : string      # 表单数据
    user_id               : string      # 用户标示
    sys_name              : string      # 终端系统类型
    sys_version           : string      # 终端版本
    extra_info            : string      # 附加扩展信息
    url                   : string      # 链接
    path                  : string      # app页面路径
    pre_page_id           : string      # 来源页,refer
    env                   : string      # 环境
  partitions:
    ds                    : string      # -
    hh                    : string      # -
    mm                    : string      # -
 
```

* 数据获取

```
t = o.get_table('qc_user_action_log')
for r in t.head(5):
    print r.values

with t.open_reader(partition='pt=test') as reader:
  count = reader.count
  for record in reader[5:10]  # 可以执行多次，直到将count数量的record读完，这里可以改造成并行操作
    # 处理一条记录
    print(record.values)
    print(record['extra_info'])

# 不使用with表达式
reader = t.open_reader(partition='pt=test')
count = reader.count
for record in reader[5:10]
  print(record.values)
  print(record['extra_info'])

```

* SQL

```
with o.execute_sql('select * from qc_user_action_log limit 5').open_reader() as reader:
    for record in reader:
        print(record.values)

```

* SQL增强

```

%load_ext odps
%enter
%sql select * from qc_user_action_log where ds='20180820' limit 5

```

* DataFrame

```
  from odps.df import DataFrame
  data = DataFrame(o.get_table('qc_user_action_log'))
  data.head(10)
  
```

## export the sql result into a local excel file

```
import xlwt

book = xlwt.Workbook(encoding="utf-8")
sheet = book.add_sheet("from odps")

with t.open_reader() as reader:
    y = 0
    for r in reader.read():
        x = 0
        for v in r.values:
            sheet.write(y, x, v)
            x = x + 1
        y = y + 1
book.save("from_odps.xls")

```

## 数据分析

### dataFrame
  https://pyodps.readthedocs.io/zh_CN/latest/df.html


## issue

### matplotlib中文乱码  针对Docker linux和windows类似
* https://edu.aliyun.com/a/2954
#### 下载字体文件 
* http://font.chinaz.com/130130474870.htm
* 解压重命名*.ttf文件为Vear.ttf
* 配置matplotlibrc修改两项，位于/usr/local/lib/python3.7/site-packages/matplotlib/mpl-data/
* font.family         : WenQuanYi Zen Hei Mono
* font.sans-serif     :Vera ## Vera对应重命名的文件
* build镜像时覆盖image的/usr/local/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc文件，如果是2.7需要修改目录
