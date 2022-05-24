---
layout: post
title: 安装GPU版本的xgboost
tags:
- PY
- DS
status: publish
type: post
published: true
---

自从python变得越来越普及之后，数据科学也变得更加亲民化，在大型计算上CPU确实不如GPU来的更省时省力。今天分享Xgboost GPU版本在windows 10上的安装

- 下载Xgboost源码

  ```shell
  git clone --recursive git@github.com:dmlc/xgboost.git
  ```

- 下载已经编译好的[xgboost.dll](http://ssl.picnet.com.au/xgboost/) 并放置于xgboost/python-package/xgboost目录下

- 这一步很关键，打开Anaconda Prompt(Anaconda3)，切换到目录xgboost/python-package，然后执行python setup.py install，等待完成安装

- 通过如下脚本测试是否安装成功

  ```python
  import xgboost as xgb
  from sklearn.datasets import load_boston
  
  boston = load_boston()
  
  # XGBoost API example
  params = {'tree_method': 'gpu_hist', 'max_depth': 3, 'learning_rate': 0.1}
  dtrain = xgb.DMatrix(boston.data, boston.target)
  xgb.train(params, dtrain, evals=[(dtrain, "train")])
  
  # sklearn API example
  gbm = xgb.XGBRegressor(silent=False, n_estimators=10, tree_method='gpu_hist')
  gbm.fit(boston.data, boston.target, eval_set=[(boston.data, boston.target)])
  ```

  

如果发现git clone很慢，参考如下设置:

1. 设置代理

   ```shell
   git config --global http.proxy socks5://127.0.0.1:1080
   git config --global https.proxy socks5://127.0.0.1:1080
   ```

2. git clone或者git push特别慢的设置，速度成倍上升

   ```shell
   sudo vi /etc/hosts
   
   151.101.72.249 http://global-ssl.fastly.Net
   192.30.253.112 http://github.com
   ```

   
