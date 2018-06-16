---
layout: post
title: 蓄水池抽样的随机性及代表性检验
tags:
- 数据
- 随机
- 抽样
status: publish
type: post
published: true
---

虽说大数据时代，全量的观念逐步深入人心，但抽样的意义同样重要。例如，在简单统计中可以借助大数据平台的处理能力进行全量计算，但深层次的计算有如机器学习、算法研发，抽样的意义就很具备实操效用价值。而抽样的合理性在大数据应用场景下，挑战性来的更加激烈。

这里测试一种称为蓄水池抽样的技术及其抽样随机性与代表性

>蓄水池抽样详细介绍可参见Wiki[https://en.wikipedia.org/wiki/Reservoir_sampling]

其基本步骤如下：
```
(*
  S has items to sample, R will contain the result
 *)

ReservoirSample(S[1..n], R[1..k])

  // fill the reservoir array

  for i = 1 to k

      R[i] := S[i]

  // replace elements with gradually decreasing probability

  for i = k+1 to n

    j := random(1, i)   // important: inclusive range

    if j <= k

        R[j] := S[i]
```

假设当前有10000个数据排列的数[1，2，3，...，10000],通过蓄水池抽样算法分别抽取10组1000个数的样本，来看其分布与总体分布之间的差别
```
          Total
 Min.   :    1
 1st Qu.: 2501
 Median : 5000
 Mean   : 5000
 3rd Qu.: 7500
 Max.   :10000
```

```
      res           res.1           res.2          res.3          res.4
 Min.   :   4   Min.   :    1   Min.   :  25   Min.   :  26   Min.   :  12
 1st Qu.:2550   1st Qu.: 2282   1st Qu.:2547   1st Qu.:2532   1st Qu.:2304
 Median :4954   Median : 4736   Median :4872   Median :5113   Median :4971
 Mean   :4991   Mean   : 4839   Mean   :4969   Mean   :5017   Mean   :4911
 3rd Qu.:7532   3rd Qu.: 7290   3rd Qu.:7435   3rd Qu.:7531   3rd Qu.:7467
 Max.   :9995   Max.   :10000   Max.   :9979   Max.   :9995   Max.   :9997
     res.5          res.6          res.7          res.8          res.9
 Min.   :   1   Min.   :   1   Min.   :   4   Min.   :  15   Min.   :   4
 1st Qu.:2434   1st Qu.:2302   1st Qu.:2562   1st Qu.:2432   1st Qu.:2292
 Median :5003   Median :4780   Median :4932   Median :4771   Median :4639
 Mean   :4911   Mean   :4857   Mean   :4955   Mean   :4892   Mean   :4826
 3rd Qu.:7369   3rd Qu.:7417   3rd Qu.:7396   3rd Qu.:7359   3rd Qu.:7338
 Max.   :9995   Max.   :9984   Max.   :9987   Max.   :9998   Max.   :9989
```

可以看到10个抽样分布与总体分布基本还是比较接近的，但并没有想象中的完美
