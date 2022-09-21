#!/usr/bin/env python
# coding: utf-8

# In[3]:


f1 = open("test_data_sm.dat")
f2 = open("test_lable_sm.dat")
f3 = open("wh_sm.dat")
f4 = open("wo_sm.dat")
f5 = open("bh_sm.dat")
f6 = open("bo_sm.dat")

def smToInt(x): # sign-magnitude to integer
    if x > 127 :
        return 128 - x
    return x

test_data = []
test_lable = []
wh = []
wo = []
bh = []
bo = []

for i in f1.readlines():
    test_data.append(int(i.strip(), 16))
for i in f2.readlines():
    test_lable.append(int(i.strip(), 16))
for i in f3.readlines():
    wh.append(int(i.strip(), 16))
for i in f4.readlines():
    wo.append(int(i.strip(), 16))
for i in f5.readlines():
    bh.append(int(i.strip(), 16))
for i in f6.readlines():
    bo.append(int(i.strip(), 16))

ans = [[0 for j in range(20)]for i in range(750)]
ans2 = [[0 for j in range(10)]for i in range(750)]

for i in range(750):
    for j in range(20):  
        for k in range(62):
            first = smToInt(test_data[i*62 + k])
            second = smToInt(wh[j*62 + k])
        
            ans[i][j] += first * second # multiply
            
        if (i == 0 and j == 19):
            print(k, ": ", ans[i][j])
        
        first = smToInt(bh[j])
        ans[i][j] += first * 127 # bias

        if (i == 0 and j == 19):
            print(k, ": ", ans[i][j])
        
        ans[i][j] = int(ans[i][j] / 512) # shift

        if (i == 0 and j == 19):
            print(k, ": ", ans[i][j])
        
        if (ans[i][j] < 0): # Relu
            ans[i][j] = 0

        if (i == 0 and j == 19):
            print(k, ": ", ans[i][j])
        
        if (ans[i][j] > 127): #satuaration
            ans[i][j] = 127

        if (i == 0 and j == 19):
            print(k, ": ", ans[i][j])
            
            
for i in range(750):
    for j in range(10):
        for k in range(20):
            first = ans[i][k]
            second = smToInt(wo[j*20 + k])
            
            ans2[i][j] += first * second
            
        first = smToInt(bo[j])
        
        ans2[i][j] += first * 127
        
        ans2[i][j] = int(ans2[i][j] / 512)
        
        if (ans2[i][j] < 0):
            ans2[i][j] = 0
            
        if (ans2[i][j] > 127):
            ans2[i][j] = 127

count = 0;
for i in range(750):
    if (ans2[i].index(max(ans2[i])) == test_lable[i]):
        count = count + 1
for i in range(len(ans2)):
    pass
    #print(i+1 , " : ", ans2[i])


# In[ ]:




