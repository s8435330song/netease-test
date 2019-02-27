import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression


df = pd.read_csv('WoeData.csv')

y = np.array(df['a'])
l1 = []
for h in range(0,df.shape[0]):
    a=df.loc[h]
    l2 = []
    for x in ['b','c','f','g','i','j','k','m','o','p','t','u','v','x','y','z','aa','ae']:
        l2.append(a[x])
    l1.append(l2)

X = np.array(l1)
# 选择模型
cls = LogisticRegression()

# 把数据交给模型训练
cls.fit(X, y)

cls.predict(X)
cls.score(X,y)





# 加载iris数据集
def load_data():
    diabetes = datasets.load_iris()

    # 将数据集拆分为训练集和测试集 
    X_train, X_test, y_train, y_test = train_test_split(
    diabetes.data, diabetes.target, test_size=0.30, random_state=0)
    return X_train, X_test, y_train, y_test

# 使用LogisticRegression考察线性回归的预测能力
def test_LogisticRegression(X_train, X_test, y_train, y_test):
    # 选择模型
    cls = LogisticRegression()

    # 把数据交给模型训练
    cls.fit(X_train, y_train)

    print("Coefficients:%s, intercept %s"%(cls.coef_,cls.intercept_))
    print("Residual sum of squares: %.2f"% np.mean((cls.predict(X_test) - y_test) ** 2))
    print('Score: %.2f' % cls.score(X_test, y_test))

if __name__=='__main__':
    X_train,X_test,y_train,y_test=load_data() # 产生用于回归问题的数据集
    test_LogisticRegression(X_train,X_test,y_train,y_test) # 调用 test_LinearRegression

