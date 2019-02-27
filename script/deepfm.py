class DeepFM(object):
    """
    Deep FM with FTRL optimization
    """
    def __init__(self, config):
        """
        :param config: configuration of hyperparameters
        type of dict
        """
        # number of latent factors
        self.k = config['k']
        self.lr = config['lr']
        self.batch_size = config['batch_size']
        self.reg_l1 = config['reg_l1']
        self.reg_l2 = config['reg_l2']
        # num of features
        self.p = feature_length
        # num of fields
        self.field_cnt = field_cnt

    def add_placeholders(self):
        self.X = tf.placeholder('float32', [None, self.p])
        self.y = tf.placeholder('int64', [None,])
        # index of none-zero features
        self.feature_inds = tf.placeholder('int64', [None,field_cnt])
        self.keep_prob = tf.placeholder('float32')

    def inference(self):
        """
        forward propagation
        :return: labels for each sample
        """
        v = tf.Variable(tf.truncated_normal(shape=[self.p, self.k], mean=0, stddev=0.01),dtype='float32')

        # Factorization Machine
        with tf.variable_scope('FM'):
            b = tf.get_variable('bias', shape=[2],
                                initializer=tf.zeros_initializer())
            w1 = tf.get_variable('w1', shape=[self.p, 2],
                                 initializer=tf.truncated_normal_initializer(mean=0,stddev=1e-2))
            # shape of [None, 2]
            self.linear_terms = tf.add(tf.matmul(self.X, w1), b)

            # shape of [None, 1]
            self.interaction_terms = tf.multiply(0.5,
                                                 tf.reduce_mean(
                                                     tf.subtract(
                                                         tf.pow(tf.matmul(self.X, v), 2),
                                                         tf.matmul(tf.pow(self.X, 2), tf.pow(v, 2))),
                                                     1, keep_dims=True))
            # shape of [None, 2]
            self.y_fm = tf.add(self.linear_terms, self.interaction_terms)

        # three-hidden-layer neural network, network shape of (200-200-200)
        with tf.variable_scope('DNN',reuse=False):
            # embedding layer
            y_embedding_input = tf.reshape(tf.gather(v, self.feature_inds), [-1, self.field_cnt*self.k])
            # first hidden layer
            w1 = tf.get_variable('w1_dnn', shape=[self.field_cnt*self.k, 200],
                                 initializer=tf.truncated_normal_initializer(mean=0,stddev=1e-2))
            b1 = tf.get_variable('b1_dnn', shape=[200],
                                 initializer=tf.constant_initializer(0.001))
            y_hidden_l1 = tf.nn.relu(tf.matmul(y_embedding_input, w1) + b1)
            # second hidden layer
            w2 = tf.get_variable('w2', shape=[200, 200],
                                 initializer=tf.truncated_normal_initializer(mean=0,stddev=1e-2))
            b2 = tf.get_variable('b2', shape=[200],
                                 initializer=tf.constant_initializer(0.001))
            y_hidden_l2 = tf.nn.relu(tf.matmul(y_hidden_l1, w2) + b2)
            # third hidden layer
            w3 = tf.get_variable('w1', shape=[200, 200],
                                 initializer=tf.truncated_normal_initializer(mean=0,stddev=1e-2))
            b3 = tf.get_variable('b1', shape=[200],
                                 initializer=tf.constant_initializer(0.001))
            y_hidden_l3 = tf.nn.relu(tf.matmul(y_hidden_l2, w3) + b3)
            # output layer
            w_out = tf.get_variable('w_out', shape=[200, 2],
                                 initializer=tf.truncated_normal_initializer(mean=0,stddev=1e-2))
            b_out = tf.get_variable('b_out', shape=[2],
                                 initializer=tf.constant_initializer(0.001))
            self.y_dnn = tf.nn.relu(tf.matmul(y_hidden_l3, w_out) + b_out)
        # add FM output and DNN output
        self.y_out = tf.add(self.y_fm, self.y_dnn)
        self.y_out_prob = tf.nn.softmax(self.y_out)

    def add_loss(self):
        cross_entropy = tf.nn.sparse_softmax_cross_entropy_with_logits(labels=self.y, logits=self.y_out)
        mean_loss = tf.reduce_mean(cross_entropy)
        self.loss = mean_loss
        tf.summary.scalar('loss', self.loss)

    def add_accuracy(self):
        # accuracy
        self.correct_prediction = tf.equal(tf.cast(tf.argmax(model.y_out,1), tf.int64), model.y)
        self.accuracy = tf.reduce_mean(tf.cast(self.correct_prediction, tf.float32))
        # add summary to accuracy# CTR预估算法之FM, FFM, DeepFM及实践# CTR预估算法之FM, FFM, DeepFM及实践c

   tf.summary.scalar('accuracy', self.accuracy)

    def train(self):
        # Applies exponential decay to learning rate
        self.global_step = tf.Variable(0, trainable=False)
        # define optimizer
        optimizer = tf.train.FtrlOptimizer(self.lr, l1_regularization_strength=self.reg_l1,
                                           l2_regularization_strength=self.reg_l2)
        extra_update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS)
        with tf.control_dependencies(extra_update_ops):
            self.train_op = optimizer.minimize(self.loss, global_step=self.global_step)

    def build_graph(self):
        """build graph for model"""
        self.add_placeholders()
        self.inference()
        self.add_loss()
        self.add_accuracy()
        self.train()

---------------------
作者：Johnson0722 
来源：CSDN 
原文：https://blog.csdn.net/john_xyz/article/details/78933253?utm_source=copy 
版权声明：本文为博主原创文章，转载请附上博文链接！