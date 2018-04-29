--- 
layout: post
title: 商业思维的重要性
tags: 
- 商业
- 投资
status: publish
type: post
published: false
---

> 啤酒2块钱 1瓶<BR>
> 4个瓶盖换 1瓶<BR>
> 2个空瓶换 1瓶<BR>
> 10块钱可以喝几瓶？

**老实人的思维方式**

第一次10元购买5瓶瓶酒喝完，酒瓶5个，瓶盖5个<br>
第二次4个酒瓶、4个瓶盖换3瓶啤酒喝完，酒瓶3个，瓶盖4个<br>
第三次4个瓶盖换1瓶啤酒喝完，酒瓶2个，瓶盖2个<br>
第四次2个酒瓶换1瓶啤酒喝完，酒瓶1个，瓶盖3个
游戏结束，最终喝到5+3+2+1 = 1瓶啤酒。

bottle=5
cap=5
drink_bottle=5
while True:
    drink_bottle += (int(bottle/2)+int(cap/4))
    tmpcap=int(bottle/2)
    bottle=bottle-int(bottle/2)+int(cap/4)
    cap=cap-int(cap/4)*3+tmpcap
    print 'accumulative bottle drunk:%d' %drink_bottle, 'with left bottle %d and cap %d' %(bottle,cap)
    if bottle<2 and cap<4:
        break