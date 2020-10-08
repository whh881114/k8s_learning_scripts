# 2020/10/08
- 使用cephFS，https://blog.csdn.net/weixin_34211761/article/details/92761142，rbd虽然可以用，但是呢，每个pvc分不太清是哪个pod挂的，有点麻烦，并且在mysql下挂的时候，会报权限问题，随后切到nfs即可。