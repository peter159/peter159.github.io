from sklearn.datasets import make_blobs
from sklearn.cluster import KMeans
from sklearn.metrics import calinski_harabaz_score

import numpy as np
import matplotlib.pyplot as plt

X, y = make_blobs(n_samples = 100000,
                  n_features = 2,
                  centers = 6,
                  cluster_std = 5,
                  random_state = 170)
score = []
for i in range(3, 10):
    y_pred = KMeans(n_clusters = i, random_state = 170).fit_predict(X)
    score.append([i, calinski_harabaz_score(X, y_pred)])

score = np.array(score)
# print(score)
plt.plot(score[:, 0], score[:, 1])
plt.show()

for i in range(3, 11):
    y_pred = KMeans(n_clusters = i).fit_predict(X)
    plt.subplot(4, 2, i - 2)
    plt.scatter(X[:, 0], X[:, 1], c = y_pred)

plt.show()
